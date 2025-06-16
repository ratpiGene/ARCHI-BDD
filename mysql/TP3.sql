-- Quel est le nombre moyen de fautes pour la série 5 du CD-ROM 14 ?
SELECT AVG(a.nb_fautes) AS moyenne_fautes
FROM assister a
JOIN seance s ON a.seance_id = s.id
JOIN serie sr ON s.serie_id = sr.id
WHERE sr.numero = 5
  AND sr.cd_rom_id = 14;

-- Quels élèves peuvent se présenter au prochain examen théorique du code de la route ?
SELECT e.id, e.first_name, e.last_name
FROM eleve e
JOIN (
    SELECT a.eleve_id
    FROM assister a
    JOIN seance s ON a.seance_id = s.id
    ORDER BY s.date DESC
) AS recent
ON e.id = recent.eleve_id
WHERE (
    SELECT COUNT(*)
    FROM (
        SELECT a.nb_fautes
        FROM assister a
        JOIN seance s ON a.seance_id = s.id
        WHERE a.eleve_id = e.id
        ORDER BY s.date DESC
        LIMIT 4
    ) AS last4
    WHERE nb_fautes <= 5
) = 4;

-- Quels élèves ont échoué au moins une fois à l'examen théorique ?
SELECT DISTINCT e.id, e.first_name, e.last_name
FROM passer_examen pe
JOIN eleve e ON pe.eleve_id = e.id
WHERE pe.est_recale = TRUE;

-- Quel est le nombre total d'élèves inscrits dans l'auto-école ?
SELECT COUNT(*) AS total_eleves
FROM eleve;

-- Quelle est la liste des élèves ayant assisté à la séance du 2024-04-15 ?
SELECT e.id, e.first_name, e.last_name
FROM eleve e
JOIN assister a ON e.id = a.eleve_id
JOIN seance s ON a.seance_id = s.id
WHERE DATE(s.date) = '2024-04-15';

-- Quel est le nombre de questions par série pour chaque CD-ROM ?
SELECT 
  cd.id AS cd_rom_id,
  cd.editeur,
  s.id AS serie_id,
  s.numero AS numero_serie,é
  COUNT(sq.question_id) AS nb_questions
FROM cd_rom cd
JOIN serie s ON s.cd_rom_id = cd.id
JOIN serie_question sq ON sq.serie_id = s.id
GROUP BY cd.id, cd.editeur, s.id, s.numero
ORDER BY cd.id, s.numero;

-- Liste des élèves qui ont obtenu la meilleure note (0 faute) dans une séance de code spécifique.
SELECT 
  e.id AS eleve_id,
  e.first_name,
  e.last_name,
  a.nb_fautes
FROM assister a
JOIN eleve e ON a.eleve_id = e.id
-- JOIN seance s ON a.seance_id = s.id
WHERE a.seance_id = 12
-- WHERE DATE(s.date) = '2024-04-15'
  AND a.nb_fautes = 0;

-- Quelle est la note moyenne obtenue par les élèves pour chaque séance ?
SELECT 
  s.id AS seance_id,
  s.date,
  AVG(a.nb_fautes) AS moyenne_fautes
FROM seance s
JOIN assister a ON s.id = a.seance_id
GROUP BY s.id, s.date
ORDER BY s.date;

-- Quel est le nombre total de fautes pour chaque CD-ROM ?
SELECT 
  cd.id AS cd_rom_id,
  cd.editeur,
  SUM(a.nb_fautes) AS total_fautes
FROM cd_rom cd
JOIN serie s ON s.cd_rom_id = cd.id
JOIN seance se ON se.serie_id = s.id
JOIN assister a ON a.seance_id = se.id
GROUP BY cd.id, cd.editeur
ORDER BY cd.id;

-- Liste des élèves ayant échoué à tous les examens théoriques.
SELECT e.id, e.first_name, e.last_name
FROM eleve e
JOIN passer_examen pe ON pe.eleve_id = e.id
GROUP BY e.id, e.first_name, e.last_name
HAVING COUNT(*) > 0 AND SUM(CASE WHEN pe.est_recale = FALSE THEN 1 ELSE 0 END) = 0;

-- Quel est le nombre moyen de fautes par élève dans une série donnée (par exemple, série 2 du CD-ROM 3) ?
SELECT 
  e.id AS eleve_id,
  e.first_name,
  e.last_name,
  AVG(a.nb_fautes) AS moyenne_fautes
FROM eleve e
JOIN assister a ON e.id = a.eleve_id
JOIN seance s ON a.seance_id = s.id
JOIN serie sr ON s.serie_id = sr.id
WHERE sr.numero = 2
  AND sr.cd_rom_id = 3
GROUP BY e.id, e.first_name, e.last_name
ORDER BY moyenne_fautes ASC;

-- Quel est le nombre total de questions pour chaque thème (par exemple,"Vitesse", "Panne") ?
SELECT 
  theme,
  COUNT(*) AS total_questions
FROM question
GROUP BY theme
ORDER BY total_questions DESC;
