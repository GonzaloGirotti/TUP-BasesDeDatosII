use("Simulacro");


/*
Escribe en la consola de MongoDB (o utiliza recursos en línea) las sentencias para:

Listar todos los estudiantes cuya edad esté entre 20 y 25 años (inclusive).
Incrementar en 0.2 el campo promedio de todos los estudiantes de la carrera “Ingeniería”.
Eliminar los estudiantes que tengan un promedio menor a 7.
Buscar los estudiantes cuyo nombre comience con la letra “M” o cuyo promedio sea mayor o igual a 9.

🧠 Operadores de comparación
$eq — Igual a: { campo: { $eq: valor } }
$ne — Distinto de: { campo: { $ne: valor } }
$gt — Mayor que: { campo: { $gt: valor } }
$gte — Mayor o igual que: { campo: { $gte: valor } }
$lt — Menor que: { campo: { $lt: valor } }
$lte — Menor o igual que: { campo: { $lte: valor } }
$in — Dentro de un conjunto: { campo: { $in: [v1, v2] } }
$nin — No está en un conjunto: { campo: { $nin: [v1, v2] } }
🔗 Operadores lógicos
$and, $or, $not, $nor
*/


//.find({ ... }): busca documentos que cumplan con la condición.
db.estudiantes.find({
    "edad": {$gte: 20 , $lte: 25}
})
//$inc es un operador de actualización que se usa para incrementar 
// (o decrementar) el valor de un campo numérico en un documento.
//{ $inc: { campo: valor } }

db.estudiantes.updateMany(
    {
        "carrera": "Ingeniería" 

    },
    {
        $inc : {"promedio": 0.2}
    }   
)

db.estudiantes.deleteMany(
    {
        "promedio": {$lt: 7}
    }

)
db.estudiantes.find({
    $or: [
        { 
            nombre: { $regex: /^M/ } 
        },
        { 
            promedio: { $gte: 9 } 
        }
    ]
})
