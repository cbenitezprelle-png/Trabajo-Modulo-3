CREATE DATABASE IF NOT EXISTS alkewallet;
USE alkewallet;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Transaccion;
DROP TABLE IF EXISTS Moneda;
DROP TABLE IF EXISTS Usuario;
SET FOREIGN_KEY_CHECKS = 1;

-- 2. Crear tabla Usuario [Paso 01]
CREATE TABLE Usuario (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(100) NOT NULL,
    saldo DECIMAL(10, 2) NOT NULL DEFAULT 0,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    CHECK (saldo >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Crear tabla Moneda 
CREATE TABLE Moneda (
    currency_id INT PRIMARY KEY AUTO_INCREMENT,
    currency_name VARCHAR(50) NOT NULL,
    currency_symbol VARCHAR(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Crear tabla Transaccion
CREATE TABLE Transaccion (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    sender_user_id INT NOT NULL,
    receiver_user_id INT NOT NULL,
    importe DECIMAL(10, 2) NOT NULL,
    transaction_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    currency_id INT NOT NULL,

    CONSTRAINT chk_sender_different_receiver CHECK (sender_user_id <> receiver_user_id),
    CONSTRAINT chk_importe CHECK (importe > 0),
    CONSTRAINT fk_sender FOREIGN KEY (sender_user_id) REFERENCES Usuario(user_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT fk_receiver FOREIGN KEY (receiver_user_id) REFERENCES Usuario(user_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT fk_currency FOREIGN KEY (currency_id) REFERENCES Moneda(currency_id) ON UPDATE RESTRICT ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Índices compuestos para optimizar consultas frecuentes
CREATE INDEX idx_usuario_nombre_correo ON Usuario (nombre, correo_electronico);
CREATE INDEX idx_transaccion_sender_date ON Transaccion (sender_user_id, transaction_date);
CREATE INDEX idx_transaccion_receiver_date ON Transaccion (receiver_user_id, transaction_date);

-- ===================================================================
-- Insertar datos iniciales
-- ===================================================================

-- Insertar Usuarios
INSERT INTO Usuario (nombre, correo_electronico, contrasena, saldo) VALUES
('Juan Perez', 'juan@example.com', 'pass123', 5000.00),
('Maria Lopez', 'maria@example.com', 'secure456', 12000.50),
('Carlos Ruiz', 'carlos@example.com', 'clave789', 300.00),
('Pedro Santana', 'pedrosantana@example.com', 'pedro652', 500.00),
('Francisca Ramirez', 'franramirez@example.com', 'fran0923', 13000.00),
('Armando Meza', 'ameza@example.com', 'Armando987', 120000.00),
('Linda Hermosilla', 'lindahermosa@example.com', 'Hermosa623', 300.00),
('Manuel Rivas', 'manuelrivas@example.com', 'manuel689', 1000.00),
('Jacinta Larrain', 'jacintallarain@example.com', 'jacinta932', 1500000.00),
('Nelson Navia', 'nelsonnavia@example.com', 'nelson951', 5000.00),
('Salvador Rivera', 'srivera@example.com', 'Salva789', 150000.00),
('Jackie Micheaux', 'jackiemichi@example.com', 'jacki820', 3000.00);

-- Insertar Monedas
INSERT INTO Moneda (currency_name, currency_symbol) VALUES
('Dolar', '$'),
('Euro', '€'),
('Peso Chileno', 'CLP');

-- Insertar Transacciones
-- (Juan le envía dinero a Maria en Dólares)
INSERT INTO Transaccion (sender_user_id, receiver_user_id, importe, transaction_date, currency_id) 
VALUES (1, 2, 100.00, '2024-03-20', 1);

-- (Maria le envía dinero a Carlos en Pesos)
INSERT INTO Transaccion (sender_user_id, receiver_user_id, importe, transaction_date, currency_id) 
VALUES (2, 3, 5000.00, '2024-03-21', 3);

-- ===================================================================
-- Lección 3: DML y control transaccional (ejecutar bloque por bloque)
-- ===================================================================

-- Ejemplo 1: transferencia controlada con COMMIT (Juan -> María)
SET @monto_transferencia := 250.00;
START TRANSACTION;
INSERT INTO Transaccion (sender_user_id, receiver_user_id, importe, transaction_date, currency_id)
VALUES (1, 2, @monto_transferencia, NOW(), 1);
SET @ultima_transaccion := LAST_INSERT_ID();
UPDATE Usuario SET saldo = saldo - @monto_transferencia WHERE user_id = 1;
UPDATE Usuario SET saldo = saldo + @monto_transferencia WHERE user_id = 2;
COMMIT;

-- Ejemplo 2: ROLLBACK voluntario (deshaciendo cambios)
SET @monto_rollback := 100.00;
START TRANSACTION;
INSERT INTO Transaccion (sender_user_id, receiver_user_id, importe, transaction_date, currency_id)
VALUES (3, 4, @monto_rollback, NOW(), 1);
UPDATE Usuario SET saldo = saldo - @monto_rollback WHERE user_id = 3;
UPDATE Usuario SET saldo = saldo + @monto_rollback WHERE user_id = 4;
-- Decidimos deshacer todo lo anterior
ROLLBACK;

-- Tarea Plus: 50 transacciones pseudoaleatorias
-- Solución compatible con Workbench 8.4 usando variables de sesión
START TRANSACTION;
INSERT INTO Transaccion (sender_user_id, receiver_user_id, importe, transaction_date, currency_id)
SELECT 
    (nums.n % 12) + 1 AS sender_user_id,
    ((nums.n + 4) % 12) + 1 AS receiver_user_id,
    ROUND(50 + (RAND() * 950), 2) AS importe,
    DATE_SUB(NOW(), INTERVAL nums.n DAY) AS transaction_date,
    ((nums.n - 1) % 3) + 1 AS currency_id
FROM (
    SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL
    SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL
    SELECT 11 UNION ALL SELECT 12 UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL SELECT 15 UNION ALL
    SELECT 16 UNION ALL SELECT 17 UNION ALL SELECT 18 UNION ALL SELECT 19 UNION ALL SELECT 20 UNION ALL
    SELECT 21 UNION ALL SELECT 22 UNION ALL SELECT 23 UNION ALL SELECT 24 UNION ALL SELECT 25 UNION ALL
    SELECT 26 UNION ALL SELECT 27 UNION ALL SELECT 28 UNION ALL SELECT 29 UNION ALL SELECT 30 UNION ALL
    SELECT 31 UNION ALL SELECT 32 UNION ALL SELECT 33 UNION ALL SELECT 34 UNION ALL SELECT 35 UNION ALL
    SELECT 36 UNION ALL SELECT 37 UNION ALL SELECT 38 UNION ALL SELECT 39 UNION ALL SELECT 40 UNION ALL
    SELECT 41 UNION ALL SELECT 42 UNION ALL SELECT 43 UNION ALL SELECT 44 UNION ALL SELECT 45 UNION ALL
    SELECT 46 UNION ALL SELECT 47 UNION ALL SELECT 48 UNION ALL SELECT 49 UNION ALL SELECT 50
) nums
WHERE (nums.n % 12) + 1 <> ((nums.n + 4) % 12) + 1;
COMMIT;
