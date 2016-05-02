pgDecibel
=========

PostgreSQL type to store and work with data in double precision pascals while representing and in/out in decibels.


<pre>
postgres=# CREATE EXTENSION decibel;
CREATE EXTENSION
postgres=# SELECT 65.23::decibel;
 decibel 
───────────
 65.23
(1 row)
</pre>

Build
==========

As long as pg_config is on the path (utility installed with PostgreSQL that should be on the system, if not, might need postgresql-dev or something) running this in the directory should build and install the extension on the system:
<pre>
make clean; make; sudo make install;
</pre>
From there you need to actually add it to the macnoms database by going into the database and running:
<pre>
CREATE EXTENSION decibel;
</pre>
If you want to get rid of it (or ditch it, then upgrade it) you can run DROP EXTENSION decibel; This will only work if you get rid of any tables with decibel columns. DROP EXTENSION decibel CASCADE; will remove any columns or other objects using the extension.
