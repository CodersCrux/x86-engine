# x86-engine
This is an Assembly x86 16-bit engine.
I've used Turbo Assembler x86 with DOSBox to compile and debug it.

I've created tools to easily assemble Turbo Assembler x86 files alongside it.
This repository mainly focuses on the documentation of the engine, although you'll also find explanations on how to use the other tools.

To use those tools yourself, you need to make sure you have a similar structure as the one here, which is:

> Directory\ <br />
> .... code\ <br />
> .... OUT\ <br />
> .... asm.bat <br />
> .... r.bat <br />
> .... asmr.bat


What each part does:

- Directory\ is your main directory, and DOSBox mounts to it. The name can be anything.

- code\ is the folder where all your .asm files are stored. The name must stay as is. <br />NOTE: TASM x86 can only access files of up to 8 letters without the extension. Meaning, that only xxxxxxxx.asm is allowed. Any more letters will be dropped and can cause issues.

- OUT\ is automatically generated when a file is assembled, and it contains the output of the assembly. <br />It contains the .EXE file of your program, as well as a COMPILE.TXT listing all your errors (if any) and a LINK.TXT file for linking issues.

- asm.bat assembles your file as well as organizes the output.
  Syntax:
  > asm <file> [directory]<br />
  
  file is the name of the file you want to assemble, MUST NOT HAVE EXTENSION!<br />
  Example uses:

  > asm testcode<br />
  
  Assembles the file: code\testcode.asm

  > asm testet games\snake<br />
  
  Assembles the file: code\games\snake\testet.asm



