
-- Supprimer les tables existantes si elles existent déjà
DROP TABLE IF EXISTS decision;
DROP TABLE IF EXISTS interne;
DROP TABLE IF EXISTS externe;
DROP TABLE IF EXISTS transactionn;
DROP TABLE IF EXISTS operationn;
DROP TABLE IF EXISTS client;
DROP TABLE IF EXISTS compte_bancaire;
DROP TABLE IF EXISTS employe;
DROP TABLE IF EXISTS personne;

CREATE TABLE IF NOT EXISTS personne (

       id INT UNSIGNED NOT NULL AUTO_INCREMENT,
       nom VARCHAR(255) NOT NULL,
       prenom VARCHAR(255) NOT NULL,
       date_naissance DATE NOT NULL,
       nationnalite VARCHAR(255) NOT NULL,
       adresse VARCHAR(255) NOT NULL,
       numero_tel INT,

       CONSTRAINT pk_personne PRIMARY KEY(id),
       CONSTRAINT ck_numero_tel CHECK (numero_tel < 0999999999)
);


CREATE TABLE IF NOT EXISTS employe(

       id INT UNSIGNED NOT NULL AUTO_INCREMENT,
       id_personne INT UNSIGNED NOT NULL,
       date_recrutement DATE NOT NULL,
       mission VARCHAR(255) NOT NULL, 
       salaire INT NOT NULL,
       CONSTRAINT pk_employe PRIMARY KEY(id),
       CONSTRAINT fk_employe_id_personne FOREIGN KEY(id_personne) REFERENCES personne(id)
);

CREATE TABLE IF NOT EXISTS compte_bancaire (
       id INT UNSIGNED NOT NULL AUTO_INCREMENT,
       solde INT NOT NULL,
       type_compte ENUM('joint','a terme','perso'),
       date_ouverture DATE NOT NULL,
       histo_des_trans TEXT,
       carte_bancaire ENUM('standard','gold','premium','platinum'),
       CONSTRAINT pk_compte_bancaire PRIMARY KEY (id)
);


CREATE TABLE IF NOT EXISTS client(
       id INT UNSIGNED NOT NULL AUTO_INCREMENT,
       id_personne INT UNSIGNED NOT NULL,
       id_compte_bancaire INT UNSIGNED NOT NULL,
       date_inscription DATE NOT NULL,


       CONSTRAINT pk_client PRIMARY KEY(id),
       CONSTRAINT fk_client_id_personne FOREIGN KEY(id_personne) REFERENCES personne(id),
       CONSTRAINT fk_client_id_compte_bancaire FOREIGN KEY(id_compte_bancaire) REFERENCES compte_bancaire(id),
       CONSTRAINT cstunq_compte_bancaire_id_client UNIQUE unq_compte_bancaire_id_client (id_compte_bancaire)	
);

CREATE TABLE IF NOT EXISTS operationn(
       
       id INT UNSIGNED NOT NULL AUTO_INCREMENT,
       id_employe INT UNSIGNED NOT NULL,
       id_compte_bancaire INT UNSIGNED NOT NULL,
       typee ENUM('ouverture','fermeture','transaction'),
       date_heure DATETIME NOT NULL,
        
       CONSTRAINT pk_operationn PRIMARY KEY(id),
       CONSTRAINT fk_operationn_id_employe FOREIGN KEY(id_employe) REFERENCES employe(id),
       CONSTRAINT fk_operationn_id_compte_bancaire FOREIGN KEY(id_compte_bancaire) REFERENCES compte_bancaire(id),
       CONSTRAINT cstunq_opartionn_id_employe UNIQUE unq_operation_id_employe (id_employe),
       CONSTRAINT cstunq_opartionn_id_compte_bancaire UNIQUE unq_operation_id_compte_bancaire (id_compte_bancaire)

);


CREATE TABLE IF NOT EXISTS transactionn(

       id INT UNSIGNED NOT NULL AUTO_INCREMENT,
       montant INT NOT NULL,
       date_heure DATETIME NOT NULL,


       CONSTRAINT pk_transaction PRIMARY KEY(id)
      
);


CREATE TABLE IF NOT EXISTS decision(
      id INT UNSIGNED NOT NULL AUTO_INCREMENT,
      id_operation INT UNSIGNED NOT NULL,
      id_transaction INT UNSIGNED NOT NULL,
      typee ENUM('accepte','refus'),
      date_heure DATETIME NOT NULL,

      CONSTRAINT pk_decision PRIMARY KEY (id),
      CONSTRAINT fk_decision_id_operation FOREIGN KEY (id_operation) REFERENCES operationn(id),	
      CONSTRAINT fk_decision_id_transaction FOREIGN KEY (id_transaction) REFERENCES transactionn(id)
);  



CREATE TABLE IF NOT EXISTS interne(
       id INT UNSIGNED NOT NULL AUTO_INCREMENT ,       
       id_transaction INT UNSIGNED NOT NULL,
       typee ENUM('depot','retrait'),


       CONSTRAINT pk_id_interne PRIMARY KEY (id),
       CONSTRAINT fk_id_transaction FOREIGN KEY(id_transaction) REFERENCES transactionn(id)

);


CREATE TABLE IF NOT EXISTS externe(
       id INT UNSIGNED NOT NULL AUTO_INCREMENT , 
       id_transactionex INT UNSIGNED NOT NULL,
       iban VARCHAR(255) NOT NULL,


       CONSTRAINT pk_id_externe PRIMARY KEY (id),
       CONSTRAINT fk_id_transactionex FOREIGN KEY(id_transactionex) REFERENCES transactionn(id)

);

INSERT INTO personne VALUES 
(NULL, 'fathi', 'samir','2003-03-09','Algerienne','11 rue des freres lumiere 68350 Brunsttat-Didenheim', 065656565), 
(NULL, 'rebbouh', 'sabrina','1997-07-16','Francaise','17 rue roger 68100 MULHOUSE', 0758882951), 
(NULL, 'Bilal', 'Kim','1981-12-09','Espagnole','fefefe saintetienne', 0763259874), 
(NULL, 'Alex', 'Chen','2000-03-19','Espagnole','fefefe saintetienne', 0675896324),
(NULL, 'Alexe', 'Chenil','2000-03-12','Espagnole','fe saintetienne', 0671896324);

INSERT INTO employe VALUES
(NULL, 1, '2021-10-14', 'Accueil des clients', 2100),
(NULL, 2, '2013-12-13', 'Ouverture de comptes', 1900),
(NULL, 3, '2023-12-23', 'Analyse de crédit', 3000),
(NULL, 4, '2020-05-23', 'Ouverture de comptes', 4520),
(NULL, 4, '2020-05-23', 'Fermeture de compte', 4520);

INSERT INTO compte_bancaire VALUES
(NULL, 5000, 'perso', '2022-01-10', 'Première transaction effectuée.', 'standard'),
(NULL, 10000, 'joint', '2022-02-05', 'Dépôt initial effectué.', 'gold'),
(NULL, 8000, 'a terme', '2022-03-15', 'Ouverture un compte à terme.', 'premium'),
(NULL, 15000, 'perso', '2022-04-20', 'Solde initial élevé.', 'platinum'),
(NULL, 16000, 'perso', '2022-04-20', 'Solde initial élevé.', 'platinum');

INSERT INTO client VALUES
(NULL, 1, 3, '2023-01-01'),
(NULL, 2, 2, '2021-02-15'),
(NULL, 3, 1, '2020-03-20'),
(NULL, 4, 5, '2017-04-10'),
(NULL, 5, 4, '2014-04-10');

-- INSERT INTO operationn VALUES
-- (NULL, 1, 2, 'ouverture', '2023-01-01 08:30:00'),
-- (NULL, 2, 4, 'transaction', '2023-02-15 10:45:00'),
-- (NULL, 3, 1, 'fermeture', '2023-03-20 15:20:00'),
-- (NULL, 4, 5, 'transaction', '2023-04-10 12:00:00'),
-- (NULL, 5, 3, 'ouverture', '2023-05-05 09:15:00');

-- INSERT INTO transactionn VALUES
-- (NULL, 500, '2023-01-10 08:30:00'),
-- (NULL, 1000, '2023-02-15 10:45:00'),
-- (NULL, 1500, '2023-03-20 15:20:00'),
-- (NULL, 2000, '2023-04-10 12:00:00'),
-- (NULL, 2500, '2023-05-05 09:15:00');


-- INSERT INTO decision VALUES
-- (NULL,5, 1, 'accepte', '2023-01-15 09:00:00'),
-- (NULL,4, 2, 'accepte', '2023-02-20 11:30:00'),
-- (NULL,3, 3, 'refus', '2023-03-25 14:45:00'),
-- (NULL,2, 4, 'accepte', '2023-04-15 10:00:00'),
-- (NULL,1, 5, 'refus', '2023-05-10 08:45:00');



DROP PROCEDURE IF EXISTS p_ajouterNouveauClient;

DELIMITER $

CREATE PROCEDURE IF NOT EXISTS p_ajouterNouveauClient(
    IN in_p_nom VARCHAR(255),
    IN in_p_prenom VARCHAR(255),
    IN in_p_date_naissance DATE,
    IN in_p_nationalite VARCHAR(255),
    IN in_p_adresse VARCHAR(255),
    IN in_p_numero_tel INT,
    IN in_p_date_inscription DATE,
    IN in_p_solde_initial INT ,
    IN in_p_type_compte ENUM('joint', 'perso', 'a terme'),
    IN in_p_carte_bancaire ENUM('standard', 'gold', 'premium', 'platinum')
)
BEGIN
    -- Vérifier l'âge du client
    IF DATEDIFF(NOW(), in_p_date_naissance) < 365 * 19 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''âge du client doit être d''au moins 19 ans';
    END IF;

    -- Ajouter la personne
    INSERT INTO personne(nom, prenom, date_naissance, nationnalite, adresse, numero_tel) VALUES (in_p_nom, in_p_prenom, in_p_date_naissance, in_p_nationalite, in_p_adresse, in_p_numero_tel);

    -- Ajouter le compte bancaire
    INSERT INTO compte_bancaire(solde, type_compte, date_ouverture, carte_bancaire) VALUES (in_p_solde_initial, in_p_type_compte, NOW(), in_p_carte_bancaire);

    -- Ajouter le client
    INSERT INTO client(id_personne, id_compte_bancaire, date_inscription) VALUES (LAST_INSERT_ID(), LAST_INSERT_ID(), in_p_date_inscription);

    -- Ajouter l'opération d'ouverture de compte
    INSERT INTO operationn(id_employe, id_compte_bancaire, typee, date_heure) VALUES (1, LAST_INSERT_ID(), 'ouverture', NOW());
END $

DELIMITER ;



CALL p_ajouterNouveauClient('John', 'Doe', '1990-01-01', 'Française', '123 Rue Example', 123456789, '2023-01-01', 1000, 'perso', 'standard');




-- Supprimer la procédure existante si elle existe déjà
DROP PROCEDURE IF EXISTS p_effectuerTransfert;

DELIMITER $

CREATE PROCEDURE IF NOT EXISTS p_effectuerTransfert(
    IN in_p_id_compte_source INT,
    IN in_p_id_compte_destination INT,
    IN in_p_montant INT
)
BEGIN
    DECLARE solde_source INT;
    DECLARE solde_destination INT;

    -- Vérifier si les comptes existent
    IF NOT EXISTS (SELECT 1 FROM compte_bancaire WHERE id = in_p_id_compte_source) OR NOT EXISTS (SELECT 1 FROM compte_bancaire WHERE id = in_p_id_compte_destination) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Les comptes spécifiés n''existent pas';
    END IF;

    -- Vérifier si le solde du compte source est suffisant
    SELECT solde INTO solde_source FROM compte_bancaire WHERE id = in_p_id_compte_source;
    IF solde_source < in_p_montant THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Solde insuffisant sur le compte source';
    END IF;

    -- Mettre à jour le solde du compte source et du compte destination dans une transaction
    START TRANSACTION;

    UPDATE compte_bancaire SET solde = solde - in_p_montant WHERE id = in_p_id_compte_source;
    UPDATE compte_bancaire SET solde = solde + in_p_montant WHERE id = in_p_id_compte_destination;

    -- Ajouter une transaction
    INSERT INTO transactionn(montant, date_heure) VALUES (in_p_montant, NOW());

    -- Ajouter une opération de transaction pour le compte source (avec IGNORE)
    INSERT IGNORE INTO operationn(id_employe, id_compte_bancaire, typee, date_heure) VALUES (1, in_p_id_compte_source, 'transaction', NOW());

    -- Ajouter une opération de transaction pour le compte destination (avec IGNORE)
    INSERT IGNORE INTO operationn(id_employe, id_compte_bancaire, typee, date_heure) VALUES (1, in_p_id_compte_destination, 'transaction', NOW());

    COMMIT;
END $

DELIMITER ;

-- Appel de la procédure pour effectuer un transfert
CALL p_effectuerTransfert(2, 1, 500);





-- Mettez à jour le déclencheur pour utiliser la nouvelle colonne
DELIMITER $

CREATE TRIGGER before_insert_operationn
BEFORE INSERT ON operationn
FOR EACH ROW
BEGIN
    DECLARE source_account_balance INT;
    DECLARE destination_account_balance INT;

    -- Vérifier si c'est une opération de transfert
    IF NEW.typee = 'transaction' THEN
        -- Vérifier si les comptes existent
        IF NOT EXISTS (SELECT 1 FROM compte_bancaire WHERE id = NEW.id_compte_bancaire) OR NOT EXISTS (SELECT 1 FROM compte_bancaire WHERE id = NEW.id_compte_destination) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Les comptes spécifiés n''existent pas';
        END IF;

        -- Vérifier si le solde du compte source est suffisant
        SELECT solde INTO source_account_balance FROM compte_bancaire WHERE id = NEW.id_compte_bancaire;
        IF source_account_balance < NEW.montant THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Solde insuffisant sur le compte source';
        END IF;

        -- Mettre à jour le solde du compte source
        UPDATE compte_bancaire SET solde = solde - NEW.montant WHERE id = NEW.id_compte_bancaire;

        -- Mettre à jour le solde du compte destination
        UPDATE compte_bancaire SET solde = solde + NEW.montant WHERE id = NEW.id_compte;
    END IF;
END $

DELIMITER ;
