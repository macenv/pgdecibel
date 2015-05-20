/* contrib/citext/citext--1.0.sql */

-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION citext" to load this file. \quit

--
--  PostgreSQL code for CITEXT.
--
-- Most I/O functions, and a few others, piggyback on the "text" type
-- functions via the implicit cast to text.
--

--
-- Shell type to keep things a bit quieter.
--

CREATE TYPE decibel;

--
--  Input and output functions.
--
CREATE FUNCTION decibelpascal(float8)
RETURNS float8
AS 'MODULE_PATHNAME'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION pascaldecibel(float8)
RETURNS float8
AS 'MODULE_PATHNAME'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION decibel_in(cstring)
RETURNS decibel
AS 'MODULE_PATHNAME'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION decibel_out(decibel)
RETURNS cstring
AS 'MODULE_PATHNAME'
LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE decibel (
    INPUT          = decibel_in,
    OUTPUT         = decibel_out,
    LIKE = pg_catalog.float8
);


CREATE OR REPLACE FUNCTION decibel(float8) RETURNS decibel AS 'SELECT $1::text::decibel' LANGUAGE SQL IMMUTABLE STRICT COST 1;
CREATE OR REPLACE FUNCTION decibel(float4) RETURNS decibel AS 'SELECT $1::text::decibel' LANGUAGE SQL IMMUTABLE STRICT COST 1;
CREATE OR REPLACE FUNCTION decibel(int2) RETURNS decibel AS 'SELECT $1::text::decibel' LANGUAGE SQL IMMUTABLE STRICT COST 1;
CREATE OR REPLACE FUNCTION decibel(int4) RETURNS decibel AS 'SELECT $1::text::decibel' LANGUAGE SQL IMMUTABLE STRICT COST 1;
CREATE OR REPLACE FUNCTION decibel(int8) RETURNS decibel AS 'SELECT $1::text::decibel' LANGUAGE SQL IMMUTABLE STRICT COST 1;

CREATE CAST (float8 AS decibel) WITH FUNCTION decibel(float8) AS IMPLICIT;
CREATE CAST (float4 AS decibel) WITH FUNCTION decibel(float4) AS IMPLICIT;
CREATE CAST (int2 AS decibel) WITH FUNCTION decibel(int2) AS IMPLICIT;
CREATE CAST (int4 AS decibel) WITH FUNCTION decibel(int4) AS IMPLICIT;
CREATE CAST (int8 AS decibel) WITH FUNCTION decibel(int8) AS IMPLICIT;

CREATE FUNCTION decibel_sum(decibel,decibel) RETURNS decibel AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION decibel_div(decibel,decibel) RETURNS decibel AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION decibel_mul(decibel,decibel) RETURNS decibel AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION decibel_mi(decibel,decibel) RETURNS decibel AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

CREATE OPERATOR + ( PROCEDURE = decibel_sum, LEFTARG=decibel, RIGHTARG=decibel );
CREATE OPERATOR / ( PROCEDURE = decibel_div, LEFTARG=decibel, RIGHTARG=decibel );
CREATE OPERATOR * ( PROCEDURE = decibel_mul, LEFTARG=decibel, RIGHTARG=decibel );
CREATE OPERATOR - ( PROCEDURE = decibel_mi, LEFTARG=decibel, RIGHTARG=decibel );

CREATE AGGREGATE sum(decibel) ( sfunc = decibel_sum, stype = decibel );
