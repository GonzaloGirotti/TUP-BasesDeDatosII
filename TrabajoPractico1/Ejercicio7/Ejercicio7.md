# EXPLICACION DE LOS COMANDOS:

**--> create user 'bddUser'@'localhost' IDENTIFIED BY '12345'; <--**

Crea el usuario de nombre "bddUser" en el servidor "localhost" y le asigna contraseña "12345".


**--> grant select on BasesDeDatosDB.TablaClientes to 'bddUser'@'localhost'; <--**

Le da permisos de hacer la consulta SELECT al usuario "bddUser" del servidor "localhost" pero solo en la tabla "TablaClientes" de la base de datos "BasesDeDatosDB".

**--> mysql -u bddUser -p <--**

Ingreso al servidor con el usuario nuevo.


**--> select * from TablaClientes <--**

Obtengo los datos de esa tabla, a la cual si estoy habilitado

**--> select * from cuentas <--**

No obtengo los datos de esa tabla, ya que no estoy habilitado a ello, y me arroja un error el MySQL server.
