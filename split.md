# Split

Used to break a large file into multiple small files.  For example you have a file with 10 Million lines.

<pre>
split -l 1000000 --numeric-suffixes planes00001 plns
</pre>

Creates 10 files with 1 Million lines each.  Files would be plns00 to plans09.


<pre>
split -l 100000 -a 4 -d planes00001 splns
</pre>

Creates files with 100,000 lines each named splns0000 to splns0099.  The -a option make the numeric part four digits the -d is the same as --numeric-suffixes.


