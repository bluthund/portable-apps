HELPDECO - Utility-Programm zum Zerlegen von Windows Hilfedateien
HELPDECO - utility program to dissect Windows help files

HELPDECO zerlegt HLP-Hilfedateien von Windows 3.0, 3.1, 3.11 und '95 und
viele MVB-Dateien des Multimedia-Viewers in alle f�r den jeweiligen
Hilfecompiler HC30, HC31, HCP, HCW, HCRTF, WMVC, MMVC oder MVC zum
erneuten Zusammenbau erforderlichen Dateien. Dazu geh�ren:
HPJ - die Projektdatei, als Parameter f�r den Hilfecompiler anzugeben
MVP - die Multimediaprojektdatei, als Parameter f�r den MM-Compiler
RTF - die Textdatei mit dem gesamten Hilfetext und allen Fu�noten
PH  - die Phrasen-Datei (wie sie auch vom Hilfecompiler erzeugt wird)
ICO - ein eventuell der Hilfedatei zugeordnetes Icon
BMP/WMF/SHG/MRB - alle Bilder in Dateien mit passendem Format
Baggage - alle als Baggage in der Hilfedatei enthaltenen Dateien

HELPDECO dissects HLP help files of Windows 3.0, 3.1, 3.11, and '95 and
many MVB multi media viewer titles into all files required for a rebuild
using the appropriate help compiler HC30, HC31, HCP, HCW, HCRTF, WMVC,
MMVC or MVC:
HPJ - help project file, use as parameter when calling help compiler
MVP - multi media project file, parameter for multi media help compiler
RTF - text file containing whole content of help file and all footnotes
PH  - phrases file (same as produced by help compiler)
ICO - icon of help file if embedded
BMP/WMF/SHG/MRB - embedded pictures in appropriate format
Baggage - all baggage files contained in help file

HELPDECO wird von der MS-DOS Kommandozeile aus mit dem Namen der zu
bearbeitenden Datei, eventuell dem Namen einer internen Datei und
eventuellen Optionen aufgerufen. HELPDECO l�uft von der Kommandozeile
von Windows 95 oder Windows NT als 32-bit Applikation zur Bearbeitung
gr��erer Hilfedateien.
Call HELPDECO from MS-DOS command line. Supply name of help file to use,
optional name of internal file, and options if appropriate.
HELPDECO runs from Windows 95 or Windows NT command line as 32-bit
application to handle larger help files.

HELPDECO
Zeigt Benutzungshinweise
Displays usage

HELPDECO helpfilename
Zerlegt die Hilfedatei in alle zum erneuten Zusammenbau ben�tigten Dateien.
Diese Dateien werden im aktuellen (m�glichst leeren) Verzeichnis abgelegt.
Existierende Dateien werden ohne R�ckfrage �berschrieben wenn die Option /y
angegeben wird.
Decompiles help file into all sources needed for a rebuild. All files are
created in current directory (should be empty). Existing files will be
overwritten without asking if option /y was specified.

Hinter dem Kommando k�nnen durch Leerzeichen abgesetzte Optionen angeben
werden:
Options may be appended to the command, separated using blanks, as follows:

/m
kann verwendet werden, um das Durchsuchen von macros nach Topicnamen zu
verhindern, wenn dabei Probleme auftreten. Hilfecompiler wird Warnung 4131
melden.
May be used to stop parsing macros for topic names. Help compiler will emit
Warning 4131.

/b
kann verwendet werden, um das Aufl�sen von Browse-Sequenzen zu verhindern,
wenn dabei Probleme auftreten. Hilfequelltextdatei enth�lt dann keine +
Fu�noten.
May be used to stop resolving browse sequences. Help source file than
contains no + footnotes.

/g
Schaltet das zeitintensive Raten von Kontextnamen aus. Anzuwenden wenn
HELPDECO 'no context ids found' meldet oder man nicht an lesbaren
Kontextnamen interessiert ist. Die Funktionsweise von HELPDECO wird dadurch
nicht beeintr�chtigt.
Zum Raten versucht HELPDECO aus Kapitel�berschriften und Schl�sselw�rten
die Kontextnamen zu rekonstruieren, was bei einigen Hilfedateien sehr gut,
bei anderen gar nicht funktioniert, je nach Hilfedateierstellungswerkzeug
oder Arbeitsmethode des Hilfeautors.
Turns off time consuming guessing of context names. Applicable when
HELPDECO reports 'no context ids found' or when you are not interested in
legible context ids. This doesn't affect functionality.
During guessing HELPDECO tries to reconstruct context ids from topic titles
and keywords. This may produce good results on some help files and no result
at all on others, depending on autoring tool used or working method of help
author.

/i
Wenn man sehen m�chte, welche Kontextnamen HELPDECO err�t...
If you want to see which context ids are guessed by HELPDECO...

/hprefix
HELPDECO versucht aus Kapitel�berschriften und Schl�sselw�rtern Kontextnamen
zu erraten, wobei auch idh_ oder helpid_ vorangestellt werden.
Wenn die Hilfedatei mit anderen bekannten Prefixen erstellt wurde, kann
die Tabelle durch die Option /h prefix erweitert werden.
HELPDECO tries to guess context ids from topic titles and keywords, possibly
prefixed by idh_ or helpid_. If the help file was created using other
prefixes, they may be added to the table using the /h prefix option.

/a [annotationfilename.ANN]
F�gt zus�tzlich alle Anmerkungen aus der angegebenen Anmerkungsdatei als
Anmerkungen des Benutzers ANN in die RTF-Datei ein. Fehlt der annotation-
filename, verwendet HELPDECO helpfilename.ANN daf�r.
Adds all annotations from annotationfile as annotations of user ANN into
RTF file. Default annotationfilename is helpfilename.ANN.

/s n
Zerteilt die Ausgabe alle n Seiten in eine eigene RTF Datei, z.B. zerlegt
  HELPDECO helpdemo /s 100
die Datei helpdemo.hlp und erzeugt RTF-Dateien mit den Namen helpdem1.rtf,
helpdem2.rtf,.. die jeweils h�chstens 100 Seiten enthalten.
Splits output every n pages into a separate RTF file. For example
  HELPDECO helpdemo /s 100
decompiles helpdeco.hlp and creates different RTF files helpdem1.rtf,
helpdem2.rtf,.. each containing no more than 100 topics.

HELPDECO helpfilename /r
Erzeugt aus der Hilfedatei eine RTF-Datei, die von WinWord geladen dasselbe
Aussehen hat wie die von WinHelp angezeigten Hilfeseiten. Damit kann eine
Hilfedatei komplett gedruckt oder weiterverarbeitet werden. Zus�tzlich
Option /n angeben, wenn an Kapitelgrenzen kein Seitenwechsel stattfinden soll.
Converts help file into RTF file of same appearance if loaded into WinWord
as if displayed by WinHelp. To print or work with complete content. Specify
additional option /n, if no page breaks should separate topics.

HELPDECO helpfilename /c
Erzeugt aus der Hilfedatei eine *.CNT-Datei f�r WinHlp32, die alle Kapitel
mit �berschriften in der Reihenfolge enth�lt, in der sie in der Hilfedatei
auftreten. Die Datei mu� dann mit HCW 4.00 oder einem Texteditor in eine
hierarchische Struktur �berarbeitet werden.
Generates a *.CNT file used by WinHlp32, containing all chapters that have
titles assigned in the order they appear in the helpfile. This file should
then be edited using HCW 4.00 or any text editor into a hierarchical order.

HELPDECO helpfilename /e
Zeigt alle Referenzen auf externe Hilfedateien.
Lists all references to external help files.

HELPDECO helpfilename /e /f
Zeigt alle Referenzen auf externe Hilfedateien und die Titel der Topics in
denen sie auftraten.
Lists all references to external help files and titles of topics that
contained these references.

HELPDECO helpfilename /p
Pr�ft Referenzen auf externe Hilfedateien. Die referenzierten Hilfedateien
m�ssen f�r HELPDECO zugreifbar sein. Dieser Aufruf erzeugt keine neuen
Dateien und modifiziert keine existierenden. Fehler werden auf stdout (den
Bildschirm) geschrieben.
Checks references to external help files. Referenced help file need to be
available to HELPDECO. This call doesn't produce any new files and doesn't
modify existing files. Errors are reported to stdout (screen).

HELPDECO helpfilename /d
Zeigt das interne Inhaltsverzeichnis der Hilfedatei. Es kann auch eine
*.MVB,*.M??,*.ANN,*.CAC,*.AUX Datei anstelle der *.HLP-Datei angegeben
werden.
Displays internal directory of help file. You may supply a *.MVB,*.M??,
*.ANN,*.CAC,*.AUX file instead of a *.HLP file.

HELPDECO helpfilename /x
Zeigt das interne Inhaltsverzeichnis als HexDump
Displays hex dump of internal directory

HELPDECO helpfilename "internalfilename"
Zeigt die genannte interne Datei in einem passenden Format an, soweit die
interne Datei anzeigbar ist, sonst als HexDump. Sie k�nnen die Ausgabe in
eine Datei umleiten durch anh�ngen von >outfile.
Displays internal file in appropriate format if known, else hex dump. You
may redirect output into a file using >outfile.

HELPDECO helpfilename "internalfilename" /x
Zeigt die genannte interne Datei als HexDump
Displays hex dump of internal file

HELPDECO helpfilename "internalfilename" /x /t offset
Zeigt die genannte interne Datei als HexDump beginnend bei Position
offset, der als Dezimalzahl oder mit vorangestelltem 0x als Hexadezimal-
zahl akzeptiert wird.
Displays hex dump of internal file starting at offset, which may be
specified in decimal or preceeded with 0x in hex.

HELPDECO helpfilename "internalfilename" filename
Exportiert die genannte interne Datei in filename
Exports internal file into filename

*.ANN, *.CAC, *.AUX
Diese Dateien sind auch wie Hilfedateien formatiert, HELPDECO kann aber nur
verwendet werden, um ihr Inhaltsverzeichnis anzuzeigen oder um einzelne
Dateien anzuzeigen und zu exportieren.
These files are formatted like helpfiles, but HELPDECO can only be used to
display their internal directory or display or export internal files.

HELPDECO wurde erstellt von / was written by
Manfred Winterhoff, Geschw.-Scholl-Ring 17, 38444 Wolfsburg, Germany
CIS 100326,2776

Wenn Sie weitere Fragen, Probleme (oder Antworten!) haben, k�nnen Sie
durch eine EMail an 100326.2776@compuserve.com mit mir in Kontakt treten.
If you have more questions, problems (or answers!), please feel free to
send me an EMail to 100326.2776@compuserve.com

HELPDECO basiert auf HELPDUMP von Pete Davis ver�ffentlicht in:
HELPDECO is based upon HELPDUMP from Pete Davis published in:
The Windows Help File Format, Dr. Dobbs Journal, Sep/Oct 1993
Thanks to Holger Haase, who did a lot of work on picture file formats.
And thanks to J�rgen M�ller for pointing out 32-bit differences.
Thanks to Bent Lynggaard for the information on help file free lists
and his contribution on context id guessing.

HELPFILE.TXT enth�lt eine Beschreibung des Windows Hilfedateiformats
wie HELPDECO es versteht und weiterer Dateiformate wie MRB/SHG.
See HELPFILE.TXT for a description of the Windows help file format
as parsed by HELPDECO and related file formats like MRB/SHG.

Die neueste Version von HELPDECO befindet sich stets in:
The newest public version of HELPDECO is always available at:
CompuServe: Dr. Dobbs Journal DDJFOR Undocumented Corner HELPDCxx.ZIP
InterNet: ftp://gmutant.wrlc.org/pub/winhelp

HELPDECO ist Freeware. Der Einsatz erfolgt auf eigene Gefahr. Kein
Programmteil darf kommerziell verwendet werden. F�r das Kopieren d�rfen
keine Geb�hren verlangt werden (Sharewarehandel Finger weg).
HELPDECO is freeware. Use at your own risk. No part of the program may be
used commercially. No fees may be charged on distributing the program
(shareware distributors keep off).

Die Verwendung von Inhalten zerlegter Hilfedateien kann eine Verletzung
des Urheberrechtes bedeuten.
The use of parts of decompiled help files may constitute a violation of
copyright law.

Version 2.1:
macros may contain rtf meta characters
Win95 topic names may contain (nearly) all characters
0x8000 in SWin->Maximize allowed
ForeHelp creates PhrIndex/PhrImage _and_ _empty_ Phrases file
HCRTF complained about > footnotes before # footnotes
macro parsing changed again

Version 2.0:
Guess context ids from titles and keywords based on idea of Bent Lynggaard
Recompiled 16 bit EXE without register calling convention. BC++ 3.1 bug.
Doesn't print last (stray) topic of HC30 help files
Can list entry points into this help file (option /l)

Version 1.9: faster & better than ever...
changed TopicPos, TopicOffset, Keyword maintenance
changed unhash to 40 bit integer arithmetic
fixed keyword footnotes [Bent Lynggaard]
no [ALIAS] in MVP files
no hidden text in option /r RTF files
some changes in font and stylesheet handling
corrects rounding error of HC31 on negative values
handles non-underlined topic jumps

Version 1.8: used some spare days to clean up the to-do list...
better tracking of TopicOffset during decompilation
lists and checks references to external files, shows referencing topics
can add annotations from .ANN file to decompiled .RTF file
fixed bug in handling of pictures containing JumpId-macro hotspots
changed parsing of macros (3rd attempt to guess what Microsoft did)
fixed bug in popup/jump to external file / secondary window
fixed bug in > footnote / |VIOLA internal file handling
fixed bug in keyword assignment
now removes LZ77 compression from exported SHGs/MRBs
recreates Win 95 (HCW 4.00) [MACROS] section from internal |Rose file
32 bit version available
handles LANGUAGE, [CHARTAB] and [GROUP] section of media view files

Version 1.7
removed unneccessary output statement

Version 1.6 can now check references to external help files plus:
duplicate macro names preceeding picture hotspot info skipped
does not write Win95 commands to multi-media help project files
changed unhash to circumvent Microsoft-C++ float rounding error
handles keywords defined inside topic text

Version 1.5
fixed static on buffer of TopicName function (affected HC30 files)

Version 1.4 fixes some bugs reported by different users:
buffer overflow in expanding LZ77&RunLen (byPacked 3) images fixed
embedded images {bmxwd} larger than 32k supported
extract topic names from jump into external file if no file specified
handles more phrases on HCRTF generated (Win95) help files
Windows 3.1 (HC31) |Phrases always Zeck compressed
LinkData2 buffer enlarged 1 byte to store trailing NUL character

Version 1.3
parses examples of {bmc} etc. statements contained in help text correctly
can now generate a *.CNT content file for Windows 95 / WinHlp32
Microsoft C: ctype macros (isalnum/isprint) don't work with signed char

Version 1.2 fixes some severe bugs introduced in version 1.1 and:
tells you which help compiler to use
collects multiple keyword footnotes into single lines
handles \r\n in COPYRIGHT
converts SPC-macro (but only in [CONFIG] section)
does not generate duplicate MAP-statements if possible
{button} and {mci,mci_left,mci_right} commands supported
[BITMAP]-section in HCRTF help files irritated transparent bitmaps

Version 1.1 now supports more features of Win95/HCRTF 4.00/WinHlp32:
Supports LCID, CHARSET, AUTO-SIZE HEIGHT, CNT, INDEX_SEPARATORS
Additional Win95 Macros (to extract original topic names)
[CONFIG:n] of Win95 supported (internal file |CFn)
Secondary windows with > footnote supported (internal file |VIOLA)
Transparent bitmaps supported (bmct,bmlt,bmrt)
Expanded internal limits as HCRTF allows larger items
Now does RunLen compressed device dependend bitmaps
Bugs in handling of metafiles removed
Bug in placement of pack(1) removed
Parsing of macros changed (is it really better now ?)
