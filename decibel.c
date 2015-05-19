#include "postgres.h"
#include <string.h>
#include "fmgr.h"
#include "utils/geo_decls.h"
#include "utils/formatting.h"

#ifdef PG_MODULE_MAGIC
PG_MODULE_MAGIC;
#endif

typedef float8 decibel_t;

#define DecibelGetDatum(x) Float8GetDatum(x)
#define DatumGetDecibel(x) DatumGetFloat8(x)
#define PG_GETARG_DECIBEL(n) DatumGetDecibel(PG_GETARG_DATUM(n))
#define PG_RETURN_DECIBEL(x) return DecibelGetDatum(x)

Datum decibelpascal(PG_FUNCTION_ARGS);
Datum pascaldecibel(PG_FUNCTION_ARGS);
Datum decibel_in(PG_FUNCTION_ARGS);
Datum decibel_out(PG_FUNCTION_ARGS);


/* by value */

PG_FUNCTION_INFO_V1(decibelpascal);

Datum
decibelpascal(PG_FUNCTION_ARGS)
{
    float8   arg = PG_GETARG_FLOAT8(0);
    PG_RETURN_FLOAT8( pow( 10, arg / 10.0 ));
}

PG_FUNCTION_INFO_V1(pascaldecibel);

Datum
pascaldecibel(PG_FUNCTION_ARGS)
{
    float8   arg = PG_GETARG_FLOAT8(0);
    PG_RETURN_FLOAT8( 10 * log10(arg) );
}


PG_FUNCTION_INFO_V1(decibel_in);
Datum
decibel_in(PG_FUNCTION_ARGS)
{
  char val_str = PG_GETARG_CSTRING(0);
# Convert val_str to a float8 inval
  PG_RETURN_DECIBEL( pow( 10, inval / 10.0) );
}

PG_FUNCTION_INFO_V1(decibel_out);
Datum
decibel_out(PG_FUNCTION_ARGS)
{
  decibel_t val_pascal = PG_GETARG_DECIBEL(0);
  decibel_t val_decibel = 10 * log10(val_pascal);
# convert val_decibel to cstring outval
  PG_RETURN_CSTRING(outval);
}

