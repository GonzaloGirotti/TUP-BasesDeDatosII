use("Simulacro");

/*
2. Modelado de datos: documentos embebidos y
referencias Colecciones con datos de ejemplo para realizar el $lookup:

Escribe en la consola de MongoDB (o utiliza recursos en línea) 
la consulta aggregate que utilice $lookup para devolver cada documento de clientes incluyendo
un arreglo pedidos con sus pedidos asociados.
*/


db.clientes.aggregate([
    {
        $lookup: {
            from: "pedidos",            // colección con la que haces join . from seria de
            localField: "_id",          // campo en clientes . campolocal
            foreignField: "cliente_id", // campo en pedidos que referencia a clientes. campo extranjero
            as: "Pedidos_clientes"      // nombre del nuevo arreglo con los pedidos asociados. el as devuelve areglo
        }
    }

])

