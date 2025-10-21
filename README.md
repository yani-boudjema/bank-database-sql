# 💳 Base de Données Relationnelle – Gestion Bancaire

## 📌 Description
Ce projet propose une **base de données relationnelle MySQL** simulant la gestion d’une banque.  
Il couvre la gestion des **clients, employés, comptes bancaires, opérations, transactions** et inclut des **procédures stockées** ainsi que des **déclencheurs (triggers)** pour assurer l’intégrité des données et automatiser certaines actions.

## 🗂️ Structure des Tables
La base est composée des tables suivantes :

- **personne** : informations générales sur les individus (clients, employés).
- **employe** : informations liées aux employés de la banque.
- **compte_bancaire** : gestion des comptes bancaires (solde, type, carte associée).
- **client** : lien entre une personne et son compte bancaire.
- **operationn** : opérations effectuées (ouverture, fermeture, transaction).
- **transactionn** : transactions monétaires (montant, date).
- **decision** : validation ou refus des opérations/transactions.
- **interne** : transactions internes (dépôt, retrait).
- **externe** : transactions externes avec IBAN.

## 🔑 Contraintes & Intégrité
- **Clés primaires** pour chaque table.  
- **Clés étrangères** assurant les relations entre les entités (par ex. : un client est lié à une personne et un compte bancaire).  
- **Contraintes d’unicité** (ex : un compte bancaire ne peut appartenir qu’à un seul client).  
- **Checks** pour garantir la validité (ex : format numéro de téléphone, solde suffisant pour un transfert).  

## ⚙️ Procédures Stockées
Deux procédures principales :

### `p_ajouterNouveauClient`
- Vérifie l’âge minimal (19 ans).  
- Ajoute une nouvelle personne, crée un compte bancaire et inscrit le client.  
- Enregistre automatiquement une **opération d’ouverture de compte**.

👉 Exemple d’appel :
```sql
CALL p_ajouterNouveauClient(
  'John', 'Doe', '1990-01-01', 'Française', 
  '123 Rue Example', 123456789, '2023-01-01', 
  1000, 'perso', 'standard'
);
```

### `p_effectuerTransfert`
- Vérifie l’existence des comptes source et destination.  
- Vérifie le solde suffisant du compte source.  
- Effectue un transfert sécurisé (mise à jour des soldes avec transaction).  
- Enregistre une transaction et les opérations associées.

👉 Exemple d’appel :
```sql
CALL p_effectuerTransfert(2, 1, 500);
```

## 🔄 Déclencheur (Trigger)
### `before_insert_operationn`
Avant toute insertion dans `operationn` :
- Vérifie l’existence des comptes.  
- Vérifie le solde suffisant du compte source.  
- Met à jour automatiquement les soldes des comptes concernés en cas de transaction.  

## 🧪 Jeu de Données (Inserts)
Des exemples de données initiales sont fournis :  
- 5 personnes.  
- 5 employés.  
- 5 comptes bancaires.  
- 5 clients liés aux comptes.  
- (Exemples de transactions et opérations commentés pour tests).  

## 🚀 Installation & Exécution
1. Crée une base de données dans MySQL :
   ```sql
   CREATE DATABASE banque;
   USE banque;
   ```
2. Exécute le script SQL fourni (`banque.sql`).  
3. Vérifie la création des tables :
   ```sql
   SHOW TABLES;
   ```
4. Lance des tests avec les **INSERT**, **procédures stockées** et **triggers**.  

## 📊 Modèle Relationnel Simplifié
```
[Personne] 1---N [Employe]
[Personne] 1---N [Client] N---1 [Compte_Bancaire]
[Compte_Bancaire] 1---N [Operationn] N---N [Transactionn] --- [Decision]
[Transactionn] 1---1 [Interne]
[Transactionn] 1---1 [Externe]
```

## ✨ Fonctionnalités futures (suggestions)
- Gestion des **crédits** et **intérêts**.  
- Ajout d’un **historique détaillé** des opérations avec journaux.  
- Interface applicative pour interagir avec la BDD (Java/Python/PHP).  
