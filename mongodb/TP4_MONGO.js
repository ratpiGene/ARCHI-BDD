const db = db.getSiblingDB("TP4") // Base TP4
db.orders.drop()

// insertions
db.orders.insertMany([
  { montant: 240.50, date: ISODate("2024-03-15T10:12:00Z") },
  { montant: 125.00, date: ISODate("2024-03-20T14:30:00Z") },
  { montant: 340.00, date: ISODate("2024-01-10T09:00:00Z") },
  { montant: 420.75, date: ISODate("2024-01-22T16:45:00Z") },
  { montant: 275.30, date: ISODate("2024-02-05T12:00:00Z") },
  { montant: 198.00, date: ISODate("2024-02-12T18:20:00Z") },
  { montant: 589.60, date: ISODate("2024-04-01T08:10:00Z") },
  { montant: 650.00, date: ISODate("2024-04-15T11:40:00Z") },
  { montant: 305.90, date: ISODate("2023-12-30T13:00:00Z") },
  { montant: 180.40, date: ISODate("2023-11-22T10:30:00Z") },
  { montant: 90.00,  date: ISODate("2023-10-10T17:00:00Z") },
  { montant: 360.00, date: ISODate("2024-05-05T13:25:00Z") },
  { montant: 75.00,  date: ISODate("2024-05-18T09:50:00Z") },
  { montant: 520.00, date: ISODate("2024-06-01T07:30:00Z") },
  { montant: 430.00, date: ISODate("2024-06-12T11:00:00Z") },
  { montant: 215.25, date: ISODate("2024-07-05T14:45:00Z") },
  { montant: 175.50, date: ISODate("2024-07-19T15:35:00Z") },
  { montant: 390.00, date: ISODate("2024-08-01T10:10:00Z") },
  { montant: 290.00, date: ISODate("2024-08-22T17:30:00Z") },
  { montant: 480.00, date: ISODate("2024-09-01T08:50:00Z") }
])


// pipeline
db.orders.aggregate([
  // Étape 1 : extraire mois + année
  {
    $project: {
      montant: 1,
      mois: { $month: "$date" },
      annee: { $year: "$date" }
    }
  },
  // Étape 2 : grouper par mois + année et sommer les montants
  {
    $group: {
      _id: { mois: "$mois", annee: "$annee" },
      totalCA: { $sum: "$montant" }
    }
  },
  // Étape 3 : trier du plus gros CA au plus petit
  {
    $sort: { totalCA: -1 }
  }
])


// bonus 
db.orders.aggregate([
  {
    $project: {
      montant: 1,
      mois: { $month: "$date" },
      annee: { $year: "$date" }
    }
  },
  {
    $group: {
      _id: { mois: "$mois", annee: "$annee" },
      totalCA: { $sum: "$montant" }
    }
  },
  { $sort: { totalCA: -1 } },
  { $skip: 5 },
  { $limit: 5 }
])
