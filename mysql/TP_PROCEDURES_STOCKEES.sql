-- ajout client
CREATE DATABASE tp_clients ;
USE tp_clients ;

CREATE TABLE clients (
id INT AUTO_INCREMENT PRIMARY KEY,
nom VARCHAR(100) ,
email VARCHAR(100)
) ;

DELIMITER //
CREATE PROCEDURE ajouter_client (IN nom VARCHAR(100), IN email VARCHAR(100))
BEGIN
	IF email like '%@%' THEN
		INSERT INTO clients(nom, email)
        VALUES(nom, email);
    ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Email Invalide';
    END IF;
END;
//

CALL ajouter_client( 'Marie' , 'marie@email.com') ;
CALL ajouter_client( 'JEAN' , 'jean.email.com') ;

-- prix produit
CREATE DATABASE tp_produits ;
USE tp_produits ;

CREATE TABLE produits (
id INT AUTO_INCREMENT PRIMARY KEY,
nom VARCHAR(100) ,
prix DECIMAL (10 , 2)
) ;

DELIMITER //
CREATE procedure modifier_prix(IN id_updated int, IN prix_updated DECIMAL (10 , 2))
BEGIN
	if prix_updated > 0 AND id_updated is not null then
    update produits
		SET prix = prix_updated
        WHERE id = id_updated;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Prix ou ID invalide';
    END IF;
END;
//

CALL modifier_prix ( 1 , 25.00 );
CALL modifier_prix ( 1 , 0.00 ); 