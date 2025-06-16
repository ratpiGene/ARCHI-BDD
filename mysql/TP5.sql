CREATE DATABASE TP5;
USE TP5;

CREATE TABLE heros (
    id_heros INT PRIMARY KEY,
    nom VARCHAR(100),
    niveau_experience INT CHECK (niveau_experience BETWEEN 0 AND 100)
);

CREATE TABLE dragons (
    id_dragon INT PRIMARY KEY,
    nom VARCHAR(100),
    niveau_puissance INT
);

INSERT INTO heros VALUES
(1, 'Delormeau Lance-Molle', 45),
(2, 'TheTanker78', 70),
(3, 'Gorille supplément banane', 10);

INSERT INTO dragons VALUES
(1, 'TiboInDrake', 30),
(2, 'Dieudo Le Ténébreux', 75),
(3, 'Bardella Le Foudroyant', 65);

CREATE TABLE journal_combats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    heros VARCHAR(100),
    dragon VARCHAR(100),
    resultat VARCHAR(255),
    date_combat DATETIME DEFAULT NOW()
);

DELIMITER $$

CREATE PROCEDURE affronter_dragon (
    IN id_heros_combat INT,
    IN id_dragon_combat INT,
    OUT resultat VARCHAR(255)
)
BEGIN
    DECLARE v_nom_heros VARCHAR(100);
    DECLARE v_xp_heros INT;
    DECLARE v_nom_dragon VARCHAR(100);
    DECLARE v_puissance_dragon INT;
    DECLARE v_bonus INT DEFAULT 0;

    -- Vérification existence héros
    IF NOT EXISTS (SELECT 1 FROM heros WHERE id_heros = id_heros_combat) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Héros inexistant.';
    END IF;

    -- Vérification existence dragon
    IF NOT EXISTS (SELECT 1 FROM dragons WHERE id_dragon = id_dragon_combat) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Dragon inexistant.';
    END IF;

    -- Récupération des infos
    SELECT nom, niveau_experience INTO v_nom_heros, v_xp_heros
    FROM heros WHERE id_heros = id_heros_combat;

    SELECT nom, niveau_puissance INTO v_nom_dragon, v_puissance_dragon
    FROM dragons WHERE id_dragon = id_dragon_combat;

    -- Combat
    IF v_xp_heros > v_puissance_dragon THEN
        SET v_xp_heros = v_xp_heros + FLOOR(v_puissance_dragon / 2);
        IF (v_xp_heros - v_puissance_dragon) > 20 THEN
            SET v_xp_heros = v_xp_heros + 5;
        END IF;

        IF v_xp_heros > 100 THEN
            SET v_xp_heros = 100;
        END IF;

        UPDATE heros SET niveau_experience = v_xp_heros WHERE id_heros = id_heros_combat;
        SET resultat = CONCAT('Victoire de ', v_nom_heros, ' contre ', v_nom_dragon);

    ELSE
        SET v_xp_heros = v_xp_heros - 10;
        IF v_xp_heros < 0 THEN
            SET v_xp_heros = 0;
        END IF;

        UPDATE heros SET niveau_experience = v_xp_heros WHERE id_heros = id_heros_combat;
        SET resultat = CONCAT('Défaite de ', v_nom_heros, ' face à ', v_nom_dragon);
    END IF;

    -- Journalisation
    INSERT INTO journal_combats (heros, dragon, resultat)
    VALUES (v_nom_heros, v_nom_dragon, resultat);
END$$

DELIMITER ;

CALL affronter_dragon(2, 3, @resultat); -- win chevalier
SELECT @resultat;
CALL affronter_dragon(1, 2, @resultat); -- win dragon
SELECT @resultat;

