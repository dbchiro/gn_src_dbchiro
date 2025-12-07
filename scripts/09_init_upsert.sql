BEGIN;

UPDATE dbchiro.accounts_profile
SET email = email;


UPDATE dbchiro.management_study
SET id_study = id_study;


UPDATE dbchiro.sights_sighting
SET uuid = uuid;


UPDATE dbchiro.sights_countdetail
SET uuid = uuid;

--Check count

SELECT count(*)
FROM gn_synthese.synthese
WHERE id_source IN (SELECT id_source
                    FROM gn_synthese.t_sources
                    WHERE name_source LIKE 'dbChiroWeb');


COMMIT;
