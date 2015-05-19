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
