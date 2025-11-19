-- ============================================================
-- Système de Gestion de Scolarité — Version complète et alignée
-- ============================================================

-- 1. Création de la base
CREATE DATABASE IF NOT EXISTS gestion_scolarite;
USE gestion_scolarite;

-- 2. Création des tables
CREATE TABLE IF NOT EXISTS etudiants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    date_naissance DATE
);

CREATE TABLE IF NOT EXISTS cours (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom_cours VARCHAR(100) NOT NULL,
    credits INT NOT NULL CHECK (credits >= 0)
);

CREATE TABLE IF NOT EXISTS inscriptions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    etudiant_id INT NOT NULL,
    cours_id INT NOT NULL,
    UNIQUE (etudiant_id, cours_id),
    FOREIGN KEY (etudiant_id) REFERENCES etudiants(id) ON DELETE CASCADE,
    FOREIGN KEY (cours_id) REFERENCES cours(id) ON DELETE CASCADE
);

-- 3. Données de test (insert si non présent)
INSERT INTO etudiants (nom, prenom, date_naissance)
SELECT 'Dupont', 'Jeanne', '1998-03-12'
WHERE NOT EXISTS (
    SELECT 1 FROM etudiants WHERE nom='Dupont' AND prenom='Jeanne'
);

INSERT INTO etudiants (nom, prenom, date_naissance)
SELECT 'Martin', 'Claire', '1999-11-05'
WHERE NOT EXISTS (
    SELECT 1 FROM etudiants WHERE nom='Martin' AND prenom='Claire'
);

INSERT INTO etudiants (nom, prenom, date_naissance)
SELECT 'Nguyen', 'Thierry', '2000-07-22'
WHERE NOT EXISTS (
    SELECT 1 FROM etudiants WHERE nom='Nguyen' AND prenom='Thierry'
);

INSERT INTO cours (nom_cours, credits)
SELECT 'Mathématiques', 6
WHERE NOT EXISTS (SELECT 1 FROM cours WHERE nom_cours='Mathématiques');

INSERT INTO cours (nom_cours, credits)
SELECT 'Informatique', 8
WHERE NOT EXISTS (SELECT 1 FROM cours WHERE nom_cours='Informatique');

INSERT INTO cours (nom_cours, credits)
SELECT 'Physique', 5
WHERE NOT EXISTS (SELECT 1 FROM cours WHERE nom_cours='Physique');

-- 4. Utilisateur applicatif
CREATE USER IF NOT EXISTS 'gestion_user'@'localhost' IDENTIFIED BY 'MotDePasseFort2025!';
GRANT SELECT, INSERT, UPDATE, DELETE ON gestion_scolarite.* TO 'gestion_user'@'localhost';
FLUSH PRIVILEGES;

-- ============================================================
-- 5. Requêtes de démonstration (compatibles DAO)
-- ============================================================

-- Liste des étudiants
SELECT e.id AS id_etudiant,
       e.nom,
       e.prenom,
       e.date_naissance
FROM etudiants e
ORDER BY e.id;

-- Liste des cours
SELECT c.id AS id_cours,
       c.nom_cours,
       c.credits
FROM cours c
ORDER BY c.id;

-- Liste des inscriptions (globale)
SELECT i.id AS id_inscription,
       e.id AS etudiant_id,
       e.nom AS nom_etudiant,
       e.prenom AS prenom_etudiant,
       c.id AS cours_id,
       c.nom_cours
FROM inscriptions i
JOIN etudiants e ON i.etudiant_id = e.id
JOIN cours c ON i.cours_id = c.id
ORDER BY i.id;

-- Démo: Étudiants inscrits au cours ID 2
SELECT i.id AS id_inscription,
       e.id AS etudiant_id,
       e.nom AS nom_etudiant,
       e.prenom AS prenom_etudiant,
       e.date_naissance,
       c.nom_cours
FROM inscriptions i
JOIN etudiants e ON i.etudiant_id = e.id
JOIN cours c ON i.cours_id = c.id
WHERE i.cours_id = 2
ORDER BY e.nom, e.prenom;

-- Démo: Cours suivis par l’étudiant ID 1
SELECT i.id AS id_inscription,
       c.id AS cours_id,
       c.nom_cours,
       c.credits,
       e.id AS etudiant_id,
       e.nom AS nom_etudiant,
       e.prenom AS prenom_etudiant
FROM inscriptions i
JOIN cours c ON i.cours_id = c.id
JOIN etudiants e ON i.etudiant_id = e.id
WHERE i.etudiant_id = 1
ORDER BY c.nom_cours;

-- 6. Vérification des connexions actives
SHOW PROCESSLIST;
