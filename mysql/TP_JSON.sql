--- MYSQL 8.0 pas PostgreSQL
-- Création de la BDD
CREATE DATABASE IF NOT EXISTS JSONS;
USE JSONS;

-- Création de la table clients avec une colonne JSON
CREATE TABLE clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data JSON
);

-- Insertion d’un exemple de client
INSERT INTO clients (data) VALUES (
    '{
        "nom": "Durand",
        "prenom": "Alice",
        "contacts": {
            "email": "alice.durand@example.com",
            "telephones": ["0123456789", "0987654321"]
        },
        "commandes": [
            { "id": 101, "date": "2024-01-10", "montant": 150.5 },
            { "id": 102, "date": "2024-02-15", "montant": 89.9 }
        ],
        "preferences": {
            "newsletter": true,
            "langue": "fr"
        }
    }'
);

-- 1. Extraire le prénom du client
SELECT JSON_UNQUOTE(JSON_EXTRACT(data, '$.prenom')) AS prenom FROM clients;

-- 2. Retourner tous les emails des clients
SELECT JSON_UNQUOTE(JSON_EXTRACT(data, '$.contacts.email')) AS email FROM clients;

-- 3. Lister toutes les commandes (id et montant) pour un client donné (ex: nom = 'Durand')
SELECT
    JSON_EXTRACT(cmd.value, '$.id') AS commande_id,
    JSON_EXTRACT(cmd.value, '$.montant') AS montant
FROM clients,
JSON_TABLE(data, '$.commandes[*]' COLUMNS (
    value JSON PATH '$'
)) AS cmd
WHERE JSON_UNQUOTE(JSON_EXTRACT(data, '$.nom')) = 'Durand';

-- 4. Calculer le montant total des commandes pour chaque client
SELECT
    id,
    SUM(JSON_EXTRACT(cmd.value, '$.montant')) AS total_commandes
FROM clients,
JSON_TABLE(data, '$.commandes[*]' COLUMNS (
    value JSON PATH '$'
)) AS cmd
GROUP BY id;

-- 5. Désactiver la newsletter pour un client donné
UPDATE clients
SET data = JSON_SET(data, '$.preferences.newsletter', false)
WHERE JSON_UNQUOTE(JSON_EXTRACT(data, '$.nom')) = 'Durand';

-- 6. Ajouter un nouveau téléphone "0112233445"
UPDATE clients
SET data = JSON_SET(
    data,
    '$.contacts.telephones',
    JSON_ARRAY_APPEND(JSON_EXTRACT(data, '$.contacts.telephones'), '$', '0112233445')
)
WHERE JSON_UNQUOTE(JSON_EXTRACT(data, '$.nom')) = 'Durand';

-- Bonus 1 : Lister les clients ayant passé une commande de montant > 100
SELECT DISTINCT id
FROM clients,
JSON_TABLE(data, '$.commandes[*]' COLUMNS (
    montant DECIMAL(10,2) PATH '$.montant'
)) AS cmd
WHERE cmd.montant > 100;

-- Bonus 2 : Extraire la langue préférée des clients
SELECT
    id,
    CASE JSON_UNQUOTE(JSON_EXTRACT(data, '$.preferences.langue'))
        WHEN 'fr' THEN 'français'
        WHEN 'en' THEN 'anglais'
        ELSE 'autre'
    END AS langue_preferee
FROM clients;
