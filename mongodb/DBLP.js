use('DBLP');
db.createCollection('publis');

db.publis.insertOne({
    type: "Book",
    title: "BASE analysis of NoSQL database",
    year: 2015,
    publisher: "Elsevier",
    authors: ["Chandra Ganesh"],
    source: "DBLP"
  });

  db.publis.insertMany([
    {
      type: "Article",
      title: "Italian Brainrot",
      year: 2025,
      journal: "Tiktok Academy",
      authors: ["Crocodilo Bombardilo", "Bombardini Guzzini"],
      source: "Google Scholar"
    },
    {
      type: "Article",
      title: "Jesse, We need to cook.",
      year: 2020,
      journal: "Breaking Bad Journal",
      authors: ["Walter White", "Heisenberg"],
      source: "Netflix"
    }
  ]);
  
db.publis.find();


