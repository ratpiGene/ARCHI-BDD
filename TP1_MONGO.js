db.users.drop()
db.users.insertMany([
  {
    username: "alice",
    email: "alice@example.com",
    profile: {
      age: 28,
      address: "123 rue de Paris",
      interests: ["lecture", "voyage"]
    }
  },
  {
    username: "bob",
    email: "bob@example.com",
    profile: {
      age: 35,
      address: "456 avenue de Lyon",
      interests: ["musique", "sport"]
    }
  }
])

db.blogPosts.drop()
db.blogPosts.insertOne({
  title: "Premier article",
  content: "Bienvenue sur le blog !",
  comments: [
    { author: "alice", text: "Bravo pour cet article !" },
    { author: "bob", text: "Très instructif, merci !" }
  ]
})

// Création d’un nouveau post
const postRefId = db.blogPosts.insertOne({
  title: "Article avec beaucoup de commentaires",
  content: "Voici un article plus long..."
}).insertedId

// Insertion de commentaires dans une collection séparée
db.comments.drop()
db.comments.insertMany([
  { postId: postRefId, author: "alice", text: "J'adore ce contenu." },
  { postId: postRefId, author: "bob", text: "Très utile, merci." },
  { postId: postRefId, author: "charlie", text: "Je recommande à mes amis !" }
])

db.students.drop()
db.courses.drop()

// Cours
db.courses.insertMany([
  { _id: 101, name: "Maths" },
  { _id: 102, name: "Physique" },
  { _id: 103, name: "Informatique" }
])

// Étudiants avec array d’ID de cours
db.students.insertMany([
  { name: "Alice", courseIds: [101, 102] },
  { name: "Bob", courseIds: [102, 103] },
  { name: "Charlie", courseIds: [101, 103] }
])

db.users.find()

const post = db.blogPosts.findOne({ title: "Article avec beaucoup de commentaires" })
db.comments.find({ postId: post._id })

const etu = db.students.findOne({ name: "Charlie" })
db.courses.find({ _id: { $in: etu.courseIds } })
