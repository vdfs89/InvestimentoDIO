CREATE VIEW view_pokemon_summary AS
SELECT 
    c.id AS card_id,
    c.name AS pokemon_name,
    c.hp,
    t.typeName AS element_type,
    s.stageName AS evolution_stage,
    col.collectionsSetName AS collection_name,
    c.cardNumberInCollection AS card_number,
    c.attack,
    c.damage,
    c.info AS description
FROM tbl_cards c
JOIN tbl_types t ON c.type_id = t.id
JOIN tbl_stages s ON c.stage_id = s.id
JOIN tbl_collections col ON c.collection_id = col.id
ORDER BY col.releaseDate DESC, c.name ASC;