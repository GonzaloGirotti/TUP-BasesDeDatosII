db.productos.aggregate([
{
    $project: {
        categoria: {
        $cond: [
            { $lt: ["$precio", 100] }, "Económico",
            {
            $cond: [
                { $lte: ["$precio", 500] }, "Estándar",
                "Premium"
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
