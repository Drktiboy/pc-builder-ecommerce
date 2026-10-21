-- 1. Tabla de Usuarios (Con Saldo Virtual para pruebas)
CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    wallet_balance DECIMAL(10,2) DEFAULT 1000.00, -- Saldo de prueba
    role ENUM('cliente', 'admin') DEFAULT 'cliente',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Tabla de Categorías (Tarjetas Madre, Procesadores, etc.)
CREATE TABLE Categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- 3. Tabla de Productos (Con especificaciones para el Build Check)
CREATE TABLE Products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    
    -- Atributos Técnicos para Validación de Compatibilidad --
    socket_type VARCHAR(50) NULL,      -- Ej: LGA1700, AM5
    ram_type VARCHAR(20) NULL,         -- Ej: DDR4, DDR5
    wattage_draw INT DEFAULT 0,        -- Consumo de energía (Procesadores, Gráficas)
    wattage_provided INT DEFAULT 0,    -- Energía que provee (Fuentes de Poder)
    
    FOREIGN KEY (category_id) REFERENCES Categories(id)
);

-- 4. Tabla de Órdenes (Cabecera de la transacción)
CREATE TABLE Orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status ENUM('pendiente', 'pagada', 'cancelada') DEFAULT 'pendiente',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

-- 5. Detalles de la Orden (Retiene el precio histórico)
CREATE TABLE OrderDetails (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    historical_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(id),
    FOREIGN KEY (product_id) REFERENCES Products(id)
);