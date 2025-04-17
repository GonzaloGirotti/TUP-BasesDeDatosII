DROP TABLE IF EXISTS ventas;
CREATE TABLE ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT,
    cantidad INT,
    fecha DATE,
    FOREIGN KEY (producto_id) REFERENCES productos_normalizados(id)
);

-- Ventas del producto 1
INSERT INTO ventas (producto_id, cantidad, fecha) VALUES
(1, 5, '2023-01-10'),
(1, 2, '2023-02-15'),
(1, 3, '2023-03-15'),
(1, 8, '2023-03-25'),
(1, 6, '2023-04-02');

-- Ventas del producto 2
INSERT INTO ventas (producto_id, cantidad, fecha) VALUES
(2, 10, '2023-01-20'),
(2, 15, '2023-02-18'),
(2, 5, '2023-03-05'),
(2, 7, '2023-03-22'),
(2, 3, '2023-04-10');

-- Ventas del producto 3
INSERT INTO ventas (producto_id, cantidad, fecha) VALUES
(3, 7, '2023-02-01'),
(3, 4, '2023-02-15'),
(3, 6, '2023-03-10'),
(3, 2, '2023-03-20'),
(3, 8, '2023-04-05');

-- Ventas del producto 4
INSERT INTO ventas (producto_id, cantidad, fecha) VALUES
(4, 3, '2023-01-05'),
(4, 5, '2023-02-10'),
(4, 6, '2023-03-15'),
(4, 2, '2023-03-30'),
(4, 4, '2023-04-01');

-- Ventas del producto 5
INSERT INTO ventas (producto_id, cantidad, fecha) VALUES
(5, 12, '2023-01-12'),
(5, 9, '2023-02-03'),
(5, 15, '2023-03-01'),
(5, 6, '2023-03-25'),
(5, 10, '2023-04-10');

-- Ventas del producto 6
INSERT INTO ventas (producto_id, cantidad, fecha) VALUES
(6, 8, '2023-01-15'),
(6, 11, '2023-02-22'),
(6, 5, '2023-03-10'),
(6, 7, '2023-03-30'),
(6, 13, '2023-04-01');

-- Ventas del producto 7
INSERT INTO ventas (producto_id, cantidad, fecha) VALUES
(7, 3, '2023-01-20'),
(7, 4, '2023-02-05'),
(7, 2, '2023-03-15'),
(7, 1, '2023-04-02'),
(7, 5, '2023-04-05');

-- Ventas del producto 8
INSERT INTO ventas (producto_id, cantidad, fecha) VALUES
(8, 6, '2023-01-30'),
(8, 8, '2023-02-10'),
(8, 9, '2023-03-18'),
(8, 4, '2023-04-08'),
(8, 7, '2023-04-15');

-- Ventas del producto 9
INSERT INTO ventas (producto_id, cantidad, fecha) VALUES
(9, 20, '2023-01-05'),
(9, 15, '2023-02-02'),
(9, 10, '2023-03-10'),
(9, 8, '2023-04-01'),
(9, 25, '2023-04-07');

-- Ventas del producto 10
INSERT INTO ventas (producto_id, cantidad, fecha) VALUES
(10, 3, '2023-01-20'),
(10, 6, '2023-02-12'),
(10, 4, '2023-03-02'),
(10, 2, '2023-03-25'),
(10, 5, '2023-04-10');

DROP VIEW IF EXISTS ventas_mensuales;
-- Creo una vista que resume las ventas mensuales por productos, esta vista luego podré usarla para obtener los 5 productos más vendidos
CREATE VIEW ventas_mensuales AS
SELECT 
    v.producto_id,
    p.nombre AS producto_nombre,
    YEAR(v.fecha) AS año,
    MONTH(v.fecha) AS mes,
    SUM(v.cantidad) AS cantidad_vendida
FROM ventas v
JOIN productos_normalizados p ON v.producto_id = p.id
GROUP BY v.producto_id, YEAR(v.fecha), MONTH(v.fecha)
ORDER BY año DESC, mes DESC, cantidad_vendida DESC;

-- Consulto los 5 productos más vendidos, de forma descendente
SELECT 
    producto_nombre,
    SUM(cantidad_vendida) AS total_vendido
FROM ventas_mensuales
GROUP BY producto_nombre
ORDER BY total_vendido DESC
LIMIT 5;