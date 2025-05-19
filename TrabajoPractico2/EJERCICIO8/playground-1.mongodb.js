//Insertarmos cursos
db.cursosEJ8.insertMany([
    { _id: 1, nombre_curso: "ED FISICA" },
    { _id: 2, nombre_curso: "FISICA" },
    { _id: 3, nombre_curso: "MATE" }
])
  
  //Insertarmos alumnos
  db.alumnosEJ8.insertMany([
    { nombre: "JERE", curso_id: 1 },
    { nombre: "PEDRO", curso_id: 2 },
    { nombre: "GONZA", curso_id: 3 },
    { nombre: "MARIAN", curso_id: 1 }
  ])
  
