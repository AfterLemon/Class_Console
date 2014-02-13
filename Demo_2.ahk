; --- demo 2 ---
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance,Force
SetWorkingDir,%A_ScriptDir%  ; Ensures a consistent starting directory.
 
a:=new console("Variable list",100,100,400,600)
a.log("A:This is working")
a.show(1)
a.log(a.debug("vars"))
b:=new console("",511,100,400,600)
b.show()
b.log(a.pull() "`n`nB:This is also")
Sleep,3000
C:="*** THIS VAR IS NEW!!!!!!!!!!!!!!!!!! ***"
a.update("lines")
Sleep,5000
a:=""
return
Esc::
    critical
    exitapp
return
