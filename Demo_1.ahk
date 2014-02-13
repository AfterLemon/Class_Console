; --- demo 1 ---
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance,Force
SetWorkingDir,%A_ScriptDir%  ; Ensures a consistent starting directory.
 
a:=new console("a",100,100,200,435)
b:=new console("b",313,100,400,200)
c:=new console("c",313,335,400,200,,,9)
a.show()
b.show()
c.show()
loop,18
{
	a.log("Line: " A_Index)
	sleep,67
}
sleep,200
a.log([111,222,[1,2,3,4],444])
b.log("aaaa,bbb,ccc,ddd`naaaaaaa,bbb,ccc,dd`naaaa,bbb,cccccc,ddd`na,b,cc,dd",",","1|2|3")
sleep,200
a.log("aaa")
sleep,200
a.prepend("bbb")
sleep,500
b.log()
b.log(" ")
b.log(" ")
b.log([111,222,[1,2,3,4],444])
c.log(c.Debug("Vars"))
sleep,3000
b.close()
sleep,700
b.show()
Sleep,1000
a:=""
sleep,800
a:=new console("a",100,100,200,435)
a.show()
a.log(c.Debug("KeyHistory"))
Sleep,2000
c.destroy()
b:=""
a.close()
return
Esc::
    critical
    exitapp
return
