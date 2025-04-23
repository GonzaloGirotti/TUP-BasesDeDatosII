# INDICES

## QUE SON LOS INDICES?

En SQL, un índice es una estructura de datos asociada a una tabla que acelera la búsqueda y recuperación de datos. 
● Los índices en bases de datos son fundamentales para optimizar el rendimiento de las
consultas y mejorar la experiencia de los usuarios.
● En aplicaciones reales, el acceso rápido a la información es crucial, especialmente
cuando se trabaja con grandes volúmenes de datos.
● Sin índices, la búsqueda de registros puede volverse lenta y afectar la eficiencia
general del sistema.

## EJEMPLO PRÁCTICO:

### *FOTO 1:*
Se crea una tabla Empleado con 4 campos:
- id -> INT PRIMARY KEY AUTO_INCREMENT
- nombre -> VARCHAR(30) NOT NULL
- apellido -> VARCHAR(30) NOT NULL
- salario -> INT NOT NULL

Y se agregan 3 registros:
Pepe, Gomez, 30000
Juan, Gomez, 100000
Alberto, Perez, 200000

### *FOTO 2:*
Se realizan 2 consultas, con la cláusula explain explicando el metodo de ejecución de las mismas, **SIN UTILIZAR INDICES**:

**1 --> EXPLAIN SELECT * FROM Empleado WHERE apellido='Gomez';**

Aqui observamos que se analizan las 3 filas (si observamos la columna 'rows' del explain que tiene valor 3) por lo que recorre toda la tabla para encontrar a los empleados cuyo apellido es Gomez (los cuales son solamente 2 y ademas estan al comienzo de la tabla).

**2 --> EXPLAIN SELECT * FROM Empleado WHERE apellido='Gomez' AND salario > 30000;**

De la misma manera, se recorre toda la tabla (cuando el único empleado que cumple las dos condiciones está en el segundo registro de esta).


### *FOTO 3:*
Se realizan 2 consultas, con la cláusula explain explicando el metodo de ejecución de las mismas, **AHORA SI SE UTILIZAN INDICES**:

Se observa que se crean dos indices, uno de un solo campo y uno de multiples campos:
<br>

**1 --> CREATE INDEX index_empleado_apellido ON Empleado(apellido)**
<br>

**2 --> CREATE INDEX index_empleado_salario_apellido ON Empleado(apellido, salario)**

Al realizar las consultas, observamos que en el campo 'rows' del EXPLAIN, las filas analizadas ya no son 3 sino 2, por lo que se puede concluir que los indices realmente aceleran el proceso de busqueda de registros en SQL.

De estos dos indices, MySQL utilizó el mismo para ambas consultas -> index_empleado_apellido (observable en el campo 'key' del EXPLAIN) por lo que se concluye que este es mas eficiente.