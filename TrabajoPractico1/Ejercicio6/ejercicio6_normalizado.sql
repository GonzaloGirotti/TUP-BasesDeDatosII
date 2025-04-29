DROP TABLE IF EXISTS categorias;
CREATE TABLE categorias (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) UNIQUE NOT NULL
);
DROP TABLE IF EXISTS marcas;

CREATE TABLE marcas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO categorias (nombre) VALUES 
('Electrónica'),
('Hogar'),
('Deportes'),
('Juguetes'),
('Ropa'),
('Belleza'),
('Libros'),
('Mascotas');

INSERT INTO marcas (nombre) VALUES
('Oscorp'),
('Acme'),
('Soylent'),
('Wonka'),
('Wayne'),
('Stark'),
('Initech'),
('Globex'),
('Umbrella'),
('Hooli');

DROP TABLE IF EXISTS productos_normalizados;

CREATE TABLE productos_normalizados (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT,
    precio DECIMAL(10,2),
    stock INT,
    categoria_id INT,
    marca_id INT,
    fecha_creacion DATE,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id),
    FOREIGN KEY (marca_id) REFERENCES marcas(id)
);

INSERT INTO productos_normalizados (
    id, nombre, descripcion, precio, stock, categoria_id, marca_id, fecha_creacion
)
SELECT 
    p.id,
    p.nombre,
    p.descripcion,
    p.precio,
    p.stock,
    c.id AS categoria_id,
    m.id AS marca_id,
    p.fecha_creacion
FROM productos p
JOIN categorias c ON p.categoria = c.nombre
JOIN marcas m ON p.marca = m.nombre;

-- Confirmo que los datos se migraron correctamente, contando que hay 100.000:
SELECT COUNT(*) FROM productos_normalizados;