
-- 1
BEGIN
    DBMS_OUTPUT.PUT_LINE('Bonjour, ceci est un test PL/SQL');
END;
/

-- 2
DECLARE
    prenom VARCHAR2(50) := 'Alice';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Bonjour ' || prenom);
END;
/

-- 3
DECLARE
    note NUMBER := 9; -- Valeur à modifier si besoin
BEGIN
    IF note >= 10 THEN
        DBMS_OUTPUT.PUT_LINE('Admis');
    ELSIF note >= 8 THEN
        DBMS_OUTPUT.PUT_LINE('Rattrapage');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Refusé');
    END IF;
END;
/

-- 4
DECLARE
    i NUMBER := 1;
BEGIN
    WHILE i <= 10 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
        i := i + 1;
    END LOOP;
END;
/

-- 5
DECLARE
    CURSOR c_emp IS SELECT nom FROM employes; -- créer table pr test
    v_nom employes.nom%TYPE;
BEGIN
    OPEN c_emp;
    LOOP
        FETCH c_emp INTO v_nom;
        EXIT WHEN c_emp%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_nom);
    END LOOP;
    CLOSE c_emp;
END;
/

-- 6
DECLARE
    a NUMBER := 10;
    b NUMBER := 0;
    c NUMBER;
BEGIN
    c := a / b;
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : division par zéro interdite.');
END;
/

-- 7
CREATE OR REPLACE PROCEDURE afficher_message(p_msg IN VARCHAR2) IS
BEGIN
    DBMS_OUTPUT.PUT_LINE(p_msg);
END;
/
-- Appel :
BEGIN
    afficher_message('Ceci est un appel de procédure.');
END;
/

-- 8
CREATE OR REPLACE TRIGGER emp_prevent_delete
BEFORE DELETE ON produits -- créer table pr test
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(-20001, 'Suppression interdite sur la table produits.');
END;
/




