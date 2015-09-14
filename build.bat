@echo off
call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" x64

set CommonCompilerFlags=/MTd /nologo /fp:fast /Gm- /GR- /EHa /Od /Oi /WX /W4 /wd4201 /wd4100 /wd4189 /wd4505 /DHANDMADE_INTERNAL=1 /DHANDMADE_SLOW=1 /DHANDMADE_WIN32 /Z7 /FC /F4194304
set CommonLinkerFlags= -incremental:no -opt:ref  user32.lib gdi32.lib winmm.lib

IF NOT EXIST build mkdir build
rem pushd build
cd build

REM compilar pra winXP
rem cl %CommonCompilerFlags% ../handmade/win32_handmade.cpp /link -subsystem:windows,5.1 %CommonLinkerFlags%

rem compilar normal x64
del *.pdb >NUL 2> NUL
REM Optimization switches /O2 /Oi /fp:fast
echo WAITING FOR PDB > lock.tmp
cl %CommonCompilerFlags% ../handmade/win32_handmade.cpp /Fmwin32_handmade.map /link %CommonLinkerFlags%
del lock.tmp
echo %CD%
cl /D_USRDLL /D_WINDLL %CommonCompilerFlags% ../handmade/handmade.cpp /Fmhandmade.map /LD /link /PDB:handmade_%random%.pdb /EXPORT:GameUpdateAndRender /EXPORT:GameGetSoundSamples -incremental:no
