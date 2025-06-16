-- DROP DATABASE TP1;

-- BDD
CREATE DATABASE EntrepriseDB;
USE EntrepriseDB;

-- TABLES
CREATE TABLE Service (
    servno INT PRIMARY KEY,
    snom VARCHAR(50),
    sloc VARCHAR(100)
);

CREATE TABLE Employe (
    empno INT PRIMARY KEY,
    enom VARCHAR(50),
    poste VARCHAR(50),
    embauche DATE,
    salaire DECIMAL(10,2),
    servno INT,
    prime DECIMAL(10,2),
    FOREIGN KEY (servno) REFERENCES Service(servno)
);

CREATE TABLE Projet (
    prjno VARCHAR(10) PRIMARY KEY,
    titre VARCHAR(100),
    empno INT,
    budget DECIMAL(10,2),
    cout DECIMAL(10,2),
    debut DATE,
    FOREIGN KEY (empno) REFERENCES Employe(empno)
);

-- DATA
INSERT INTO Service (servno, snom, sloc) VALUES
(10, 'RECHERCHE', 'Paris'),
(20, 'FINANCE', 'Lyon'),
(30, 'VENTE', 'Marseille'),
(40, 'PRODUCTION', 'Toulouse'),
(50, 'MARKETING', 'Nice'),
(60, 'EXPORT', 'Nantes');

INSERT INTO Employe (empno, enom, poste, embauche, salaire, servno, prime) VALUES
(1001, 'Martin', 'INGENIEUR', '2018-05-01', 2400.00, 10, 600),
(1002, 'Dubois', 'DIRECTEUR', '2010-02-10', 3500.00, 20, 1000),
(1003, 'Lemoine', 'SECRETAIRE', '2019-09-15', 1200.00, 30, 300),
(1004, 'Moreau', 'SECRETAIRE', '2015-04-25', 1400.00, 30, 400),
(1005, 'Roux', 'VENDEUR', '2020-01-10', 1300.00, 30, 350),
(1006, 'Chevalier', 'VENDEUR', '2021-11-05', 1250.00, 60, 300);

INSERT INTO Projet (prjno, titre, empno, budget, cout, debut) VALUES
('PR001', 'Energie Verte', 1002, 50000.00, 1200, '2023-01-15'),
('PR002', 'Blockchain RH', 1003, 30000.00, 800, '2022-10-01'),
('PR003', 'IoT Industriel', 1004, 40000.00, 900, '2024-03-20'),
('PR004', 'Robotique Avancée', 1005, 35000.00, 700, '2023-12-10'),
('PR005', 'IA Médicale', 1001, 60000.00, 1500, '2022-07-01');

-- QUERY 1
SELECT
	enom
FROM EMPLOYE
WHERE servno = '30';

-- QUERY 2
SELECT
	titre
FROM Projet
WHERE budget > 40000;

-- QUERY 3
SELECT
	enom,
    poste
FROM Employe
WHERE salaire > 2000;

-- QUERY 4
SELECT 
	snom
FROM Service
WHERE sloc = 'PARIS';

-- QUERY 5
SELECT 
	enom
FROM Employe
WHERE embauche > '2015-12-31';

-- QUERY 6
SELECT 
	SERVNO,
ROUND(AVG(SALAIRE), 2)
FROM EMPLOYE
GROUP BY servno;
    
-- QUERY 7
SELECT 
	titre
FROM PROJET
WHERE YEAR(DEBUT) = '2023';

-- QUERY 8
SELECT 
	MAX(Salaire) Salaire_MAX
FROM Employe
WHERE POSTE = 'INGENIEUR';

-- QUERY 9
SELECT
	poste,
    SUM(prime) primes
FROM Employe
GROUP BY poste;

-- QUERY 10
SELECT
	titre,
    enom
FROM Projet p
JOIN Employe E on P.empno = e.empno;

-- QUERY 11
SELECT
	titre,
    enom
FROM Projet p
JOIN Employe E on P.empno = e.empno
WHERE poste = 'DIRECTEUR';

-- QUERY 12
SELECT 
	Titre
FROM Projet p
JOIN Employe e on p.empno = e.empno
JOIN service s on e.servno = s.servno
WHERE S.snom = 'FINANCE';

-- QUERY 13
SELECT 
	enom
FROM Employe
WHERE enom like '%o%';

-- QUERY 14
SELECT 
	titre,
    enom
FROM Projet P
JOIN Employe E ON P.EMPNO = E.EMPNO;

-- QUERY 15
SELECT
	enom,
    salaire
FROM Employe
WHERE SALAIRE >= 1000 AND SALAIRE <= 2000;

-- QUERY 16
SELECT 
	enom,
    poste
FROM Employe
ORDER BY poste desc, salaire desc;

-- QUERY 17
SELECT 
	SNOM,
    COUNT(DISTINCT TITRE)
FROM SERVICE S
LEFT JOIN Employe E ON S.SERVNO = E.SERVNO
LEFT JOIN PROJET P ON E.EMPNO = P.EMPNO
GROUP BY SNOM;

-- QUERY 18
SELECT
	SNOM,
    NBR_EMP
FROM
(SELECT
	SNOM,
    COUNT(DISTINCT EMPNO) NBR_EMP
FROM SERVICE S
LEFT JOIN EMPLOYE E ON S.SERVNO = E.SERVNO
GROUP BY SNOM ) EMP
WHERE NBR_EMP > 2;

-- QUERY 19
SELECT 
	ENOM,
    SALAIRE
from EMPLOYE E
WHERE E.SALAIRE > (select avg(salaire) from employe);

-- QUERY 20
SELECT 
	titre,
    TIMESTAMPDIFF(MONTH, debut, now()) MOIS_ECOULES
FROM PROJET