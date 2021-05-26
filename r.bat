@echo off
if not "%2"=="" goto :rdir
if not exist "out\%1\%1.EXE" goto :nof
out\%1\%1.EXE
goto :end

:rdir
if not exist "out\%2\%1\%1.EXE" goto :nof
out\%2\%1\%1.EXE
goto :end

:nof
echo File does not exist!

:end
echo on
