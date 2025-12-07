BEGIN;
INSERT INTO gn_synthese.t_sources (name_source, desc_source, entity_source_pk_field, url_source, id_module)
SELECT *
FROM (VALUES ( 'dbChiroWeb', 'Données issues de dbChiroWeb', 'dbchiro.sights_sighting.id_sighting'
             , 'https://cacchi.dbchiro.org', NULL::INT)) AS t(name_source, desc_source, entity_source_pk_value,
                                                              url_source,
                                                              id_module)
ON CONFLICT DO NOTHING;

COMMIT;
