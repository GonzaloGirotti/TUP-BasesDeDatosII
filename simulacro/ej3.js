use("Simulacro");
//3. Pipeline de agregación: análisis de ventas por categoría Colección ventas con datos de ejemplo:

/**
Escribe en la consola de MongoDB (o utiliza recursos en línea) el pipeline de agregación
(db.ventas.aggregate([...])) que:

1.Filtre las ventas entre el 1 de enero y el 31 de marzo de 2025.
2.Agrupe por categoria, calculando el total de ventas y el número de transacciones.
3.Ordene los resultados de forma descendente por total de ventas.
4.Limite la salida a las tres categorías con mayor facturación.
*/


/*
Un aggregate en MongoDB es una operación que procesa y transforma conjuntos de documentos 
usando una serie de etapas llamadas pipeline, para obtener resultados resumidos, filtrados 
o calculados. Es como hacer consultas avanzadas que pueden agrupar, ordenar, filtrar y
 calcular datos en varios pasos.
*/
db.ventas.aggregate([//aggregate: método que ejecuta un pipeline de operaciones para procesar y transformar documentos
    {
        $match: {//Filtra documentos, similar a una consulta find().
            fecha:{
                $gte: ISODate("2025-01-01"),
                $lte: ISODate("2025-03-31")
            }
        }
    },
    {
        $group: {//Agrupa documentos por campos específicos y aplica operadores de acumulación.
            _id: "$categoria",// Agrupamos por la categoría
            totalVentas: {$sum: "$monto"},// Suma total de ventas en esa categoría
            CantidadTrans: {$sum: 1}// Cuenta cuántas ventas hay
        }
    },
    {
        $sort: {//Ordena los documentos.
            totalVentas :-1 // -1 indica orden descendente
        }
    },
    {
        $limit: 3
    }

])

