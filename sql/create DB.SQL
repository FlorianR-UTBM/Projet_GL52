DROP TABLE IF EXISTS ETRE_SUJET;

DROP TABLE IF EXISTS ETRE_ALLERGIQUE;

DROP TABLE IF EXISTS ASSOCIER;

DROP TABLE IF EXISTS POSSEDER;

DROP TABLE IF EXISTS CARENCES;

DROP TABLE IF EXISTS ALLERGENES;

DROP TABLE IF EXISTS ANC;

DROP TABLE IF EXISTS ETAPE;

DROP TABLE IF EXISTS GERER;

DROP TABLE IF EXISTS PREFERER;

DROP TABLE IF EXISTS ADMINISTRATEUR;

DROP TABLE IF EXISTS UTILISATEUR;

DROP TABLE IF EXISTS NUTRITIONNISTE;

DROP TABLE IF EXISTS USER_AUTH;

DROP TABLE IF EXISTS CONTENIR;

DROP TABLE IF EXISTS FOURNIR;

DROP TABLE IF EXISTS INGREDIENTS;

DROP TABLE IF EXISTS FOURNISSEUR;

DROP TABLE IF EXISTS RECETTE;

# -----------------------------------------------------------------------------
#       TABLE : RECETTE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS RECETTE
 (
   NUM_RECETTE BIGINT(5) NOT NULL AUTO_INCREMENT  ,
   NOM_RECETTE VARCHAR(50) NOT NULL  ,
   TYPE_RECETTE VARCHAR(30) NOT NULL  ,
   DIFFICULTE_RECETTE VARCHAR(15) NOT NULL  ,
   DESC_RECETTE VARCHAR(1000) NOT NULL  ,
   TEMPS_PREPARATION_RECETTE INTEGER(3) NOT NULL  ,
   NB_PERSONNES_RECETTE INTEGER(2) NOT NULL  ,
   IMAGE_RECETTE LONGBLOB NOT NULL  ,
   ENERGIE INTEGER(5) NULL  
   , PRIMARY KEY (NUM_RECETTE) 
 ) 
;

# -----------------------------------------------------------------------------
#       TABLE : FOURNISSEUR
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS FOURNISSEUR
 (
   NUM_FOURNISSEUR BIGINT(4) NOT NULL AUTO_INCREMENT  ,
   NOM_FOURNISSEUR VARCHAR(40) NOT NULL  ,
   ADRESSE_FOURNISSEUR VARCHAR(128) NOT NULL  
   , PRIMARY KEY (NUM_FOURNISSEUR) 
 ) 
;

# -----------------------------------------------------------------------------
#       TABLE : ADMINISTRATEUR
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ADMINISTRATEUR
 (
   NUM_ADMIN INTEGER(2) NOT NULL AUTO_INCREMENT  ,
   ID BIGINT(6) NOT NULL  ,
   PRENOM_ADMIN VARCHAR(40) NOT NULL  ,
   NOM_ADMIN VARCHAR(50) NOT NULL  ,
   COURRIEL_ADMIN VARCHAR(50) NOT NULL  
   , PRIMARY KEY (NUM_ADMIN) 
 ) 
;

# -----------------------------------------------------------------------------
#       TABLE : UTILISATEUR
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS UTILISATEUR
 (
   NUM_UTILISATEUR BIGINT(5) NOT NULL AUTO_INCREMENT  ,
   NUM_NUTRITIONNISTE BIGINT(6) NULL  ,
   ID BIGINT(6) NOT NULL  ,
   PRENOM_UTILISATEUR VARCHAR(40) NOT NULL  ,
   NOM_UTILISATEUR VARCHAR(50) NOT NULL  ,
   COURRIEL_UTILISATEUR VARCHAR(50) NOT NULL  ,
   ADRESSE_UTILISATEUR VARCHAR(150) NULL  ,
   AGE INTEGER(3) NOT NULL  ,
   POIDS INTEGER(3) NOT NULL  ,
   TAILLE INTEGER(3) NOT NULL  
   , PRIMARY KEY (NUM_UTILISATEUR) 
 ) 
;

# -----------------------------------------------------------------------------
#       TABLE : CARENCES
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CARENCES
 (
   NUM_CARENCE INTEGER(2) NOT NULL AUTO_INCREMENT  ,
   NOM_CARENCE VARCHAR(40) NOT NULL  
   , PRIMARY KEY (NUM_CARENCE) 
 ) 
;

# -----------------------------------------------------------------------------
#       TABLE : ALLERGENES
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ALLERGENES
 (
   NUM_ALLERGENE INTEGER(2) NOT NULL AUTO_INCREMENT  ,
   NOM_ALLERGENE VARCHAR(40) NOT NULL  
   , PRIMARY KEY (NUM_ALLERGENE) 
 ) 
;

# -----------------------------------------------------------------------------
#       TABLE : USER_AUTH
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS USER_AUTH
 (
   ID BIGINT(6) NOT NULL AUTO_INCREMENT  ,
   PSEUDO VARCHAR(40) NOT NULL  ,
   MDP VARCHAR(50) NOT NULL  ,
   ACCOUNT_TYPE SMALLINT(1) NOT NULL  
   , PRIMARY KEY (ID) 
 ) 
;

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE USER_AUTH
# -----------------------------------------------------------------------------


CREATE UNIQUE INDEX I_UK_PSEUDO
     ON USER_AUTH (PSEUDO ASC);


# -----------------------------------------------------------------------------
#       TABLE : INGREDIENTS
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS INGREDIENTS
 (
   NUM_INGREDIENT BIGINT(4) NOT NULL AUTO_INCREMENT  ,
   NOM_INGREDIENT VARCHAR(40) NOT NULL  
   , PRIMARY KEY (NUM_INGREDIENT) 
 ) 
;

# -----------------------------------------------------------------------------
#       TABLE : NUTRITIONNISTE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS NUTRITIONNISTE
 (
   NUM_NUTRITIONNISTE BIGINT(6) NOT NULL AUTO_INCREMENT  ,
   ID BIGINT(6) NOT NULL  ,
   PRENOM_NUTRITIONNISTE VARCHAR(40) NOT NULL  ,
   NOM_NUTRITIONNISTE VARCHAR(50) NOT NULL  ,
   COURRIEL_NUTRITIONNISTE VARCHAR(50) NOT NULL  ,
   DESCRIPTION_NUTRITIONNISTE VARCHAR(300) NOT NULL  
   , PRIMARY KEY (NUM_NUTRITIONNISTE) 
 ) 
;

# -----------------------------------------------------------------------------
#       TABLE : ANC
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ANC
 (
   NUM_ANC INTEGER(2) NOT NULL AUTO_INCREMENT  ,
   NOM_ANC VARCHAR(40) NOT NULL  ,
   TYPE_ANC VARCHAR(40) NOT NULL  
   , PRIMARY KEY (NUM_ANC) 
 ) 
;

# -----------------------------------------------------------------------------
#       TABLE : ETAPE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ETAPE
 (
   NUM_ETAPE INTEGER(2) NOT NULL   ,
   NUM_RECETTE BIGINT(5) NOT NULL   ,
   INSTRUCTION_ETAPE VARCHAR(1000) NOT NULL  
   , PRIMARY KEY (NUM_ETAPE,NUM_RECETTE) 
 ) 
;

# -----------------------------------------------------------------------------
#       TABLE : PREFERER
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PREFERER
 (
   NUM_UTILISATEUR BIGINT(5) NOT NULL  ,
   NUM_RECETTE BIGINT(5) NOT NULL  
   , PRIMARY KEY (NUM_UTILISATEUR,NUM_RECETTE) 
 ) 
;

# -----------------------------------------------------------------------------
#       TABLE : ETRE_ALLERGIQUE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ETRE_ALLERGIQUE
 (
   NUM_UTILISATEUR BIGINT(5) NOT NULL  ,
   NUM_ALLERGENE INTEGER(2) NOT NULL  
   , PRIMARY KEY (NUM_UTILISATEUR,NUM_ALLERGENE) 
 ) 
;

# -----------------------------------------------------------------------------
#       TABLE : ASSOCIER
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ASSOCIER
 (
   NUM_RECETTE BIGINT(5) NOT NULL  ,
   NUM_ALLERGENE INTEGER(2) NOT NULL  
   , PRIMARY KEY (NUM_RECETTE,NUM_ALLERGENE) 
 ) 
;

# -----------------------------------------------------------------------------
#       TABLE : GERER
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS GERER
 (
   NUM_ADMIN INTEGER(2) NOT NULL  ,
   NUM_RECETTE BIGINT(5) NOT NULL  ,
   NUM_NUTRITIONNISTE BIGINT(6) NOT NULL  
   , PRIMARY KEY (NUM_ADMIN,NUM_RECETTE,NUM_NUTRITIONNISTE) 
 ) 
;

# -----------------------------------------------------------------------------
#       TABLE : CONTENIR
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CONTENIR
 (
   NUM_RECETTE BIGINT(5) NOT NULL  ,
   NUM_INGREDIENT BIGINT(4) NOT NULL  ,
   QUANTITE INTEGER(5) NOT NULL  ,
   UNITE VARCHAR(20) NULL  
   , PRIMARY KEY (NUM_RECETTE,NUM_INGREDIENT) 
 ) 
;

# -----------------------------------------------------------------------------
#       TABLE : ETRE_SUJET
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ETRE_SUJET
 (
   NUM_UTILISATEUR BIGINT(5) NOT NULL  ,
   NUM_CARENCE INTEGER(2) NOT NULL  
   , PRIMARY KEY (NUM_UTILISATEUR,NUM_CARENCE) 
 ) 
;

# -----------------------------------------------------------------------------
#       TABLE : FOURNIR
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS FOURNIR
 (
   NUM_INGREDIENT BIGINT(4) NOT NULL AUTO_INCREMENT  ,
   NUM_FOURNISSEUR BIGINT(4) NOT NULL  
   , PRIMARY KEY (NUM_INGREDIENT,NUM_FOURNISSEUR) 
 ) 
;

# -----------------------------------------------------------------------------
#       TABLE : POSSEDER
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS POSSEDER
 (
   NUM_ANC INTEGER(2) NOT NULL  ,
   NUM_RECETTE BIGINT(5) NOT NULL  
   , PRIMARY KEY (NUM_ANC,NUM_RECETTE) 
 ) 
;


# -----------------------------------------------------------------------------
#       CREATION DES REFERENCES DE TABLE
# -----------------------------------------------------------------------------


ALTER TABLE ADMINISTRATEUR 
  ADD FOREIGN KEY FK_ADMINISTRATEUR_USER_AUTH (ID)
      REFERENCES USER_AUTH (ID) ;


ALTER TABLE UTILISATEUR 
  ADD FOREIGN KEY FK_UTILISATEUR_NUTRITIONNISTE (NUM_NUTRITIONNISTE)
      REFERENCES NUTRITIONNISTE (NUM_NUTRITIONNISTE) ;


ALTER TABLE UTILISATEUR 
  ADD FOREIGN KEY FK_UTILISATEUR_USER_AUTH (ID)
      REFERENCES USER_AUTH (ID) ;


ALTER TABLE NUTRITIONNISTE 
  ADD FOREIGN KEY FK_NUTRITIONNISTE_USER_AUTH (ID)
      REFERENCES USER_AUTH (ID) ;


ALTER TABLE ETAPE 
  ADD FOREIGN KEY FK_ETAPE_RECETTE (NUM_RECETTE)
      REFERENCES RECETTE (NUM_RECETTE) ;


ALTER TABLE PREFERER 
  ADD FOREIGN KEY FK_PREFERER_UTILISATEUR (NUM_UTILISATEUR)
      REFERENCES UTILISATEUR (NUM_UTILISATEUR) ;


ALTER TABLE PREFERER 
  ADD FOREIGN KEY FK_PREFERER_RECETTE (NUM_RECETTE)
      REFERENCES RECETTE (NUM_RECETTE) ;


ALTER TABLE ETRE_ALLERGIQUE 
  ADD FOREIGN KEY FK_ETRE_ALLERGIQUE_UTILISATEUR (NUM_UTILISATEUR)
      REFERENCES UTILISATEUR (NUM_UTILISATEUR) ;


ALTER TABLE ETRE_ALLERGIQUE 
  ADD FOREIGN KEY FK_ETRE_ALLERGIQUE_ALLERGENES (NUM_ALLERGENE)
      REFERENCES ALLERGENES (NUM_ALLERGENE) ;


ALTER TABLE ASSOCIER 
  ADD FOREIGN KEY FK_ASSOCIER_RECETTE (NUM_RECETTE)
      REFERENCES RECETTE (NUM_RECETTE) ;


ALTER TABLE ASSOCIER 
  ADD FOREIGN KEY FK_ASSOCIER_ALLERGENES (NUM_ALLERGENE)
      REFERENCES ALLERGENES (NUM_ALLERGENE) ;


ALTER TABLE GERER 
  ADD FOREIGN KEY FK_GERER_ADMINISTRATEUR (NUM_ADMIN)
      REFERENCES ADMINISTRATEUR (NUM_ADMIN) ;


ALTER TABLE GERER 
  ADD FOREIGN KEY FK_GERER_RECETTE (NUM_RECETTE)
      REFERENCES RECETTE (NUM_RECETTE) ;


ALTER TABLE GERER 
  ADD FOREIGN KEY FK_GERER_NUTRITIONNISTE (NUM_NUTRITIONNISTE)
      REFERENCES NUTRITIONNISTE (NUM_NUTRITIONNISTE) ;


ALTER TABLE CONTENIR 
  ADD FOREIGN KEY FK_CONTENIR_RECETTE (NUM_RECETTE)
      REFERENCES RECETTE (NUM_RECETTE) ;


ALTER TABLE CONTENIR 
  ADD FOREIGN KEY FK_CONTENIR_INGREDIENTS (NUM_INGREDIENT)
      REFERENCES INGREDIENTS (NUM_INGREDIENT) ;


ALTER TABLE ETRE_SUJET 
  ADD FOREIGN KEY FK_ETRE_SUJET_UTILISATEUR (NUM_UTILISATEUR)
      REFERENCES UTILISATEUR (NUM_UTILISATEUR) ;


ALTER TABLE ETRE_SUJET 
  ADD FOREIGN KEY FK_ETRE_SUJET_CARENCES (NUM_CARENCE)
      REFERENCES CARENCES (NUM_CARENCE) ;


ALTER TABLE FOURNIR 
  ADD FOREIGN KEY FK_FOURNIR_INGREDIENTS (NUM_INGREDIENT)
      REFERENCES INGREDIENTS (NUM_INGREDIENT) ;


ALTER TABLE FOURNIR 
  ADD FOREIGN KEY FK_FOURNIR_FOURNISSEUR (NUM_FOURNISSEUR)
      REFERENCES FOURNISSEUR (NUM_FOURNISSEUR) ;


ALTER TABLE POSSEDER 
  ADD FOREIGN KEY FK_POSSEDER_ANC (NUM_ANC)
      REFERENCES ANC (NUM_ANC) ;


ALTER TABLE POSSEDER 
  ADD FOREIGN KEY FK_POSSEDER_RECETTE (NUM_RECETTE)
      REFERENCES RECETTE (NUM_RECETTE) ;

