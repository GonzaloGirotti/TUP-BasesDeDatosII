db.ventas.aggregate([
{
    $project: {
        categoria: {
        $cond: [
            { $lt: ["$total", 200] }, "Pequeña",
            {
            $cond: [
                { $lte: ["$total", 800] }, "Mediana",
                "Grande"
            ]
            }
        ]
        }
    }
    },
    {
    $group: {
        _id: "$categoria",
        cantidad: { $sum: 1 }
    }
    }
])
