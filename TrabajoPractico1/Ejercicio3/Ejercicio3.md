# READ COMMITTED VS. SERIALIZABLE

## DEFINICIONES:
- **READ COMMITTED**: Es un nivel de aislamiento que permite a una transacción leer solo los datos que han sido confirmados por otras transacciones. Esto significa que una transacción no puede leer datos que están siendo modificados por otra transacción hasta que esa transacción haya sido confirmada. Este nivel de aislamiento previene la lectura de datos "sucios", pero no previene la lectura de datos "no repetibles" o "fantasmas".

- **SERIALIZABLE**: Es el nivel de aislamiento más alto en las bases de datos. En este nivel, las transacciones se ejecutan de tal manera que el resultado es el mismo que si se hubieran ejecutado de forma secuencial, una tras otra. Esto significa que no se permiten lecturas sucias, lecturas no repetibles ni fantasmas. Este nivel de aislamiento garantiza la consistencia de los datos, pero puede afectar el rendimiento debido a la mayor cantidad de bloqueos y esperas entre transacciones.
  
- **Lectura sucia**: Ocurre cuando una transacción ve datos que otra transacción aún no ha confirmado (committed).
  
- **Lectura no repetible**: Una transacción vuelve a leer un dato que ha sido modificado y confirmado por otra transacción, dando dos resultados distintos en lecturas consecutivas.


- **FOR UPDATE**: FOR UPDATE se utiliza dentro de una transacción para bloquear la(s) fila(s) que se seleccionan para escritura.
Lo que hace es:

    Impedir que otras transacciones lean o escriban esa misma fila hasta que la transacción actual termine (ya sea con COMMIT o ROLLBACK).

    Se usa típicamente cuando se va a hacer una operación de lectura seguida de escritura, como:
        
  - Leer el saldo de una cuenta.

  - Calcular un nuevo saldo.

  - Actualizar ese saldo.

Esto evita condiciones de carrera o inconsistencias cuando varias transacciones acceden y modifican al mismo tiempo la misma fila.


## EN EL EJEMPLO:
Se simula una situación donde 2 usuarios acceden a la misma cuenta de banco casi al mismo tiempo, y hacen una extracción y consulta del saldo. Se realiza la simulación de 4 maneras: 

- **a. Nivel de aislamiento READ COMMITTED y la cláusula FOR UPDATE en la consulta de actualización del saldo, a la base de datos.**
  
    ### QUE OCURRE AQUÍ?
    Observamos que con estas indicaciones, se ejecuta primero el hilo del usuario B, leyendo y actualizando el saldo (pasa de 1000 a 900), y luego el hilo del usuario A haciendo exactamente lo mismo (pasa de 900 a 800). Se puede considerar una **ejecución exitosa.**

<br><br>    

- **b. Nivel de aislamiento SERIALIZABLE y la cláusula FOR UPDATE en la consulta de actualización del saldo, a la base de datos.**
  
    ### QUE OCURRE AQUÍ?
    Observamos que con estas indicaciones, se ejecuta primero el hilo del usuario A, leyendo y actualizando el saldo (pasa de 1000 a 900), y luego el hilo del usuario B haciendo exactamente lo mismo (pasa de 900 a 800). Se puede considerar una **ejecución exitosa.**

<br><br> 

- **c. Nivel de aislamiento READ COMMITTED *¡¡¡SIN LA CLÁUSULA FOR UPDATE!!!* en la consulta de actualización del saldo, a la base de datos.**
  
    ### QUE OCURRE AQUÍ?
    Observamos que con estas indicaciones, ambos hilos se ejecutan al mismo tiempo haciendo que ambos lean el saldo inicial (1000) y luego ambos al mismo tiempo realicen la extracción (ambos pasan el saldo de 1000 a 900). Se considera una **ejecución ¡FALLIDA!**

<br><br> 

- **d. Nivel de aislamiento SERALIZABLE *¡¡¡SIN LA CLÁUSULA FOR UPDATE!!!* en la consulta de actualización del saldo, a la base de datos.**
  
    ### QUE OCURRE AQUÍ?
    Observamos que con estas indicaciones, ambos hilos se ejecutan al mismo tiempo haciendo que ambos lean el saldo inicial (1000) y luego ambos **INTENTAN** realizar la extracción al mismo tiempo pero ocurre un error. <br>
    
    El usuario B intenta primero realizar la transacción pero el nivel de aislamiento **SERIALIZABLE** evita esto. Se debe a que no estaría pasando que las transacciones se ejecuten una despues de otra como el nivel de aislamiento lo pide, sino que ambas se intentan ejecutar simultaneamente. Finalmente, luego de arrojarse el error, el hilo A logra ejecutarse, llevando el saldo a 900. Se considera una **ejecución ¡FALLIDA!**.
