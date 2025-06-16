// select database TP2
const db = db.getSiblingDB("TP2")

// Nettoyage préalable
db.students.drop()
db.courses.drop()
db.professors.drop()

// Étape 1 — Préparation des données

// Insertion des professeurs
const profs = db.professors.insertMany([
  { name: "Dr. Karim" },
  { name: "Dr. Sophie" }
]).insertedIds

// Insertion des cours (avec référence au prof)
const cours = db.courses.insertMany([
  { title: "Mathématiques", professorId: profs[0] },
  { title: "Physique", professorId: profs[1] },
  { title: "Informatique", professorId: profs[0] }
]).insertedIds

// Insertion des étudiants avec références aux cours
db.students.insertMany([
  { name: "Ali", courses: [cours[0], cours[1]] },
  { name: "Emma", courses: [cours[1], cours[2]] }
])

// Étape 2 — Jointure simple 
db.students.aggregate([
  {
    $lookup: {
      from: "courses",
      localField: "courses",
      foreignField: "_id",
      as: "course_details"
    }
  }
])

// Étape 3 — Jointure + unwind + projet
db.students.aggregate([
  {
    $lookup: {
      from: "courses",
      localField: "courses",
      foreignField: "_id",
      as: "course_details"
    }
  },
  { $unwind: "$course_details" },
  {
    $project: {
      _id: 0,
      name: 1,
      course_title: "$course_details.title"
    }
  }
])

// Etape 4 — Jointure avec les professeurs
db.students.aggregate([
  {
    $lookup: {
      from: "courses",
      localField: "courses",
      foreignField: "_id",
      as: "course_details"
    }
  },
  { $unwind: "$course_details" },
  {
    $lookup: {
      from: "professors",
      let: { profId: "$course_details.professorId" },
      pipeline: [
        { $match: { $expr: { $eq: ["$_id", "$$profId"] } } }
      ],
      as: "professor_details"
    }
  },
  { $unwind: "$professor_details" },
  {
    $project: {
      _id: 0,
      student_name: "$name",
      course_title: "$course_details.title",
      professor_name: "$professor_details.name"
    }
  }
])
