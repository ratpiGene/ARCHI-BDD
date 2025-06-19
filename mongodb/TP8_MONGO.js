const db = db.getSiblingDB("TP8") // Base TP8

// 1. Insertion des documents dans la collection employes
db.employes.insertMany([
  { _id: 1, nom: "Alice", age: 30, salaire: 3000 },
  { _id: 2, nom: "Bob", age: 25, salaire: 2500 },
  { _id: 3, nom: "Charlie", age: 35, salaire: 4000 },
  { _id: 4, nom: "David", age: 28, salaire: 2800 }
])

// 2. Query *
// 2.1 Afficher les employés avec age > 28
db.employes.find({ age: { $gt: 28 } })

// 2.2 Afficher les employés avec salaire <= 2800
db.employes.find({ salaire: { $lte: 2800 } })

// 2.3 Afficher les employés avec age between 26 and 35
db.employes.find({ age: { $gte: 26, $lte: 35 } })

// 2.4 Afficher les employés avec salaire <> 3000
db.employes.find({ salaire: { $ne: 3000 } })
