# Split

Used to break a large file into multiple small files.  For example you have a file with 10 Million lines.


## Split Million Line Files
<pre>
split -l 1000000 --numeric-suffixes planes00001 plns
</pre>

Creates 10 files with 1 Million lines each.  Files would be plns00 to plans09.

## Split 100 Thousand Line Files; 4 digit number
<pre>
split -l 100000 -a 4 -d planes00001 splns
</pre>

Creates files with 100,000 lines each named splns0000 to splns0099.  The -a option make the numeric part four digits the -d is the same as --numeric-suffixes.


## Split 200 Thousand Line Files; 4 digit number; Suffix .json

<pre>
split -l 200000 -a 4 -d --additional-suffix=.json planes00001.json splns
</pre>

Creates files with 200,000 lines each named splns0000.json to splns0049.json. 

