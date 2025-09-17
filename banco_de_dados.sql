DROP TABLE IF EXISTS variacao_valores, variacoes, valores_atributos, atributos, produtos, categorias, fornecedores, usuarios, roles CASCADE;

CREATE TABLE roles (
    id SERIAL PRIMARY KEY, 
    nome VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL,
    role_id INT,
    ativo BOOLEAN DEFAULT TRUE,
    data_criacao TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(id)
);


CREATE TABLE categorias (
    id SERIAL PRIMARY KEY,
    usuario_id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE fornecedores (
    id SERIAL PRIMARY KEY,
    usuario_id INT NOT NULL,
    nome_fantasia VARCHAR(255) NOT NULL,
    cnpj VARCHAR(14),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    usuario_id INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    categoria_id INT,
    fornecedor_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (categoria_id) REFERENCES categorias(id),
    FOREIGN KEY (fornecedor_id) REFERENCES fornecedores(id)
);

CREATE TABLE atributos (
    id SERIAL PRIMARY KEY, 
    usuario_id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE valores_atributos (
    id SERIAL PRIMARY KEY, 
    atributo_id INT NOT NULL,
    valor VARCHAR(100) NOT NULL,
    FOREIGN KEY (atributo_id) REFERENCES atributos(id) ON DELETE CASCADE
);

CREATE TABLE variacoes (
    id SERIAL PRIMARY KEY,
    produto_id INT NOT NULL,
    sku VARCHAR(100) UNIQUE,
    preco_custo DECIMAL(10, 2),
    preco_venda DECIMAL(10, 2),
    quantidade_estoque INT NOT NULL DEFAULT 0,
    FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE
);

CREATE TABLE variacao_valores (
    variacao_id INT NOT NULL,
    valor_atributo_id INT NOT NULL,
    PRIMARY KEY (variacao_id, valor_atributo_id),
    FOREIGN KEY (variacao_id) REFERENCES variacoes(id) ON DELETE CASCADE,
    FOREIGN KEY (valor_atributo_id) REFERENCES valores_atributos(id) ON DELETE CASCADE
);
