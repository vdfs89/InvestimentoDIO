-- View: vw_cards_full_details
CREATE OR REPLACE VIEW vw_cards_full_details AS
SELECT 
    c.id AS card_id,
    c.name AS pokemon_name,
    c.hp,
    t.typeName AS type,
    s.stageName AS stage,
    col.collectionsSetName AS collection,
    c.attack,
    c.damage,
    c.info,
    c.weak,
    c.resistance,
    c.retreat,
    c.cardNumberInCollection
FROM 
    tbl_cards c
INNER JOIN 
    tbl_types t ON c.type_id = t.id
INNER JOIN 
    tbl_stages s ON c.stage_id = s.id
INNER JOIN 
    tbl_collections col ON c.collection_id = col.id;
