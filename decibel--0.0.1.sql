-- Only allow this SQL to be run by loading as an extension.
\echo Use "CREATE EXTENSION decibel" to load this file. \quit

-- Base type required empty definition
CREATE TYPE decibel;

-- C functions for converting between decibels and pascals
CREATE FUNCTION decibelpascal(float8)  RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION pascaldecibel(float8)  RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION       pascals(decibel) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- C functions for converting to and from cstring using the log math to do the appropriate backend conversion
CREATE FUNCTION decibel_in(cstring)  RETURNS decibel AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION decibel_out(decibel) RETURNS cstring AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- Actual definition of the decibel type
CREATE TYPE decibel ( INPUT = decibel_in, OUTPUT = decibel_out, LIKE = pg_catalog.float8 );

-- Functions used for the casts. All these just pass through the text representation to convert
CREATE OR REPLACE FUNCTION decibel(float8)  RETURNS decibel AS 'SELECT $1::text::decibel' LANGUAGE SQL IMMUTABLE STRICT COST 1;
CREATE OR REPLACE FUNCTION decibel(float4)  RETURNS decibel AS 'SELECT $1::text::decibel' LANGUAGE SQL IMMUTABLE STRICT COST 1;
CREATE OR REPLACE FUNCTION decibel(int2)    RETURNS decibel AS 'SELECT $1::text::decibel' LANGUAGE SQL IMMUTABLE STRICT COST 1;
CREATE OR REPLACE FUNCTION decibel(int4)    RETURNS decibel AS 'SELECT $1::text::decibel' LANGUAGE SQL IMMUTABLE STRICT COST 1;
CREATE OR REPLACE FUNCTION decibel(int8)    RETURNS decibel AS 'SELECT $1::text::decibel' LANGUAGE SQL IMMUTABLE STRICT COST 1;
CREATE OR REPLACE FUNCTION decibel(numeric) RETURNS decibel AS 'SELECT $1::text::decibel' LANGUAGE SQL IMMUTABLE STRICT COST 1;
CREATE OR REPLACE FUNCTION float8(decibel)  RETURNS float8  AS 'SELECT $1::text::float8'  LANGUAGE SQL IMMUTABLE STRICT COST 1;
CREATE OR REPLACE FUNCTION num(decibel)     RETURNS numeric AS 'SELECT $1::text::numeric' LANGUAGE SQL IMMUTABLE STRICT COST 1;

-- Casts
CREATE CAST (float8 AS decibel)  WITH FUNCTION decibel(float8)  AS IMPLICIT;
CREATE CAST (float4 AS decibel)  WITH FUNCTION decibel(float4)  AS IMPLICIT;
CREATE CAST (int2 AS decibel)    WITH FUNCTION decibel(int2)    AS IMPLICIT;
CREATE CAST (int4 AS decibel)    WITH FUNCTION decibel(int4)    AS IMPLICIT;
CREATE CAST (int8 AS decibel)    WITH FUNCTION decibel(int8)    AS IMPLICIT;
CREATE CAST (numeric AS decibel) WITH FUNCTION decibel(numeric) AS IMPLICIT;
CREATE CAST (decibel AS numeric) WITH FUNCTION num(decibel)     AS IMPLICIT;
CREATE CAST (decibel AS float8)  WITH FUNCTION float8(decibel)  AS IMPLICIT;


-- Functions used to back the operators
CREATE FUNCTION decibel_sum(decibel,decibel) RETURNS decibel AS 'float8pl'  LANGUAGE INTERNAL IMMUTABLE STRICT;
CREATE FUNCTION decibel_mi(decibel,decibel)  RETURNS decibel AS 'float8mi'  LANGUAGE INTERNAL IMMUTABLE STRICT;

CREATE FUNCTION decibel_div(decibel,float8)  RETURNS decibel AS 'float8div' LANGUAGE INTERNAL IMMUTABLE STRICT;
CREATE FUNCTION decibel_mul(decibel,float8)  RETURNS decibel AS 'float8mul' LANGUAGE INTERNAL IMMUTABLE STRICT;

CREATE FUNCTION decibel_mi(decibel,float8)   RETURNS decibel AS 'SELECT ($1::text::float8 - $2)::decibel'  LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION decibel_sum(decibel,float8)  RETURNS decibel AS 'SELECT ($1::text::float8 + $2)::decibel'  LANGUAGE SQL IMMUTABLE STRICT;

CREATE FUNCTION decibel_eq(decibel,decibel) RETURNS boolean AS 'float8eq' LANGUAGE INTERNAL IMMUTABLE STRICT;
CREATE FUNCTION decibel_ge(decibel,decibel) RETURNS boolean AS 'float8ge' LANGUAGE INTERNAL IMMUTABLE STRICT;
CREATE FUNCTION decibel_gt(decibel,decibel) RETURNS boolean AS 'float8gt' LANGUAGE INTERNAL IMMUTABLE STRICT;
CREATE FUNCTION decibel_le(decibel,decibel) RETURNS boolean AS 'float8le' LANGUAGE INTERNAL IMMUTABLE STRICT;
CREATE FUNCTION decibel_lt(decibel,decibel) RETURNS boolean AS 'float8lt' LANGUAGE INTERNAL IMMUTABLE STRICT;
CREATE FUNCTION decibel_ne(decibel,decibel) RETURNS boolean AS 'float8ne' LANGUAGE INTERNAL IMMUTABLE STRICT;



-- Operator definitions
CREATE OPERATOR +  ( PROCEDURE = decibel_sum, LEFTARG=decibel, RIGHTARG=decibel );
CREATE OPERATOR +  ( PROCEDURE = decibel_sum, LEFTARG=decibel, RIGHTARG=float8  ); -- used in case of 65::decibel + 10.0 = 75 decibels
CREATE OPERATOR /  ( PROCEDURE = decibel_div, LEFTARG=decibel, RIGHTARG=float8  );
CREATE OPERATOR *  ( PROCEDURE = decibel_mul, LEFTARG=decibel, RIGHTARG=float8  );
CREATE OPERATOR -  ( PROCEDURE = decibel_mi,  LEFTARG=decibel, RIGHTARG=decibel );
CREATE OPERATOR -  ( PROCEDURE = decibel_mi,  LEFTARG=decibel, RIGHTARG=float8  ); -- used in case of 65::decibel - 10.0 = 55 decibels
CREATE OPERATOR =  ( PROCEDURE = decibel_eq,  LEFTARG=decibel, RIGHTARG=decibel );
CREATE OPERATOR <  ( PROCEDURE = decibel_lt,  LEFTARG=decibel, RIGHTARG=decibel );
CREATE OPERATOR <= ( PROCEDURE = decibel_le,  LEFTARG=decibel, RIGHTARG=decibel );
CREATE OPERATOR >  ( PROCEDURE = decibel_gt,  LEFTARG=decibel, RIGHTARG=decibel );
CREATE OPERATOR >= ( PROCEDURE = decibel_ge,  LEFTARG=decibel, RIGHTARG=decibel );
CREATE OPERATOR != ( PROCEDURE = decibel_ne,  LEFTARG=decibel, RIGHTARG=decibel );


-- Functions used for min/max aggregates
CREATE FUNCTION decibel_smaller(decibel,decibel) RETURNS decibel AS 'float8smaller' LANGUAGE INTERNAL IMMUTABLE STRICT;
CREATE FUNCTION decibel_larger(decibel,decibel)  RETURNS decibel AS 'float8larger'  LANGUAGE INTERNAL IMMUTABLE STRICT;

-- Functiond used for avg aggregate
CREATE FUNCTION decibel_accum(decibel[],decibel) RETURNS decibel[] AS 'float8_accum' LANGUAGE INTERNAL IMMUTABLE STRICT;
CREATE FUNCTION decibel_avg(decibel[]) RETURNS decibel AS 'float8_avg' LANGUAGE INTERNAL IMMUTABLE STRICT;

-- Aggregate Functions
CREATE AGGREGATE sum(decibel) ( sfunc = decibel_sum, stype = decibel );
CREATE AGGREGATE avg(decibel) ( sfunc = decibel_accum, stype = decibel[], finalfunc=decibel_avg, initcond='{0,0,0}' );
CREATE AGGREGATE max(decibel) ( sfunc = decibel_larger,  stype=decibel );
CREATE AGGREGATE min(decibel) ( sfunc = decibel_smaller, stype=decibel );
--*/
