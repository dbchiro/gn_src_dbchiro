/*
  Manage observers from VisioNature observers datas
*/
BEGIN;
/* Fonction to create observers if not already registered */

DROP FUNCTION IF EXISTS dbchiro.fct_c_create_geonature_observer_from_dbchiro() CASCADE
;

CREATE OR REPLACE FUNCTION src_dbchirogcra.fct_c_create_geonature_observer_from_dbchiro() RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _row RECORD;
BEGIN
    INSERT INTO utilisateurs.t_roles(nom_role, prenom_role, email, active, date_insert, date_update, champs_addi)
    VALUES ( new.last_name, new.first_name, new.email, FALSE, new.timestamp_create, new.timestamp_update
           , JSONB_BUILD_OBJECT('from_dbchiro', JSONB_BUILD_OBJECT('anonymous_in_export', TO_JSONB(new.pseudonymize))))
    ON CONFLICT (email)
        DO UPDATE SET (nom_role, prenom_role, date_update) = (new.last_name, new.first_name, new.timestamp_update)
                    , champs_addi                          = JSONB_SET(
                COALESCE(t_roles.champs_addi, '{}'::jsonb),
                '{from_dbchiro}',
                COALESCE(t_roles.champs_addi -> 'from_dbchiro', '{}'::jsonb)
                    || JSONB_BUILD_OBJECT(
                        'anonymous_in_export',
                        COALESCE(new.pseudonymize, FALSE)
                       ),
                TRUE)
    RETURNING * INTO _row;
    RAISE NOTICE '%', _row.champs_addi;
    RETURN new;
END
$$
;
CREATE OR REPLACE FUNCTION src_dbchirogcra.fct_c_create_geonature_observer_from_dbchiro()
RETURNS TRIGGER
LANGUAGE plpgsql
AS
$$
DECLARE
    _row RECORD;
BEGIN
    INSERT INTO utilisateurs.t_roles(
        nom_role,
        prenom_role,
        email,
        active,
        date_insert,
        date_update,
        champs_addi
    )
    VALUES (
        new.last_name,
        new.first_name,
        new.email,
        FALSE,
        new.timestamp_create,
        new.timestamp_update,
        JSONB_BUILD_OBJECT(
            'from_dbchiro',
            JSONB_BUILD_OBJECT(
                'anonymous_in_export',
                TO_JSONB(COALESCE(new.pseudonymize, FALSE)),
                'anonymous_in_export_ts_update',
                TO_JSONB(now())
            )
        )
    )
    ON CONFLICT (email)
    DO UPDATE SET
        nom_role = new.last_name,
        prenom_role = new.first_name,
        date_update = new.timestamp_update,
        champs_addi = JSONB_SET(
            COALESCE(t_roles.champs_addi, '{}'::jsonb),
            '{from_dbchiro}',
            COALESCE(t_roles.champs_addi -> 'from_dbchiro', '{}'::jsonb)
            || JSONB_BUILD_OBJECT(
                'anonymous_in_export',
                COALESCE(new.pseudonymize, FALSE),
                'anonymous_in_export_ts_update',
                CASE
                    WHEN (
                        COALESCE(
                            (t_roles.champs_addi #>> '{from_dbchiro,anonymous_in_export}')::boolean,
                            FALSE
                        )
                        IS DISTINCT FROM COALESCE(new.pseudonymize, FALSE)
                    )
                    THEN TO_JSONB(now())
                    ELSE COALESCE(
                        t_roles.champs_addi #> '{from_dbchiro,anonymous_in_export_ts_update}',
                        TO_JSONB(now())
                    )
                END
            ),
            TRUE
        )
    RETURNING * INTO _row;
    RETURN new;
END
$$;

COMMENT ON FUNCTION dbchiro.fct_c_create_geonature_observer_from_dbchiro() IS 'Fonction trigger pour générer les observateurs GeoNature depuis dbChiro'
;

DROP TRIGGER IF EXISTS tri_c_upsert_observer ON dbchiro.accounts_profile
;

CREATE TRIGGER tri_c_upsert_observer
    AFTER INSERT OR UPDATE
    ON dbchiro.accounts_profile
    FOR EACH ROW
EXECUTE PROCEDURE dbchiro.fct_c_create_geonature_observer_from_dbchiro()
;

CREATE UNIQUE INDEX IF NOT EXISTS i_uniq_roles_email ON utilisateurs.t_roles (email)
;

CREATE UNIQUE INDEX IF NOT EXISTS i_uniq_roles_uuid_role ON utilisateurs.t_roles (uuid_role)
;


/* Function that returns id_role from VisioNature user universal id */

DROP FUNCTION IF EXISTS dbchiro.fct_c_get_id_role_from_dbchiro(_id INT)
;

CREATE FUNCTION dbchiro.fct_c_get_id_role_from_dbchiro(_id INT) RETURNS INT
AS
$$
DECLARE
    theroleid INT ;
BEGIN
    SELECT id_role
    INTO theroleid
    FROM utilisateurs.t_roles
             JOIN dbchiro.accounts_profile ON accounts_profile.email = t_roles.email
    WHERE accounts_profile.id = _id;
    RETURN theroleid;
END
$$
    LANGUAGE plpgsql
;

COMMENT ON FUNCTION dbchiro.fct_c_get_id_role_from_dbchiro(_id INT) IS 'Retourne un id_role à partir d''un id_universal de visionature'
;
COMMIT;