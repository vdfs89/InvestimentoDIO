-- 1. Populando Tipos (Tabela de Referência)
INSERT INTO tbl_types (typeName) VALUES 
('Grass'), ('Fire'), ('Water'), ('Lightning'), ('Psychic'), 
('Fighting'), ('Darkness'), ('Metal'), ('Colorless'), ('Dragon');

-- 2. Populando Estágios (Tabela de Referência)
INSERT INTO tbl_stages (stageName) VALUES 
('Basic'), ('Stage 1'), ('Stage 2'), ('V'), ('VMAX'), ('VSTAR'), ('ex');

-- 3. Populando Coleções (Exemplos Reais)
INSERT INTO tbl_collections (collectionsSetName, releaseDate, totalCardsInCollection) VALUES 
('Base Set', '1999-01-09', 102),
('Scarlet & Violet', '2023-03-31', 198),
('Crown Zenith', '2023-01-20', 159);

-- 4. Populando Cartas (Vinculando com as FKs)
-- IDs assumidos: Collection 1 (Base Set), Types (1:Grass, 2:Fire, 3:Water), Stages (1:Basic, 3:Stage 2)

INSERT INTO tbl_cards 
(name, hp, info, attack, damage, weak, resistance, retreat, cardNumberInCollection, collection_id, type_id, stage_id) 
VALUES 
-- Charizard (Base Set)
('Charizard', 120, 'Spits fire that is hot enough to melt boulders.', 'Fire Spin', '100', 'Water', NULL, '3', '4/102', 1, 2, 3),

-- Blastoise (Base Set)
('Blastoise', 100, 'A brutal Pokémon with pressurized water jets on its shell.', 'Hydro Pump', '40+', 'Grass', NULL, '3', '2/102', 1, 3, 3),

-- Venusaur (Base Set)
('Venusaur', 100, 'The plant blooms when it is absorbing solar energy.', 'Solarbeam', '60', 'Fire', NULL, '2', '15/102', 1, 1, 3),

-- Pikachu (Base Set)
('Pikachu', 40, 'When several of these Pokémon gather, their electricity could build and cause lightning storms.', 'Gnaw', '10', 'Fighting', NULL, '1', '58/102', 1, 4, 1);