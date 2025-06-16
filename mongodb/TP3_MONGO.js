const db = db.getSiblingDB("TP3") // Base TP3

// Nettoyage de la collection si elle existe déjà
db.products.drop()

// Products + documents 
db.products.insertMany([
  {
    name: "Clavier",
    price: 49.99,
    description: "Clavier mécanique rétroéclairé",
    location: [2.35, 48.86],
    specs: { color: "noir", switches: "red", usb: true }
  },
  {
    name: "Souris",
    price: 29.99,
    description: "Souris optique sans fil",
    location: [2.36, 48.85],
    specs: { color: "blanc", dpi: 1600, bluetooth: true }
  },
  {
    name: "Écran",
    price: 199.99,
    description: "Écran 24 pouces full HD",
    location: [2.30, 48.87],
    specs: { resolution: "1920x1080", refresh: 75 }
  },
  {
    name: "Casque",
    price: 79.99,
    description: "Casque audio avec réduction de bruit",
    location: [2.28, 48.88],
    specs: { color: "gris", wireless: true }
  },
  {
    name: "Webcam",
    price: 59.99,
    description: "Webcam HD pour streaming",
    location: [2.29, 48.84],
    specs: { resolution: "1080p", fps: 60 }
  },
  {
    name: "Micro",
    price: 89.99,
    description: "Microphone studio USB",
    location: [2.32, 48.83],
    specs: { cardioid: true, usb: true }
  },
  {
    name: "Clé USB",
    price: 14.99,
    description: "Clé USB 64Go",
    location: [2.33, 48.89],
    specs: { capacity: "64GB", usb3: true }
  },
  {
    name: "Chargeur",
    price: 24.99,
    description: "Chargeur rapide 20W",
    location: [2.34, 48.82],
    specs: { power: "20W", usb_c: true }
  },
  {
    name: "Support",
    price: 19.99,
    description: "Support écran ajustable",
    location: [2.37, 48.87],
    specs: { adjustable: true, material: "metal" }
  },
  {
    name: "Hub USB",
    price: 39.99,
    description: "Hub USB avec 4 ports",
    location: [2.38, 48.88],
    specs: { ports: 4, usb3: true }
  }
])

// Indexation
// 1. Index simple
db.products.createIndex({ name: 1 })

// 2. Index composé
db.products.createIndex({ name: 1, price: -1 })

// 3. Index textuel
db.products.createIndex({ description: "text" })

// 4. Index géospatial
db.products.createIndex({ location: "2dsphere" })

// 5. Index wildcard
db.products.createIndex({ "specs.$**": 1 })

// 🧾 Vérification des index
db.products.getIndexes()

// rqt sans index
db.products.find({ name: "Clavier" })
  .explain("executionStats")

// rqt avec index
db.products.find({ name: "Clavier" })
  .hint({ name: 1 })
  .explain("executionStats")
