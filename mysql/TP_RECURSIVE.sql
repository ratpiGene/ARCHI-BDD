CREATE DATABASE TP_RECURSIVE ;
USE TP_RECURSIVE;

CREATE TABLE employes (
id INT PRIMARY KEY,
nom VARCHAR(50) ,
manager_id INT ,
FOREIGN KEY ( manager_id ) REFERENCES employes ( id )
) ;

INSERT INTO employes ( id , nom, manager_id ) VALUES
( 1 , 'Alice' , NULL ) ,
( 2 , 'Bob' , 1 ) ,
( 3 , 'Charlie' , 1 ) ,
( 4 , 'David' , 2 ) ,
( 5 , 'Eva' , 2 ) ,
( 6 , 'Frank' , 3 ) ;


WITH RECURSIVE sous_ordres AS (
SELECT id , nom, manager_id , 0 AS niveau
FROM employes
WHERE nom = 'Alice'
UNION ALL
SELECT e.id , e.nom, e.manager_id , s.niveau + 1
FROM employes e
JOIN sous_ordres s ON e.manager_id = s . id
)
SELECT * FROM SOUS_ORDRES;

CREATE TABLE categories (
id INT PRIMARY KEY,
nom VARCHAR(100),
parent_id INT,
FOREIGN KEY (parent_id) REFERENCES categories(id)
);

INSERT INTO categories ( id , nom , parent_id ) VALUES
( 1 , 'Electronique' , NULL ) ,
( 2 , 'Informatique' , 1 ) ,
( 3 , 'Smartphones' , 1 ) ,
( 4 , 'Ordinateurs portables' , 2 ) ,
( 5 , 'Composants' , 2 ) ,
( 6 , 'Memoire RAM' , 5 ) ,
( 7 , 'Disques SSD' , 5 ) ,
( 8 , 'Accessoires' , 1 ) ;

--- QUERIES
WITH RECURSIVE sous_categories AS (
  SELECT id, nom, parent_id, 0 AS niveau
  FROM categories
  WHERE nom = 'Électronique'

  UNION ALL

  SELECT c.id, c.nom, c.parent_id, sc.niveau + 1
  FROM categories c
  JOIN sous_categories sc ON c.parent_id = sc.id
)
SELECT * FROM sous_categories;

WITH RECURSIVE sous_categories AS (
  SELECT id, nom, parent_id, 0 AS niveau
  FROM categories
  WHERE nom = 'Electronique'

  UNION ALL

  SELECT c.id, c.nom, c.parent_id, sc.niveau + 1
  FROM categories c
  JOIN sous_categories sc ON c.parent_id = sc.id
)
SELECT CONCAT(REPEAT('- ', niveau), nom) AS arborescence
FROM sous_categories;

