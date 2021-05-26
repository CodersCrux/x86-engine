@echo off
if not "%2"=="" goto :rdir
if not exist "out\%1\%1.EXE" goto :nof
tasm\TD.exe out\%1\%1.exe
del TD.TR > t
del t
goto :end

:rdir
if not exist "out\%2\%1\%1.EXE" goto :nof
tasm\TD.exe out\%2\%1\%1.exe
del TD.TR > t
del t
goto :end

:nof
echo File does not exist!

:end
echo on
