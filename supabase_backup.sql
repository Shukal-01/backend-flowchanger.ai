PGDMP  9    	                |            postgres    15.6    16.4 �              0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    5    postgres    DATABASE     t   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';
    DROP DATABASE postgres;
                postgres    false                       0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    4885                       0    0    DATABASE postgres    ACL     2   GRANT ALL ON DATABASE postgres TO dashboard_user;
                   postgres    false    4885                       0    0    postgres    DATABASE PROPERTIES     >   ALTER DATABASE postgres SET "app.settings.jwt_exp" TO '3600';
                     postgres    false                        2615    16488    auth    SCHEMA        CREATE SCHEMA auth;
    DROP SCHEMA auth;
                supabase_admin    false                       0    0    SCHEMA auth    ACL        GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT ALL ON SCHEMA auth TO postgres;
                   supabase_admin    false    16                        2615    16388 
   extensions    SCHEMA        CREATE SCHEMA extensions;
    DROP SCHEMA extensions;
                postgres    false                       0    0    SCHEMA extensions    ACL     �   GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;
                   postgres    false    14                        2615    16618    graphql    SCHEMA        CREATE SCHEMA graphql;
    DROP SCHEMA graphql;
                supabase_admin    false                        2615    16607    graphql_public    SCHEMA        CREATE SCHEMA graphql_public;
    DROP SCHEMA graphql_public;
                supabase_admin    false                        2615    16386 	   pgbouncer    SCHEMA        CREATE SCHEMA pgbouncer;
    DROP SCHEMA pgbouncer;
             	   pgbouncer    false                        2615    16645    pgsodium    SCHEMA        CREATE SCHEMA pgsodium;
    DROP SCHEMA pgsodium;
                supabase_admin    false                        3079    16646    pgsodium 	   EXTENSION     >   CREATE EXTENSION IF NOT EXISTS pgsodium WITH SCHEMA pgsodium;
    DROP EXTENSION pgsodium;
                   false    17                       0    0    EXTENSION pgsodium    COMMENT     \   COMMENT ON EXTENSION pgsodium IS 'Pgsodium is a modern cryptography library for Postgres.';
                        false    6                        2615    39586    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                postgres    false                       0    0    SCHEMA public    COMMENT         COMMENT ON SCHEMA public IS '';
                   postgres    false    22                       0    0    SCHEMA public    ACL     +   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
                   postgres    false    22                        2615    16599    realtime    SCHEMA        CREATE SCHEMA realtime;
    DROP SCHEMA realtime;
                supabase_admin    false                       0    0    SCHEMA realtime    ACL     �   GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;
                   supabase_admin    false    13                        2615    16536    storage    SCHEMA        CREATE SCHEMA storage;
    DROP SCHEMA storage;
                supabase_admin    false                       0    0    SCHEMA storage    ACL       GRANT ALL ON SCHEMA storage TO postgres;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;
                   supabase_admin    false    15                        2615    16949    vault    SCHEMA        CREATE SCHEMA vault;
    DROP SCHEMA vault;
                supabase_admin    false                        3079    16982 
   pg_graphql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;
    DROP EXTENSION pg_graphql;
                   false    21                        0    0    EXTENSION pg_graphql    COMMENT     B   COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';
                        false    8                        3079    16389    pg_stat_statements 	   EXTENSION     J   CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;
 #   DROP EXTENSION pg_stat_statements;
                   false    14            !           0    0    EXTENSION pg_stat_statements    COMMENT     u   COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';
                        false    2                        3079    16434    pgcrypto 	   EXTENSION     @   CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;
    DROP EXTENSION pgcrypto;
                   false    14            "           0    0    EXTENSION pgcrypto    COMMENT     <   COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
                        false    4                        3079    16471    pgjwt 	   EXTENSION     =   CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;
    DROP EXTENSION pgjwt;
                   false    14    4            #           0    0    EXTENSION pgjwt    COMMENT     C   COMMENT ON EXTENSION pgjwt IS 'JSON Web Token API for Postgresql';
                        false    5                        3079    16950    supabase_vault 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;
    DROP EXTENSION supabase_vault;
                   false    19    6            $           0    0    EXTENSION supabase_vault    COMMENT     C   COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';
                        false    7                        3079    16423 	   uuid-ossp 	   EXTENSION     C   CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;
    DROP EXTENSION "uuid-ossp";
                   false    14            %           0    0    EXTENSION "uuid-ossp"    COMMENT     W   COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
                        false    3            �           1247    28722 	   aal_level    TYPE     K   CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);
    DROP TYPE auth.aal_level;
       auth          supabase_auth_admin    false    16            �           1247    28863    code_challenge_method    TYPE     L   CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);
 &   DROP TYPE auth.code_challenge_method;
       auth          supabase_auth_admin    false    16            �           1247    28716    factor_status    TYPE     M   CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);
    DROP TYPE auth.factor_status;
       auth          supabase_auth_admin    false    16            �           1247    28710    factor_type    TYPE     R   CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);
    DROP TYPE auth.factor_type;
       auth          supabase_auth_admin    false    16            �           1247    28905    one_time_token_type    TYPE     �   CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);
 $   DROP TYPE auth.one_time_token_type;
       auth          supabase_auth_admin    false    16            $           1247    39694    BreakMethod    TYPE     ^   CREATE TYPE public."BreakMethod" AS ENUM (
    'BIOMETRIC',
    'QRSCAN',
    'PHOTOCLICK'
);
     DROP TYPE public."BreakMethod";
       public          postgres    false    22                       1247    39652    Day    TYPE     r   CREATE TYPE public."Day" AS ENUM (
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
);
    DROP TYPE public."Day";
       public          postgres    false    22                       1247    39640    FineType    TYPE     E   CREATE TYPE public."FineType" AS ENUM (
    'HOURLY',
    'DAILY'
);
    DROP TYPE public."FineType";
       public          postgres    false    22                       1247    39632    LeaveRequestStatus    TYPE     c   CREATE TYPE public."LeaveRequestStatus" AS ENUM (
    'PENDING',
    'APPROVED',
    'REJECTED'
);
 '   DROP TYPE public."LeaveRequestStatus";
       public          postgres    false    22                       1247    39626 	   LeaveType    TYPE     H   CREATE TYPE public."LeaveType" AS ENUM (
    'MONTHLY',
    'YEARLY'
);
    DROP TYPE public."LeaveType";
       public          postgres    false    22                       1247    39612    MarkAttendenceType    TYPE     R   CREATE TYPE public."MarkAttendenceType" AS ENUM (
    'Office',
    'Anywhere'
);
 '   DROP TYPE public."MarkAttendenceType";
       public          postgres    false    22                       1247    39678    PunchInMethod    TYPE     `   CREATE TYPE public."PunchInMethod" AS ENUM (
    'BIOMETRIC',
    'QRSCAN',
    'PHOTOCLICK'
);
 "   DROP TYPE public."PunchInMethod";
       public          postgres    false    22            !           1247    39686    PunchOutMethod    TYPE     a   CREATE TYPE public."PunchOutMethod" AS ENUM (
    'BIOMETRIC',
    'QRSCAN',
    'PHOTOCLICK'
);
 #   DROP TYPE public."PunchOutMethod";
       public          postgres    false    22                       1247    39646 	   PunchTime    TYPE     J   CREATE TYPE public."PunchTime" AS ENUM (
    'ANYTIME',
    'ADDLIMIT'
);
    DROP TYPE public."PunchTime";
       public          postgres    false    22                        1247    39597    UserRole    TYPE     R   CREATE TYPE public."UserRole" AS ENUM (
    'ADMIN',
    'STAFF',
    'CLIENT'
);
    DROP TYPE public."UserRole";
       public          postgres    false    22                       1247    39604    UserType    TYPE     R   CREATE TYPE public."UserType" AS ENUM (
    'ADMIN',
    'STAFF',
    'CLIENT'
);
    DROP TYPE public."UserType";
       public          postgres    false    22            	           1247    39618    VerificationStatus    TYPE     c   CREATE TYPE public."VerificationStatus" AS ENUM (
    'VERIFIED',
    'PENDING',
    'REJECTED'
);
 '   DROP TYPE public."VerificationStatus";
       public          postgres    false    22                       1247    39668    punchRecordStatus    TYPE     p   CREATE TYPE public."punchRecordStatus" AS ENUM (
    'ABSENT',
    'PRESENT',
    'HALFDAY',
    'PAIDLEAVE'
);
 &   DROP TYPE public."punchRecordStatus";
       public          postgres    false    22            �           1247    29076    action    TYPE     o   CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);
    DROP TYPE realtime.action;
       realtime          supabase_admin    false    13            �           1247    29037    equality_op    TYPE     v   CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);
     DROP TYPE realtime.equality_op;
       realtime          supabase_admin    false    13            �           1247    29051    user_defined_filter    TYPE     j   CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);
 (   DROP TYPE realtime.user_defined_filter;
       realtime          supabase_admin    false    13    1463                       1247    29118 
   wal_column    TYPE     �   CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);
    DROP TYPE realtime.wal_column;
       realtime          supabase_admin    false    13                        1247    29089    wal_rls    TYPE     s   CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);
    DROP TYPE realtime.wal_rls;
       realtime          supabase_admin    false    13            i           1255    16534    email()    FUNCTION       CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;
    DROP FUNCTION auth.email();
       auth          supabase_auth_admin    false    16            &           0    0    FUNCTION email()    COMMENT     X   COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';
          auth          supabase_auth_admin    false    361            '           0    0    FUNCTION email()    ACL     6   GRANT ALL ON FUNCTION auth.email() TO dashboard_user;
          auth          supabase_auth_admin    false    361            5           1255    28692    jwt()    FUNCTION     �   CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;
    DROP FUNCTION auth.jwt();
       auth          supabase_auth_admin    false    16            (           0    0    FUNCTION jwt()    ACL     b   GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;
          auth          supabase_auth_admin    false    565            h           1255    16533    role()    FUNCTION        CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;
    DROP FUNCTION auth.role();
       auth          supabase_auth_admin    false    16            )           0    0    FUNCTION role()    COMMENT     V   COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';
          auth          supabase_auth_admin    false    360            *           0    0    FUNCTION role()    ACL     5   GRANT ALL ON FUNCTION auth.role() TO dashboard_user;
          auth          supabase_auth_admin    false    360            g           1255    16532    uid()    FUNCTION     �   CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;
    DROP FUNCTION auth.uid();
       auth          supabase_auth_admin    false    16            +           0    0    FUNCTION uid()    COMMENT     T   COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';
          auth          supabase_auth_admin    false    359            ,           0    0    FUNCTION uid()    ACL     4   GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;
          auth          supabase_auth_admin    false    359            -           0    0 D   FUNCTION algorithm_sign(signables text, secret text, algorithm text)    ACL     Y  REVOKE ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) FROM postgres;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO dashboard_user;
       
   extensions          postgres    false    547            .           0    0    FUNCTION armor(bytea)    ACL     �   REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;
       
   extensions          postgres    false    542            /           0    0 %   FUNCTION armor(bytea, text[], text[])    ACL     �   REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;
       
   extensions          postgres    false    543            0           0    0    FUNCTION crypt(text, text)    ACL     �   REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;
       
   extensions          postgres    false    530            1           0    0    FUNCTION dearmor(text)    ACL     �   REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;
       
   extensions          postgres    false    544            2           0    0 $   FUNCTION decrypt(bytea, bytea, text)    ACL     �   REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;
       
   extensions          postgres    false    510            3           0    0 .   FUNCTION decrypt_iv(bytea, bytea, bytea, text)    ACL       REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;
       
   extensions          postgres    false    512            4           0    0    FUNCTION digest(bytea, text)    ACL     �   REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;
       
   extensions          postgres    false    527            5           0    0    FUNCTION digest(text, text)    ACL     �   REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;
       
   extensions          postgres    false    526            6           0    0 $   FUNCTION encrypt(bytea, bytea, text)    ACL     �   REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;
       
   extensions          postgres    false    509            7           0    0 .   FUNCTION encrypt_iv(bytea, bytea, bytea, text)    ACL       REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;
       
   extensions          postgres    false    511            8           0    0 "   FUNCTION gen_random_bytes(integer)    ACL     �   REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;
       
   extensions          postgres    false    531            9           0    0    FUNCTION gen_random_uuid()    ACL     �   REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;
       
   extensions          postgres    false    532            :           0    0    FUNCTION gen_salt(text)    ACL     �   REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;
       
   extensions          postgres    false    507            ;           0    0     FUNCTION gen_salt(text, integer)    ACL     �   REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;
       
   extensions          postgres    false    508            4           1255    16591    grant_pg_cron_access()    FUNCTION     �  CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;
 1   DROP FUNCTION extensions.grant_pg_cron_access();
    
   extensions          postgres    false    14            <           0    0    FUNCTION grant_pg_cron_access()    COMMENT     U   COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';
       
   extensions          postgres    false    564            =           0    0    FUNCTION grant_pg_cron_access()    ACL     �   REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;
       
   extensions          postgres    false    564            �           1255    16612    grant_pg_graphql_access()    FUNCTION     i	  CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;
 4   DROP FUNCTION extensions.grant_pg_graphql_access();
    
   extensions          supabase_admin    false    14            >           0    0 "   FUNCTION grant_pg_graphql_access()    COMMENT     [   COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';
       
   extensions          supabase_admin    false    384            ?           0    0 "   FUNCTION grant_pg_graphql_access()    ACL     Z   GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;
       
   extensions          supabase_admin    false    384            +           1255    16593    grant_pg_net_access()    FUNCTION     �  CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

    REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
    REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

    GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
  END IF;
END;
$$;
 0   DROP FUNCTION extensions.grant_pg_net_access();
    
   extensions          postgres    false    14            @           0    0    FUNCTION grant_pg_net_access()    COMMENT     S   COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';
       
   extensions          postgres    false    555            A           0    0    FUNCTION grant_pg_net_access()    ACL     �   REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;
       
   extensions          postgres    false    555            B           0    0 !   FUNCTION hmac(bytea, bytea, text)    ACL     �   REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;
       
   extensions          postgres    false    529            C           0    0    FUNCTION hmac(text, text, text)    ACL     �   REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;
       
   extensions          postgres    false    528            D           0    0 U  FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision)    ACL     �  REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO dashboard_user;
       
   extensions          postgres    false    550            E           0    0 ^   FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone)    ACL     �  REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;
       
   extensions          postgres    false    549            F           0    0 G   FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint)    ACL     b  REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO dashboard_user;
       
   extensions          postgres    false    548            G           0    0 >   FUNCTION pgp_armor_headers(text, OUT key text, OUT value text)    ACL     G  REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;
       
   extensions          postgres    false    545            H           0    0    FUNCTION pgp_key_id(bytea)    ACL     �   REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;
       
   extensions          postgres    false    541            I           0    0 &   FUNCTION pgp_pub_decrypt(bytea, bytea)    ACL     �   REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;
       
   extensions          postgres    false    368            J           0    0 ,   FUNCTION pgp_pub_decrypt(bytea, bytea, text)    ACL       REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;
       
   extensions          postgres    false    537            K           0    0 2   FUNCTION pgp_pub_decrypt(bytea, bytea, text, text)    ACL     #  REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;
       
   extensions          postgres    false    539            L           0    0 ,   FUNCTION pgp_pub_decrypt_bytea(bytea, bytea)    ACL       REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;
       
   extensions          postgres    false    536            M           0    0 2   FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text)    ACL     #  REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;
       
   extensions          postgres    false    538            N           0    0 8   FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text)    ACL     5  REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;
       
   extensions          postgres    false    540            O           0    0 %   FUNCTION pgp_pub_encrypt(text, bytea)    ACL     �   REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;
       
   extensions          postgres    false    356            P           0    0 +   FUNCTION pgp_pub_encrypt(text, bytea, text)    ACL       REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;
       
   extensions          postgres    false    358            Q           0    0 ,   FUNCTION pgp_pub_encrypt_bytea(bytea, bytea)    ACL       REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;
       
   extensions          postgres    false    357            R           0    0 2   FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text)    ACL     #  REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;
       
   extensions          postgres    false    535            S           0    0 %   FUNCTION pgp_sym_decrypt(bytea, text)    ACL     �   REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;
       
   extensions          postgres    false    371            T           0    0 +   FUNCTION pgp_sym_decrypt(bytea, text, text)    ACL       REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;
       
   extensions          postgres    false    373            U           0    0 +   FUNCTION pgp_sym_decrypt_bytea(bytea, text)    ACL       REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;
       
   extensions          postgres    false    372            V           0    0 1   FUNCTION pgp_sym_decrypt_bytea(bytea, text, text)    ACL        REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;
       
   extensions          postgres    false    374            W           0    0 $   FUNCTION pgp_sym_encrypt(text, text)    ACL     �   REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;
       
   extensions          postgres    false    533            X           0    0 *   FUNCTION pgp_sym_encrypt(text, text, text)    ACL       REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;
       
   extensions          postgres    false    369            Y           0    0 +   FUNCTION pgp_sym_encrypt_bytea(bytea, text)    ACL       REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;
       
   extensions          postgres    false    534            Z           0    0 1   FUNCTION pgp_sym_encrypt_bytea(bytea, text, text)    ACL        REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;
       
   extensions          postgres    false    370            *           1255    16603    pgrst_ddl_watch()    FUNCTION     >  CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;
 ,   DROP FUNCTION extensions.pgrst_ddl_watch();
    
   extensions          supabase_admin    false    14            [           0    0    FUNCTION pgrst_ddl_watch()    ACL     R   GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;
       
   extensions          supabase_admin    false    554            ~           1255    16604    pgrst_drop_watch()    FUNCTION       CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;
 -   DROP FUNCTION extensions.pgrst_drop_watch();
    
   extensions          supabase_admin    false    14            \           0    0    FUNCTION pgrst_drop_watch()    ACL     S   GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;
       
   extensions          supabase_admin    false    382            ,           1255    16614    set_graphql_placeholder()    FUNCTION     r  CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;
 4   DROP FUNCTION extensions.set_graphql_placeholder();
    
   extensions          supabase_admin    false    14            ]           0    0 "   FUNCTION set_graphql_placeholder()    COMMENT     |   COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';
       
   extensions          supabase_admin    false    556            ^           0    0 "   FUNCTION set_graphql_placeholder()    ACL     Z   GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;
       
   extensions          supabase_admin    false    556            _           0    0 8   FUNCTION sign(payload json, secret text, algorithm text)    ACL     5  REVOKE ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) FROM postgres;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO dashboard_user;
       
   extensions          postgres    false    551            `           0    0 "   FUNCTION try_cast_double(inp text)    ACL     �   REVOKE ALL ON FUNCTION extensions.try_cast_double(inp text) FROM postgres;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO dashboard_user;
       
   extensions          postgres    false    552            a           0    0    FUNCTION url_decode(data text)    ACL     �   REVOKE ALL ON FUNCTION extensions.url_decode(data text) FROM postgres;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO dashboard_user;
       
   extensions          postgres    false    378            b           0    0    FUNCTION url_encode(data bytea)    ACL     �   REVOKE ALL ON FUNCTION extensions.url_encode(data bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO dashboard_user;
       
   extensions          postgres    false    546            c           0    0    FUNCTION uuid_generate_v1()    ACL     �   REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;
       
   extensions          postgres    false    375            d           0    0    FUNCTION uuid_generate_v1mc()    ACL     �   REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;
       
   extensions          postgres    false    376            e           0    0 4   FUNCTION uuid_generate_v3(namespace uuid, name text)    ACL     )  REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;
       
   extensions          postgres    false    377            f           0    0    FUNCTION uuid_generate_v4()    ACL     �   REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;
       
   extensions          postgres    false    524            g           0    0 4   FUNCTION uuid_generate_v5(namespace uuid, name text)    ACL     )  REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;
       
   extensions          postgres    false    525            h           0    0    FUNCTION uuid_nil()    ACL     �   REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;
       
   extensions          postgres    false    362            i           0    0    FUNCTION uuid_ns_dns()    ACL     �   REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;
       
   extensions          postgres    false    363            j           0    0    FUNCTION uuid_ns_oid()    ACL     �   REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;
       
   extensions          postgres    false    365            k           0    0    FUNCTION uuid_ns_url()    ACL     �   REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;
       
   extensions          postgres    false    364            l           0    0    FUNCTION uuid_ns_x500()    ACL     �   REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;
       
   extensions          postgres    false    366            m           0    0 8   FUNCTION verify(token text, secret text, algorithm text)    ACL     5  REVOKE ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) FROM postgres;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO dashboard_user;
       
   extensions          postgres    false    553            n           0    0 U   FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb)    ACL       GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;
          graphql_public          supabase_admin    false    559            X           1255    16387    get_auth(text)    FUNCTION     J  CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    RAISE WARNING 'PgBouncer auth request: %', p_usename;

    RETURN QUERY
    SELECT usename::TEXT, passwd::TEXT FROM pg_catalog.pg_shadow
    WHERE usename = p_usename;
END;
$$;
 2   DROP FUNCTION pgbouncer.get_auth(p_usename text);
    	   pgbouncer          postgres    false    12            o           0    0 !   FUNCTION get_auth(p_usename text)    ACL     �   REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;
       	   pgbouncer          postgres    false    344            p           0    0 ]   FUNCTION crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea)    ACL     �   GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;
          pgsodium          pgsodium_keymaker    false    518            q           0    0 ]   FUNCTION crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea)    ACL     �   GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;
          pgsodium          pgsodium_keymaker    false    519            r           0    0 !   FUNCTION crypto_aead_det_keygen()    ACL     I   GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_keygen() TO service_role;
          pgsodium          supabase_admin    false    520            H           1255    29111    apply_rls(jsonb, integer)    FUNCTION     �(  CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;
 G   DROP FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer);
       realtime          supabase_admin    false    1536    13            s           0    0 7   FUNCTION apply_rls(wal jsonb, max_record_bytes integer)    ACL     <  GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;
          realtime          supabase_admin    false    584            I           1255    29189 E   broadcast_changes(text, text, text, text, text, record, record, text)    FUNCTION       CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;
 �   DROP FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text);
       realtime          supabase_admin    false    13            t           0    0 �   FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text)    ACL     v  GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;
          realtime          supabase_admin    false    585            F           1255    29123 C   build_prepared_statement_sql(text, regclass, realtime.wal_column[])    FUNCTION     �  CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;
 �   DROP FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]);
       realtime          supabase_admin    false    1539    13            u           0    0 s   FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[])    ACL     �  GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;
          realtime          supabase_admin    false    582            C           1255    29073    cast(text, regtype)    FUNCTION       CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;
 8   DROP FUNCTION realtime."cast"(val text, type_ regtype);
       realtime          supabase_admin    false    13            v           0    0 (   FUNCTION "cast"(val text, type_ regtype)    ACL     �  GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;
          realtime          supabase_admin    false    579            E           1255    29068 <   check_equality_op(realtime.equality_op, regtype, text, text)    FUNCTION     U  CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;
 j   DROP FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text);
       realtime          supabase_admin    false    13    1463            w           0    0 Z   FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text)    ACL       GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;
          realtime          supabase_admin    false    581            J           1255    29119 Q   is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[])    FUNCTION     �  CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;
 z   DROP FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]);
       realtime          supabase_admin    false    1539    1466    13            x           0    0 j   FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[])    ACL     n  GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;
          realtime          supabase_admin    false    586            D           1255    29130 *   list_changes(name, name, integer, integer)    FUNCTION     �  CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;
 v   DROP FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer);
       realtime          supabase_admin    false    13    1536            y           0    0 f   FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer)    ACL     V  GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;
          realtime          supabase_admin    false    580            B           1255    29067    quote_wal2json(regclass)    FUNCTION     �  CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;
 8   DROP FUNCTION realtime.quote_wal2json(entity regclass);
       realtime          supabase_admin    false    13            z           0    0 (   FUNCTION quote_wal2json(entity regclass)    ACL     �  GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;
          realtime          supabase_admin    false    578            G           1255    29188     send(jsonb, text, text, boolean)    FUNCTION       CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  partition_name text;
BEGIN
  partition_name := 'messages_' || to_char(NOW(), 'YYYY_MM_DD');

  IF NOT EXISTS (
    SELECT 1
    FROM pg_class c
    JOIN pg_namespace n ON n.oid = c.relnamespace
    WHERE n.nspname = 'realtime'
    AND c.relname = partition_name
  ) THEN
    EXECUTE format(
      'CREATE TABLE realtime.%I PARTITION OF realtime.messages FOR VALUES FROM (%L) TO (%L)',
      partition_name,
      NOW(),
      (NOW() + interval '1 day')::timestamp
    );
  END IF;

  INSERT INTO realtime.messages (payload, event, topic, private, extension)
  VALUES (payload, event, topic, private, 'broadcast');
END;
$$;
 U   DROP FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean);
       realtime          supabase_admin    false    13            {           0    0 E   FUNCTION send(payload jsonb, event text, topic text, private boolean)    ACL     �   GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;
          realtime          supabase_admin    false    583            >           1255    29065    subscription_check_filters()    FUNCTION     <
  CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;
 5   DROP FUNCTION realtime.subscription_check_filters();
       realtime          supabase_admin    false    13            |           0    0 %   FUNCTION subscription_check_filters()    ACL     �  GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;
          realtime          supabase_admin    false    574            =           1255    29100    to_regrole(text)    FUNCTION     �   CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;
 3   DROP FUNCTION realtime.to_regrole(role_name text);
       realtime          supabase_admin    false    13            }           0    0 #   FUNCTION to_regrole(role_name text)    ACL     �  GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;
          realtime          supabase_admin    false    573            K           1255    29182    topic()    FUNCTION     �   CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;
     DROP FUNCTION realtime.topic();
       realtime          supabase_realtime_admin    false    13            ~           0    0    FUNCTION topic()    ACL     n   GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;
          realtime          supabase_realtime_admin    false    587            ;           1255    28970 *   can_insert_object(text, text, uuid, jsonb)    FUNCTION     �  CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;
 _   DROP FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb);
       storage          supabase_storage_admin    false    15            8           1255    28944    extension(text)    FUNCTION     Z  CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;
 ,   DROP FUNCTION storage.extension(name text);
       storage          supabase_storage_admin    false    15            7           1255    28943    filename(text)    FUNCTION     �   CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;
 +   DROP FUNCTION storage.filename(name text);
       storage          supabase_storage_admin    false    15            6           1255    28942    foldername(text)    FUNCTION     �   CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;
 -   DROP FUNCTION storage.foldername(name text);
       storage          supabase_storage_admin    false    15            9           1255    28956    get_size_by_bucket()    FUNCTION        CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;
 ,   DROP FUNCTION storage.get_size_by_bucket();
       storage          supabase_storage_admin    false    15            ?           1255    29009 L   list_multipart_uploads_with_delimiter(text, text, text, integer, text, text)    FUNCTION     9  CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;
 �   DROP FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text);
       storage          supabase_storage_admin    false    15            <           1255    28972 B   list_objects_with_delimiter(text, text, text, integer, text, text)    FUNCTION     �  CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;
 �   DROP FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text);
       storage          supabase_storage_admin    false    15            A           1255    29025    operation()    FUNCTION     �   CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;
 #   DROP FUNCTION storage.operation();
       storage          supabase_storage_admin    false    15            @           1255    28959 ?   search(text, text, integer, integer, integer, text, text, text)    FUNCTION       CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;
 �   DROP FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text);
       storage          supabase_storage_admin    false    15            :           1255    28960    update_updated_at_column()    FUNCTION     �   CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;
 2   DROP FUNCTION storage.update_updated_at_column();
       storage          supabase_storage_admin    false    15            	           1255    16974    secrets_encrypt_secret_secret()    FUNCTION     (  CREATE FUNCTION vault.secrets_encrypt_secret_secret() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
		BEGIN
		        new.secret = CASE WHEN new.secret IS NULL THEN NULL ELSE
			CASE WHEN new.key_id IS NULL THEN NULL ELSE pg_catalog.encode(
			  pgsodium.crypto_aead_det_encrypt(
				pg_catalog.convert_to(new.secret, 'utf8'),
				pg_catalog.convert_to((new.id::text || new.description::text || new.created_at::text || new.updated_at::text)::text, 'utf8'),
				new.key_id::uuid,
				new.nonce
			  ),
				'base64') END END;
		RETURN new;
		END;
		$$;
 5   DROP FUNCTION vault.secrets_encrypt_secret_secret();
       vault          supabase_admin    false    19            �            1259    16519    audit_log_entries    TABLE     �   CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);
 #   DROP TABLE auth.audit_log_entries;
       auth         heap    supabase_auth_admin    false    16                       0    0    TABLE audit_log_entries    COMMENT     R   COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';
          auth          supabase_auth_admin    false    237            �           0    0    TABLE audit_log_entries    ACL     �   GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;
          auth          supabase_auth_admin    false    237                       1259    28867 
   flow_state    TABLE     �  CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);
    DROP TABLE auth.flow_state;
       auth         heap    supabase_auth_admin    false    1442    16            �           0    0    TABLE flow_state    COMMENT     G   COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';
          auth          supabase_auth_admin    false    267            �           0    0    TABLE flow_state    ACL     �   GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;
          auth          supabase_auth_admin    false    267                       1259    28664 
   identities    TABLE     �  CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);
    DROP TABLE auth.identities;
       auth         heap    supabase_auth_admin    false    16            �           0    0    TABLE identities    COMMENT     U   COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';
          auth          supabase_auth_admin    false    258            �           0    0    COLUMN identities.email    COMMENT     �   COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';
          auth          supabase_auth_admin    false    258            �           0    0    TABLE identities    ACL     �   GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;
          auth          supabase_auth_admin    false    258            �            1259    16512 	   instances    TABLE     �   CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);
    DROP TABLE auth.instances;
       auth         heap    supabase_auth_admin    false    16            �           0    0    TABLE instances    COMMENT     Q   COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';
          auth          supabase_auth_admin    false    236            �           0    0    TABLE instances    ACL     �   GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;
          auth          supabase_auth_admin    false    236                       1259    28754    mfa_amr_claims    TABLE     �   CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);
     DROP TABLE auth.mfa_amr_claims;
       auth         heap    supabase_auth_admin    false    16            �           0    0    TABLE mfa_amr_claims    COMMENT     ~   COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';
          auth          supabase_auth_admin    false    262            �           0    0    TABLE mfa_amr_claims    ACL     �   GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;
          auth          supabase_auth_admin    false    262                       1259    28742    mfa_challenges    TABLE       CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);
     DROP TABLE auth.mfa_challenges;
       auth         heap    supabase_auth_admin    false    16            �           0    0    TABLE mfa_challenges    COMMENT     _   COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';
          auth          supabase_auth_admin    false    261            �           0    0    TABLE mfa_challenges    ACL     �   GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;
          auth          supabase_auth_admin    false    261                       1259    28729    mfa_factors    TABLE     �  CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);
    DROP TABLE auth.mfa_factors;
       auth         heap    supabase_auth_admin    false    1415    1412    16            �           0    0    TABLE mfa_factors    COMMENT     L   COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';
          auth          supabase_auth_admin    false    260            �           0    0    TABLE mfa_factors    ACL     �   GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;
          auth          supabase_auth_admin    false    260                       1259    28917    one_time_tokens    TABLE     �  CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);
 !   DROP TABLE auth.one_time_tokens;
       auth         heap    supabase_auth_admin    false    1448    16            �           0    0    TABLE one_time_tokens    ACL     �   GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;
          auth          supabase_auth_admin    false    268            �            1259    16501    refresh_tokens    TABLE     8  CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);
     DROP TABLE auth.refresh_tokens;
       auth         heap    supabase_auth_admin    false    16            �           0    0    TABLE refresh_tokens    COMMENT     n   COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';
          auth          supabase_auth_admin    false    235            �           0    0    TABLE refresh_tokens    ACL     �   GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;
          auth          supabase_auth_admin    false    235            �            1259    16500    refresh_tokens_id_seq    SEQUENCE     |   CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE auth.refresh_tokens_id_seq;
       auth          supabase_auth_admin    false    235    16            �           0    0    refresh_tokens_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;
          auth          supabase_auth_admin    false    234            �           0    0    SEQUENCE refresh_tokens_id_seq    ACL     �   GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;
          auth          supabase_auth_admin    false    234            	           1259    28796    saml_providers    TABLE     H  CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);
     DROP TABLE auth.saml_providers;
       auth         heap    supabase_auth_admin    false    16            �           0    0    TABLE saml_providers    COMMENT     ]   COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';
          auth          supabase_auth_admin    false    265            �           0    0    TABLE saml_providers    ACL     �   GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;
          auth          supabase_auth_admin    false    265            
           1259    28814    saml_relay_states    TABLE     `  CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);
 #   DROP TABLE auth.saml_relay_states;
       auth         heap    supabase_auth_admin    false    16            �           0    0    TABLE saml_relay_states    COMMENT     �   COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';
          auth          supabase_auth_admin    false    266            �           0    0    TABLE saml_relay_states    ACL     �   GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;
          auth          supabase_auth_admin    false    266            �            1259    16527    schema_migrations    TABLE     U   CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);
 #   DROP TABLE auth.schema_migrations;
       auth         heap    supabase_auth_admin    false    16            �           0    0    TABLE schema_migrations    COMMENT     X   COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';
          auth          supabase_auth_admin    false    238            �           0    0    TABLE schema_migrations    ACL     �   GRANT ALL ON TABLE auth.schema_migrations TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.schema_migrations TO postgres;
GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;
          auth          supabase_auth_admin    false    238                       1259    28694    sessions    TABLE     T  CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);
    DROP TABLE auth.sessions;
       auth         heap    supabase_auth_admin    false    16    1418            �           0    0    TABLE sessions    COMMENT     U   COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';
          auth          supabase_auth_admin    false    259            �           0    0    COLUMN sessions.not_after    COMMENT     �   COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';
          auth          supabase_auth_admin    false    259            �           0    0    TABLE sessions    ACL     �   GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;
          auth          supabase_auth_admin    false    259                       1259    28781    sso_domains    TABLE       CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);
    DROP TABLE auth.sso_domains;
       auth         heap    supabase_auth_admin    false    16            �           0    0    TABLE sso_domains    COMMENT     t   COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';
          auth          supabase_auth_admin    false    264            �           0    0    TABLE sso_domains    ACL     �   GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;
          auth          supabase_auth_admin    false    264                       1259    28772    sso_providers    TABLE       CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);
    DROP TABLE auth.sso_providers;
       auth         heap    supabase_auth_admin    false    16            �           0    0    TABLE sso_providers    COMMENT     x   COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';
          auth          supabase_auth_admin    false    263            �           0    0     COLUMN sso_providers.resource_id    COMMENT     �   COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';
          auth          supabase_auth_admin    false    263            �           0    0    TABLE sso_providers    ACL     �   GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;
          auth          supabase_auth_admin    false    263            �            1259    16489    users    TABLE     4  CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);
    DROP TABLE auth.users;
       auth         heap    supabase_auth_admin    false    16            �           0    0    TABLE users    COMMENT     W   COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';
          auth          supabase_auth_admin    false    233            �           0    0    COLUMN users.is_sso_user    COMMENT     �   COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';
          auth          supabase_auth_admin    false    233            �           0    0    TABLE users    ACL     �   GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;
          auth          supabase_auth_admin    false    233            �           0    0    TABLE pg_stat_statements    ACL     �   REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;
       
   extensions          postgres    false    232            �           0    0    TABLE pg_stat_statements_info    ACL     �   REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;
       
   extensions          postgres    false    231            �           0    0    TABLE decrypted_key    ACL     A   GRANT ALL ON TABLE pgsodium.decrypted_key TO pgsodium_keyholder;
          pgsodium          supabase_admin    false    254            �           0    0    TABLE masking_rule    ACL     @   GRANT ALL ON TABLE pgsodium.masking_rule TO pgsodium_keyholder;
          pgsodium          supabase_admin    false    252            �           0    0    TABLE mask_columns    ACL     @   GRANT ALL ON TABLE pgsodium.mask_columns TO pgsodium_keyholder;
          pgsodium          supabase_admin    false    253            5           1259    40030    AIPermissions    TABLE     -  CREATE TABLE public."AIPermissions" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    grant_access boolean DEFAULT false NOT NULL,
    "permissionsId" text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);
 #   DROP TABLE public."AIPermissions";
       public         heap    postgres    false    22                       1259    39738    AdminDetails    TABLE     $  CREATE TABLE public."AdminDetails" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "userId" text NOT NULL,
    package_id text,
    company_name text,
    company_logo text,
    profile_image text,
    time_format text,
    time_zone text,
    date_format text,
    week_format text
);
 "   DROP TABLE public."AdminDetails";
       public         heap    postgres    false    22                       1259    39772    AttendanceAutomationRule    TABLE     �  CREATE TABLE public."AttendanceAutomationRule" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    auto_absent boolean DEFAULT false NOT NULL,
    present_on_punch boolean DEFAULT false NOT NULL,
    auto_half_day text,
    manadatory_half_day text,
    manadatory_full_day text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL,
    "staffId" text NOT NULL
);
 .   DROP TABLE public."AttendanceAutomationRule";
       public         heap    postgres    false    22                        1259    39783    AttendanceMode    TABLE     A  CREATE TABLE public."AttendanceMode" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    selfie_attendance boolean DEFAULT false NOT NULL,
    qr_attendance boolean DEFAULT false NOT NULL,
    gps_attendance boolean DEFAULT false NOT NULL,
    mark_attendance public."MarkAttendenceType" DEFAULT 'Office'::public."MarkAttendenceType" NOT NULL,
    allow_punch_in_for_mobile boolean DEFAULT false NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL,
    "staffId" text NOT NULL
);
 $   DROP TABLE public."AttendanceMode";
       public         heap    postgres    false    1286    22    1286            #           1259    39825    BankDetails    TABLE     T  CREATE TABLE public."BankDetails" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "staffId" text NOT NULL,
    bank_name text,
    account_number text,
    branch_name text,
    ifsc_code text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);
 !   DROP TABLE public."BankDetails";
       public         heap    postgres    false    22                       1259    39746    Branch    TABLE     �   CREATE TABLE public."Branch" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "branchName" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
    DROP TABLE public."Branch";
       public         heap    postgres    false    22            4           1259    40020    ChatModulePermissions    TABLE     5  CREATE TABLE public."ChatModulePermissions" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    grant_access boolean DEFAULT false NOT NULL,
    "permissionsId" text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);
 +   DROP TABLE public."ChatModulePermissions";
       public         heap    postgres    false    22                       1259    39719    ChatRoom    TABLE     �   CREATE TABLE public."ChatRoom" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    name text,
    "isGroup" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public."ChatRoom";
       public         heap    postgres    false    22            K           1259    40251    ClientDetails    TABLE     <  CREATE TABLE public."ClientDetails" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "userId" text NOT NULL,
    company text NOT NULL,
    vat_number text NOT NULL,
    website text,
    groups text[],
    currency text[],
    default_language text[],
    address text NOT NULL,
    country text NOT NULL,
    state text NOT NULL,
    city text NOT NULL,
    status boolean DEFAULT false NOT NULL,
    zip_code text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);
 #   DROP TABLE public."ClientDetails";
       public         heap    postgres    false    22            ,           1259    39920    ClientsPermissions    TABLE     �  CREATE TABLE public."ClientsPermissions" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    view_global boolean DEFAULT false NOT NULL,
    "create" boolean DEFAULT false NOT NULL,
    edit boolean DEFAULT false NOT NULL,
    delete boolean DEFAULT false NOT NULL,
    "permissionsId" text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);
 (   DROP TABLE public."ClientsPermissions";
       public         heap    postgres    false    22            '           1259    39867    CustomDetails    TABLE     �   CREATE TABLE public."CustomDetails" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "staffId" text NOT NULL,
    field_name text NOT NULL,
    field_value text NOT NULL
);
 #   DROP TABLE public."CustomDetails";
       public         heap    postgres    false    22            O           1259    40284 
   Deductions    TABLE     �   CREATE TABLE public."Deductions" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    heads text,
    calculation text,
    amount double precision,
    deduction_month text,
    "staffId" text,
    "salaryDetailsId" text
);
     DROP TABLE public."Deductions";
       public         heap    postgres    false    22                       1259    39764 
   Department    TABLE     x   CREATE TABLE public."Department" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    department_name text NOT NULL
);
     DROP TABLE public."Department";
       public         heap    postgres    false    22            J           1259    40243 
   Discussion    TABLE     �   CREATE TABLE public."Discussion" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    subject text NOT NULL,
    discription text NOT NULL,
    last_activity text NOT NULL,
    total_comments text NOT NULL,
    visible_to_customer text NOT NULL
);
     DROP TABLE public."Discussion";
       public         heap    postgres    false    22            (           1259    39875    EarlyLeavePolicy    TABLE     P  CREATE TABLE public."EarlyLeavePolicy" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "fineType" public."FineType" DEFAULT 'HOURLY'::public."FineType" NOT NULL,
    "gracePeriodMins" integer DEFAULT 0 NOT NULL,
    "fineAmountMins" integer DEFAULT 0 NOT NULL,
    "waiveOffDays" integer DEFAULT 0 NOT NULL,
    "staffId" text
);
 &   DROP TABLE public."EarlyLeavePolicy";
       public         heap    postgres    false    1298    1298    22            P           1259    40292    Earnings    TABLE     �   CREATE TABLE public."Earnings" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    heads text,
    calculation text,
    amount double precision,
    "staffId" text,
    salary_month text,
    "salaryDetailsId" text
);
    DROP TABLE public."Earnings";
       public         heap    postgres    false    22            C           1259    40183    EndBreak    TABLE     �  CREATE TABLE public."EndBreak" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "breakMethod" public."BreakMethod" DEFAULT 'PHOTOCLICK'::public."BreakMethod" NOT NULL,
    "endBreakTime" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "biometricData" text,
    "qrCodeValue" text,
    "photoUrl" text,
    location text NOT NULL,
    "staffId" text NOT NULL,
    "punchRecordId" text,
    "punchRecordsId" text
);
    DROP TABLE public."EndBreak";
       public         heap    postgres    false    1316    22    1316            >           1259    40121    Fine    TABLE     �  CREATE TABLE public."Fine" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "lateEntryFineHoursTime" text,
    "lateEntryFineAmount" double precision DEFAULT 1,
    "lateEntryAmount" double precision DEFAULT 0,
    "excessBreakFineHoursTime" text,
    "excessBreakFineAmount" double precision DEFAULT 1,
    "excessBreakAmount" double precision DEFAULT 0,
    "earlyOutFineHoursTime" text,
    "earlyOutFineAmount" double precision DEFAULT 1,
    "earlyOutAmount" double precision DEFAULT 0,
    "totalAmount" double precision DEFAULT 0,
    "shiftIds" text,
    "punchRecordId" text NOT NULL,
    "staffId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public."Fine";
       public         heap    postgres    false    22            :           1259    40080 
   FixedShift    TABLE     A  CREATE TABLE public."FixedShift" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    day public."Day" DEFAULT 'Mon'::public."Day" NOT NULL,
    "weekOff" boolean DEFAULT false NOT NULL,
    "staffId" text NOT NULL,
    "weekId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
     DROP TABLE public."FixedShift";
       public         heap    postgres    false    1304    1304    22            ;           1259    40091    FlexibleShift    TABLE     .  CREATE TABLE public."FlexibleShift" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "dateTime" timestamp(3) without time zone NOT NULL,
    "weekOff" boolean DEFAULT false NOT NULL,
    "staffId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
 #   DROP TABLE public."FlexibleShift";
       public         heap    postgres    false    22            )           1259    39887    LateComingPolicy    TABLE     P  CREATE TABLE public."LateComingPolicy" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "fineType" public."FineType" DEFAULT 'HOURLY'::public."FineType" NOT NULL,
    "gracePeriodMins" integer DEFAULT 0 NOT NULL,
    "fineAmountMins" integer DEFAULT 0 NOT NULL,
    "waiveOffDays" integer DEFAULT 0 NOT NULL,
    "staffId" text
);
 &   DROP TABLE public."LateComingPolicy";
       public         heap    postgres    false    1298    1298    22            &           1259    39856    LeaveBalance    TABLE     �  CREATE TABLE public."LeaveBalance" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "staffId" text NOT NULL,
    "leavePolicyId" text NOT NULL,
    balance double precision DEFAULT 0 NOT NULL,
    used double precision DEFAULT 0 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
 "   DROP TABLE public."LeaveBalance";
       public         heap    postgres    false    22            $           1259    39834    LeavePolicy    TABLE     �  CREATE TABLE public."LeavePolicy" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "staffId" text NOT NULL,
    name text NOT NULL,
    allowed_leaves integer DEFAULT 0 NOT NULL,
    carry_forward_leaves integer DEFAULT 0 NOT NULL,
    policy_type public."LeaveType" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
 !   DROP TABLE public."LeavePolicy";
       public         heap    postgres    false    22    1292            %           1259    39845    LeaveRequest    TABLE     C  CREATE TABLE public."LeaveRequest" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "staffId" text NOT NULL,
    "leaveTypeId" text NOT NULL,
    request_date timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    start_date timestamp(3) without time zone NOT NULL,
    end_date timestamp(3) without time zone NOT NULL,
    status public."LeaveRequestStatus" DEFAULT 'PENDING'::public."LeaveRequestStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
 "   DROP TABLE public."LeaveRequest";
       public         heap    postgres    false    1295    1295    22                       1259    39729    Message    TABLE     �   CREATE TABLE public."Message" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    content text NOT NULL,
    "timestamp" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "senderId" text NOT NULL,
    "roomId" text NOT NULL
);
    DROP TABLE public."Message";
       public         heap    postgres    false    22            ?           1259    40137    Overtime    TABLE     �  CREATE TABLE public."Overtime" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "earlyCommingEntryHoursTime" text,
    "earlyCommingEntryAmount" double precision DEFAULT 1,
    "earlyEntryAmount" double precision DEFAULT 0,
    "lateOutOvertimeHoursTime" text,
    "lateOutOvertimeAmount" double precision DEFAULT 1,
    "lateOutAmount" double precision DEFAULT 0,
    "totalAmount" double precision DEFAULT 0,
    "shiftIds" text,
    "punchRecordId" text,
    "staffId" text
);
    DROP TABLE public."Overtime";
       public         heap    postgres    false    22            *           1259    39899    OvertimePolicy    TABLE     /  CREATE TABLE public."OvertimePolicy" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "gracePeriodMins" integer DEFAULT 0 NOT NULL,
    "extraHoursPay" integer DEFAULT 0 NOT NULL,
    "publicHolidayPay" integer DEFAULT 0 NOT NULL,
    "weekOffPay" integer DEFAULT 0 NOT NULL,
    "staffId" text
);
 $   DROP TABLE public."OvertimePolicy";
       public         heap    postgres    false    22            "           1259    39813    PastEmployment    TABLE     �  CREATE TABLE public."PastEmployment" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    company_name text NOT NULL,
    designation text,
    joining_date timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    leaving_date timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    currency text,
    salary double precision,
    company_gst text,
    "past_Employment_status" public."VerificationStatus" DEFAULT 'PENDING'::public."VerificationStatus" NOT NULL,
    "staffId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
 $   DROP TABLE public."PastEmployment";
       public         heap    postgres    false    1289    22    1289            6           1259    40040    Permissions    TABLE     �   CREATE TABLE public."Permissions" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "roleId" text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);
 !   DROP TABLE public."Permissions";
       public         heap    postgres    false    22            H           1259    40227    Project    TABLE     �  CREATE TABLE public."Project" (
    id text NOT NULL,
    project_name text NOT NULL,
    billing_type text NOT NULL,
    status text NOT NULL,
    total_rate integer NOT NULL,
    estimated_hours integer NOT NULL,
    start_date text NOT NULL,
    deadline text NOT NULL,
    tags text[],
    description text NOT NULL,
    send_mail boolean DEFAULT false NOT NULL,
    "customerId" text
);
    DROP TABLE public."Project";
       public         heap    postgres    false    22            G           1259    40218    ProjectFiles    TABLE     T  CREATE TABLE public."ProjectFiles" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    file_name text NOT NULL,
    file_type text NOT NULL,
    last_activity text,
    total_comments text,
    visible_to_customer boolean DEFAULT false NOT NULL,
    uploaded_by text NOT NULL,
    date_uploaded timestamp(3) without time zone NOT NULL
);
 "   DROP TABLE public."ProjectFiles";
       public         heap    postgres    false    22            N           1259    40276    ProjectPriority    TABLE       CREATE TABLE public."ProjectPriority" (
    id text NOT NULL,
    "Priority_name" text NOT NULL,
    "Priority_color" text NOT NULL,
    "Priority_order" text NOT NULL,
    default_filter boolean DEFAULT false NOT NULL,
    is_hidden text[],
    can_changed text[]
);
 %   DROP TABLE public."ProjectPriority";
       public         heap    postgres    false    22            M           1259    40268    ProjectStatus    TABLE     �   CREATE TABLE public."ProjectStatus" (
    id text NOT NULL,
    project_name text NOT NULL,
    project_color text NOT NULL,
    project_order text NOT NULL,
    default_filter boolean DEFAULT false NOT NULL,
    can_changed text[]
);
 #   DROP TABLE public."ProjectStatus";
       public         heap    postgres    false    22            -           1259    39933    ProjectsPermissions    TABLE     �  CREATE TABLE public."ProjectsPermissions" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    view_global boolean DEFAULT false NOT NULL,
    "create" boolean DEFAULT false NOT NULL,
    edit boolean DEFAULT false NOT NULL,
    delete boolean DEFAULT false NOT NULL,
    "permissionsId" text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);
 )   DROP TABLE public."ProjectsPermissions";
       public         heap    postgres    false    22            @           1259    40150    PunchIn    TABLE     �  CREATE TABLE public."PunchIn" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "punchInMethod" public."PunchInMethod" DEFAULT 'PHOTOCLICK'::public."PunchInMethod",
    "punchInTime" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "punchInDate" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "biometricData" text,
    "qrCodeValue" text,
    "photoUrl" text,
    location text,
    approve text DEFAULT 'Pending'::text
);
    DROP TABLE public."PunchIn";
       public         heap    postgres    false    1310    1310    22            A           1259    40162    PunchOut    TABLE     �  CREATE TABLE public."PunchOut" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "punchOutMethod" public."PunchOutMethod" DEFAULT 'PHOTOCLICK'::public."PunchOutMethod",
    "punchOutTime" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "punchOutDate" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "biometricData" text,
    "qrCodeValue" text,
    "photoUrl" text,
    location text,
    overtime text
);
    DROP TABLE public."PunchOut";
       public         heap    postgres    false    1313    1313    22            <           1259    40101    PunchRecords    TABLE     y  CREATE TABLE public."PunchRecords" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "punchDate" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "isApproved" boolean DEFAULT false NOT NULL,
    "punchInId" text,
    "punchOutId" text,
    "staffId" text,
    status public."punchRecordStatus" DEFAULT 'ABSENT'::public."punchRecordStatus" NOT NULL
);
 "   DROP TABLE public."PunchRecords";
       public         heap    postgres    false    1307    1307    22            .           1259    39946    ReportPermissions    TABLE     e  CREATE TABLE public."ReportPermissions" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    view_global boolean DEFAULT false NOT NULL,
    view_time_sheets boolean DEFAULT false NOT NULL,
    "permissionsId" text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);
 '   DROP TABLE public."ReportPermissions";
       public         heap    postgres    false    22            +           1259    39911    Role    TABLE     �   CREATE TABLE public."Role" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    role_name text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);
    DROP TABLE public."Role";
       public         heap    postgres    false    22            7           1259    40049    SalaryDetails    TABLE     N  CREATE TABLE public."SalaryDetails" (
    id text NOT NULL,
    effective_date timestamp(3) without time zone,
    salary_type text,
    ctc_amount double precision,
    employer_pf double precision,
    employer_esi double precision,
    employer_lwf double precision,
    employee_pf double precision,
    employee_esi double precision,
    professional_tax double precision,
    employee_lwf double precision,
    tds double precision,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(3) without time zone,
    "staffId" text NOT NULL
);
 #   DROP TABLE public."SalaryDetails";
       public         heap    postgres    false    22            0           1259    39970    SettingsPermissions    TABLE     g  CREATE TABLE public."SettingsPermissions" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    view_global boolean DEFAULT false NOT NULL,
    view_time_sheets boolean DEFAULT false NOT NULL,
    "permissionsId" text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);
 )   DROP TABLE public."SettingsPermissions";
       public         heap    postgres    false    22            8           1259    40057    Shifts    TABLE     �  CREATE TABLE public."Shifts" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "shiftName" text NOT NULL,
    "shiftStartTime" text NOT NULL,
    "shiftEndTime" text NOT NULL,
    "punchInType" public."PunchTime" DEFAULT 'ANYTIME'::public."PunchTime" NOT NULL,
    "punchOutType" public."PunchTime" DEFAULT 'ANYTIME'::public."PunchTime" NOT NULL,
    "allowPunchInHours" integer,
    "allowPunchInMinutes" integer,
    "allowPunchOutMinutes" integer,
    "allowPunchOutHours" integer
);
    DROP TABLE public."Shifts";
       public         heap    postgres    false    1301    1301    22    1301    1301            !           1259    39797    StaffBackgroundVerification    TABLE     p  CREATE TABLE public."StaffBackgroundVerification" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    aadhaar_number text,
    aadhaar_verification_status public."VerificationStatus" DEFAULT 'PENDING'::public."VerificationStatus" NOT NULL,
    aadhaar_file text,
    voter_id_number text,
    voter_id_verification_status public."VerificationStatus" DEFAULT 'PENDING'::public."VerificationStatus" NOT NULL,
    voter_id_file text,
    pan_number text,
    pan_verification_status public."VerificationStatus" DEFAULT 'PENDING'::public."VerificationStatus" NOT NULL,
    pan_file text,
    uan_number text,
    uan_verification_status public."VerificationStatus" DEFAULT 'PENDING'::public."VerificationStatus" NOT NULL,
    uan_file text,
    driving_license_number text,
    driving_license_status public."VerificationStatus" DEFAULT 'PENDING'::public."VerificationStatus" NOT NULL,
    driving_license_file text,
    face_file text,
    face_verification_status public."VerificationStatus" DEFAULT 'PENDING'::public."VerificationStatus" NOT NULL,
    current_address text,
    permanent_address text,
    address_status public."VerificationStatus" DEFAULT 'PENDING'::public."VerificationStatus" NOT NULL,
    address_file text,
    "staffId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
 1   DROP TABLE public."StaffBackgroundVerification";
       public         heap    postgres    false    1289    1289    1289    1289    1289    1289    1289    1289    1289    1289    1289    1289    1289    1289    22                       1259    39754    StaffDetails    TABLE     �  CREATE TABLE public."StaffDetails" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "userId" text NOT NULL,
    job_title text,
    "departmentId" text,
    "roleId" text,
    login_otp text,
    gender text,
    official_email text,
    date_of_joining timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    date_of_birth timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    current_address text,
    permanent_address text,
    emergency_contact_name text,
    emergency_contact_mobile text,
    emergency_contact_relation text,
    emergency_contact_address text,
    guardian_name text,
    status text,
    employment text,
    marital_status text,
    blood_group text,
    "branchId" text
);
 "   DROP TABLE public."StaffDetails";
       public         heap    postgres    false    22            1           1259    39981    StaffPermissions    TABLE     �  CREATE TABLE public."StaffPermissions" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    view_global boolean DEFAULT false NOT NULL,
    "create" boolean DEFAULT false NOT NULL,
    edit boolean DEFAULT false NOT NULL,
    delete boolean DEFAULT false NOT NULL,
    "permissionsId" text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);
 &   DROP TABLE public."StaffPermissions";
       public         heap    postgres    false    22            /           1259    39957    StaffRolePermissions    TABLE     �  CREATE TABLE public."StaffRolePermissions" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    view_global boolean DEFAULT false NOT NULL,
    "create" boolean DEFAULT false NOT NULL,
    edit boolean DEFAULT false NOT NULL,
    delete boolean DEFAULT false NOT NULL,
    "permissionsId" text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);
 *   DROP TABLE public."StaffRolePermissions";
       public         heap    postgres    false    22            B           1259    40173 
   StartBreak    TABLE     �  CREATE TABLE public."StartBreak" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "breakMethod" public."BreakMethod" DEFAULT 'PHOTOCLICK'::public."BreakMethod" NOT NULL,
    "startBreakTime" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "biometricData" text,
    "qrCodeValue" text,
    "photoUrl" text,
    location text NOT NULL,
    "staffId" text NOT NULL,
    "punchRecordId" text,
    "punchRecordsId" text
);
     DROP TABLE public."StartBreak";
       public         heap    postgres    false    1316    22    1316            3           1259    40007    SubTaskPermissions    TABLE     �  CREATE TABLE public."SubTaskPermissions" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    view_global boolean DEFAULT false NOT NULL,
    "create" boolean DEFAULT false NOT NULL,
    edit boolean DEFAULT false NOT NULL,
    delete boolean DEFAULT false NOT NULL,
    "permissionsId" text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);
 (   DROP TABLE public."SubTaskPermissions";
       public         heap    postgres    false    22            F           1259    40210 
   TaskDetail    TABLE     P  CREATE TABLE public."TaskDetail" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "taskName" text NOT NULL,
    "taskStatusId" text NOT NULL,
    "taskPriorityId" text NOT NULL,
    "startDate" text NOT NULL,
    "endDate" text,
    "dueDate" text,
    "taskDescription" text NOT NULL,
    "taskTag" text,
    "attachFile" text
);
     DROP TABLE public."TaskDetail";
       public         heap    postgres    false    22            2           1259    39994    TaskPermissions    TABLE     �  CREATE TABLE public."TaskPermissions" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    view_global boolean DEFAULT false NOT NULL,
    "create" boolean DEFAULT false NOT NULL,
    edit boolean DEFAULT false NOT NULL,
    delete boolean DEFAULT false NOT NULL,
    "permissionsId" text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);
 %   DROP TABLE public."TaskPermissions";
       public         heap    postgres    false    22            E           1259    40202    TaskPriority    TABLE     }   CREATE TABLE public."TaskPriority" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "taskPriorityName" text NOT NULL
);
 "   DROP TABLE public."TaskPriority";
       public         heap    postgres    false    22            D           1259    40193 
   TaskStatus    TABLE     �   CREATE TABLE public."TaskStatus" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "taskStatusName" text NOT NULL,
    "statusColor" text NOT NULL,
    "statusOrder" integer DEFAULT 0 NOT NULL,
    "canBeChangedId" text[]
);
     DROP TABLE public."TaskStatus";
       public         heap    postgres    false    22            I           1259    40235    TicketInformation    TABLE       CREATE TABLE public."TicketInformation" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    subject text NOT NULL,
    contact text NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    department text NOT NULL,
    cc text NOT NULL,
    tags text[],
    asign_ticket text NOT NULL,
    priority text NOT NULL,
    service text NOT NULL,
    project text NOT NULL,
    ticket_body text NOT NULL,
    insert_link text NOT NULL,
    personal_notes text NOT NULL,
    insert_files text NOT NULL,
    "staffIdd" text
);
 '   DROP TABLE public."TicketInformation";
       public         heap    postgres    false    22            L           1259    40261 
   UpiDetails    TABLE     ]   CREATE TABLE public."UpiDetails" (
    "UpiId" text NOT NULL,
    "staffId" text NOT NULL
);
     DROP TABLE public."UpiDetails";
       public         heap    postgres    false    22                       1259    39701    User    TABLE     W  CREATE TABLE public."User" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    email text NOT NULL,
    password text,
    name text,
    mobile text,
    role public."UserRole" DEFAULT 'STAFF'::public."UserRole" NOT NULL,
    is_verified boolean DEFAULT false NOT NULL,
    otp integer,
    "otpExpiresAt" timestamp(3) without time zone
);
    DROP TABLE public."User";
       public         heap    postgres    false    1280    1280    22            9           1259    40067    WeekOffShift    TABLE       CREATE TABLE public."WeekOffShift" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "weekOne" boolean DEFAULT false,
    "weekTwo" boolean DEFAULT false,
    "weekThree" boolean DEFAULT false,
    "weekFour" boolean DEFAULT false,
    "weekFive" boolean DEFAULT false
);
 "   DROP TABLE public."WeekOffShift";
       public         heap    postgres    false    22                       1259    39711 	   WorkEntry    TABLE     /  CREATE TABLE public."WorkEntry" (
    id text NOT NULL,
    work_name text NOT NULL,
    units text NOT NULL,
    description text NOT NULL,
    attachments text,
    location text,
    "staffDetailsId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public."WorkEntry";
       public         heap    postgres    false    22            T           1259    40315    _FixedShiftToShifts    TABLE     \   CREATE TABLE public."_FixedShiftToShifts" (
    "A" text NOT NULL,
    "B" text NOT NULL
);
 )   DROP TABLE public."_FixedShiftToShifts";
       public         heap    postgres    false    22            U           1259    40320    _FlexibleShiftToShifts    TABLE     _   CREATE TABLE public."_FlexibleShiftToShifts" (
    "A" text NOT NULL,
    "B" text NOT NULL
);
 ,   DROP TABLE public."_FlexibleShiftToShifts";
       public         heap    postgres    false    22            V           1259    40325    _ProjectStaff    TABLE     V   CREATE TABLE public."_ProjectStaff" (
    "A" text NOT NULL,
    "B" text NOT NULL
);
 #   DROP TABLE public."_ProjectStaff";
       public         heap    postgres    false    22            Q           1259    40300 
   _UserRooms    TABLE     S   CREATE TABLE public."_UserRooms" (
    "A" text NOT NULL,
    "B" text NOT NULL
);
     DROP TABLE public."_UserRooms";
       public         heap    postgres    false    22            S           1259    40310    _departmentId    TABLE     V   CREATE TABLE public."_departmentId" (
    "A" text NOT NULL,
    "B" text NOT NULL
);
 #   DROP TABLE public."_departmentId";
       public         heap    postgres    false    22                       1259    39587    _prisma_migrations    TABLE     �  CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);
 &   DROP TABLE public._prisma_migrations;
       public         heap    postgres    false    22            W           1259    40330 
   _projectId    TABLE     S   CREATE TABLE public."_projectId" (
    "A" text NOT NULL,
    "B" text NOT NULL
);
     DROP TABLE public."_projectId";
       public         heap    postgres    false    22            R           1259    40305    _staffId    TABLE     Q   CREATE TABLE public."_staffId" (
    "A" text NOT NULL,
    "B" text NOT NULL
);
    DROP TABLE public."_staffId";
       public         heap    postgres    false    22            =           1259    40112    breakRecord    TABLE       CREATE TABLE public."breakRecord" (
    id text DEFAULT gen_random_uuid() NOT NULL,
    "breakDate" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "startBreakId" text,
    "endBreakId" text,
    "punchRecordId" text,
    "staffId" text
);
 !   DROP TABLE public."breakRecord";
       public         heap    postgres    false    22                       1259    29192    messages    TABLE     w  CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);
    DROP TABLE realtime.messages;
       realtime            supabase_realtime_admin    false    13            �           0    0    TABLE messages    ACL     8  GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;
          realtime          supabase_realtime_admin    false    277                       1259    29031    schema_migrations    TABLE     y   CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);
 '   DROP TABLE realtime.schema_migrations;
       realtime         heap    supabase_admin    false    13            �           0    0    TABLE schema_migrations    ACL     �  GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;
          realtime          supabase_admin    false    271                       1259    29053    subscription    TABLE     �  CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);
 "   DROP TABLE realtime.subscription;
       realtime         heap    supabase_admin    false    1466    573    13    1466            �           0    0    TABLE subscription    ACL     g  GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;
          realtime          supabase_admin    false    274                       1259    29052    subscription_id_seq    SEQUENCE     �   ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            realtime          supabase_admin    false    274    13            �           0    0    SEQUENCE subscription_id_seq    ACL     �  GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;
          realtime          supabase_admin    false    273            �            1259    16540    buckets    TABLE     k  CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);
    DROP TABLE storage.buckets;
       storage         heap    supabase_storage_admin    false    15            �           0    0    COLUMN buckets.owner    COMMENT     X   COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';
          storage          supabase_storage_admin    false    239            �           0    0    TABLE buckets    ACL     �   GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres;
          storage          supabase_storage_admin    false    239            �            1259    16582 
   migrations    TABLE     �   CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE storage.migrations;
       storage         heap    supabase_storage_admin    false    15            �           0    0    TABLE migrations    ACL     �   GRANT ALL ON TABLE storage.migrations TO anon;
GRANT ALL ON TABLE storage.migrations TO authenticated;
GRANT ALL ON TABLE storage.migrations TO service_role;
GRANT ALL ON TABLE storage.migrations TO postgres;
          storage          supabase_storage_admin    false    241            �            1259    16555    objects    TABLE     �  CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);
    DROP TABLE storage.objects;
       storage         heap    supabase_storage_admin    false    15            �           0    0    COLUMN objects.owner    COMMENT     X   COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';
          storage          supabase_storage_admin    false    240            �           0    0    TABLE objects    ACL     �   GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres;
          storage          supabase_storage_admin    false    240                       1259    28974    s3_multipart_uploads    TABLE     j  CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);
 )   DROP TABLE storage.s3_multipart_uploads;
       storage         heap    supabase_storage_admin    false    15            �           0    0    TABLE s3_multipart_uploads    ACL     �   GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;
          storage          supabase_storage_admin    false    269                       1259    28988    s3_multipart_uploads_parts    TABLE     �  CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);
 /   DROP TABLE storage.s3_multipart_uploads_parts;
       storage         heap    supabase_storage_admin    false    15            �           0    0     TABLE s3_multipart_uploads_parts    ACL     �   GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;
          storage          supabase_storage_admin    false    270                        1259    16970    decrypted_secrets    VIEW     �  CREATE VIEW vault.decrypted_secrets AS
 SELECT secrets.id,
    secrets.name,
    secrets.description,
    secrets.secret,
        CASE
            WHEN (secrets.secret IS NULL) THEN NULL::text
            ELSE
            CASE
                WHEN (secrets.key_id IS NULL) THEN NULL::text
                ELSE convert_from(pgsodium.crypto_aead_det_decrypt(decode(secrets.secret, 'base64'::text), convert_to(((((secrets.id)::text || secrets.description) || (secrets.created_at)::text) || (secrets.updated_at)::text), 'utf8'::name), secrets.key_id, secrets.nonce), 'utf8'::name)
            END
        END AS decrypted_secret,
    secrets.key_id,
    secrets.nonce,
    secrets.created_at,
    secrets.updated_at
   FROM vault.secrets;
 #   DROP VIEW vault.decrypted_secrets;
       vault          supabase_admin    false    7    6    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    17    17    6    17    6    17    6    6    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    17    17    6    17    6    17    6    17    17    6    17    6    17    19    7    6    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    17    17    6    17    6    17    6    6    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    17    17    6    17    6    17    6    17    17    6    17    6    17    19    7    6    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    17    17    6    17    6    17    6    6    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    17    17    6    17    6    17    6    17    17    6    17    6    17    19    6    17    7    6    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    17    17    6    17    6    17    6    6    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    17    17    6    17    6    17    6    17    17    6    17    6    17    19    7    6    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    17    17    6    17    6    17    6    6    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    17    17    6    17    6    17    6    17    17    6    17    6    17    19    7    6    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    17    17    6    17    6    17    6    6    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    17    17    6    17    6    17    6    17    17    6    17    6    17    19    7    6    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    17    17    6    17    6    17    6    6    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    17    17    6    17    6    17    6    17    17    6    17    6    17    19    7    6    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    17    17    6    17    6    17    6    6    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    6    17    6    17    17    6    17    6    17    17    6    17    6    17    6    17    17    6    17    6    17    19    19            �           2604    16504    refresh_tokens id    DEFAULT     r   ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);
 >   ALTER TABLE auth.refresh_tokens ALTER COLUMN id DROP DEFAULT;
       auth          supabase_auth_admin    false    234    235    235            �          0    16519    audit_log_entries 
   TABLE DATA           [   COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
    auth          supabase_auth_admin    false    237   �      �          0    28867 
   flow_state 
   TABLE DATA           �   COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
    auth          supabase_auth_admin    false    267   �      �          0    28664 
   identities 
   TABLE DATA           ~   COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
    auth          supabase_auth_admin    false    258         �          0    16512 	   instances 
   TABLE DATA           T   COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
    auth          supabase_auth_admin    false    236   /      �          0    28754    mfa_amr_claims 
   TABLE DATA           e   COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
    auth          supabase_auth_admin    false    262   L      �          0    28742    mfa_challenges 
   TABLE DATA           |   COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
    auth          supabase_auth_admin    false    261   i      �          0    28729    mfa_factors 
   TABLE DATA           �   COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid) FROM stdin;
    auth          supabase_auth_admin    false    260   �      �          0    28917    one_time_tokens 
   TABLE DATA           p   COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
    auth          supabase_auth_admin    false    268   �      �          0    16501    refresh_tokens 
   TABLE DATA           |   COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
    auth          supabase_auth_admin    false    235   �      �          0    28796    saml_providers 
   TABLE DATA           �   COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
    auth          supabase_auth_admin    false    265   �      �          0    28814    saml_relay_states 
   TABLE DATA           �   COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
    auth          supabase_auth_admin    false    266   �      �          0    16527    schema_migrations 
   TABLE DATA           2   COPY auth.schema_migrations (version) FROM stdin;
    auth          supabase_auth_admin    false    238         �          0    28694    sessions 
   TABLE DATA           �   COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) FROM stdin;
    auth          supabase_auth_admin    false    259   s      �          0    28781    sso_domains 
   TABLE DATA           X   COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
    auth          supabase_auth_admin    false    264   �      �          0    28772    sso_providers 
   TABLE DATA           N   COPY auth.sso_providers (id, resource_id, created_at, updated_at) FROM stdin;
    auth          supabase_auth_admin    false    263   �      �          0    16489    users 
   TABLE DATA           O  COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
    auth          supabase_auth_admin    false    233   �      �          0    16790    key 
   TABLE DATA           �   COPY pgsodium.key (id, status, created, expires, key_type, key_id, key_context, name, associated_data, raw_key, raw_key_nonce, parent_key, comment, user_data) FROM stdin;
    pgsodium          supabase_admin    false    249   �      �          0    40030    AIPermissions 
   TABLE DATA           d   COPY public."AIPermissions" (id, grant_access, "permissionsId", created_at, updated_at) FROM stdin;
    public          postgres    false    309         �          0    39738    AdminDetails 
   TABLE DATA           �   COPY public."AdminDetails" (id, "userId", package_id, company_name, company_logo, profile_image, time_format, time_zone, date_format, week_format) FROM stdin;
    public          postgres    false    283   !      �          0    39772    AttendanceAutomationRule 
   TABLE DATA           �   COPY public."AttendanceAutomationRule" (id, auto_absent, present_on_punch, auto_half_day, manadatory_half_day, manadatory_full_day, created_at, updated_at, "staffId") FROM stdin;
    public          postgres    false    287   >      �          0    39783    AttendanceMode 
   TABLE DATA           �   COPY public."AttendanceMode" (id, selfie_attendance, qr_attendance, gps_attendance, mark_attendance, allow_punch_in_for_mobile, created_at, updated_at, "staffId") FROM stdin;
    public          postgres    false    288   [      �          0    39825    BankDetails 
   TABLE DATA           �   COPY public."BankDetails" (id, "staffId", bank_name, account_number, branch_name, ifsc_code, created_at, updated_at) FROM stdin;
    public          postgres    false    291   x      �          0    39746    Branch 
   TABLE DATA           N   COPY public."Branch" (id, "branchName", "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    284   �      �          0    40020    ChatModulePermissions 
   TABLE DATA           l   COPY public."ChatModulePermissions" (id, grant_access, "permissionsId", created_at, updated_at) FROM stdin;
    public          postgres    false    308   �      �          0    39719    ChatRoom 
   TABLE DATA           F   COPY public."ChatRoom" (id, name, "isGroup", "createdAt") FROM stdin;
    public          postgres    false    281   �                0    40251    ClientDetails 
   TABLE DATA           �   COPY public."ClientDetails" (id, "userId", company, vat_number, website, groups, currency, default_language, address, country, state, city, status, zip_code, created_at, updated_at) FROM stdin;
    public          postgres    false    331   �      �          0    39920    ClientsPermissions 
   TABLE DATA           �   COPY public."ClientsPermissions" (id, view_global, "create", edit, delete, "permissionsId", created_at, updated_at) FROM stdin;
    public          postgres    false    300   	      �          0    39867    CustomDetails 
   TABLE DATA           Q   COPY public."CustomDetails" (id, "staffId", field_name, field_value) FROM stdin;
    public          postgres    false    295   &                0    40284 
   Deductions 
   TABLE DATA           u   COPY public."Deductions" (id, heads, calculation, amount, deduction_month, "staffId", "salaryDetailsId") FROM stdin;
    public          postgres    false    335   C      �          0    39764 
   Department 
   TABLE DATA           ;   COPY public."Department" (id, department_name) FROM stdin;
    public          postgres    false    286   `                0    40243 
   Discussion 
   TABLE DATA           t   COPY public."Discussion" (id, subject, discription, last_activity, total_comments, visible_to_customer) FROM stdin;
    public          postgres    false    330   }      �          0    39875    EarlyLeavePolicy 
   TABLE DATA           |   COPY public."EarlyLeavePolicy" (id, "fineType", "gracePeriodMins", "fineAmountMins", "waiveOffDays", "staffId") FROM stdin;
    public          postgres    false    296   �                0    40292    Earnings 
   TABLE DATA           p   COPY public."Earnings" (id, heads, calculation, amount, "staffId", salary_month, "salaryDetailsId") FROM stdin;
    public          postgres    false    336   �      �          0    40183    EndBreak 
   TABLE DATA           �   COPY public."EndBreak" (id, "breakMethod", "endBreakTime", "biometricData", "qrCodeValue", "photoUrl", location, "staffId", "punchRecordId", "punchRecordsId") FROM stdin;
    public          postgres    false    323   �      �          0    40121    Fine 
   TABLE DATA           7  COPY public."Fine" (id, "lateEntryFineHoursTime", "lateEntryFineAmount", "lateEntryAmount", "excessBreakFineHoursTime", "excessBreakFineAmount", "excessBreakAmount", "earlyOutFineHoursTime", "earlyOutFineAmount", "earlyOutAmount", "totalAmount", "shiftIds", "punchRecordId", "staffId", "createdAt") FROM stdin;
    public          postgres    false    318   �      �          0    40080 
   FixedShift 
   TABLE DATA           \   COPY public."FixedShift" (id, day, "weekOff", "staffId", "weekId", "createdAt") FROM stdin;
    public          postgres    false    314         �          0    40091    FlexibleShift 
   TABLE DATA           \   COPY public."FlexibleShift" (id, "dateTime", "weekOff", "staffId", "createdAt") FROM stdin;
    public          postgres    false    315   +      �          0    39887    LateComingPolicy 
   TABLE DATA           |   COPY public."LateComingPolicy" (id, "fineType", "gracePeriodMins", "fineAmountMins", "waiveOffDays", "staffId") FROM stdin;
    public          postgres    false    297   H      �          0    39856    LeaveBalance 
   TABLE DATA           q   COPY public."LeaveBalance" (id, "staffId", "leavePolicyId", balance, used, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    294   e      �          0    39834    LeavePolicy 
   TABLE DATA           �   COPY public."LeavePolicy" (id, "staffId", name, allowed_leaves, carry_forward_leaves, policy_type, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    292   �      �          0    39845    LeaveRequest 
   TABLE DATA           �   COPY public."LeaveRequest" (id, "staffId", "leaveTypeId", request_date, start_date, end_date, status, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    293   �      �          0    39729    Message 
   TABLE DATA           S   COPY public."Message" (id, content, "timestamp", "senderId", "roomId") FROM stdin;
    public          postgres    false    282   �      �          0    40137    Overtime 
   TABLE DATA           �   COPY public."Overtime" (id, "earlyCommingEntryHoursTime", "earlyCommingEntryAmount", "earlyEntryAmount", "lateOutOvertimeHoursTime", "lateOutOvertimeAmount", "lateOutAmount", "totalAmount", "shiftIds", "punchRecordId", "staffId") FROM stdin;
    public          postgres    false    319   �      �          0    39899    OvertimePolicy 
   TABLE DATA              COPY public."OvertimePolicy" (id, "gracePeriodMins", "extraHoursPay", "publicHolidayPay", "weekOffPay", "staffId") FROM stdin;
    public          postgres    false    298   �      �          0    39813    PastEmployment 
   TABLE DATA           �   COPY public."PastEmployment" (id, company_name, designation, joining_date, leaving_date, currency, salary, company_gst, "past_Employment_status", "staffId", "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    290         �          0    40040    Permissions 
   TABLE DATA           M   COPY public."Permissions" (id, "roleId", created_at, updated_at) FROM stdin;
    public          postgres    false    310   0                 0    40227    Project 
   TABLE DATA           �   COPY public."Project" (id, project_name, billing_type, status, total_rate, estimated_hours, start_date, deadline, tags, description, send_mail, "customerId") FROM stdin;
    public          postgres    false    328   M      �          0    40218    ProjectFiles 
   TABLE DATA           �   COPY public."ProjectFiles" (id, file_name, file_type, last_activity, total_comments, visible_to_customer, uploaded_by, date_uploaded) FROM stdin;
    public          postgres    false    327   j                0    40276    ProjectPriority 
   TABLE DATA           �   COPY public."ProjectPriority" (id, "Priority_name", "Priority_color", "Priority_order", default_filter, is_hidden, can_changed) FROM stdin;
    public          postgres    false    334   �                0    40268    ProjectStatus 
   TABLE DATA           v   COPY public."ProjectStatus" (id, project_name, project_color, project_order, default_filter, can_changed) FROM stdin;
    public          postgres    false    333   �      �          0    39933    ProjectsPermissions 
   TABLE DATA           �   COPY public."ProjectsPermissions" (id, view_global, "create", edit, delete, "permissionsId", created_at, updated_at) FROM stdin;
    public          postgres    false    301   �      �          0    40150    PunchIn 
   TABLE DATA           �   COPY public."PunchIn" (id, "punchInMethod", "punchInTime", "punchInDate", "biometricData", "qrCodeValue", "photoUrl", location, approve) FROM stdin;
    public          postgres    false    320   �      �          0    40162    PunchOut 
   TABLE DATA           �   COPY public."PunchOut" (id, "punchOutMethod", "punchOutTime", "punchOutDate", "biometricData", "qrCodeValue", "photoUrl", location, overtime) FROM stdin;
    public          postgres    false    321   �      �          0    40101    PunchRecords 
   TABLE DATA           u   COPY public."PunchRecords" (id, "punchDate", "isApproved", "punchInId", "punchOutId", "staffId", status) FROM stdin;
    public          postgres    false    316         �          0    39946    ReportPermissions 
   TABLE DATA           y   COPY public."ReportPermissions" (id, view_global, view_time_sheets, "permissionsId", created_at, updated_at) FROM stdin;
    public          postgres    false    302   5      �          0    39911    Role 
   TABLE DATA           G   COPY public."Role" (id, role_name, created_at, updated_at) FROM stdin;
    public          postgres    false    299   R      �          0    40049    SalaryDetails 
   TABLE DATA           �   COPY public."SalaryDetails" (id, effective_date, salary_type, ctc_amount, employer_pf, employer_esi, employer_lwf, employee_pf, employee_esi, professional_tax, employee_lwf, tds, created_at, updated_at, "staffId") FROM stdin;
    public          postgres    false    311   o      �          0    39970    SettingsPermissions 
   TABLE DATA           {   COPY public."SettingsPermissions" (id, view_global, view_time_sheets, "permissionsId", created_at, updated_at) FROM stdin;
    public          postgres    false    304   �      �          0    40057    Shifts 
   TABLE DATA           �   COPY public."Shifts" (id, "shiftName", "shiftStartTime", "shiftEndTime", "punchInType", "punchOutType", "allowPunchInHours", "allowPunchInMinutes", "allowPunchOutMinutes", "allowPunchOutHours") FROM stdin;
    public          postgres    false    312   �      �          0    39797    StaffBackgroundVerification 
   TABLE DATA           �  COPY public."StaffBackgroundVerification" (id, aadhaar_number, aadhaar_verification_status, aadhaar_file, voter_id_number, voter_id_verification_status, voter_id_file, pan_number, pan_verification_status, pan_file, uan_number, uan_verification_status, uan_file, driving_license_number, driving_license_status, driving_license_file, face_file, face_verification_status, current_address, permanent_address, address_status, address_file, "staffId", "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    289   �      �          0    39754    StaffDetails 
   TABLE DATA           w  COPY public."StaffDetails" (id, "userId", job_title, "departmentId", "roleId", login_otp, gender, official_email, date_of_joining, date_of_birth, current_address, permanent_address, emergency_contact_name, emergency_contact_mobile, emergency_contact_relation, emergency_contact_address, guardian_name, status, employment, marital_status, blood_group, "branchId") FROM stdin;
    public          postgres    false    285   �      �          0    39981    StaffPermissions 
   TABLE DATA           ~   COPY public."StaffPermissions" (id, view_global, "create", edit, delete, "permissionsId", created_at, updated_at) FROM stdin;
    public          postgres    false    305          �          0    39957    StaffRolePermissions 
   TABLE DATA           �   COPY public."StaffRolePermissions" (id, view_global, "create", edit, delete, "permissionsId", created_at, updated_at) FROM stdin;
    public          postgres    false    303         �          0    40173 
   StartBreak 
   TABLE DATA           �   COPY public."StartBreak" (id, "breakMethod", "startBreakTime", "biometricData", "qrCodeValue", "photoUrl", location, "staffId", "punchRecordId", "punchRecordsId") FROM stdin;
    public          postgres    false    322   :      �          0    40007    SubTaskPermissions 
   TABLE DATA           �   COPY public."SubTaskPermissions" (id, view_global, "create", edit, delete, "permissionsId", created_at, updated_at) FROM stdin;
    public          postgres    false    307   W      �          0    40210 
   TaskDetail 
   TABLE DATA           �   COPY public."TaskDetail" (id, "taskName", "taskStatusId", "taskPriorityId", "startDate", "endDate", "dueDate", "taskDescription", "taskTag", "attachFile") FROM stdin;
    public          postgres    false    326   t      �          0    39994    TaskPermissions 
   TABLE DATA           }   COPY public."TaskPermissions" (id, view_global, "create", edit, delete, "permissionsId", created_at, updated_at) FROM stdin;
    public          postgres    false    306   �      �          0    40202    TaskPriority 
   TABLE DATA           @   COPY public."TaskPriority" (id, "taskPriorityName") FROM stdin;
    public          postgres    false    325   �      �          0    40193 
   TaskStatus 
   TABLE DATA           l   COPY public."TaskStatus" (id, "taskStatusName", "statusColor", "statusOrder", "canBeChangedId") FROM stdin;
    public          postgres    false    324   �                0    40235    TicketInformation 
   TABLE DATA           �   COPY public."TicketInformation" (id, subject, contact, name, email, department, cc, tags, asign_ticket, priority, service, project, ticket_body, insert_link, personal_notes, insert_files, "staffIdd") FROM stdin;
    public          postgres    false    329   �                0    40261 
   UpiDetails 
   TABLE DATA           :   COPY public."UpiDetails" ("UpiId", "staffId") FROM stdin;
    public          postgres    false    332         �          0    39701    User 
   TABLE DATA           k   COPY public."User" (id, email, password, name, mobile, role, is_verified, otp, "otpExpiresAt") FROM stdin;
    public          postgres    false    279   "      �          0    40067    WeekOffShift 
   TABLE DATA           g   COPY public."WeekOffShift" (id, "weekOne", "weekTwo", "weekThree", "weekFour", "weekFive") FROM stdin;
    public          postgres    false    313   ?      �          0    39711 	   WorkEntry 
   TABLE DATA           ~   COPY public."WorkEntry" (id, work_name, units, description, attachments, location, "staffDetailsId", "createdAt") FROM stdin;
    public          postgres    false    280   \                0    40315    _FixedShiftToShifts 
   TABLE DATA           9   COPY public."_FixedShiftToShifts" ("A", "B") FROM stdin;
    public          postgres    false    340   y                0    40320    _FlexibleShiftToShifts 
   TABLE DATA           <   COPY public."_FlexibleShiftToShifts" ("A", "B") FROM stdin;
    public          postgres    false    341   �                0    40325    _ProjectStaff 
   TABLE DATA           3   COPY public."_ProjectStaff" ("A", "B") FROM stdin;
    public          postgres    false    342   �      	          0    40300 
   _UserRooms 
   TABLE DATA           0   COPY public."_UserRooms" ("A", "B") FROM stdin;
    public          postgres    false    337   �                0    40310    _departmentId 
   TABLE DATA           3   COPY public."_departmentId" ("A", "B") FROM stdin;
    public          postgres    false    339   �      �          0    39587    _prisma_migrations 
   TABLE DATA           �   COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
    public          postgres    false    278   
                0    40330 
   _projectId 
   TABLE DATA           0   COPY public."_projectId" ("A", "B") FROM stdin;
    public          postgres    false    343   �      
          0    40305    _staffId 
   TABLE DATA           .   COPY public."_staffId" ("A", "B") FROM stdin;
    public          postgres    false    338   �      �          0    40112    breakRecord 
   TABLE DATA           r   COPY public."breakRecord" (id, "breakDate", "startBreakId", "endBreakId", "punchRecordId", "staffId") FROM stdin;
    public          postgres    false    317         �          0    29031    schema_migrations 
   TABLE DATA           C   COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
    realtime          supabase_admin    false    271   !      �          0    29053    subscription 
   TABLE DATA           b   COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
    realtime          supabase_admin    false    274         �          0    16540    buckets 
   TABLE DATA           �   COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) FROM stdin;
    storage          supabase_storage_admin    false    239          �          0    16582 
   migrations 
   TABLE DATA           B   COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
    storage          supabase_storage_admin    false    241   =      �          0    16555    objects 
   TABLE DATA           �   COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
    storage          supabase_storage_admin    false    240          �          0    28974    s3_multipart_uploads 
   TABLE DATA           �   COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
    storage          supabase_storage_admin    false    269   /       �          0    28988    s3_multipart_uploads_parts 
   TABLE DATA           �   COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
    storage          supabase_storage_admin    false    270   L       �          0    16951    secrets 
   TABLE DATA           f   COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
    vault          supabase_admin    false    255   i       �           0    0    refresh_tokens_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 1, false);
          auth          supabase_auth_admin    false    234            �           0    0    key_key_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('pgsodium.key_key_id_seq', 1, false);
          pgsodium          supabase_admin    false    248            �           0    0    subscription_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);
          realtime          supabase_admin    false    273            �           2606    28767    mfa_amr_claims amr_id_pk 
   CONSTRAINT     T   ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);
 @   ALTER TABLE ONLY auth.mfa_amr_claims DROP CONSTRAINT amr_id_pk;
       auth            supabase_auth_admin    false    262            �           2606    16525 (   audit_log_entries audit_log_entries_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY auth.audit_log_entries DROP CONSTRAINT audit_log_entries_pkey;
       auth            supabase_auth_admin    false    237            �           2606    28873    flow_state flow_state_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY auth.flow_state DROP CONSTRAINT flow_state_pkey;
       auth            supabase_auth_admin    false    267            �           2606    28891    identities identities_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY auth.identities DROP CONSTRAINT identities_pkey;
       auth            supabase_auth_admin    false    258            �           2606    28901 1   identities identities_provider_id_provider_unique 
   CONSTRAINT     {   ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);
 Y   ALTER TABLE ONLY auth.identities DROP CONSTRAINT identities_provider_id_provider_unique;
       auth            supabase_auth_admin    false    258    258            �           2606    16518    instances instances_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY auth.instances DROP CONSTRAINT instances_pkey;
       auth            supabase_auth_admin    false    236            �           2606    28760 C   mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);
 k   ALTER TABLE ONLY auth.mfa_amr_claims DROP CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey;
       auth            supabase_auth_admin    false    262    262            �           2606    28748 "   mfa_challenges mfa_challenges_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY auth.mfa_challenges DROP CONSTRAINT mfa_challenges_pkey;
       auth            supabase_auth_admin    false    261            �           2606    28941 .   mfa_factors mfa_factors_last_challenged_at_key 
   CONSTRAINT     u   ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);
 V   ALTER TABLE ONLY auth.mfa_factors DROP CONSTRAINT mfa_factors_last_challenged_at_key;
       auth            supabase_auth_admin    false    260            �           2606    28735    mfa_factors mfa_factors_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY auth.mfa_factors DROP CONSTRAINT mfa_factors_pkey;
       auth            supabase_auth_admin    false    260            �           2606    28926 $   one_time_tokens one_time_tokens_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY auth.one_time_tokens DROP CONSTRAINT one_time_tokens_pkey;
       auth            supabase_auth_admin    false    268            �           2606    16508 "   refresh_tokens refresh_tokens_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY auth.refresh_tokens DROP CONSTRAINT refresh_tokens_pkey;
       auth            supabase_auth_admin    false    235            �           2606    28677 *   refresh_tokens refresh_tokens_token_unique 
   CONSTRAINT     d   ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);
 R   ALTER TABLE ONLY auth.refresh_tokens DROP CONSTRAINT refresh_tokens_token_unique;
       auth            supabase_auth_admin    false    235            �           2606    28807 +   saml_providers saml_providers_entity_id_key 
   CONSTRAINT     i   ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);
 S   ALTER TABLE ONLY auth.saml_providers DROP CONSTRAINT saml_providers_entity_id_key;
       auth            supabase_auth_admin    false    265            �           2606    28805 "   saml_providers saml_providers_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY auth.saml_providers DROP CONSTRAINT saml_providers_pkey;
       auth            supabase_auth_admin    false    265            �           2606    28821 (   saml_relay_states saml_relay_states_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY auth.saml_relay_states DROP CONSTRAINT saml_relay_states_pkey;
       auth            supabase_auth_admin    false    266            �           2606    16531 (   schema_migrations schema_migrations_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);
 P   ALTER TABLE ONLY auth.schema_migrations DROP CONSTRAINT schema_migrations_pkey;
       auth            supabase_auth_admin    false    238            �           2606    28698    sessions sessions_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY auth.sessions DROP CONSTRAINT sessions_pkey;
       auth            supabase_auth_admin    false    259            �           2606    28788    sso_domains sso_domains_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY auth.sso_domains DROP CONSTRAINT sso_domains_pkey;
       auth            supabase_auth_admin    false    264            �           2606    28779     sso_providers sso_providers_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY auth.sso_providers DROP CONSTRAINT sso_providers_pkey;
       auth            supabase_auth_admin    false    263            �           2606    28861    users users_phone_key 
   CONSTRAINT     O   ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);
 =   ALTER TABLE ONLY auth.users DROP CONSTRAINT users_phone_key;
       auth            supabase_auth_admin    false    233            �           2606    16495    users users_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY auth.users DROP CONSTRAINT users_pkey;
       auth            supabase_auth_admin    false    233            Y           2606    40039     AIPermissions AIPermissions_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public."AIPermissions"
    ADD CONSTRAINT "AIPermissions_pkey" PRIMARY KEY (id);
 N   ALTER TABLE ONLY public."AIPermissions" DROP CONSTRAINT "AIPermissions_pkey";
       public            postgres    false    309                       2606    39745    AdminDetails AdminDetails_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."AdminDetails"
    ADD CONSTRAINT "AdminDetails_pkey" PRIMARY KEY (id);
 L   ALTER TABLE ONLY public."AdminDetails" DROP CONSTRAINT "AdminDetails_pkey";
       public            postgres    false    283                       2606    39782 6   AttendanceAutomationRule AttendanceAutomationRule_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public."AttendanceAutomationRule"
    ADD CONSTRAINT "AttendanceAutomationRule_pkey" PRIMARY KEY (id);
 d   ALTER TABLE ONLY public."AttendanceAutomationRule" DROP CONSTRAINT "AttendanceAutomationRule_pkey";
       public            postgres    false    287                       2606    39796 "   AttendanceMode AttendanceMode_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public."AttendanceMode"
    ADD CONSTRAINT "AttendanceMode_pkey" PRIMARY KEY (id);
 P   ALTER TABLE ONLY public."AttendanceMode" DROP CONSTRAINT "AttendanceMode_pkey";
       public            postgres    false    288            (           2606    39833    BankDetails BankDetails_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public."BankDetails"
    ADD CONSTRAINT "BankDetails_pkey" PRIMARY KEY (id);
 J   ALTER TABLE ONLY public."BankDetails" DROP CONSTRAINT "BankDetails_pkey";
       public            postgres    false    291                       2606    39753    Branch Branch_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public."Branch"
    ADD CONSTRAINT "Branch_pkey" PRIMARY KEY (id);
 @   ALTER TABLE ONLY public."Branch" DROP CONSTRAINT "Branch_pkey";
       public            postgres    false    284            V           2606    40029 0   ChatModulePermissions ChatModulePermissions_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public."ChatModulePermissions"
    ADD CONSTRAINT "ChatModulePermissions_pkey" PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public."ChatModulePermissions" DROP CONSTRAINT "ChatModulePermissions_pkey";
       public            postgres    false    308                       2606    39728    ChatRoom ChatRoom_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."ChatRoom"
    ADD CONSTRAINT "ChatRoom_pkey" PRIMARY KEY (id);
 D   ALTER TABLE ONLY public."ChatRoom" DROP CONSTRAINT "ChatRoom_pkey";
       public            postgres    false    281            �           2606    40260     ClientDetails ClientDetails_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public."ClientDetails"
    ADD CONSTRAINT "ClientDetails_pkey" PRIMARY KEY (id);
 N   ALTER TABLE ONLY public."ClientDetails" DROP CONSTRAINT "ClientDetails_pkey";
       public            postgres    false    331            >           2606    39932 *   ClientsPermissions ClientsPermissions_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public."ClientsPermissions"
    ADD CONSTRAINT "ClientsPermissions_pkey" PRIMARY KEY (id);
 X   ALTER TABLE ONLY public."ClientsPermissions" DROP CONSTRAINT "ClientsPermissions_pkey";
       public            postgres    false    300            2           2606    39874     CustomDetails CustomDetails_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public."CustomDetails"
    ADD CONSTRAINT "CustomDetails_pkey" PRIMARY KEY (id);
 N   ALTER TABLE ONLY public."CustomDetails" DROP CONSTRAINT "CustomDetails_pkey";
       public            postgres    false    295            �           2606    40291    Deductions Deductions_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."Deductions"
    ADD CONSTRAINT "Deductions_pkey" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public."Deductions" DROP CONSTRAINT "Deductions_pkey";
       public            postgres    false    335                       2606    39771    Department Department_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."Department"
    ADD CONSTRAINT "Department_pkey" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public."Department" DROP CONSTRAINT "Department_pkey";
       public            postgres    false    286            �           2606    40250    Discussion Discussion_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."Discussion"
    ADD CONSTRAINT "Discussion_pkey" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public."Discussion" DROP CONSTRAINT "Discussion_pkey";
       public            postgres    false    330            4           2606    39886 &   EarlyLeavePolicy EarlyLeavePolicy_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public."EarlyLeavePolicy"
    ADD CONSTRAINT "EarlyLeavePolicy_pkey" PRIMARY KEY (id);
 T   ALTER TABLE ONLY public."EarlyLeavePolicy" DROP CONSTRAINT "EarlyLeavePolicy_pkey";
       public            postgres    false    296            �           2606    40299    Earnings Earnings_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."Earnings"
    ADD CONSTRAINT "Earnings_pkey" PRIMARY KEY (id);
 D   ALTER TABLE ONLY public."Earnings" DROP CONSTRAINT "Earnings_pkey";
       public            postgres    false    336                       2606    40192    EndBreak EndBreak_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."EndBreak"
    ADD CONSTRAINT "EndBreak_pkey" PRIMARY KEY (id);
 D   ALTER TABLE ONLY public."EndBreak" DROP CONSTRAINT "EndBreak_pkey";
       public            postgres    false    323            r           2606    40136    Fine Fine_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."Fine"
    ADD CONSTRAINT "Fine_pkey" PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."Fine" DROP CONSTRAINT "Fine_pkey";
       public            postgres    false    318            d           2606    40090    FixedShift FixedShift_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."FixedShift"
    ADD CONSTRAINT "FixedShift_pkey" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public."FixedShift" DROP CONSTRAINT "FixedShift_pkey";
       public            postgres    false    314            g           2606    40100     FlexibleShift FlexibleShift_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public."FlexibleShift"
    ADD CONSTRAINT "FlexibleShift_pkey" PRIMARY KEY (id);
 N   ALTER TABLE ONLY public."FlexibleShift" DROP CONSTRAINT "FlexibleShift_pkey";
       public            postgres    false    315            6           2606    39898 &   LateComingPolicy LateComingPolicy_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public."LateComingPolicy"
    ADD CONSTRAINT "LateComingPolicy_pkey" PRIMARY KEY (id);
 T   ALTER TABLE ONLY public."LateComingPolicy" DROP CONSTRAINT "LateComingPolicy_pkey";
       public            postgres    false    297            0           2606    39866    LeaveBalance LeaveBalance_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."LeaveBalance"
    ADD CONSTRAINT "LeaveBalance_pkey" PRIMARY KEY (id);
 L   ALTER TABLE ONLY public."LeaveBalance" DROP CONSTRAINT "LeaveBalance_pkey";
       public            postgres    false    294            +           2606    39844    LeavePolicy LeavePolicy_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public."LeavePolicy"
    ADD CONSTRAINT "LeavePolicy_pkey" PRIMARY KEY (id);
 J   ALTER TABLE ONLY public."LeavePolicy" DROP CONSTRAINT "LeavePolicy_pkey";
       public            postgres    false    292            -           2606    39855    LeaveRequest LeaveRequest_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."LeaveRequest"
    ADD CONSTRAINT "LeaveRequest_pkey" PRIMARY KEY (id);
 L   ALTER TABLE ONLY public."LeaveRequest" DROP CONSTRAINT "LeaveRequest_pkey";
       public            postgres    false    293                       2606    39737    Message Message_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_pkey" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public."Message" DROP CONSTRAINT "Message_pkey";
       public            postgres    false    282            8           2606    39910 "   OvertimePolicy OvertimePolicy_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public."OvertimePolicy"
    ADD CONSTRAINT "OvertimePolicy_pkey" PRIMARY KEY (id);
 P   ALTER TABLE ONLY public."OvertimePolicy" DROP CONSTRAINT "OvertimePolicy_pkey";
       public            postgres    false    298            u           2606    40149    Overtime Overtime_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."Overtime"
    ADD CONSTRAINT "Overtime_pkey" PRIMARY KEY (id);
 D   ALTER TABLE ONLY public."Overtime" DROP CONSTRAINT "Overtime_pkey";
       public            postgres    false    319            %           2606    39824 "   PastEmployment PastEmployment_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public."PastEmployment"
    ADD CONSTRAINT "PastEmployment_pkey" PRIMARY KEY (id);
 P   ALTER TABLE ONLY public."PastEmployment" DROP CONSTRAINT "PastEmployment_pkey";
       public            postgres    false    290            [           2606    40048    Permissions Permissions_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public."Permissions"
    ADD CONSTRAINT "Permissions_pkey" PRIMARY KEY (id);
 J   ALTER TABLE ONLY public."Permissions" DROP CONSTRAINT "Permissions_pkey";
       public            postgres    false    310            �           2606    40226    ProjectFiles ProjectFiles_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."ProjectFiles"
    ADD CONSTRAINT "ProjectFiles_pkey" PRIMARY KEY (id);
 L   ALTER TABLE ONLY public."ProjectFiles" DROP CONSTRAINT "ProjectFiles_pkey";
       public            postgres    false    327            �           2606    40283 $   ProjectPriority ProjectPriority_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public."ProjectPriority"
    ADD CONSTRAINT "ProjectPriority_pkey" PRIMARY KEY (id);
 R   ALTER TABLE ONLY public."ProjectPriority" DROP CONSTRAINT "ProjectPriority_pkey";
       public            postgres    false    334            �           2606    40275     ProjectStatus ProjectStatus_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public."ProjectStatus"
    ADD CONSTRAINT "ProjectStatus_pkey" PRIMARY KEY (id);
 N   ALTER TABLE ONLY public."ProjectStatus" DROP CONSTRAINT "ProjectStatus_pkey";
       public            postgres    false    333            �           2606    40234    Project Project_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."Project"
    ADD CONSTRAINT "Project_pkey" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public."Project" DROP CONSTRAINT "Project_pkey";
       public            postgres    false    328            A           2606    39945 ,   ProjectsPermissions ProjectsPermissions_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public."ProjectsPermissions"
    ADD CONSTRAINT "ProjectsPermissions_pkey" PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public."ProjectsPermissions" DROP CONSTRAINT "ProjectsPermissions_pkey";
       public            postgres    false    301            x           2606    40161    PunchIn PunchIn_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."PunchIn"
    ADD CONSTRAINT "PunchIn_pkey" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public."PunchIn" DROP CONSTRAINT "PunchIn_pkey";
       public            postgres    false    320            z           2606    40172    PunchOut PunchOut_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."PunchOut"
    ADD CONSTRAINT "PunchOut_pkey" PRIMARY KEY (id);
 D   ALTER TABLE ONLY public."PunchOut" DROP CONSTRAINT "PunchOut_pkey";
       public            postgres    false    321            j           2606    40111    PunchRecords PunchRecords_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."PunchRecords"
    ADD CONSTRAINT "PunchRecords_pkey" PRIMARY KEY (id);
 L   ALTER TABLE ONLY public."PunchRecords" DROP CONSTRAINT "PunchRecords_pkey";
       public            postgres    false    316            D           2606    39956 (   ReportPermissions ReportPermissions_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public."ReportPermissions"
    ADD CONSTRAINT "ReportPermissions_pkey" PRIMARY KEY (id);
 V   ALTER TABLE ONLY public."ReportPermissions" DROP CONSTRAINT "ReportPermissions_pkey";
       public            postgres    false    302            :           2606    39919    Role Role_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."Role"
    ADD CONSTRAINT "Role_pkey" PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."Role" DROP CONSTRAINT "Role_pkey";
       public            postgres    false    299            ^           2606    40056     SalaryDetails SalaryDetails_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public."SalaryDetails"
    ADD CONSTRAINT "SalaryDetails_pkey" PRIMARY KEY (id);
 N   ALTER TABLE ONLY public."SalaryDetails" DROP CONSTRAINT "SalaryDetails_pkey";
       public            postgres    false    311            J           2606    39980 ,   SettingsPermissions SettingsPermissions_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public."SettingsPermissions"
    ADD CONSTRAINT "SettingsPermissions_pkey" PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public."SettingsPermissions" DROP CONSTRAINT "SettingsPermissions_pkey";
       public            postgres    false    304            `           2606    40066    Shifts Shifts_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public."Shifts"
    ADD CONSTRAINT "Shifts_pkey" PRIMARY KEY (id);
 @   ALTER TABLE ONLY public."Shifts" DROP CONSTRAINT "Shifts_pkey";
       public            postgres    false    312            "           2606    39812 <   StaffBackgroundVerification StaffBackgroundVerification_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public."StaffBackgroundVerification"
    ADD CONSTRAINT "StaffBackgroundVerification_pkey" PRIMARY KEY (id);
 j   ALTER TABLE ONLY public."StaffBackgroundVerification" DROP CONSTRAINT "StaffBackgroundVerification_pkey";
       public            postgres    false    289                       2606    39763    StaffDetails StaffDetails_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."StaffDetails"
    ADD CONSTRAINT "StaffDetails_pkey" PRIMARY KEY (id);
 L   ALTER TABLE ONLY public."StaffDetails" DROP CONSTRAINT "StaffDetails_pkey";
       public            postgres    false    285            M           2606    39993 &   StaffPermissions StaffPermissions_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public."StaffPermissions"
    ADD CONSTRAINT "StaffPermissions_pkey" PRIMARY KEY (id);
 T   ALTER TABLE ONLY public."StaffPermissions" DROP CONSTRAINT "StaffPermissions_pkey";
       public            postgres    false    305            G           2606    39969 .   StaffRolePermissions StaffRolePermissions_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public."StaffRolePermissions"
    ADD CONSTRAINT "StaffRolePermissions_pkey" PRIMARY KEY (id);
 \   ALTER TABLE ONLY public."StaffRolePermissions" DROP CONSTRAINT "StaffRolePermissions_pkey";
       public            postgres    false    303            |           2606    40182    StartBreak StartBreak_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."StartBreak"
    ADD CONSTRAINT "StartBreak_pkey" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public."StartBreak" DROP CONSTRAINT "StartBreak_pkey";
       public            postgres    false    322            S           2606    40019 *   SubTaskPermissions SubTaskPermissions_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public."SubTaskPermissions"
    ADD CONSTRAINT "SubTaskPermissions_pkey" PRIMARY KEY (id);
 X   ALTER TABLE ONLY public."SubTaskPermissions" DROP CONSTRAINT "SubTaskPermissions_pkey";
       public            postgres    false    307            �           2606    40217    TaskDetail TaskDetail_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."TaskDetail"
    ADD CONSTRAINT "TaskDetail_pkey" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public."TaskDetail" DROP CONSTRAINT "TaskDetail_pkey";
       public            postgres    false    326            P           2606    40006 $   TaskPermissions TaskPermissions_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public."TaskPermissions"
    ADD CONSTRAINT "TaskPermissions_pkey" PRIMARY KEY (id);
 R   ALTER TABLE ONLY public."TaskPermissions" DROP CONSTRAINT "TaskPermissions_pkey";
       public            postgres    false    306            �           2606    40209    TaskPriority TaskPriority_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."TaskPriority"
    ADD CONSTRAINT "TaskPriority_pkey" PRIMARY KEY (id);
 L   ALTER TABLE ONLY public."TaskPriority" DROP CONSTRAINT "TaskPriority_pkey";
       public            postgres    false    325            �           2606    40201    TaskStatus TaskStatus_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."TaskStatus"
    ADD CONSTRAINT "TaskStatus_pkey" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public."TaskStatus" DROP CONSTRAINT "TaskStatus_pkey";
       public            postgres    false    324            �           2606    40242 (   TicketInformation TicketInformation_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public."TicketInformation"
    ADD CONSTRAINT "TicketInformation_pkey" PRIMARY KEY (id);
 V   ALTER TABLE ONLY public."TicketInformation" DROP CONSTRAINT "TicketInformation_pkey";
       public            postgres    false    329            �           2606    40267    UpiDetails UpiDetails_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public."UpiDetails"
    ADD CONSTRAINT "UpiDetails_pkey" PRIMARY KEY ("UpiId");
 H   ALTER TABLE ONLY public."UpiDetails" DROP CONSTRAINT "UpiDetails_pkey";
       public            postgres    false    332            
           2606    39710    User User_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_pkey";
       public            postgres    false    279            b           2606    40079    WeekOffShift WeekOffShift_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."WeekOffShift"
    ADD CONSTRAINT "WeekOffShift_pkey" PRIMARY KEY (id);
 L   ALTER TABLE ONLY public."WeekOffShift" DROP CONSTRAINT "WeekOffShift_pkey";
       public            postgres    false    313                       2606    39718    WorkEntry WorkEntry_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."WorkEntry"
    ADD CONSTRAINT "WorkEntry_pkey" PRIMARY KEY (id);
 F   ALTER TABLE ONLY public."WorkEntry" DROP CONSTRAINT "WorkEntry_pkey";
       public            postgres    false    280                       2606    39595 *   _prisma_migrations _prisma_migrations_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public._prisma_migrations DROP CONSTRAINT _prisma_migrations_pkey;
       public            postgres    false    278            o           2606    40120    breakRecord breakRecord_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public."breakRecord"
    ADD CONSTRAINT "breakRecord_pkey" PRIMARY KEY (id);
 J   ALTER TABLE ONLY public."breakRecord" DROP CONSTRAINT "breakRecord_pkey";
       public            postgres    false    317                       2606    29206    messages messages_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);
 B   ALTER TABLE ONLY realtime.messages DROP CONSTRAINT messages_pkey;
       realtime            supabase_realtime_admin    false    277    277                       2606    29061    subscription pk_subscription 
   CONSTRAINT     \   ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);
 H   ALTER TABLE ONLY realtime.subscription DROP CONSTRAINT pk_subscription;
       realtime            supabase_admin    false    274            �           2606    29035 (   schema_migrations schema_migrations_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);
 T   ALTER TABLE ONLY realtime.schema_migrations DROP CONSTRAINT schema_migrations_pkey;
       realtime            supabase_admin    false    271            �           2606    16548    buckets buckets_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);
 ?   ALTER TABLE ONLY storage.buckets DROP CONSTRAINT buckets_pkey;
       storage            supabase_storage_admin    false    239            �           2606    16589    migrations migrations_name_key 
   CONSTRAINT     Z   ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);
 I   ALTER TABLE ONLY storage.migrations DROP CONSTRAINT migrations_name_key;
       storage            supabase_storage_admin    false    241            �           2606    16587    migrations migrations_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);
 E   ALTER TABLE ONLY storage.migrations DROP CONSTRAINT migrations_pkey;
       storage            supabase_storage_admin    false    241            �           2606    16565    objects objects_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);
 ?   ALTER TABLE ONLY storage.objects DROP CONSTRAINT objects_pkey;
       storage            supabase_storage_admin    false    240            �           2606    28997 :   s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey 
   CONSTRAINT     y   ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);
 e   ALTER TABLE ONLY storage.s3_multipart_uploads_parts DROP CONSTRAINT s3_multipart_uploads_parts_pkey;
       storage            supabase_storage_admin    false    270            �           2606    28982 .   s3_multipart_uploads s3_multipart_uploads_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);
 Y   ALTER TABLE ONLY storage.s3_multipart_uploads DROP CONSTRAINT s3_multipart_uploads_pkey;
       storage            supabase_storage_admin    false    269            �           1259    16526    audit_logs_instance_id_idx    INDEX     ]   CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);
 ,   DROP INDEX auth.audit_logs_instance_id_idx;
       auth            supabase_auth_admin    false    237            �           1259    28687    confirmation_token_idx    INDEX     �   CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);
 (   DROP INDEX auth.confirmation_token_idx;
       auth            supabase_auth_admin    false    233    233            �           1259    28689    email_change_token_current_idx    INDEX     �   CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);
 0   DROP INDEX auth.email_change_token_current_idx;
       auth            supabase_auth_admin    false    233    233            �           1259    28690    email_change_token_new_idx    INDEX     �   CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);
 ,   DROP INDEX auth.email_change_token_new_idx;
       auth            supabase_auth_admin    false    233    233            �           1259    28769    factor_id_created_at_idx    INDEX     ]   CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);
 *   DROP INDEX auth.factor_id_created_at_idx;
       auth            supabase_auth_admin    false    260    260            �           1259    28877    flow_state_created_at_idx    INDEX     Y   CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);
 +   DROP INDEX auth.flow_state_created_at_idx;
       auth            supabase_auth_admin    false    267            �           1259    28857    identities_email_idx    INDEX     [   CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);
 &   DROP INDEX auth.identities_email_idx;
       auth            supabase_auth_admin    false    258            �           0    0    INDEX identities_email_idx    COMMENT     c   COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';
          auth          supabase_auth_admin    false    4292            �           1259    28684    identities_user_id_idx    INDEX     N   CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);
 (   DROP INDEX auth.identities_user_id_idx;
       auth            supabase_auth_admin    false    258            �           1259    28874    idx_auth_code    INDEX     G   CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);
    DROP INDEX auth.idx_auth_code;
       auth            supabase_auth_admin    false    267            �           1259    28875    idx_user_id_auth_method    INDEX     f   CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);
 )   DROP INDEX auth.idx_user_id_auth_method;
       auth            supabase_auth_admin    false    267    267            �           1259    28880    mfa_challenge_created_at_idx    INDEX     `   CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);
 .   DROP INDEX auth.mfa_challenge_created_at_idx;
       auth            supabase_auth_admin    false    261            �           1259    28741 %   mfa_factors_user_friendly_name_unique    INDEX     �   CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);
 7   DROP INDEX auth.mfa_factors_user_friendly_name_unique;
       auth            supabase_auth_admin    false    260    260    260            �           1259    28886    mfa_factors_user_id_idx    INDEX     P   CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);
 )   DROP INDEX auth.mfa_factors_user_id_idx;
       auth            supabase_auth_admin    false    260            �           1259    28933 #   one_time_tokens_relates_to_hash_idx    INDEX     b   CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);
 5   DROP INDEX auth.one_time_tokens_relates_to_hash_idx;
       auth            supabase_auth_admin    false    268            �           1259    28932 #   one_time_tokens_token_hash_hash_idx    INDEX     b   CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);
 5   DROP INDEX auth.one_time_tokens_token_hash_hash_idx;
       auth            supabase_auth_admin    false    268            �           1259    28934 &   one_time_tokens_user_id_token_type_key    INDEX     v   CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);
 8   DROP INDEX auth.one_time_tokens_user_id_token_type_key;
       auth            supabase_auth_admin    false    268    268            �           1259    28691    reauthentication_token_idx    INDEX     �   CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);
 ,   DROP INDEX auth.reauthentication_token_idx;
       auth            supabase_auth_admin    false    233    233            �           1259    28688    recovery_token_idx    INDEX     �   CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);
 $   DROP INDEX auth.recovery_token_idx;
       auth            supabase_auth_admin    false    233    233            �           1259    16509    refresh_tokens_instance_id_idx    INDEX     ^   CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);
 0   DROP INDEX auth.refresh_tokens_instance_id_idx;
       auth            supabase_auth_admin    false    235            �           1259    16510 &   refresh_tokens_instance_id_user_id_idx    INDEX     o   CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);
 8   DROP INDEX auth.refresh_tokens_instance_id_user_id_idx;
       auth            supabase_auth_admin    false    235    235            �           1259    28683    refresh_tokens_parent_idx    INDEX     T   CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);
 +   DROP INDEX auth.refresh_tokens_parent_idx;
       auth            supabase_auth_admin    false    235            �           1259    28771 %   refresh_tokens_session_id_revoked_idx    INDEX     m   CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);
 7   DROP INDEX auth.refresh_tokens_session_id_revoked_idx;
       auth            supabase_auth_admin    false    235    235            �           1259    28876    refresh_tokens_updated_at_idx    INDEX     a   CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);
 /   DROP INDEX auth.refresh_tokens_updated_at_idx;
       auth            supabase_auth_admin    false    235            �           1259    28813 "   saml_providers_sso_provider_id_idx    INDEX     f   CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);
 4   DROP INDEX auth.saml_providers_sso_provider_id_idx;
       auth            supabase_auth_admin    false    265            �           1259    28878     saml_relay_states_created_at_idx    INDEX     g   CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);
 2   DROP INDEX auth.saml_relay_states_created_at_idx;
       auth            supabase_auth_admin    false    266            �           1259    28828    saml_relay_states_for_email_idx    INDEX     `   CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);
 1   DROP INDEX auth.saml_relay_states_for_email_idx;
       auth            supabase_auth_admin    false    266            �           1259    28827 %   saml_relay_states_sso_provider_id_idx    INDEX     l   CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);
 7   DROP INDEX auth.saml_relay_states_sso_provider_id_idx;
       auth            supabase_auth_admin    false    266            �           1259    28879    sessions_not_after_idx    INDEX     S   CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);
 (   DROP INDEX auth.sessions_not_after_idx;
       auth            supabase_auth_admin    false    259            �           1259    28770    sessions_user_id_idx    INDEX     J   CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);
 &   DROP INDEX auth.sessions_user_id_idx;
       auth            supabase_auth_admin    false    259            �           1259    28795    sso_domains_domain_idx    INDEX     \   CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));
 (   DROP INDEX auth.sso_domains_domain_idx;
       auth            supabase_auth_admin    false    264    264            �           1259    28794    sso_domains_sso_provider_id_idx    INDEX     `   CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);
 1   DROP INDEX auth.sso_domains_sso_provider_id_idx;
       auth            supabase_auth_admin    false    264            �           1259    28780    sso_providers_resource_id_idx    INDEX     j   CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));
 /   DROP INDEX auth.sso_providers_resource_id_idx;
       auth            supabase_auth_admin    false    263    263            �           1259    28939    unique_phone_factor_per_user    INDEX     c   CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);
 .   DROP INDEX auth.unique_phone_factor_per_user;
       auth            supabase_auth_admin    false    260    260            �           1259    28768    user_id_created_at_idx    INDEX     X   CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);
 (   DROP INDEX auth.user_id_created_at_idx;
       auth            supabase_auth_admin    false    259    259            �           1259    28848    users_email_partial_key    INDEX     k   CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);
 )   DROP INDEX auth.users_email_partial_key;
       auth            supabase_auth_admin    false    233    233            �           0    0    INDEX users_email_partial_key    COMMENT     }   COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';
          auth          supabase_auth_admin    false    4246            �           1259    28685    users_instance_id_email_idx    INDEX     h   CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));
 -   DROP INDEX auth.users_instance_id_email_idx;
       auth            supabase_auth_admin    false    233    233            �           1259    16499    users_instance_id_idx    INDEX     L   CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);
 '   DROP INDEX auth.users_instance_id_idx;
       auth            supabase_auth_admin    false    233            �           1259    28903    users_is_anonymous_idx    INDEX     N   CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);
 (   DROP INDEX auth.users_is_anonymous_idx;
       auth            supabase_auth_admin    false    233            W           1259    40354    AIPermissions_permissionsId_key    INDEX     o   CREATE UNIQUE INDEX "AIPermissions_permissionsId_key" ON public."AIPermissions" USING btree ("permissionsId");
 5   DROP INDEX public."AIPermissions_permissionsId_key";
       public            postgres    false    309                       1259    40336    AdminDetails_userId_key    INDEX     _   CREATE UNIQUE INDEX "AdminDetails_userId_key" ON public."AdminDetails" USING btree ("userId");
 -   DROP INDEX public."AdminDetails_userId_key";
       public            postgres    false    283                       1259    40338 $   AttendanceAutomationRule_staffId_key    INDEX     y   CREATE UNIQUE INDEX "AttendanceAutomationRule_staffId_key" ON public."AttendanceAutomationRule" USING btree ("staffId");
 :   DROP INDEX public."AttendanceAutomationRule_staffId_key";
       public            postgres    false    287                        1259    40339    AttendanceMode_staffId_key    INDEX     e   CREATE UNIQUE INDEX "AttendanceMode_staffId_key" ON public."AttendanceMode" USING btree ("staffId");
 0   DROP INDEX public."AttendanceMode_staffId_key";
       public            postgres    false    288            )           1259    40342    BankDetails_staffId_key    INDEX     _   CREATE UNIQUE INDEX "BankDetails_staffId_key" ON public."BankDetails" USING btree ("staffId");
 -   DROP INDEX public."BankDetails_staffId_key";
       public            postgres    false    291            T           1259    40353 '   ChatModulePermissions_permissionsId_key    INDEX        CREATE UNIQUE INDEX "ChatModulePermissions_permissionsId_key" ON public."ChatModulePermissions" USING btree ("permissionsId");
 =   DROP INDEX public."ChatModulePermissions_permissionsId_key";
       public            postgres    false    308            �           1259    40366    ClientDetails_userId_key    INDEX     a   CREATE UNIQUE INDEX "ClientDetails_userId_key" ON public."ClientDetails" USING btree ("userId");
 .   DROP INDEX public."ClientDetails_userId_key";
       public            postgres    false    331            �           1259    40367    ClientDetails_vat_number_key    INDEX     g   CREATE UNIQUE INDEX "ClientDetails_vat_number_key" ON public."ClientDetails" USING btree (vat_number);
 2   DROP INDEX public."ClientDetails_vat_number_key";
       public            postgres    false    331            <           1259    40345 $   ClientsPermissions_permissionsId_key    INDEX     y   CREATE UNIQUE INDEX "ClientsPermissions_permissionsId_key" ON public."ClientsPermissions" USING btree ("permissionsId");
 :   DROP INDEX public."ClientsPermissions_permissionsId_key";
       public            postgres    false    300            �           1259    40365    EndBreak_punchRecordId_key    INDEX     e   CREATE UNIQUE INDEX "EndBreak_punchRecordId_key" ON public."EndBreak" USING btree ("punchRecordId");
 0   DROP INDEX public."EndBreak_punchRecordId_key";
       public            postgres    false    323            s           1259    40362    Fine_punchRecordId_key    INDEX     ]   CREATE UNIQUE INDEX "Fine_punchRecordId_key" ON public."Fine" USING btree ("punchRecordId");
 ,   DROP INDEX public."Fine_punchRecordId_key";
       public            postgres    false    318            e           1259    40356    FixedShift_weekId_key    INDEX     [   CREATE UNIQUE INDEX "FixedShift_weekId_key" ON public."FixedShift" USING btree ("weekId");
 +   DROP INDEX public."FixedShift_weekId_key";
       public            postgres    false    314            h           1259    40357 "   FlexibleShift_staffId_dateTime_key    INDEX     x   CREATE UNIQUE INDEX "FlexibleShift_staffId_dateTime_key" ON public."FlexibleShift" USING btree ("staffId", "dateTime");
 8   DROP INDEX public."FlexibleShift_staffId_dateTime_key";
       public            postgres    false    315    315            .           1259    40343    LeaveBalance_leavePolicyId_key    INDEX     m   CREATE UNIQUE INDEX "LeaveBalance_leavePolicyId_key" ON public."LeaveBalance" USING btree ("leavePolicyId");
 4   DROP INDEX public."LeaveBalance_leavePolicyId_key";
       public            postgres    false    294            v           1259    40363    Overtime_punchRecordId_key    INDEX     e   CREATE UNIQUE INDEX "Overtime_punchRecordId_key" ON public."Overtime" USING btree ("punchRecordId");
 0   DROP INDEX public."Overtime_punchRecordId_key";
       public            postgres    false    319            &           1259    40341    PastEmployment_staffId_key    INDEX     e   CREATE UNIQUE INDEX "PastEmployment_staffId_key" ON public."PastEmployment" USING btree ("staffId");
 0   DROP INDEX public."PastEmployment_staffId_key";
       public            postgres    false    290            \           1259    40355    Permissions_roleId_key    INDEX     ]   CREATE UNIQUE INDEX "Permissions_roleId_key" ON public."Permissions" USING btree ("roleId");
 ,   DROP INDEX public."Permissions_roleId_key";
       public            postgres    false    310            ?           1259    40346 %   ProjectsPermissions_permissionsId_key    INDEX     {   CREATE UNIQUE INDEX "ProjectsPermissions_permissionsId_key" ON public."ProjectsPermissions" USING btree ("permissionsId");
 ;   DROP INDEX public."ProjectsPermissions_permissionsId_key";
       public            postgres    false    301            k           1259    40358    PunchRecords_punchInId_key    INDEX     e   CREATE UNIQUE INDEX "PunchRecords_punchInId_key" ON public."PunchRecords" USING btree ("punchInId");
 0   DROP INDEX public."PunchRecords_punchInId_key";
       public            postgres    false    316            l           1259    40359    PunchRecords_punchOutId_key    INDEX     g   CREATE UNIQUE INDEX "PunchRecords_punchOutId_key" ON public."PunchRecords" USING btree ("punchOutId");
 1   DROP INDEX public."PunchRecords_punchOutId_key";
       public            postgres    false    316            m           1259    40360 "   PunchRecords_staffId_punchDate_key    INDEX     x   CREATE UNIQUE INDEX "PunchRecords_staffId_punchDate_key" ON public."PunchRecords" USING btree ("staffId", "punchDate");
 8   DROP INDEX public."PunchRecords_staffId_punchDate_key";
       public            postgres    false    316    316            B           1259    40347 #   ReportPermissions_permissionsId_key    INDEX     w   CREATE UNIQUE INDEX "ReportPermissions_permissionsId_key" ON public."ReportPermissions" USING btree ("permissionsId");
 9   DROP INDEX public."ReportPermissions_permissionsId_key";
       public            postgres    false    302            ;           1259    40344    Role_role_name_key    INDEX     S   CREATE UNIQUE INDEX "Role_role_name_key" ON public."Role" USING btree (role_name);
 (   DROP INDEX public."Role_role_name_key";
       public            postgres    false    299            H           1259    40349 %   SettingsPermissions_permissionsId_key    INDEX     {   CREATE UNIQUE INDEX "SettingsPermissions_permissionsId_key" ON public."SettingsPermissions" USING btree ("permissionsId");
 ;   DROP INDEX public."SettingsPermissions_permissionsId_key";
       public            postgres    false    304            #           1259    40340 '   StaffBackgroundVerification_staffId_key    INDEX        CREATE UNIQUE INDEX "StaffBackgroundVerification_staffId_key" ON public."StaffBackgroundVerification" USING btree ("staffId");
 =   DROP INDEX public."StaffBackgroundVerification_staffId_key";
       public            postgres    false    289                       1259    40337    StaffDetails_userId_key    INDEX     _   CREATE UNIQUE INDEX "StaffDetails_userId_key" ON public."StaffDetails" USING btree ("userId");
 -   DROP INDEX public."StaffDetails_userId_key";
       public            postgres    false    285            K           1259    40350 "   StaffPermissions_permissionsId_key    INDEX     u   CREATE UNIQUE INDEX "StaffPermissions_permissionsId_key" ON public."StaffPermissions" USING btree ("permissionsId");
 8   DROP INDEX public."StaffPermissions_permissionsId_key";
       public            postgres    false    305            E           1259    40348 &   StaffRolePermissions_permissionsId_key    INDEX     }   CREATE UNIQUE INDEX "StaffRolePermissions_permissionsId_key" ON public."StaffRolePermissions" USING btree ("permissionsId");
 <   DROP INDEX public."StaffRolePermissions_permissionsId_key";
       public            postgres    false    303            }           1259    40364    StartBreak_punchRecordId_key    INDEX     i   CREATE UNIQUE INDEX "StartBreak_punchRecordId_key" ON public."StartBreak" USING btree ("punchRecordId");
 2   DROP INDEX public."StartBreak_punchRecordId_key";
       public            postgres    false    322            Q           1259    40352 $   SubTaskPermissions_permissionsId_key    INDEX     y   CREATE UNIQUE INDEX "SubTaskPermissions_permissionsId_key" ON public."SubTaskPermissions" USING btree ("permissionsId");
 :   DROP INDEX public."SubTaskPermissions_permissionsId_key";
       public            postgres    false    307            N           1259    40351 !   TaskPermissions_permissionsId_key    INDEX     s   CREATE UNIQUE INDEX "TaskPermissions_permissionsId_key" ON public."TaskPermissions" USING btree ("permissionsId");
 7   DROP INDEX public."TaskPermissions_permissionsId_key";
       public            postgres    false    306            �           1259    40368    UpiDetails_staffId_key    INDEX     ]   CREATE UNIQUE INDEX "UpiDetails_staffId_key" ON public."UpiDetails" USING btree ("staffId");
 ,   DROP INDEX public."UpiDetails_staffId_key";
       public            postgres    false    332                       1259    40335    User_email_key    INDEX     K   CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);
 $   DROP INDEX public."User_email_key";
       public            postgres    false    279            �           1259    40375    _FixedShiftToShifts_AB_unique    INDEX     l   CREATE UNIQUE INDEX "_FixedShiftToShifts_AB_unique" ON public."_FixedShiftToShifts" USING btree ("A", "B");
 3   DROP INDEX public."_FixedShiftToShifts_AB_unique";
       public            postgres    false    340    340            �           1259    40376    _FixedShiftToShifts_B_index    INDEX     ^   CREATE INDEX "_FixedShiftToShifts_B_index" ON public."_FixedShiftToShifts" USING btree ("B");
 1   DROP INDEX public."_FixedShiftToShifts_B_index";
       public            postgres    false    340            �           1259    40377     _FlexibleShiftToShifts_AB_unique    INDEX     r   CREATE UNIQUE INDEX "_FlexibleShiftToShifts_AB_unique" ON public."_FlexibleShiftToShifts" USING btree ("A", "B");
 6   DROP INDEX public."_FlexibleShiftToShifts_AB_unique";
       public            postgres    false    341    341            �           1259    40378    _FlexibleShiftToShifts_B_index    INDEX     d   CREATE INDEX "_FlexibleShiftToShifts_B_index" ON public."_FlexibleShiftToShifts" USING btree ("B");
 4   DROP INDEX public."_FlexibleShiftToShifts_B_index";
       public            postgres    false    341            �           1259    40379    _ProjectStaff_AB_unique    INDEX     `   CREATE UNIQUE INDEX "_ProjectStaff_AB_unique" ON public."_ProjectStaff" USING btree ("A", "B");
 -   DROP INDEX public."_ProjectStaff_AB_unique";
       public            postgres    false    342    342            �           1259    40380    _ProjectStaff_B_index    INDEX     R   CREATE INDEX "_ProjectStaff_B_index" ON public."_ProjectStaff" USING btree ("B");
 +   DROP INDEX public."_ProjectStaff_B_index";
       public            postgres    false    342            �           1259    40369    _UserRooms_AB_unique    INDEX     Z   CREATE UNIQUE INDEX "_UserRooms_AB_unique" ON public."_UserRooms" USING btree ("A", "B");
 *   DROP INDEX public."_UserRooms_AB_unique";
       public            postgres    false    337    337            �           1259    40370    _UserRooms_B_index    INDEX     L   CREATE INDEX "_UserRooms_B_index" ON public."_UserRooms" USING btree ("B");
 (   DROP INDEX public."_UserRooms_B_index";
       public            postgres    false    337            �           1259    40373    _departmentId_AB_unique    INDEX     `   CREATE UNIQUE INDEX "_departmentId_AB_unique" ON public."_departmentId" USING btree ("A", "B");
 -   DROP INDEX public."_departmentId_AB_unique";
       public            postgres    false    339    339            �           1259    40374    _departmentId_B_index    INDEX     R   CREATE INDEX "_departmentId_B_index" ON public."_departmentId" USING btree ("B");
 +   DROP INDEX public."_departmentId_B_index";
       public            postgres    false    339            �           1259    40381    _projectId_AB_unique    INDEX     Z   CREATE UNIQUE INDEX "_projectId_AB_unique" ON public."_projectId" USING btree ("A", "B");
 *   DROP INDEX public."_projectId_AB_unique";
       public            postgres    false    343    343            �           1259    40382    _projectId_B_index    INDEX     L   CREATE INDEX "_projectId_B_index" ON public."_projectId" USING btree ("B");
 (   DROP INDEX public."_projectId_B_index";
       public            postgres    false    343            �           1259    40371    _staffId_AB_unique    INDEX     V   CREATE UNIQUE INDEX "_staffId_AB_unique" ON public."_staffId" USING btree ("A", "B");
 (   DROP INDEX public."_staffId_AB_unique";
       public            postgres    false    338    338            �           1259    40372    _staffId_B_index    INDEX     H   CREATE INDEX "_staffId_B_index" ON public."_staffId" USING btree ("B");
 &   DROP INDEX public."_staffId_B_index";
       public            postgres    false    338            p           1259    40361    breakRecord_punchRecordId_key    INDEX     k   CREATE UNIQUE INDEX "breakRecord_punchRecordId_key" ON public."breakRecord" USING btree ("punchRecordId");
 3   DROP INDEX public."breakRecord_punchRecordId_key";
       public            postgres    false    317                        1259    29064    ix_realtime_subscription_entity    INDEX     [   CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING hash (entity);
 5   DROP INDEX realtime.ix_realtime_subscription_entity;
       realtime            supabase_admin    false    274                       1259    29110 /   subscription_subscription_id_entity_filters_key    INDEX     �   CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);
 E   DROP INDEX realtime.subscription_subscription_id_entity_filters_key;
       realtime            supabase_admin    false    274    274    274            �           1259    16554    bname    INDEX     A   CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);
    DROP INDEX storage.bname;
       storage            supabase_storage_admin    false    239            �           1259    16576    bucketid_objname    INDEX     W   CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);
 %   DROP INDEX storage.bucketid_objname;
       storage            supabase_storage_admin    false    240    240            �           1259    29008    idx_multipart_uploads_list    INDEX     r   CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);
 /   DROP INDEX storage.idx_multipart_uploads_list;
       storage            supabase_storage_admin    false    269    269    269            �           1259    28973    idx_objects_bucket_id_name    INDEX     f   CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");
 /   DROP INDEX storage.idx_objects_bucket_id_name;
       storage            supabase_storage_admin    false    240    240            �           1259    16577    name_prefix_search    INDEX     X   CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);
 '   DROP INDEX storage.name_prefix_search;
       storage            supabase_storage_admin    false    240                       2620    29066    subscription tr_check_filters    TRIGGER     �   CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();
 8   DROP TRIGGER tr_check_filters ON realtime.subscription;
       realtime          supabase_admin    false    574    274                       2620    28961 !   objects update_objects_updated_at    TRIGGER     �   CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();
 ;   DROP TRIGGER update_objects_updated_at ON storage.objects;
       storage          supabase_storage_admin    false    570    240            �           2606    28671 "   identities identities_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY auth.identities DROP CONSTRAINT identities_user_id_fkey;
       auth          supabase_auth_admin    false    4253    258    233            �           2606    28761 -   mfa_amr_claims mfa_amr_claims_session_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;
 U   ALTER TABLE ONLY auth.mfa_amr_claims DROP CONSTRAINT mfa_amr_claims_session_id_fkey;
       auth          supabase_auth_admin    false    262    259    4300            �           2606    28749 1   mfa_challenges mfa_challenges_auth_factor_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;
 Y   ALTER TABLE ONLY auth.mfa_challenges DROP CONSTRAINT mfa_challenges_auth_factor_id_fkey;
       auth          supabase_auth_admin    false    4307    260    261            �           2606    28736 $   mfa_factors mfa_factors_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
 L   ALTER TABLE ONLY auth.mfa_factors DROP CONSTRAINT mfa_factors_user_id_fkey;
       auth          supabase_auth_admin    false    233    4253    260            �           2606    28927 ,   one_time_tokens one_time_tokens_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY auth.one_time_tokens DROP CONSTRAINT one_time_tokens_user_id_fkey;
       auth          supabase_auth_admin    false    268    233    4253            �           2606    28704 -   refresh_tokens refresh_tokens_session_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;
 U   ALTER TABLE ONLY auth.refresh_tokens DROP CONSTRAINT refresh_tokens_session_id_fkey;
       auth          supabase_auth_admin    false    235    4300    259            �           2606    28808 2   saml_providers saml_providers_sso_provider_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;
 Z   ALTER TABLE ONLY auth.saml_providers DROP CONSTRAINT saml_providers_sso_provider_id_fkey;
       auth          supabase_auth_admin    false    263    4319    265            �           2606    28881 6   saml_relay_states saml_relay_states_flow_state_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;
 ^   ALTER TABLE ONLY auth.saml_relay_states DROP CONSTRAINT saml_relay_states_flow_state_id_fkey;
       auth          supabase_auth_admin    false    4337    266    267            �           2606    28822 8   saml_relay_states saml_relay_states_sso_provider_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY auth.saml_relay_states DROP CONSTRAINT saml_relay_states_sso_provider_id_fkey;
       auth          supabase_auth_admin    false    263    4319    266            �           2606    28699    sessions sessions_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
 F   ALTER TABLE ONLY auth.sessions DROP CONSTRAINT sessions_user_id_fkey;
       auth          supabase_auth_admin    false    233    259    4253            �           2606    28789 ,   sso_domains sso_domains_sso_provider_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY auth.sso_domains DROP CONSTRAINT sso_domains_sso_provider_id_fkey;
       auth          supabase_auth_admin    false    264    263    4319            �           2606    40538 .   AIPermissions AIPermissions_permissionsId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."AIPermissions"
    ADD CONSTRAINT "AIPermissions_permissionsId_fkey" FOREIGN KEY ("permissionsId") REFERENCES public."Permissions"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 \   ALTER TABLE ONLY public."AIPermissions" DROP CONSTRAINT "AIPermissions_permissionsId_fkey";
       public          postgres    false    4443    309    310            �           2606    40398 %   AdminDetails AdminDetails_userId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."AdminDetails"
    ADD CONSTRAINT "AdminDetails_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 S   ALTER TABLE ONLY public."AdminDetails" DROP CONSTRAINT "AdminDetails_userId_fkey";
       public          postgres    false    283    4362    279            �           2606    40423 >   AttendanceAutomationRule AttendanceAutomationRule_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."AttendanceAutomationRule"
    ADD CONSTRAINT "AttendanceAutomationRule_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 l   ALTER TABLE ONLY public."AttendanceAutomationRule" DROP CONSTRAINT "AttendanceAutomationRule_staffId_fkey";
       public          postgres    false    4375    285    287            �           2606    40428 *   AttendanceMode AttendanceMode_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."AttendanceMode"
    ADD CONSTRAINT "AttendanceMode_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 X   ALTER TABLE ONLY public."AttendanceMode" DROP CONSTRAINT "AttendanceMode_staffId_fkey";
       public          postgres    false    4375    288    285            �           2606    40443 $   BankDetails BankDetails_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."BankDetails"
    ADD CONSTRAINT "BankDetails_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 R   ALTER TABLE ONLY public."BankDetails" DROP CONSTRAINT "BankDetails_staffId_fkey";
       public          postgres    false    4375    285    291            �           2606    40533 >   ChatModulePermissions ChatModulePermissions_permissionsId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ChatModulePermissions"
    ADD CONSTRAINT "ChatModulePermissions_permissionsId_fkey" FOREIGN KEY ("permissionsId") REFERENCES public."Permissions"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 l   ALTER TABLE ONLY public."ChatModulePermissions" DROP CONSTRAINT "ChatModulePermissions_permissionsId_fkey";
       public          postgres    false    310    308    4443            �           2606    40663 '   ClientDetails ClientDetails_userId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ClientDetails"
    ADD CONSTRAINT "ClientDetails_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 U   ALTER TABLE ONLY public."ClientDetails" DROP CONSTRAINT "ClientDetails_userId_fkey";
       public          postgres    false    4362    279    331            �           2606    40493 8   ClientsPermissions ClientsPermissions_permissionsId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ClientsPermissions"
    ADD CONSTRAINT "ClientsPermissions_permissionsId_fkey" FOREIGN KEY ("permissionsId") REFERENCES public."Permissions"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 f   ALTER TABLE ONLY public."ClientsPermissions" DROP CONSTRAINT "ClientsPermissions_permissionsId_fkey";
       public          postgres    false    4443    310    300            �           2606    40473 (   CustomDetails CustomDetails_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."CustomDetails"
    ADD CONSTRAINT "CustomDetails_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 V   ALTER TABLE ONLY public."CustomDetails" DROP CONSTRAINT "CustomDetails_staffId_fkey";
       public          postgres    false    285    295    4375            �           2606    40678 *   Deductions Deductions_salaryDetailsId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Deductions"
    ADD CONSTRAINT "Deductions_salaryDetailsId_fkey" FOREIGN KEY ("salaryDetailsId") REFERENCES public."SalaryDetails"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 X   ALTER TABLE ONLY public."Deductions" DROP CONSTRAINT "Deductions_salaryDetailsId_fkey";
       public          postgres    false    335    4446    311            �           2606    40673 "   Deductions Deductions_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Deductions"
    ADD CONSTRAINT "Deductions_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 P   ALTER TABLE ONLY public."Deductions" DROP CONSTRAINT "Deductions_staffId_fkey";
       public          postgres    false    4375    285    335            �           2606    40478 .   EarlyLeavePolicy EarlyLeavePolicy_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."EarlyLeavePolicy"
    ADD CONSTRAINT "EarlyLeavePolicy_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 \   ALTER TABLE ONLY public."EarlyLeavePolicy" DROP CONSTRAINT "EarlyLeavePolicy_staffId_fkey";
       public          postgres    false    285    4375    296            �           2606    40688 &   Earnings Earnings_salaryDetailsId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Earnings"
    ADD CONSTRAINT "Earnings_salaryDetailsId_fkey" FOREIGN KEY ("salaryDetailsId") REFERENCES public."SalaryDetails"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 T   ALTER TABLE ONLY public."Earnings" DROP CONSTRAINT "Earnings_salaryDetailsId_fkey";
       public          postgres    false    311    4446    336            �           2606    40683    Earnings Earnings_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Earnings"
    ADD CONSTRAINT "Earnings_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 L   ALTER TABLE ONLY public."Earnings" DROP CONSTRAINT "Earnings_staffId_fkey";
       public          postgres    false    4375    285    336            �           2606    40648 %   EndBreak EndBreak_punchRecordsId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."EndBreak"
    ADD CONSTRAINT "EndBreak_punchRecordsId_fkey" FOREIGN KEY ("punchRecordsId") REFERENCES public."PunchRecords"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 S   ALTER TABLE ONLY public."EndBreak" DROP CONSTRAINT "EndBreak_punchRecordsId_fkey";
       public          postgres    false    323    4458    316            �           2606    40643    EndBreak EndBreak_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."EndBreak"
    ADD CONSTRAINT "EndBreak_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 L   ALTER TABLE ONLY public."EndBreak" DROP CONSTRAINT "EndBreak_staffId_fkey";
       public          postgres    false    4375    285    323            �           2606    40608    Fine Fine_punchRecordId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Fine"
    ADD CONSTRAINT "Fine_punchRecordId_fkey" FOREIGN KEY ("punchRecordId") REFERENCES public."PunchRecords"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 J   ALTER TABLE ONLY public."Fine" DROP CONSTRAINT "Fine_punchRecordId_fkey";
       public          postgres    false    4458    316    318            �           2606    40603    Fine Fine_shiftIds_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Fine"
    ADD CONSTRAINT "Fine_shiftIds_fkey" FOREIGN KEY ("shiftIds") REFERENCES public."Shifts"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 E   ALTER TABLE ONLY public."Fine" DROP CONSTRAINT "Fine_shiftIds_fkey";
       public          postgres    false    312    318    4448            �           2606    40613    Fine Fine_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Fine"
    ADD CONSTRAINT "Fine_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 D   ALTER TABLE ONLY public."Fine" DROP CONSTRAINT "Fine_staffId_fkey";
       public          postgres    false    4375    285    318            �           2606    40553 "   FixedShift FixedShift_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."FixedShift"
    ADD CONSTRAINT "FixedShift_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 P   ALTER TABLE ONLY public."FixedShift" DROP CONSTRAINT "FixedShift_staffId_fkey";
       public          postgres    false    314    285    4375            �           2606    40558 !   FixedShift FixedShift_weekId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."FixedShift"
    ADD CONSTRAINT "FixedShift_weekId_fkey" FOREIGN KEY ("weekId") REFERENCES public."WeekOffShift"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 O   ALTER TABLE ONLY public."FixedShift" DROP CONSTRAINT "FixedShift_weekId_fkey";
       public          postgres    false    314    4450    313            �           2606    40563 (   FlexibleShift FlexibleShift_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."FlexibleShift"
    ADD CONSTRAINT "FlexibleShift_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 V   ALTER TABLE ONLY public."FlexibleShift" DROP CONSTRAINT "FlexibleShift_staffId_fkey";
       public          postgres    false    4375    285    315            �           2606    40483 .   LateComingPolicy LateComingPolicy_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."LateComingPolicy"
    ADD CONSTRAINT "LateComingPolicy_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 \   ALTER TABLE ONLY public."LateComingPolicy" DROP CONSTRAINT "LateComingPolicy_staffId_fkey";
       public          postgres    false    4375    297    285            �           2606    40468 ,   LeaveBalance LeaveBalance_leavePolicyId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."LeaveBalance"
    ADD CONSTRAINT "LeaveBalance_leavePolicyId_fkey" FOREIGN KEY ("leavePolicyId") REFERENCES public."LeavePolicy"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public."LeaveBalance" DROP CONSTRAINT "LeaveBalance_leavePolicyId_fkey";
       public          postgres    false    294    4395    292            �           2606    40463 &   LeaveBalance LeaveBalance_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."LeaveBalance"
    ADD CONSTRAINT "LeaveBalance_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 T   ALTER TABLE ONLY public."LeaveBalance" DROP CONSTRAINT "LeaveBalance_staffId_fkey";
       public          postgres    false    285    294    4375            �           2606    40448 $   LeavePolicy LeavePolicy_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."LeavePolicy"
    ADD CONSTRAINT "LeavePolicy_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 R   ALTER TABLE ONLY public."LeavePolicy" DROP CONSTRAINT "LeavePolicy_staffId_fkey";
       public          postgres    false    4375    292    285            �           2606    40458 *   LeaveRequest LeaveRequest_leaveTypeId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."LeaveRequest"
    ADD CONSTRAINT "LeaveRequest_leaveTypeId_fkey" FOREIGN KEY ("leaveTypeId") REFERENCES public."LeavePolicy"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 X   ALTER TABLE ONLY public."LeaveRequest" DROP CONSTRAINT "LeaveRequest_leaveTypeId_fkey";
       public          postgres    false    4395    293    292            �           2606    40453 &   LeaveRequest LeaveRequest_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."LeaveRequest"
    ADD CONSTRAINT "LeaveRequest_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 T   ALTER TABLE ONLY public."LeaveRequest" DROP CONSTRAINT "LeaveRequest_staffId_fkey";
       public          postgres    false    285    4375    293            �           2606    40393    Message Message_roomId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_roomId_fkey" FOREIGN KEY ("roomId") REFERENCES public."ChatRoom"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 I   ALTER TABLE ONLY public."Message" DROP CONSTRAINT "Message_roomId_fkey";
       public          postgres    false    4366    281    282            �           2606    40388    Message Message_senderId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 K   ALTER TABLE ONLY public."Message" DROP CONSTRAINT "Message_senderId_fkey";
       public          postgres    false    4362    282    279            �           2606    40488 *   OvertimePolicy OvertimePolicy_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."OvertimePolicy"
    ADD CONSTRAINT "OvertimePolicy_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 X   ALTER TABLE ONLY public."OvertimePolicy" DROP CONSTRAINT "OvertimePolicy_staffId_fkey";
       public          postgres    false    298    4375    285            �           2606    40623 $   Overtime Overtime_punchRecordId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Overtime"
    ADD CONSTRAINT "Overtime_punchRecordId_fkey" FOREIGN KEY ("punchRecordId") REFERENCES public."PunchRecords"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 R   ALTER TABLE ONLY public."Overtime" DROP CONSTRAINT "Overtime_punchRecordId_fkey";
       public          postgres    false    4458    316    319            �           2606    40618    Overtime Overtime_shiftIds_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Overtime"
    ADD CONSTRAINT "Overtime_shiftIds_fkey" FOREIGN KEY ("shiftIds") REFERENCES public."Shifts"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 M   ALTER TABLE ONLY public."Overtime" DROP CONSTRAINT "Overtime_shiftIds_fkey";
       public          postgres    false    4448    319    312            �           2606    40628    Overtime Overtime_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Overtime"
    ADD CONSTRAINT "Overtime_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 L   ALTER TABLE ONLY public."Overtime" DROP CONSTRAINT "Overtime_staffId_fkey";
       public          postgres    false    4375    319    285            �           2606    40438 *   PastEmployment PastEmployment_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."PastEmployment"
    ADD CONSTRAINT "PastEmployment_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 X   ALTER TABLE ONLY public."PastEmployment" DROP CONSTRAINT "PastEmployment_staffId_fkey";
       public          postgres    false    4375    285    290            �           2606    40543 #   Permissions Permissions_roleId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Permissions"
    ADD CONSTRAINT "Permissions_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES public."Role"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 Q   ALTER TABLE ONLY public."Permissions" DROP CONSTRAINT "Permissions_roleId_fkey";
       public          postgres    false    299    4410    310            �           2606    40653    Project Project_customerId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Project"
    ADD CONSTRAINT "Project_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public."ClientDetails"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 M   ALTER TABLE ONLY public."Project" DROP CONSTRAINT "Project_customerId_fkey";
       public          postgres    false    331    328    4496            �           2606    40498 :   ProjectsPermissions ProjectsPermissions_permissionsId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ProjectsPermissions"
    ADD CONSTRAINT "ProjectsPermissions_permissionsId_fkey" FOREIGN KEY ("permissionsId") REFERENCES public."Permissions"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 h   ALTER TABLE ONLY public."ProjectsPermissions" DROP CONSTRAINT "ProjectsPermissions_permissionsId_fkey";
       public          postgres    false    301    4443    310            �           2606    40568 (   PunchRecords PunchRecords_punchInId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."PunchRecords"
    ADD CONSTRAINT "PunchRecords_punchInId_fkey" FOREIGN KEY ("punchInId") REFERENCES public."PunchIn"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 V   ALTER TABLE ONLY public."PunchRecords" DROP CONSTRAINT "PunchRecords_punchInId_fkey";
       public          postgres    false    316    4472    320            �           2606    40573 )   PunchRecords PunchRecords_punchOutId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."PunchRecords"
    ADD CONSTRAINT "PunchRecords_punchOutId_fkey" FOREIGN KEY ("punchOutId") REFERENCES public."PunchOut"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 W   ALTER TABLE ONLY public."PunchRecords" DROP CONSTRAINT "PunchRecords_punchOutId_fkey";
       public          postgres    false    316    321    4474            �           2606    40578 &   PunchRecords PunchRecords_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."PunchRecords"
    ADD CONSTRAINT "PunchRecords_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 T   ALTER TABLE ONLY public."PunchRecords" DROP CONSTRAINT "PunchRecords_staffId_fkey";
       public          postgres    false    4375    316    285            �           2606    40503 6   ReportPermissions ReportPermissions_permissionsId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ReportPermissions"
    ADD CONSTRAINT "ReportPermissions_permissionsId_fkey" FOREIGN KEY ("permissionsId") REFERENCES public."Permissions"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 d   ALTER TABLE ONLY public."ReportPermissions" DROP CONSTRAINT "ReportPermissions_permissionsId_fkey";
       public          postgres    false    4443    310    302            �           2606    40548 (   SalaryDetails SalaryDetails_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."SalaryDetails"
    ADD CONSTRAINT "SalaryDetails_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 V   ALTER TABLE ONLY public."SalaryDetails" DROP CONSTRAINT "SalaryDetails_staffId_fkey";
       public          postgres    false    285    311    4375            �           2606    40513 :   SettingsPermissions SettingsPermissions_permissionsId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."SettingsPermissions"
    ADD CONSTRAINT "SettingsPermissions_permissionsId_fkey" FOREIGN KEY ("permissionsId") REFERENCES public."Permissions"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 h   ALTER TABLE ONLY public."SettingsPermissions" DROP CONSTRAINT "SettingsPermissions_permissionsId_fkey";
       public          postgres    false    4443    310    304            �           2606    40433 D   StaffBackgroundVerification StaffBackgroundVerification_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."StaffBackgroundVerification"
    ADD CONSTRAINT "StaffBackgroundVerification_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 r   ALTER TABLE ONLY public."StaffBackgroundVerification" DROP CONSTRAINT "StaffBackgroundVerification_staffId_fkey";
       public          postgres    false    4375    289    285            �           2606    40418 '   StaffDetails StaffDetails_branchId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."StaffDetails"
    ADD CONSTRAINT "StaffDetails_branchId_fkey" FOREIGN KEY ("branchId") REFERENCES public."Branch"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 U   ALTER TABLE ONLY public."StaffDetails" DROP CONSTRAINT "StaffDetails_branchId_fkey";
       public          postgres    false    284    285    4373            �           2606    40403 +   StaffDetails StaffDetails_departmentId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."StaffDetails"
    ADD CONSTRAINT "StaffDetails_departmentId_fkey" FOREIGN KEY ("departmentId") REFERENCES public."Department"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 Y   ALTER TABLE ONLY public."StaffDetails" DROP CONSTRAINT "StaffDetails_departmentId_fkey";
       public          postgres    false    4378    286    285            �           2606    40408 %   StaffDetails StaffDetails_roleId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."StaffDetails"
    ADD CONSTRAINT "StaffDetails_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES public."Role"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 S   ALTER TABLE ONLY public."StaffDetails" DROP CONSTRAINT "StaffDetails_roleId_fkey";
       public          postgres    false    4410    299    285            �           2606    40413 %   StaffDetails StaffDetails_userId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."StaffDetails"
    ADD CONSTRAINT "StaffDetails_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 S   ALTER TABLE ONLY public."StaffDetails" DROP CONSTRAINT "StaffDetails_userId_fkey";
       public          postgres    false    285    4362    279            �           2606    40518 4   StaffPermissions StaffPermissions_permissionsId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."StaffPermissions"
    ADD CONSTRAINT "StaffPermissions_permissionsId_fkey" FOREIGN KEY ("permissionsId") REFERENCES public."Permissions"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 b   ALTER TABLE ONLY public."StaffPermissions" DROP CONSTRAINT "StaffPermissions_permissionsId_fkey";
       public          postgres    false    305    310    4443            �           2606    40508 <   StaffRolePermissions StaffRolePermissions_permissionsId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."StaffRolePermissions"
    ADD CONSTRAINT "StaffRolePermissions_permissionsId_fkey" FOREIGN KEY ("permissionsId") REFERENCES public."Permissions"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 j   ALTER TABLE ONLY public."StaffRolePermissions" DROP CONSTRAINT "StaffRolePermissions_permissionsId_fkey";
       public          postgres    false    4443    303    310            �           2606    40638 )   StartBreak StartBreak_punchRecordsId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."StartBreak"
    ADD CONSTRAINT "StartBreak_punchRecordsId_fkey" FOREIGN KEY ("punchRecordsId") REFERENCES public."PunchRecords"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 W   ALTER TABLE ONLY public."StartBreak" DROP CONSTRAINT "StartBreak_punchRecordsId_fkey";
       public          postgres    false    4458    322    316            �           2606    40633 "   StartBreak StartBreak_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."StartBreak"
    ADD CONSTRAINT "StartBreak_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 P   ALTER TABLE ONLY public."StartBreak" DROP CONSTRAINT "StartBreak_staffId_fkey";
       public          postgres    false    4375    285    322            �           2606    40528 8   SubTaskPermissions SubTaskPermissions_permissionsId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."SubTaskPermissions"
    ADD CONSTRAINT "SubTaskPermissions_permissionsId_fkey" FOREIGN KEY ("permissionsId") REFERENCES public."Permissions"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 f   ALTER TABLE ONLY public."SubTaskPermissions" DROP CONSTRAINT "SubTaskPermissions_permissionsId_fkey";
       public          postgres    false    307    4443    310            �           2606    40523 2   TaskPermissions TaskPermissions_permissionsId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."TaskPermissions"
    ADD CONSTRAINT "TaskPermissions_permissionsId_fkey" FOREIGN KEY ("permissionsId") REFERENCES public."Permissions"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 `   ALTER TABLE ONLY public."TaskPermissions" DROP CONSTRAINT "TaskPermissions_permissionsId_fkey";
       public          postgres    false    310    306    4443            �           2606    40658 1   TicketInformation TicketInformation_staffIdd_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."TicketInformation"
    ADD CONSTRAINT "TicketInformation_staffIdd_fkey" FOREIGN KEY ("staffIdd") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 _   ALTER TABLE ONLY public."TicketInformation" DROP CONSTRAINT "TicketInformation_staffIdd_fkey";
       public          postgres    false    329    285    4375            �           2606    40668 "   UpiDetails UpiDetails_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."UpiDetails"
    ADD CONSTRAINT "UpiDetails_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 P   ALTER TABLE ONLY public."UpiDetails" DROP CONSTRAINT "UpiDetails_staffId_fkey";
       public          postgres    false    332    4375    285            �           2606    40383 '   WorkEntry WorkEntry_staffDetailsId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."WorkEntry"
    ADD CONSTRAINT "WorkEntry_staffDetailsId_fkey" FOREIGN KEY ("staffDetailsId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 U   ALTER TABLE ONLY public."WorkEntry" DROP CONSTRAINT "WorkEntry_staffDetailsId_fkey";
       public          postgres    false    4375    280    285            �           2606    40723 .   _FixedShiftToShifts _FixedShiftToShifts_A_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."_FixedShiftToShifts"
    ADD CONSTRAINT "_FixedShiftToShifts_A_fkey" FOREIGN KEY ("A") REFERENCES public."FixedShift"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 \   ALTER TABLE ONLY public."_FixedShiftToShifts" DROP CONSTRAINT "_FixedShiftToShifts_A_fkey";
       public          postgres    false    4452    340    314                        2606    40728 .   _FixedShiftToShifts _FixedShiftToShifts_B_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."_FixedShiftToShifts"
    ADD CONSTRAINT "_FixedShiftToShifts_B_fkey" FOREIGN KEY ("B") REFERENCES public."Shifts"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 \   ALTER TABLE ONLY public."_FixedShiftToShifts" DROP CONSTRAINT "_FixedShiftToShifts_B_fkey";
       public          postgres    false    4448    340    312                       2606    40733 4   _FlexibleShiftToShifts _FlexibleShiftToShifts_A_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."_FlexibleShiftToShifts"
    ADD CONSTRAINT "_FlexibleShiftToShifts_A_fkey" FOREIGN KEY ("A") REFERENCES public."FlexibleShift"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 b   ALTER TABLE ONLY public."_FlexibleShiftToShifts" DROP CONSTRAINT "_FlexibleShiftToShifts_A_fkey";
       public          postgres    false    4455    315    341                       2606    40738 4   _FlexibleShiftToShifts _FlexibleShiftToShifts_B_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."_FlexibleShiftToShifts"
    ADD CONSTRAINT "_FlexibleShiftToShifts_B_fkey" FOREIGN KEY ("B") REFERENCES public."Shifts"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 b   ALTER TABLE ONLY public."_FlexibleShiftToShifts" DROP CONSTRAINT "_FlexibleShiftToShifts_B_fkey";
       public          postgres    false    341    312    4448                       2606    40743 "   _ProjectStaff _ProjectStaff_A_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."_ProjectStaff"
    ADD CONSTRAINT "_ProjectStaff_A_fkey" FOREIGN KEY ("A") REFERENCES public."Project"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 P   ALTER TABLE ONLY public."_ProjectStaff" DROP CONSTRAINT "_ProjectStaff_A_fkey";
       public          postgres    false    4490    328    342                       2606    40748 "   _ProjectStaff _ProjectStaff_B_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."_ProjectStaff"
    ADD CONSTRAINT "_ProjectStaff_B_fkey" FOREIGN KEY ("B") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 P   ALTER TABLE ONLY public."_ProjectStaff" DROP CONSTRAINT "_ProjectStaff_B_fkey";
       public          postgres    false    342    4375    285            �           2606    40693    _UserRooms _UserRooms_A_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."_UserRooms"
    ADD CONSTRAINT "_UserRooms_A_fkey" FOREIGN KEY ("A") REFERENCES public."ChatRoom"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 J   ALTER TABLE ONLY public."_UserRooms" DROP CONSTRAINT "_UserRooms_A_fkey";
       public          postgres    false    337    4366    281            �           2606    40698    _UserRooms _UserRooms_B_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."_UserRooms"
    ADD CONSTRAINT "_UserRooms_B_fkey" FOREIGN KEY ("B") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 J   ALTER TABLE ONLY public."_UserRooms" DROP CONSTRAINT "_UserRooms_B_fkey";
       public          postgres    false    279    4362    337            �           2606    40713 "   _departmentId _departmentId_A_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."_departmentId"
    ADD CONSTRAINT "_departmentId_A_fkey" FOREIGN KEY ("A") REFERENCES public."Department"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 P   ALTER TABLE ONLY public."_departmentId" DROP CONSTRAINT "_departmentId_A_fkey";
       public          postgres    false    4378    339    286            �           2606    40718 "   _departmentId _departmentId_B_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."_departmentId"
    ADD CONSTRAINT "_departmentId_B_fkey" FOREIGN KEY ("B") REFERENCES public."TaskDetail"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 P   ALTER TABLE ONLY public."_departmentId" DROP CONSTRAINT "_departmentId_B_fkey";
       public          postgres    false    326    4486    339                       2606    40753    _projectId _projectId_A_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."_projectId"
    ADD CONSTRAINT "_projectId_A_fkey" FOREIGN KEY ("A") REFERENCES public."Project"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 J   ALTER TABLE ONLY public."_projectId" DROP CONSTRAINT "_projectId_A_fkey";
       public          postgres    false    343    4490    328                       2606    40758    _projectId _projectId_B_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."_projectId"
    ADD CONSTRAINT "_projectId_B_fkey" FOREIGN KEY ("B") REFERENCES public."TaskDetail"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 J   ALTER TABLE ONLY public."_projectId" DROP CONSTRAINT "_projectId_B_fkey";
       public          postgres    false    326    343    4486            �           2606    40703    _staffId _staffId_A_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."_staffId"
    ADD CONSTRAINT "_staffId_A_fkey" FOREIGN KEY ("A") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 F   ALTER TABLE ONLY public."_staffId" DROP CONSTRAINT "_staffId_A_fkey";
       public          postgres    false    285    338    4375            �           2606    40708    _staffId _staffId_B_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."_staffId"
    ADD CONSTRAINT "_staffId_B_fkey" FOREIGN KEY ("B") REFERENCES public."TaskStatus"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 F   ALTER TABLE ONLY public."_staffId" DROP CONSTRAINT "_staffId_B_fkey";
       public          postgres    false    324    338    4482            �           2606    40588 '   breakRecord breakRecord_endBreakId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."breakRecord"
    ADD CONSTRAINT "breakRecord_endBreakId_fkey" FOREIGN KEY ("endBreakId") REFERENCES public."EndBreak"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 U   ALTER TABLE ONLY public."breakRecord" DROP CONSTRAINT "breakRecord_endBreakId_fkey";
       public          postgres    false    4479    323    317            �           2606    40593 *   breakRecord breakRecord_punchRecordId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."breakRecord"
    ADD CONSTRAINT "breakRecord_punchRecordId_fkey" FOREIGN KEY ("punchRecordId") REFERENCES public."PunchRecords"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 X   ALTER TABLE ONLY public."breakRecord" DROP CONSTRAINT "breakRecord_punchRecordId_fkey";
       public          postgres    false    317    316    4458            �           2606    40598 $   breakRecord breakRecord_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."breakRecord"
    ADD CONSTRAINT "breakRecord_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."StaffDetails"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 R   ALTER TABLE ONLY public."breakRecord" DROP CONSTRAINT "breakRecord_staffId_fkey";
       public          postgres    false    317    4375    285            �           2606    40583 )   breakRecord breakRecord_startBreakId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."breakRecord"
    ADD CONSTRAINT "breakRecord_startBreakId_fkey" FOREIGN KEY ("startBreakId") REFERENCES public."StartBreak"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 W   ALTER TABLE ONLY public."breakRecord" DROP CONSTRAINT "breakRecord_startBreakId_fkey";
       public          postgres    false    4476    317    322            �           2606    16566    objects objects_bucketId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);
 J   ALTER TABLE ONLY storage.objects DROP CONSTRAINT "objects_bucketId_fkey";
       storage          supabase_storage_admin    false    239    240    4272            �           2606    28983 8   s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);
 c   ALTER TABLE ONLY storage.s3_multipart_uploads DROP CONSTRAINT s3_multipart_uploads_bucket_id_fkey;
       storage          supabase_storage_admin    false    269    4272    239            �           2606    29003 D   s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);
 o   ALTER TABLE ONLY storage.s3_multipart_uploads_parts DROP CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey;
       storage          supabase_storage_admin    false    239    270    4272            �           2606    28998 D   s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;
 o   ALTER TABLE ONLY storage.s3_multipart_uploads_parts DROP CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey;
       storage          supabase_storage_admin    false    270    269    4347            �           0    16519    audit_log_entries    ROW SECURITY     =   ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;          auth          supabase_auth_admin    false    237            �           0    28867 
   flow_state    ROW SECURITY     6   ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;          auth          supabase_auth_admin    false    267            �           0    28664 
   identities    ROW SECURITY     6   ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;          auth          supabase_auth_admin    false    258            �           0    16512 	   instances    ROW SECURITY     5   ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;          auth          supabase_auth_admin    false    236            �           0    28754    mfa_amr_claims    ROW SECURITY     :   ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;          auth          supabase_auth_admin    false    262            �           0    28742    mfa_challenges    ROW SECURITY     :   ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;          auth          supabase_auth_admin    false    261            �           0    28729    mfa_factors    ROW SECURITY     7   ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;          auth          supabase_auth_admin    false    260            �           0    28917    one_time_tokens    ROW SECURITY     ;   ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;          auth          supabase_auth_admin    false    268            �           0    16501    refresh_tokens    ROW SECURITY     :   ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;          auth          supabase_auth_admin    false    235            �           0    28796    saml_providers    ROW SECURITY     :   ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;          auth          supabase_auth_admin    false    265            �           0    28814    saml_relay_states    ROW SECURITY     =   ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;          auth          supabase_auth_admin    false    266            �           0    16527    schema_migrations    ROW SECURITY     =   ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;          auth          supabase_auth_admin    false    238            �           0    28694    sessions    ROW SECURITY     4   ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;          auth          supabase_auth_admin    false    259            �           0    28781    sso_domains    ROW SECURITY     7   ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;          auth          supabase_auth_admin    false    264            �           0    28772    sso_providers    ROW SECURITY     9   ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;          auth          supabase_auth_admin    false    263            �           0    16489    users    ROW SECURITY     1   ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;          auth          supabase_auth_admin    false    233            �           0    29192    messages    ROW SECURITY     8   ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;          realtime          supabase_realtime_admin    false    277            �           0    16540    buckets    ROW SECURITY     6   ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;          storage          supabase_storage_admin    false    239            �           0    16582 
   migrations    ROW SECURITY     9   ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;          storage          supabase_storage_admin    false    241            �           0    16555    objects    ROW SECURITY     6   ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;          storage          supabase_storage_admin    false    240            �           0    28974    s3_multipart_uploads    ROW SECURITY     C   ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;          storage          supabase_storage_admin    false    269            �           0    28988    s3_multipart_uploads_parts    ROW SECURITY     I   ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;          storage          supabase_storage_admin    false    270            �           6104    16420    supabase_realtime    PUBLICATION     Z   CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');
 $   DROP PUBLICATION supabase_realtime;
                postgres    false            �
           826    16597     DEFAULT PRIVILEGES FOR SEQUENCES    DEFAULT ACL     �   ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;
          auth          supabase_auth_admin    false    16            �
           826    16598     DEFAULT PRIVILEGES FOR FUNCTIONS    DEFAULT ACL     �   ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;
          auth          supabase_auth_admin    false    16            �
           826    16596    DEFAULT PRIVILEGES FOR TABLES    DEFAULT ACL     �   ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;
          auth          supabase_auth_admin    false    16            �
           826    16980     DEFAULT PRIVILEGES FOR SEQUENCES    DEFAULT ACL     |   ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;
       
   extensions          supabase_admin    false    14            �
           826    16979     DEFAULT PRIVILEGES FOR FUNCTIONS    DEFAULT ACL     |   ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;
       
   extensions          supabase_admin    false    14            �
           826    16978    DEFAULT PRIVILEGES FOR TABLES    DEFAULT ACL     y   ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;
       
   extensions          supabase_admin    false    14            �
           826    16631     DEFAULT PRIVILEGES FOR SEQUENCES    DEFAULT ACL     �  ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;
          graphql          supabase_admin    false    21            �
           826    16630     DEFAULT PRIVILEGES FOR FUNCTIONS    DEFAULT ACL     �  ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;
          graphql          supabase_admin    false    21            �
           826    16629    DEFAULT PRIVILEGES FOR TABLES    DEFAULT ACL     �  ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;
          graphql          supabase_admin    false    21            �
           826    16611     DEFAULT PRIVILEGES FOR SEQUENCES    DEFAULT ACL     �  ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;
          graphql_public          supabase_admin    false    20            �
           826    16610     DEFAULT PRIVILEGES FOR FUNCTIONS    DEFAULT ACL     �  ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;
          graphql_public          supabase_admin    false    20            �
           826    16609    DEFAULT PRIVILEGES FOR TABLES    DEFAULT ACL     �  ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;
          graphql_public          supabase_admin    false    20            �
           826    16839     DEFAULT PRIVILEGES FOR SEQUENCES    DEFAULT ACL     r   ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT ALL ON SEQUENCES TO pgsodium_keyholder;
          pgsodium          supabase_admin    false    17            �
           826    16838    DEFAULT PRIVILEGES FOR TABLES    DEFAULT ACL     o   ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT ALL ON TABLES TO pgsodium_keyholder;
          pgsodium          supabase_admin    false    17            �
           826    16836     DEFAULT PRIVILEGES FOR SEQUENCES    DEFAULT ACL     x   ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON SEQUENCES TO pgsodium_keyiduser;
          pgsodium_masks          supabase_admin    false    6            �
           826    16837     DEFAULT PRIVILEGES FOR FUNCTIONS    DEFAULT ACL     x   ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON FUNCTIONS TO pgsodium_keyiduser;
          pgsodium_masks          supabase_admin    false    6            �
           826    16835    DEFAULT PRIVILEGES FOR TABLES    DEFAULT ACL     u   ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON TABLES TO pgsodium_keyiduser;
          pgsodium_masks          supabase_admin    false    6            �
           826    16601     DEFAULT PRIVILEGES FOR SEQUENCES    DEFAULT ACL     �   ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;
          realtime          supabase_admin    false    13            �
           826    16602     DEFAULT PRIVILEGES FOR FUNCTIONS    DEFAULT ACL     �   ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;
          realtime          supabase_admin    false    13            �
           826    16600    DEFAULT PRIVILEGES FOR TABLES    DEFAULT ACL     �   ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;
          realtime          supabase_admin    false    13            �
           826    16539     DEFAULT PRIVILEGES FOR SEQUENCES    DEFAULT ACL     �  ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;
          storage          postgres    false    15            �
           826    16538     DEFAULT PRIVILEGES FOR FUNCTIONS    DEFAULT ACL     �  ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;
          storage          postgres    false    15            �
           826    16537    DEFAULT PRIVILEGES FOR TABLES    DEFAULT ACL     }  ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;
          storage          postgres    false    15            �           3466    16615    issue_graphql_placeholder    EVENT TRIGGER     �   CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();
 .   DROP EVENT TRIGGER issue_graphql_placeholder;
                supabase_admin    false    556            �           3466    16993    issue_pg_cron_access    EVENT TRIGGER     �   CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();
 )   DROP EVENT TRIGGER issue_pg_cron_access;
                supabase_admin    false    564            �           3466    16613    issue_pg_graphql_access    EVENT TRIGGER     �   CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();
 ,   DROP EVENT TRIGGER issue_pg_graphql_access;
                supabase_admin    false    384            �           3466    16594    issue_pg_net_access    EVENT TRIGGER     �   CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();
 (   DROP EVENT TRIGGER issue_pg_net_access;
                postgres    false    555            �           3466    16616    pgrst_ddl_watch    EVENT TRIGGER     j   CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();
 $   DROP EVENT TRIGGER pgrst_ddl_watch;
                supabase_admin    false    554            �           3466    16617    pgrst_drop_watch    EVENT TRIGGER     e   CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();
 %   DROP EVENT TRIGGER pgrst_drop_watch;
                supabase_admin    false    382            �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   L  x�U�ɕ1�{�G�%��?�)Z��}��,�F�����7=��`N�����ML"Zb��)�e�_S<��䋮[N��i�v�Nv8�M�Dn����~�X�[ܡ�F�Ɠ�H���S� �v^Zp�_�W��͆��/*�Z�;rUk��d�9^�æ��#��`���i;/��p�����[�S��5�C�qf�D��͹���Վ�TsF},:�./������7�p�9�U�"QSP�C홆M�D�&hZ��w7�������Î��w^�AŏZu���"�sS��ܻZ��TS|Q��{_;�EЪ<8{>�4�Cծ����������      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �            x������ � �      �      x������ � �      �      x������ � �            x������ � �      �      x������ � �            x������ � �      �      x������ � �            x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �             x������ � �      �      x������ � �            x������ � �            x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �            x������ � �            x������ � �      �      x������ � �      �      x������ � �      �      x������ � �            x������ � �            x������ � �            x������ � �      	      x������ � �            x������ � �      �   �  x���KnT1E�ݫ`��T_ەE��H�r��P� ��� 	,�\���ǒ<GQ�Zib�G���X�=`j�,���i�T�v�QshMk3+���vm*�9fý<�<����������#��������.��u?�_.�>��ů�_��9�n?=�yz�?��gNbneV�"�E�X�4��d?��L����[ K|�S�H���͘4��fE����&�o[�DQ��Q�CU��3�X��y��"�P|�(���X�i�/�=1��A6�7�\�N0c@���h��Y�dt�w\)�s�W`P�.w׻��W<�ۃ-c-U�Y<Kos+r3����ԓ7R,3��Q��A1��`O!F�}Ug߂���.�� �_� ������ړp}y�y�����]��|{��.��~T�,/_��8�Ͽո�            x������ � �      
      x������ � �      �      x������ � �      �   �  x�u�Qn�0D��S�]�CҒ|���9v��b��	�f43��)����R�������ˁ�bo$d�B⁨;
��G�0�	y f�'2����@n-��po2nĥ��vh\���|�=zS i�O�j��S��2�b����B��ۉ���p
Z c!F��ݷ�@kr��Tds��?�[�g"3#ߊI$�4jfV`�eH׆�w��%�2�yuh{Yg�:X:R�a ��Dk�n��Y,/��H��͋�=��tPK��D8�]��/�����BX�_��)|Y{�F6��{��n�y߭�ܣ�0�(�`�G>����mI1��X���0!�b����(�"�8��^�����*���#��>���,���{���ݝH���NI_:�;��T���hpIN�}�-��F
-��c�ƴ�Dz"\��3�EfW���[��/��Ȍ�y��D������T�      �      x������ � �      �      x������ � �      �   �  x�mVI��6]S��� ��ϒ�_ 	�+��l���>��C*�F^��@>�A��Me���n�.��}^��)�^C�u%iBwD��V!,�G@<#�T������[��O��.r�����pTȵ^MH��!�RC=������ q"w_/79�|ozZ*1�n3GS� �pG��[I	k)��Zb~��*��z���]����Q�X�k�T��PAJB�ծ\�]X�1z��I��f�v�;��B�~(6�8�YZ��Q��IB���L����/�<��w�(d���Raa���sE��F�}�B��]�����ba>�I��<t}�s�x#VF1�7hҌ�z�@���?�#�)=Oo\��e���Y׻3;\�^[0�2<c��
v�M0���h:�����ǥ�{�h���h�a�J�J7�R o
�R�.6.1Mō��|W���_�;/ ��`R��(؜�-!)V՘)�"���	���]�z�ߌ�{C�D]���L4Qy�#f�uF��d�ߨYo�ᠷ�y��q��_?�]֟�OL���l:�h��s������&B�3c������:���,_�1w]�y�y��R��<0�(܂G/5����reP
�m�zm{n��|\N���5��(0���^Ă�r�f��c�J��}'Fք�w���ն3.��$�^n(���z��d�ʈ��%�y.1w�hs��e�&g3�]o�|�E�P�
k�Y7�0XoY��Y�ǘJ�}��B�ʄ�9���d�]���.���h�S.��ɷ"�]�b�����r�/_�&)�E��y�����V+�<,�m��5��Ö� V(��oV�A�7@6�'|���	�����0߻^o�L��7n�Kk��uS��4�jԼm�VP�Ƹ?*%(f�����y����c�y�Ȃ�HR�dvK
���7ÊK��v ���O��D���}��uY?l�S�v�֣��&�B�*�� $kZ�&���L�Bޓ�D�t"tw?��
�ULH���"��̷��%X'0����:�'
vt��rM{un�b�ޥ]�.ӭ9�$oB��;���ֽ���h�RsU�\�>G6�R�Ȼ�u5F�����'����5X��%b��K���5��v�y�2����7����wjFy����Q$�.���ۛ�[=���-���IW�4g�_��Y�����f��F�frP��H��}>B��+��|����'�      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �     