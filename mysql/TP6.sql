CREATE DATABASE IF NOT EXISTS TP6;
USE TP6;

--- tables
CREATE TABLE IF NOT EXISTS formulaires (
    id_formulaire INT PRIMARY KEY AUTO_INCREMENT,
    titre VARCHAR(255),
    date_creation DATE
);

CREATE TABLE IF NOT EXISTS questions (
    id_question INT PRIMARY KEY AUTO_INCREMENT,
    id_formulaire INT,
    texte_question VARCHAR(255),
    type_champ VARCHAR(50),
    FOREIGN KEY (id_formulaire) REFERENCES formulaires(id_formulaire)
);

CREATE TABLE IF NOT EXISTS participants (
    id_participant INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS reponses (
    id_reponse INT PRIMARY KEY AUTO_INCREMENT,
    id_participant INT,
    id_formulaire INT,
    donnees_json JSON,
    FOREIGN KEY (id_participant) REFERENCES participants(id_participant),
    FOREIGN KEY (id_formulaire) REFERENCES formulaires(id_formulaire)
);

--- donnees
-- Formulaire avec 3 questions
INSERT INTO formulaires (titre, date_creation)
VALUES ('Satisfaction client', CURDATE());

INSERT INTO questions (id_formulaire, texte_question, type_champ) VALUES
(1, 'Êtes-vous satisfait ?', 'choice'),
(1, 'Quel est votre âge ?', 'number'),
(1, 'Commentaires libres', 'text');

-- Participants
INSERT INTO participants (nom) VALUES ('Alice'), ('Bob');

-- Réponses
INSERT INTO reponses (id_participant, id_formulaire, donnees_json)
VALUES
(1, 1, '{
    "1": "Oui",
    "2": "30",
    "3": "Très satisfait"
}'),
(2, 1, '{
    "1": "Non",
    "2": "25",
    "3": "Peu satisfait"
}');

--- queries 
--- Toutes les réponses à la question 3
SELECT id_participant,
       JSON_UNQUOTE(JSON_EXTRACT(donnees_json, '$."3"')) AS reponse
FROM reponses
WHERE id_formulaire = 1;

--- La moyenne des réponses à une question numérique (ex: question 2)
SELECT AVG(CAST(JSON_UNQUOTE(JSON_EXTRACT(donnees_json, '$."2"')) AS UNSIGNED)) AS moyenne_question_2
FROM reponses
WHERE id_formulaire = 1;

--- La distribution des réponses à une question de type choix
SELECT 
  JSON_UNQUOTE(JSON_EXTRACT(donnees_json, '$."1"')) AS reponse,
  COUNT(*) AS nb_reponses
FROM reponses
WHERE id_formulaire = 1
GROUP BY JSON_UNQUOTE(JSON_EXTRACT(donnees_json, '$."1"'));

--- Requête pour voir toutes les réponses avec leur texte
SELECT 
r.id_participant,
  q.texte_question,
  JSON_UNQUOTE(JSON_EXTRACT(r.donnees_json, CONCAT('$."', q.id_question, '"'))) AS reponse
FROM reponses r
JOIN questions q ON q.id_formulaire = r.id_formulaire
-- WHERE r.id_participant = 1;

--- BONUS
DELIMITER $$

CREATE TRIGGER check_reponse_unique
BEFORE INSERT ON reponses
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM reponses
        WHERE id_participant = NEW.id_participant
          AND id_formulaire = NEW.id_formulaire
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ce participant a déjà répondu à ce formulaire.';
    END IF;
END$$

DELIMITER ;


