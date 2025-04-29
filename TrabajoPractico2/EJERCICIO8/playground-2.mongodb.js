
  //lookup convina alumnos con cursos


db.alumnosEJ8.aggregate([
    {
      $lookup: {
        from: "cursosEJ8",
        localField: "curso_id",
        foreignField: "_id",
        as: "curso_info"
      }
    },
    {
      $unwind: "$curso_info"
    },
    {
      $project: {
        _id: 0,
        nombre: 1,
        curso: "$curso_info.nombre_curso"
      }
    }
  ])
