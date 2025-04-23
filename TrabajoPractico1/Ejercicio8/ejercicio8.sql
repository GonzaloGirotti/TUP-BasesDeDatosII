DROP TABLE IF EXISTS Clientes;
CREATE TABLE Clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    correo VARCHAR(100),
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS AuditoriaClientes;
CREATE TABLE AuditoriaClientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    operacion ENUM('INSERT', 'UPDATE', 'DELETE'),
    id_cliente INT,
    nombre_anterior VARCHAR(100),
    correo_anterior VARCHAR(100),
    nombre_nuevo VARCHAR(100),
    correo_nuevo VARCHAR(100),
    fecha_operacion DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Trigger para insert
DELIMITER $$
CREATE TRIGGER after_insert_clientes
AFTER INSERT ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO AuditoriaClientes (operacion, id_cliente, nombre_nuevo, correo_nuevo)
    VALUES ('INSERT', NEW.id, NEW.nombre, NEW.correo);
END$$
DELIMITER ;

-- Trigger para update 
DELIMITER $$
CREATE TRIGGER after_update_clientes
AFTER UPDATE ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO AuditoriaClientes (
        operacion, id_cliente,
        nombre_anterior, correo_anterior,
        nombre_nuevo, correo_nuevo
    ) VALUES (
        'UPDATE', OLD.id,
        OLD.nombre, OLD.correo,
        NEW.nombre, NEW.correo
    );
END$$
DELIMITER ;

-- Trigger para delete
DELIMITER $$
CREATE TRIGGER after_delete_clientes
AFTER DELETE ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO AuditoriaClientes (
        operacion, id_cliente,
        nombre_anterior, correo_anterior
    ) VALUES (
        'DELETE', OLD.id,
        OLD.nombre, OLD.correo
    );
END$$

DELIMITER ;

-- Insertar un cliente
INSERT INTO Clientes (nombre, correo) VALUES 
('Luis Fernández', 'luisf@example.com'),
('María López', 'maria.lopez@example.com'),
('Carlos García', 'carlosg@example.com'),
('Sofía Méndez', 'sofia.mendez@example.com'),
('Juan Torres', 'juan.torres@example.com');
-- Esto es para deshabilitar el modo seguro de mySQL workbench temporalmente, que por defecto viene activado para evitar actualizaciones o eliminaciones por accidente
SET SQL_SAFE_UPDATES = 0;
-- Actualizo 2 clientes
UPDATE Clientes SET correo = 'nuevo.luis@example.com' WHERE nombre = 'Luis Fernández';
UPDATE Clientes SET nombre = 'María L. López' WHERE nombre = 'María López';
-- Eliminar un cliente
DELETE FROM Clientes WHERE nombre = 'Carlos García';
-- Habilito el modo seguro de vuelta
SET SQL_SAFE_UPDATES = 1;
-- Chequeo las operaciones registradas
SELECT * FROM AuditoriaClientes;