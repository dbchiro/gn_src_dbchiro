ROLLBACK;
BEGIN;

INSERT INTO gn_commons.t_parameters(id_organism, parameter_name, parameter_desc, parameter_value, parameter_extra_value)
VALUES ( NULL
       , 'dbchiro_default_af'
       , 'Cadre d''acquisition par défaut pour les données issues de dbChiroWeb'
       , '<UNCLASSIFIED> from dbChiro'
       , NULL)
     , ( NULL
       , 'dbchiro_default_dataset_shortname'
       , 'Jeu de données par défaut pour les données issues de dbChiroWeb'
       , 'OpportunisticDbChiroData'
       , NULL)
ON CONFLICT (id_organism, parameter_name)
    DO NOTHING
;

INSERT INTO gn_meta.t_datasets ( id_acquisition_framework
                               , unique_dataset_id
                               , dataset_name
                               , dataset_shortname
                               , dataset_desc
                               , marine_domain
                               , terrestrial_domain
                               , meta_create_date
                               , meta_update_date)
SELECT (dbchiro.fct_c_get_or_insert_basic_acquisition_framework(
        gn_commons.get_default_parameter(
                'dbchiro_default_af', NULL), 'Cadre d''acquisition par défaut pour les données dbChiroWeb',
        now()::DATE))                                      AS id_acquisition_framework
     , uuid_generate_v4()                                  AS unique_dataset_id
     , 'Données oppportunistes dbChiro'                    AS dataset_name
     , gn_commons.get_default_parameter(
        'dbchiro_default_dataset_shortname', NULL)         AS dataset_shortname
     , 'Jeu de données par défault des données dbChiroWeb' AS dataset_desc
     , FALSE                                               AS marine_domain
     , TRUE                                                AS terrestrial_domain
     , now()                                               AS meta_create_date
     , now()                                               AS meta_update_date
ON CONFLICT DO NOTHING
;

INSERT INTO taxonomie.bib_taxref_rangs (id_rang, nom_rang, tri_rang, nom_rang_en)
VALUES ('RES ', 'Regroupement sp', NULL, 'Species grouping')
ON CONFLICT (id_rang) DO NOTHING;


INSERT INTO taxonomie.t_c_taxref_ajout ( cd_nom, id_statut, id_habitat, id_rang, regne, phylum, classe, ordre, famille
                                       , sous_famille, tribu, cd_taxsup, cd_sup, cd_ref, lb_nom, lb_auteur, nom_complet
                                       , nom_complet_html, nom_valide, nom_vern, nom_vern_eng, group1_inpn, group2_inpn
                                       , url, group3_inpn)
VALUES ( -79325, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79325, 'Myotis bechsteinii / mystacinus', NULL, NULL, NULL, NULL
       , 'Murin de Bechstein / à moustaches', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -60258, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Verspertilionidae', NULL, NULL
       , NULL, 196414, -60258, 'Plecotus auritus / austriacus', NULL, NULL, NULL, NULL, 'Oreillard gris / roux', NULL
       , 'Chordés', 'Mammifères', NULL, NULL)
     , ( -186233, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', NULL, NULL, NULL, NULL, 186233, -186233
       , 'Aucune capture filet', NULL, NULL, NULL, NULL, 'Aucune capture filet', NULL, 'Chordés', 'Mammifères', NULL
       , NULL)
     , ( -60297, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Rhinolophidae', NULL, NULL, NULL
       , 197139, -60297, 'Rhinolophus euryale / ferrumequinum', NULL, NULL, NULL, NULL
       , 'Grand rhinolophe / Rhinolophe euryale', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -60313, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Rhinolophidae', NULL, NULL, NULL
       , 197139, -60313, 'Rhinolophus euryale / hipposideros', NULL, NULL, NULL, NULL, 'Petit rhinolophe / euryale'
       , NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -60418, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -60418, 'Myotis myotis / M. blythii', NULL, NULL, NULL, NULL, 'Murin de grande taille', NULL
       , 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79299, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79299, 'Myotis alcathoe / brandtii / mystacinus', NULL, NULL, NULL, NULL
       , 'Murin d''Alcathoé / Brandt / moustaches', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79300, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79300, 'Myotis alcathoe / capaccini / mystacinus', NULL, NULL, NULL, NULL
       , 'Murin d''Alcathoé / Capaccini / moustaches', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79301, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79301, 'Myotis alcathoe / daubentonii', NULL, NULL, NULL, NULL
       , 'Murin d''Alcathoe / de Daubenton', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79302, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79302, 'Myotis alcathoe / emarginatus', NULL, NULL, NULL, NULL, 'Murin d''Alcathoé / émarginé'
       , NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79304, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79304, 'Myotis alcathoe / mystacinus', NULL, NULL, NULL, NULL, 'Murin d''Alcathoé / moustaches'
       , NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79305, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79305, 'Myotis bechsteinii / brandtii / mystacinus', NULL, NULL, NULL, NULL
       , 'Murin de Bechstein / Brandt / moustaches', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79306, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79306, 'Myotis bechsteinii / daubentonii', NULL, NULL, NULL, NULL
       , 'Murin de Bechstein / Daubenton', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79307, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79307, 'Myotis bechsteinii / daubentonii / myotis-bly', NULL, NULL, NULL, NULL
       , 'Murin de Bechstein / Daubenton / grande taille', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79308, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79308, 'Myotis bechsteinii / daubentonii / mystacinus', NULL, NULL, NULL, NULL
       , 'Murin de Bechstein / Daubenton / moustaches', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79309, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79309, 'Myotis bechsteinii / emarginatus', NULL, NULL, NULL, NULL
       , 'Murin de Bechstein / émarginé', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79310, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79310, 'Myotis bechsteinii / myotis-blythii', NULL, NULL, NULL, NULL
       , 'Murin de Bechstein / murin de grande taille', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79311, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79311, 'Myotis brandtii / daubentonii', NULL, NULL, NULL, NULL, 'Murin de Brandt / Daubenton'
       , NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79312, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79312, 'Myotis brandtii / daubentonii / mystacinus', NULL, NULL, NULL, NULL
       , 'Murin de Brandt / Daubenton / moustaches', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79313, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79313, 'Myotis brandtii / emarginatus', NULL, NULL, NULL, NULL, 'Murin de Brandt / échancré'
       , NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79314, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79314, 'Myotis brandtii / emarginatus / mystacinus', NULL, NULL, NULL, NULL
       , 'Murin de Brandt / émarginé / moustaches', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79315, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79315, 'Myotis brandtii / mystacinus', NULL, NULL, NULL, NULL, 'Murin de Brandt / moustaches'
       , NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79316, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79316, 'Myotis capaccinii / daubentonii', NULL, NULL, NULL, NULL
       , 'Murin de Capaccini / de Daubenton', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79317, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79317, 'Myotis capaccini / daubentonii / emarginatus', NULL, NULL, NULL, NULL
       , 'Murin de Capaccini / Daubenton / émarginé', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79318, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79318, 'Myotis daubentonii / emarginatus', NULL, NULL, NULL, NULL
       , 'Murin de Daubenton / émarginé', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79319, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79319, 'Myotis daubentonii / mystacinus / emarginatus', NULL, NULL, NULL, NULL
       , 'Murin de Daubenton / moustaches / emarginé', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79320, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79320, 'Myotis daubentonii / mystacinus', NULL, NULL, NULL, NULL
       , 'Murin de Daubenton / moustaches', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -64468, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195295, -64468, 'Nyctalus noctula / N. lasiopterus', NULL, NULL, NULL, NULL
       , 'Noctule commune / Grande noctule', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -64469, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195295, -64469, 'Nyctalus leisleri / Vespertilio murinus', NULL, NULL, NULL, NULL
       , 'Noctule de Leisler / Sérotine bicolore', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -64470, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', NULL, NULL, NULL, NULL, 186233, -64470
       , 'Nyctalus / Tadarida', NULL, NULL, NULL, NULL, 'Noctule / Molosse', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -192256, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', NULL, NULL, NULL, NULL, 186233, -192256
       , 'Eptesicus / Nyctalus', NULL, NULL, NULL, NULL, 'Sérotine / Noctule', NULL, 'Chordés', 'Mammifères', NULL
       , NULL)
     , ( -192257, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', NULL, NULL, NULL, NULL, 186233, -192257
       , 'Eptesicus / Vespertilio / Nyctalus', NULL, NULL, NULL, NULL, 'Sérotine / Noctule', NULL, 'Chordés'
       , 'Mammifères', NULL, NULL)
     , ( -192258, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', NULL, NULL, NULL, NULL, 186233, -192258
       , 'Eptesicus / Myotis myotis / M. blythii', NULL, NULL, NULL, NULL, 'Sérotine / Murin de grande taille', NULL
       , 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79303, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 196296, -79303, 'P. kuhlii / nathusii', NULL, NULL, NULL, NULL, 'Pipistrelle de Kuhl / Nathusius', NULL
       , 'Chordés', 'Mammifères', NULL, NULL)
     , ( -60479, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 196296, -60479, 'P. pipistrellus / nathusii', NULL, NULL, NULL, NULL, 'Pipistrelle commune / Nathusius'
       , NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -60480, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 196296, -60480, 'P. pipistrellus / pygmaeus', NULL, NULL, NULL, NULL, 'Pipistrelle commune / pygmée'
       , NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -60481, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 196296, -60481, 'P. pipistrellus / M. schreibersii', NULL, NULL, NULL, NULL
       , 'Pipistrelle commune / Minioptère', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -60489, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 196296, -60489, 'P. pygmaeus / M. schreibersii', NULL, NULL, NULL, NULL
       , 'Pipistrelle pygmée / Minioptère', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -60518, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 196414, -60518, 'Plecotus auritus / macrobullaris', NULL, NULL, NULL, NULL, 'Oreillard roux / montagnard'
       , NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -60257, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 196414, -60257, 'Plecotus austriacus / macrobullaris', NULL, NULL, NULL, NULL
       , 'Oreillard gris / montagnard', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -186234, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', NULL, NULL, NULL, NULL, 186233, -186234
       , 'Aucune chauve-souris ou trace', NULL, NULL, NULL, NULL, 'Aucune chauve-souris ou trace', NULL, 'Chordés'
       , 'Mammifères', NULL, NULL)
     , ( -186235, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', NULL, NULL, NULL, NULL, 186233, -186235
       , 'Aucun contact acoustique', NULL, NULL, NULL, NULL, 'Aucun contact acoustique', NULL, 'Chordés', 'Mammifères'
       , NULL, NULL)
     , ( -79321, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79321, 'Myotis bechsteinii / brandtii', NULL, NULL, NULL, NULL, 'Murin de Bechstein / Brandt'
       , NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79322, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79322, 'Myotis bechsteinii / brandtii / daubentonii', NULL, NULL, NULL, NULL
       , 'Murin de Bechstein / Brandt / Daubenton', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79323, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79323, 'Myotis bechsteinii / brandtii / emarginatus', NULL, NULL, NULL, NULL
       , 'Murin de Bechstein / Brandt / émarginé', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79324, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79324, 'Myotis bechsteinii / brandtii / myotis-bly', NULL, NULL, NULL, NULL
       , 'Murin de Bechstein / Brandt / grande taille', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79333, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79333, 'Myotis alcathoe / emarginatus / mystacinus', NULL, NULL, NULL, NULL
       , 'Murin d''Alcathoé / émarginé / moustaches', NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79341, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79341, 'Myotis emarginatus / mystacinus', NULL, NULL, NULL, NULL, 'Murin émarginé / moustaches'
       , NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79342, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79342, 'Myotis natterreri / blythii', NULL, NULL, NULL, NULL, 'Murin de Natterer / Petit murin'
       , NULL, 'Chordés', 'Mammifères', NULL, NULL)
     , ( -79343, NULL, NULL, 'RES', 'Animalia', 'Chordata', 'Mammalia', 'Chiroptera', 'Vespertilionidae', NULL, NULL
       , NULL, 195005, -79343, 'Myotis pt taille sp.', NULL, NULL, NULL, NULL, 'Murin de petite taille', NULL, 'Chordés'
       , 'Mammifères', NULL, NULL)
ON CONFLICT (cd_nom) DO NOTHING;


INSERT INTO dbchiro.cor_sp_dbchiro_taxref
VALUES (53, 59, 60360)
     , (56, 62, 192256)
     , (88, 91, 197139)
     , (2, 3, 60330)
     , (91, 94, 195005)
     , (45, 51, 195005)
     , (1, 1, 60295)
     , (15, 16, 60427)
     , (67, 70, 196296)
     , (16, 17, 79298)
     , (12, 13, 60411)
     , (6, 7, 197139)
     , (54, 60, 79302)
     , (64, 67, 60489)
     , (56, 62, 192256)
     , (88, 91, 197139)
     , (2, 3, 60330)
     , (19, 21, 60447)
     , (9, 10, 79299)
     , (8, 9, 79300)
     , (3, 4, 60337)
     , (93, 97, 198894)
     , (76, 79, 163463)
     , (79, 82, 196414)
     , (63, 66, 60479)
     , (95, 99, 194793)
     , (74, 77, 60518)
     , (73, 76, 60506)
     , (66, 69, 79303)
     , (62, 96, 198894)
     , (10, 11, 60400)
     , (87, 90, 186233)
     , (82, 85, 60557)
     , (92, 95, 195005)
     , (48, 54, 60468)
     , (17, 19, 200118)
     , (81, 84, 79305)
     , (97, 2, 60313)
     , (75, 78, 60527)
     , (46, 52, 60457)
     , (50, 56, 195295)
     , (80, 83, 60345)
     , (11, 12, 60408)
     , (14, 15, 60418)
     , (59, 50, 195005)
     , (47, 53, 60461)
     , (13, 14, 79301)
     , (55, 61, 60537)
     , (96, 100, 198187)
     , (90, 93, 197139)
     , (65, 68, 60490)
     , (7, 8, 60383)
     , (94, 98, 186233)
     , (89, 92, 197139)
     , (18, 20, 60439)
     , (98, 101, 186235)
     , (83, 86, 186233)
     , (78, 81, -60257)
     , (4, 5, -60297)
     , (5, 6, -60313)
     , (100, 18, -60418)
     , (69, 72, -60479)
     , (70, 73, -60480)
     , (71, 74, -60481)
     , (72, 75, -60489)
     , (77, 80, -60518)
     , (49, 55, -64468)
     , (51, 57, -64469)
     , (52, 58, -64470)
     , (20, 22, -79299)
     , (21, 23, -79300)
     , (22, 24, -79301)
     , (23, 25, -79302)
     , (68, 71, -79303)
     , (25, 27, -79304)
     , (29, 32, -79305)
     , (30, 33, -79306)
     , (61, 34, -79307)
     , (31, 35, -79308)
     , (32, 36, -79309)
     , (60, 37, -79310)
     , (33, 38, -79311)
     , (34, 39, -79312)
     , (35, 40, -79313)
     , (36, 41, -79314)
     , (37, 42, -79315)
     , (38, 43, -79316)
     , (39, 44, -79317)
     , (40, 45, -79318)
     , (41, 46, -79319)
     , (42, 47, -79320)
     , (26, 28, -79321)
     , (27, 29, -79322)
     , (28, 30, -79323)
     , (101, 31, -79324)
     , (24, 26, -79333)
     , (43, 48, -79341)
     , (44, 49, -79342)
     , (84, 87, -186233)
     , (85, 88, -186234)
     , (86, 89, -186235)
     , (57, 63, -192256)
     , (58, 64, -192257)
     , (99, 65, -192258)

ON CONFLICT (idsp_dbchiro) DO NOTHING;

COMMIT;