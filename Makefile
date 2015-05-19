# contrib/decibel/Makefile

MODULES = decibel

EXTENSION = decibel
DATA = decibel--0.0.1.sql

REGRESS = decibel


PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)