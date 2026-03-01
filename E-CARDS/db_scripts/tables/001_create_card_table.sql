-- 1. Tabela de Tipos (Fire, Water, Grass, etc.)
CREATE TABLE tbl_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    typeName VARCHAR(30) NOT NULL UNIQUE
);

-- 2. Tabela de Estágios (Basic, Stage 1, Stage 2, VMAX, etc.)
CREATE TABLE tbl_stages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    stageName VARCHAR(30) NOT NULL UNIQUE
);

-- 3. Tabela de Coleções (Já existente, mantida para contexto)
CREATE TABLE tbl_collections (
    id INT AUTO_INCREMENT PRIMARY KEY,
    collectionsSetName VARCHAR(100) NOT NULL,
    releaseDate DATE,
    totalCardsInCollection INT
);

-- 4. Tabela de Cartas Refatorada
CREATE TABLE tbl_cards (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    hp INT,
    info TEXT,
    attack VARCHAR(100),
    damage VARCHAR(50),
    weak VARCHAR(50),
    resistance VARCHAR(50),
    retreat VARCHAR(50),
    cardNumberInCollection VARCHAR(20),
    
    -- Chaves Estrangeiras (FKs)
    collection_id INT,
    type_id INT,
    stage_id INT,

    CONSTRAINT fk_card_collection FOREIGN KEY (collection_id) REFERENCES tbl_collections(id),
    CONSTRAINT fk_card_type FOREIGN KEY (type_id) REFERENCES tbl_types(id),
    CONSTRAINT fk_card_stage FOREIGN KEY (stage_id) REFERENCES tbl_stages(id)

    
);