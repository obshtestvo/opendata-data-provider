@echo off
setlocal enabledelayedexpansion
chcp 65001
set INTEXTFILE=data.txt
set OUTTEXTFILE=data.csv
set TMPFILE=data-tmp.csv
set SEARCHTEXT=	
set REPLACETEXT=","
SET quote="

REM cleanup any leftover files
del %OUTTEXTFILE%
del %TMPFILE%

REM read the input file and replace tabs with commas, quote everything and remove accidental double quotes and tabs.
for /f "tokens=1,* delims=" %%A in ( '"type %INTEXTFILE%"') do (
SET string=%%A
SET modified=!string:		=	!
SET modified=!modified:%SEARCHTEXT%=%REPLACETEXT%!
SET modified=!modified:",""=","!
SET modified=!modified:"","=","!

SET firstSymbol=!modified:~0,1!
SET lastSymbol=!modified:~-1,1!

REM opening and closing quotes if not already there (excel quotes only some outputs, and not all)
IF "!firstSymbol!" NEQ "!quote!" SET modified="!modified!
IF "!lastSymbol!" NEQ "!quote!" SET modified=!modified!"

echo !modified! >> %TMPFILE%
)

REM another pass to cleanup leftover quotes at the end
for /f "tokens=1,* delims=" %%A in ( '"type %TMPFILE%"') do (
SET string=%%A
SET modified=!string:"," ="!
echo !modified! >> %OUTTEXTFILE%
)
del %TMPFILE%