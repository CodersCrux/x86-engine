@echo off
if not "%2"=="" goto :checkdir
if not exist "code\%1.ASM" goto :nof
goto :bld

:checkdir
if not exist "code\%2\%1.ASM" goto :nofdir
goto :bldir

:bld
mkdir out > NUL
cd out
mkdir %1 > NUL
cd c:\
tasm\TASM.exe /zi code\%1.ASM > out\%1\compile.txt
tasm\TLINK.exe /v %1.OBJ > out\%1\link.txt
del out\%1\%1.MAP > NUL
del out\%1\%1.OBJ > NUL
del out\%1\%1.EXE > NUL
ren %1.MAP out\%1\%1.MAP
ren %1.OBJ out\%1\%1.OBJ
ren %1.EXE out\%1\%1.EXE
if exist "out\%1\%1.EXE" goto :cmp
echo Your code couldn't compile! Check 'out\%1\compile.txt' to see your errors.
goto :end

:cmp
echo '%1' is compiled! Running..
out\%1\%1.EXE
goto :end

:bldir
mkdir out > NUL
cd out
mkdir %2 > NUL
cd %2
mkdir %1 > NUL
cd c:\
tasm\TASM.exe /zi code\%2\%1.ASM > out\%2\%1\compile.txt
tasm\TLINK.exe /v %1.OBJ > out\%2\%1\link.txt
del out\%2\%1\%1.MAP > NUL
del out\%2\%1\%1.OBJ > NUL
del out\%2\%1\%1.EXE > NUL
ren %1.MAP out\%2\%1\%1.MAP
ren %1.OBJ out\%2\%1\%1.OBJ
ren %1.EXE out\%2\%1\%1.EXE
if exist "out\%2\%1\%1.EXE" goto :cmpdir
echo Your code couldn't compile! Check 'out\%2\%1\compile.txt' to see your errors.
goto :end

:cmpdir
echo '%2\%1' is compiled! Running..
out\%2\%1\%1.EXE
goto :end

:nof
echo 'code\%1.ASM' does not exist!
goto :end

:nofdir
echo 'code\%2\%1.ASM' does not exist!

:end
echo on
