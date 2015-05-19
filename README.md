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
