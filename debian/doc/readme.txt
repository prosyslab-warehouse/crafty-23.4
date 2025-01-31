Crafty version 17.5

-----------------------------------------------------------------------------
What's new?

Majority/candidate passer code rewritten.  Now just a few lines using
pre-computed bitmaps...  Fixes a couple of ugly bugs...

"white"/"black" commands in succession could cause problems in
xboard/winboard.  This was fixed.  The "bk" command to get a hint
for the next book move now works as well.

A new book format means old book.bin files won't work with version 17.0.
There are .bin files in the v17 directory that I use on ICC.  There are
now three, book.bin (same as always), books.bin (start book for non-
computers) and bookc.bin (start book for computers).  A new "bookc create"
command can be used to make this latter file.  If you don't have one, the
normal books.bin file will be used.

More details on new commands are in crafty.doc and in the source file
main.c

-----------------------------------------------------------------------------
The Crafty mailing list

Specific questions can be directed to majordomo@cis.uab.edu, and in the
body of this email, put the text "subscribe crafty-list" (without the
quotes) which will subscribe to the crafty-list@cis.uab.edu mailing list, 
which covers lots of questions about the current goings-on in crafty, from
problems, to installation questions, to future development goals.

-----------------------------------------------------------------------------
How does Crafty work?

Download the file "crafty.doc" which is a complete description of all of
the commands for Crafty along with examples where needed.  This covers
*every* command in the current version of Crafty.

-----------------------------------------------------------------------------
executable choices.

wcrafty-*.exe is the executable you need to run crafty under
windows, or under windows in a dos box.  

if you want tablebase support the standard executables provide this,
but you must add egtb to the crafty.rc/.craftyrc file.  

The Macintosh port of Crafty is available in the macintosh directory.

-----------------------------------------------------------------------------
book database choices.

All of these book choices are in the common directory.  Each book has its
own sub-directory so that you can cd into the appropriate directory and then
"mget *" to get everything you need.

large.zip, medium.zip and small.zip are the raw input files to make the three
different sized books.  large produces a 60mb opening database with 100K GM
games; medium produces a 30MB database, and small will produce a 1MB database.
On my sparc-20, large takes about 7 minutes to build, medium around 3 minutes,
and small is under minute.  Note that you will need at least double this space
to create the files, as temporary stuff is written to disk along the way, and
then deleted later.

There are two new files available, "rock.pgn" and "wall.pgn".  These files
are still .gz compressed archives, but because they are so large (rock.pgn
has over 660,000 games in it) they are broken into pieces.  These pieces
must be combined before they are unzipped.  In windows, use a dos box and
enter this:  copy rock.01+rock.02+...+rock.10 rock.gz.  Then ungzip rock.gz
and you should be set.  "wall" is about one-third the size of "rock" if you
want something smaller.

There is a newer book, called 'enormous' that can be downloaded in
pieces (this from Dan's FTP site).  The pieces are a,b,c,d,e and
correspond to ECO classifications.  Altogether this is roughly one
gigabyte after it unzipped, which can make a truly huge book if you
are not careful.

Note that small.txt was made from opening textbooks, and, as a result,
does not have the PGN "Result" tag.  This causes some book random modes
to not work correctly because crafty won't play an opening that has no
wins to its credit.  Either don't use small for the present, or else make
your own from a select group of pgn games, maybe the first 5000 games from
medium.zip as an example.  (for more specific info, see crafty.doc)

crafty
book create <filename> 60 3
quit

<filename> should be replaced by what you get when you unzip the book file
of your choice.

start.zip contains a small file that is used to create books.bin.
books.bin is created as follows:

crafty
books create start.pgn 60
quit

this file contains suggested openings that fit Crafty's "open" style of
play better.  You can edit/modify this at will, and it takes a fraction of
a second to re-build after modification, so the big book file can be left 
alone.  

Note that the "60" is arbitrary, and is used to cut book lines off at roughly
60 plies.  you "can" say 500, so that the entire games will be stored, but you
need even more disk space.  you can also reduce this number to 30 (15 moves for
each side to conserve disk space as needed, since the book will contain far
fewer positions.

Note that you can also look in the current directory (v15 at present) and
you will find a book.bin and books.bin file already built from rock.pgn
and ready to use.  These are under 10mb together and are ready to use.
You only have to put them in the same directory with crafty and you will
be set to play.

-----------------------------------------------------------------------------
crafty.zip is a zip file that contains a complete set of source and
header files for crafty and a Linux makefile that you will have to tweak for
your machine.  ditto for crafty.tar.gz just using gzip and tar instead for
those that don't have plain zip.

Note that you probably need only change the #define LINUX to #define SUN
for example, and it will self-configure for SUN. Any of the machines in
the comments can be done like this.  others may take some playing, but the
options are commented to help.

If you are using gcc/Linux, the included Makefile should fit your needs
perfectly, since linux uses gcc.  NOTICE:  if you are running linux, and
have a gcc earlier than 2.6.3, crafty probably will compile cleanly but
won't run.  Early versions seem to have a defective implementation of the
long long data type, which breaks crafty completely.  Note that there is
a linux version of crafty (crafty.linux) here compiled with gcc-i 2.6.3, if
you have this problem.  You will get an error when you start it, about the
wrong version of ld.so.n, but it seems to run correctly.  Note also, that
I use gcc-i2.6.3, the pentium-specific version of gcc that is kept on
most linux archive sites in the development directory.  If you are
not using this, you will have to modify CFLAGS to get rid of the pentium
optimization options and simply use -On where n=the level that produces
the fastest code (you'll have to try several to find the best usually.)

-----------------------------------------------------------------------------
It is highly recommended that you use the latest version of Xboard
or Winboard from Tim Mann.  

   http://www.research.digital.com/SRC/personal/Tim_Mann/chess.html

To use Crafty with xboard, you do the following:

xboard -fcp crafty 

This will let you play using the mouse, etc.

To set the time control, try this:

xboard -fcp crafty -tc nm -mps mvs

replace nm by the number of minutes in the time control you'd like to
play under, mvs should be the number of moves in a time control.  Blitz
might be something like -tc 5 -mvs 60 to play 60 moves in 5 minutes, then 60
more moves in 5 minutes, etc.

to use it to play on ics/fics/etc, you can

xboard -ics -zp -fcp "crafty ..." and create a .icsrc file, first line is
login id, second line is password, remaining lines are simple force-fed to
the server to set things like your formula, etc.
