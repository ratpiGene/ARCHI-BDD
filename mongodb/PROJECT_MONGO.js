const db = db.getSiblingDB("PROJET")

// Collection AUTEURS
// { _id: ObjectId, nom: String, prenom: String, date_naissance: Date }

// Collection LIVRES
// { _id: ObjectId, titre: String, auteurs: [ObjectId], categorie: String, editeur: String, annee_edition: Number }

// Collection UTILISATEURS
// { _id: ObjectId, nom: String, prenom: String, email: String }

// Collection EMPRUNTS
// { _id: ObjectId, utilisateur: ObjectId, livre: ObjectId, date_emprunt: Date, date_retour: Date, evaluation: Number }

// initialisation des collections
db.createCollection("auteurs")
db.createCollection("livres")
db.createCollection("utilisateurs")
db.createCollection("emprunts")

// Insertion 
db.auteurs.insertMany([
  { _id: ObjectId("64a1f1a00000000000000001"), nom: "Martin", prenom: "Paul", date_naissance: ISODate("1970-05-10") },
  { _id: ObjectId("64a1f1a00000000000000002"), nom: "Durand", prenom: "Emma", date_naissance: ISODate("1985-11-23") },
  { _id: ObjectId("64a1f1a00000000000000003"), nom: "Nguyen", prenom: "Linh", date_naissance: ISODate("1990-07-15") }
])

db.livres.insertMany([
  {
    _id: ObjectId("64a1f1b00000000000000001"),
    titre: "L’Ombre du vent",
    auteurs: [ObjectId("64a1f1a00000000000000001")],
    categorie: "Roman",
    editeur: "Gallimard",
    annee_edition: 2001
  },
  {
    _id: ObjectId("64a1f1b00000000000000002"),
    titre: "Data Science 101",
    auteurs: [ObjectId("64a1f1a00000000000000002"), ObjectId("64a1f1a00000000000000003")],
    categorie: "Informatique",
    editeur: "O'Reilly",
    annee_edition: 2020
  },
  {
    _id: ObjectId("64a1f1b00000000000000003"),
    titre: "La Vie Moderne",
    auteurs: [ObjectId("64a1f1a00000000000000003")],
    categorie: "Essai",
    editeur: "Seuil",
    annee_edition: 2015
  },
  {
    _id: ObjectId("64a1f1b00000000000000004"),
    titre: "Introduction à MongoDB",
    auteurs: [ObjectId("64a1f1a00000000000000002")],
    categorie: "Informatique",
    editeur: "Eyrolles",
    annee_edition: 2022
  }
])

db.utilisateurs.insertMany([
  { _id: ObjectId("64a1f1c00000000000000001"), nom: "Dubois", prenom: "Alice", email: "alice@example.com" },
  { _id: ObjectId("64a1f1c00000000000000002"), nom: "Morel", prenom: "Lucas", email: "lucas@example.com" }
])

db.emprunts.insertMany([
  {
    utilisateur: ObjectId("64a1f1c00000000000000001"),
    livre: ObjectId("64a1f1b00000000000000001"),
    date_emprunt: ISODate("2025-05-10"),
    date_retour: ISODate("2025-05-17"),
    evaluation: 4
  },
  {
    utilisateur: ObjectId("64a1f1c00000000000000002"),
    livre: ObjectId("64a1f1b00000000000000002"),
    date_emprunt: ISODate("2025-05-01"),
    date_retour: ISODate("2025-05-08")
  },
  {
    utilisateur: ObjectId("64a1f1c00000000000000001"),
    livre: ObjectId("64a1f1b00000000000000003"),
    date_emprunt: ISODate("2025-04-20"),
    date_retour: ISODate("2025-04-30"), 
    evaluation: 5
  }
])
