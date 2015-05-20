
\echo Use "CREATE EXTENSION decibel" to load this file. \quit


CREATE TYPE decibel;

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
CREATE OR REPLACE FUNCTION decibel(numeric) RETURNS decibel AS 'SELECT $1::text::decibel' LANGUAGE SQL IMMUTABLE STRICT COST 1;


CREATE CAST (decibel AS float8) WITHOUT FUNCTION AS IMPLICIT;
CREATE CAST (float8 AS decibel) WITH FUNCTION decibel(float8) AS IMPLICIT;
CREATE CAST (float4 AS decibel) WITH FUNCTION decibel(float4) AS IMPLICIT;
CREATE CAST (int2 AS decibel) WITH FUNCTION decibel(int2) AS IMPLICIT;
CREATE CAST (int4 AS decibel) WITH FUNCTION decibel(int4) AS IMPLICIT;
CREATE CAST (int8 AS decibel) WITH FUNCTION decibel(int8) AS IMPLICIT;
CREATE CAST (numeric AS decibel) WITH FUNCTION decibel(numeric) AS IMPLICIT;

CREATE FUNCTION decibel_sum(decibel,decibel) RETURNS decibel AS 'float8pl' LANGUAGE INTERNAL IMMUTABLE STRICT;
CREATE FUNCTION decibel_div(decibel,float8) RETURNS decibel AS 'float8div' LANGUAGE INTERNAL IMMUTABLE STRICT;
CREATE FUNCTION decibel_mul(decibel,float8) RETURNS decibel AS 'float8mul' LANGUAGE INTERNAL IMMUTABLE STRICT;
CREATE FUNCTION decibel_mi(decibel,decibel) RETURNS decibel AS 'float8mi' LANGUAGE INTERNAL IMMUTABLE STRICT;

CREATE OPERATOR + ( PROCEDURE = decibel_sum, LEFTARG=decibel, RIGHTARG=decibel );
CREATE OPERATOR / ( PROCEDURE = decibel_div, LEFTARG=decibel, RIGHTARG=float8 );
CREATE OPERATOR * ( PROCEDURE = decibel_mul, LEFTARG=decibel, RIGHTARG=float8 );
CREATE OPERATOR - ( PROCEDURE = decibel_mi, LEFTARG=decibel, RIGHTARG=decibel );

CREATE AGGREGATE sum(decibel) ( sfunc = float8pl, stype = float8 );
CREATE AGGREGATE avg(decibel) ( sfunc = float8_accum, stype = float8[], finalfunc=float8_avg, initcond='{0,0,0}' );
