-- ############################################################
-- ESTRUTURA (DDL)
-- ############################################################

CREATE DATABASE IF NOT EXISTS betalent_api;
USE betalent_api;

-- Tabela de Usuários (Acesso Administrativo)
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('ADMIN', 'MANAGER', 'FINANCE', 'USER') DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabela de Clientes (Compradores)
CREATE TABLE clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Gateways de Pagamento
CREATE TABLE gateways (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    priority INT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    api_url VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Produtos
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    amount INT NOT NULL, -- Valor em centavos (Ex: 1500 = R$ 15,00)
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Transações
CREATE TABLE transactions (
    id CHAR(36) PRIMARY KEY, -- UUID para segurança e rastreio externo
    client_id INT NOT NULL,
    gateway_id INT, -- Pode ser null se a transação falhar em todos
    amount INT NOT NULL, -- Valor total calculado no back-end
    card_last_numbers CHAR(4) NOT NULL,
    status ENUM('pending', 'paid', 'refunded', 'failed') DEFAULT 'pending',
    external_id VARCHAR(255), -- ID retornado pelo Gateway Mock
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_transaction_client FOREIGN KEY (client_id) REFERENCES clients(id),
    CONSTRAINT fk_transaction_gateway FOREIGN KEY (gateway_id) REFERENCES gateways(id)
);

-- Tabela Associativa (Nível 3 Ready)
CREATE TABLE transaction_products (
    transaction_id CHAR(36) NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_at_time INT NOT NULL, -- Valor do produto no momento da compra
    PRIMARY KEY (transaction_id, product_id),
    CONSTRAINT fk_tp_transaction FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE CASCADE,
    CONSTRAINT fk_tp_product FOREIGN KEY (product_id) REFERENCES products(id)
);

-- ############################################################
-- POPULAÇÃO INICIAL (DML)
-- ############################################################

-- Gateways (Conforme especificações do Desafio)
INSERT INTO gateways (name, priority, api_url) VALUES 
('Gateway 1', 1, 'http://gateways_mock:3001'),
('Gateway 2', 2, 'http://gateways_mock:3002');

-- Produtos para Teste
INSERT INTO products (name, amount) VALUES 
('Curso de Backend Pro', 25000),   -- R$ 250,00
('Mentoria Engenharia de Software', 100000); -- R$ 1.000,00

-- Usuário Admin (Senha: admin123 - No TypeORM usaremos Hash)
INSERT INTO users (email, password, role) VALUES 
('admin@betalent.tech', '$2b$10$O9lGfX6P.Rz/S6fR2n6.ueS.J.x3yW.fG/X.X.X.X.X.', 'ADMIN');