
# 🎓 Gestion Scolarité

Dans le cadre d’un projet destiné à appliquer concrètement les notions étudiées en conception logicielle et en persistance des données, nous sommes chargés de développer une application en ligne de commande pour une petite école. Cette application doit permettre au personnel administratif de gérer les étudiants et leurs inscriptions aux cours.  
Ce projet utilise une structure de packages professionnelle (`com.ecole.model`, `com.ecole.dao`) et une base MySQL robuste.

---

## 📂 Structure du projet

```
gestion_scolarite/
 ├── src/
 │   └── java/
 │       └── com/
 │           └── ecole/
 │               ├── model/
 │               │    ├── Etudiant.java
 │               │    ├── Cours.java
 │               │    └── Inscription.java
 │               ├── dao/
 │               │    ├── EtudiantDAO.java
 │               │    ├── CoursDAO.java
 │               │    ├── InscriptionDAO.java
 │               │    └── DatabaseConnection.java
 │               └── Main.java
 └── README.md

```

## ⚙️ Prérequis

- **Java JDK 17+** (ou version compatible)
- **MySQL** installé et configuré
- Base de données `gestion_scolarite` avec les tables suivantes :

```sql
CREATE TABLE etudiants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    date_naissance DATE
);

CREATE TABLE cours (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom_cours VARCHAR(100),
    credits INT
);

CREATE TABLE inscriptions (
    etudiant_id INT,
    cours_id INT,
    PRIMARY KEY (etudiant_id, cours_id),
    FOREIGN KEY (etudiant_id) REFERENCES etudiants(id),
    FOREIGN KEY (cours_id) REFERENCES cours(id)
);
```

---

## 🚀 Compilation et exécution
### 1. Compiler
```bash
javac src/java/com/ecole/**/*.java
```

### 2. Lancer le programme
```bash
java -cp src/java com.ecole.Main
```

---
## 🖥️ Fonctionnalités
- Ajouter, modifier, supprimer un étudiant
- Ajouter, modifier, supprimer un cours
- Inscrire un étudiant à un cours
- Lister les étudiants, les cours, les inscriptions
- Afficher les étudiants inscrits à un cours
- Afficher les cours suivis par un étudiant (fonction uniquement réalisée sur fichier .sql)
---

## 📌 Notes
- Les identifiants (`id`) sont générés automatiquement par MySQL (`AUTO_INCREMENT`)
- Les packages suivent les conventions professionnelles (`com.ecole.model`, `com.ecole.dao`)
- Le fichier `DatabaseConnection.java` doit être configuré avec ton **utilisateur MySQL** et ton **mot de passe**
- La racine des packages est `src/java`, ce qui explique la commande `javac src/java/...`

---
# 🧠 Défis techniques surmontés
Ce projet a été l’occasion de résoudre plusieurs problématiques concrètes :

### 🔄 Synchronisation Java ↔ SQL
- Utilisation de `PreparedStatement` pour sécuriser les requêtes
- Mapping clair entre les alias SQL et les attributs Java

### 🧼 Refactoring et modularité
- DAO séparés pour chaque entité
- Méthodes comme `existeEtudiant()` et `existeCours()` pour alléger `Main.java`

### 🧠 Conflits de noms
- Résolution des collisions dans les lambdas (`e`, `c`) via renommage (`et`, `co`) ou refactoring

### 🔐 Sécurité MySQL
- Création d’un utilisateur `gestion_user` avec privilèges limités (`SELECT`, `INSERT`, `UPDATE`, `DELETE`)
- Vérification et configuration via MySQL Workbench

### 🧾 Script SQL robuste
- Structure complète avec clés primaires, étrangères, contraintes
- Requêtes de démonstration pour tester les fonctionnalités
- Gestion des réinsertions conditionnelles (ex: Jeanne revient si supprimée)
---
# 🛠️ Problèmes rencontrés et solutions
### 1. Erreur `chcp` dans MySQL Workbench
- **Cause** : page de code locale incompatible
- **Solution** : activer UTF-8 dans les paramètres régionaux Windows

### 2. Remote Management grisé
- **Cause** : type d’installation incorrect
- **Solution** : passer à `Windows (MySQL Installer)`

### 3. Connexions multiples
- **Cause** : connexions système internes
- **Solution** : vérification via `SHOW PROCESSLIST;`

### 4. Gestion des privilèges
- **Solution** : création de rôles dédiés (`data_reader`, `data_writer`, `dev_schema`, `root`)
---

# ✅ Conclusion
Le projet est terminé, fonctionnel, et prêt à être présenté.  
J'ai démontré une maîtrise complète de la gestion de données, de la structuration Java/SQL, et de la résolution de problèmes techniques.  
Ce projet peut facilement évoluer vers une interface web, une API REST, ou une application mobile.

---