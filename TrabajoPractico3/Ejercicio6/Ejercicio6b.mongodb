db.ventas.aggregate([
    {
        $project: {
            diaDeLaSemana: { $dayOfWeek: "$fecha" }
        }
    },
    {
        $group: {
            _id: "$diaDeLaSemana",
            cantidad: { $sum: 1 }
        }
    },
    {
        $sort:{ cantidad: -1 }
    },
    {
        $limit: 1
    }




])