class console
{	__new(Name,x,y,w,h,Timestamp:=1,HTML:="",Font:="Courier New",FontSize:=10)
	{	global
		local Name2,S,MatchList,Check,Temp_,Temp_2,Gui,Gui_B,cmd,cmd2,Assign1,Assign2,Assign3,debugprev,DHW,textO,Check2,tc
		ListLines,% ("Off",this.Time:=A_Now,this.WordList:=this.WordList1 this.WordList2,(Name=""?Name:="DebugID" this.Time:""),((Timestamp!=0&&Timestamp!=1)?this.timeext:=Timestamp:(Timestamp=1?this.timeext:="":(Timestamp=0?this.timeext:=0:""))),Name2:=Name,Name:=regExReplace(Name,"i)[^a-z0-9#_@$]{1,253}","_"),this.Name:=Name,this.edit:=Name this.time,this.tc:="c3")
		If !html
			html=
			(ltrim
			<!DOCTYPE html>
			<html>
			<head>
			<style type="text/css">
			#bod {background-color:black;color:white;font:%FontSize%pt %Font%;}
			p {margin:0;padding:0;}
			.c1{color:yellow;}.c2{color:orange;}.c3{color:white;}.c4{color:red;}.c5{color:cyan;}.c6{color:lime;}.c7{color:green;}.c8{color:black;}
			.h1{color:#BBBBBB;font-size:14pt;}
			.h2{font-size:18pt;}
			.dlim1{color:#444444;}
			.num{color:#6666FF}
			</style>
			</head>
			<body id="bod">
			)
		Gui,% Name ":Destroy"
		Gui,% Name ":Font",s%FontSize% cDDDDDD,%Font%
		Gui,% Name ":color",000000,000000
		Gui,% Name ":add",activeX,% "x0 y-1 w" w " h" h-22 " -TabStop HScroll v" this.edit, MSHTML:
		Gui,% Name ":add",edit,% "x-1 y" h-23 " w" w+2 "h22 -0x200 vcc" name
		Gui,% Name ":add",button,default Hidden gSubCC,OK
		Gui,% (Name ":-MinimizeBox +Border",this.Check2:=["","&nbsp;&nbsp;","&nbsp;&nbsp;&nbsp;","&nbsp;&nbsp;&nbsp;&nbsp;","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"])
		Gui,% Name ":show",% "Hide x" x " y" y " w" (this.w:=w) " h" h,% ("Console """ Name2 """",this.fontsize:=FontSize,this.line:=0,Temp_:=this.edit,%Temp_%.write(this.html:=html),this.append("Type 'help' for a list of commands (no quotes)"))
		ListLines,Off
		DetectHiddenWindows,% ("On",DHW:=A_DetectHiddenWindows)
		DetectHiddenWindows,% (DHW,this.HWND:=WinExist("Console """ Name2 """"))
		this.Console_Help:={"!ExitApp":"<span class='c1'>Syntax:</span> ExitApp`n<span class='c1'>Desc:</span> Exits entire script."
			,"*Catch":"<span class='c1'>Syntax:</span>catch var varName Value command`n<span class='c1'>Syntax:</span>catch var line DebugLineNum Command`n<span class='c1'>Desc:</span> Detect when a variable is a certain value, OR when a line in ListLines exists.`n<span class='c1'>Example:</span>catch var d 4 prepend %d%`n<span class='c1'>Example:</span>catch line 11 log line 11 was accessed!"
			,"*Settimer":"<span class='c1'>Syntax:</span> SetTimer N command.`n<span class='c1'>Desc:</span> Run a [command] every N milliseconds (1000=1 second, 5000=5 seconds, etc).`n<span class='c1'>Example:</span> SetTimer 1000 var Banana"
			,Append:"<span class='c1'>Syntax:</span> Append NewText.`n<span class='c1'>Desc:</span> Add text to the end of the console. You may use variables such as %varName%.`n<span class='c1'>Example:</span> Append I'm at the end of the log! For now..."
			,Clear:"<span class='c1'>Syntax:</span> Clear.`n<span class='c1'>Desc:</span> Clear all text in the console.`n<span class='c1'>Example:</span> Clear"
			,Close:"<span class='c1'>Syntax:</span> Close.`n<span class='c1'>Desc:</span> Close (or hide) the console. It can be re-shown.`n<span class='c1'>Example:</span> Close"
			,Color:"<span class='c1'>Syntax:</span>Color N.`n<span class='c1'>Desc:</span>Apply a color to all below lines. Available colors: Yellow, Orange, White, Red, Blue, Lime, Green, Black.`n<span class='c1'>Example:</span> color blue"
			,Cmd:"<span class='c1'>Syntax:</span> cmd cmd.exe stuff.`n<span class='c1'>Desc:</span> Run cmd.exe commands here. You can ping, run programs, whatever you want. Output will go to the console. This gets stuff line-by-line.`n<span class='c1'>Example:</span> Cmd ipconfig"
			,CmdWait:"<span class='c1'>Syntax:</span> CmdWait cmd.exe stuff.`n<span class='c1'>Desc:</span> Run cmd.exe commands here. You can ping, run programs, whatever you want. Output will go to the console. This waits for the whole command to finish before printing to the console.`n<span class='c1'>Example:</span> CmdWait ipconfig"
			,Debug:"<span class='c1'>Syntax:</span> debug UNIT.`n<span class='c1'>Desc:</span> Get various AHK debugging info such as Last Lines.`nUNIT should be one of the following: Hotkeys, KeyHistory, Lines or Vars`n<span class='c1'>Example:</span> Debug Vars"
			,Destroy:"<span class='c1'>Syntax:</span> Destroy.`n<span class='c1'>Desc:</span> Destroy the console. It can NOT be re-shown.`n<span class='c1'>Example:</span> Destroy"
			,Log:"<span class='c1'>Syntax:</span> Log NewText.`n<span class='c1'>Desc:</span> Add text to the end of the console with a formatted timestamp above the new text. You may use variables such as %varName%.`n<span class='c1'>Example:</span> Log Some new data"
			,Operators:"<span class='c1'>Syntax:</span> var+=5`n<span class='c1'>Desc:</span> Create and/or do math or do other unforsaken things to variables, such as append text. You do not need to use quotes around text.`nAvailable Operators: := .= += -= *= /= //= &= ^= |=`n<span class='c1'>Example:</span> SomeVar.=New text at the end."
			,Prepend:"<span class='c1'>Syntax:</span> Prepend NewText.`n<span class='c1'>Desc:</span> Adds text to the TOP of the log, not the bottom. No timestamp will be added. You may use variables such as %varName%.`n<span class='c1'>Example:</span> Prepend I'M ON TOP OF THE WOR... CONSOLE!"
			,Pull:"<span class='c1'>Syntax:</span> Pull [lines|line First-Last|N] VarName|Clipboard`n<span class='c1'>Desc:</span> Pulls data from console window (line/lines specifies the line numbers) and saves it in a variable (or the clipboard).`n<span class='c1'>Example:</span> Pull banana`n      OR Pull lines 1-10 banana`n      OR Pull line 3 banana"
			,Run:"<span class='c1'>Syntax:</span> Run Label`n<span class='c1'>Desc:</span> Runs a label within the script.`n<span class='c1'>Example:</span> Run BananaLabel -> BananaLabel: ...."
			,Save:"<span class='c1'>Syntax:</span> Save Filepath.`n<span class='c1'>Desc:</span> Save the console text to the specified file.`n<span class='c1'>Example:</span> Save C:\blah\log.txt"
			,Show:"<span class='c1'>Syntax:</span> Show NAME.`n<span class='c1'>Desc:</span> Show a specified closed (not destroyed) console or reshow the current one.`n<span class='c1'>Example:</span> Show Variable"
			,TimeSinceLastCall:"<span class='c1'>Syntax:</span> TimeSinceLastCall [X Y]`n<span class='c1'>Desc:</span> X and Y are optional. Return the time in milliseconds since the last time this command was run.`n<span class='c1'>Example:</span> TimeSinceLastCall"
			,Update:"<span class='c1'>Syntax:</span> Update`n<span class='c1'>Desc:</span> Uses last Debug UNIT, clearing the log and re-running the debug.`n<span class='c1'>Example:</span> Debug vars --> SetTimer 3000 Update"
			,Var:"<span class='c1'>Syntax:</span> Var VariableName.`n<span class='c1'>Desc:</span> Print the value of a variable to the console. no %'s needed.`n<span class='c1'>Example:</span> Var Banana"}
		ListLines,On
		return this
		TimerSubCC:
		SubCC:
			ListLines,Off
			If(A_ThisLabel!="TimerSubCC")
			{	Gui,% A_Gui ":Submit",NoHide
				GuiControl,,% ("cc" A_Gui,Gui:=A_Gui)
			}else cc%Gui%:=cc%Gui%_B,Gui:=Gui_B
			For Temp_ in ((InStr(cc%Gui%," ")?cmd:=StrSplit(cc%Gui%,[" ","`t"]):(cmd:=[],cmd[1]:=(InStr(cc%Gui%,",")?SubStr(cc%Gui%,1,InStr(cc%Gui%,",")-1):cc%Gui%))),cmd2:=StrSplit((InStr(cc%Gui%," ")?SubStr(cc%Gui%,InStr(cc%Gui%," ")+1):cc%Gui%),","))
				(cmd[Temp_]=""?cmd.remove(Temp_):"")
			If(RegExReplace(cc%Gui%,".=")!=cc%Gui%)
			{	SetFormat,FloatFast,0.18
				Transform,Assign3,deref,% SubStr(cc%Gui%,InStr(cc%Gui%,"=")+1)
				Assign1:=SubStr(cc%Gui%,1,InStr(cc%Gui%,"=")-2),Assign2:=SubStr(cc%Gui%,InStr(cc%Gui%,"=")-1,2),%Assign1%:=%Gui%.eval((Assign2=":="?Assign3:(Assign2="+="?%Assign1%+Assign3:(Assign2="-="?%Assign1%-Assign3:(Assign2="*="?%Assign1%*Assign3:(Assign2="/="?%Assign1%/Assign3:(Assign2="//="?%Assign1%//Assign3:(Assign2=".="?%Assign1% Assign3:(Assign2="|="?%Assign1%|Assign3:(Assign2="&="?%Assign1%&Assign3:(Assign2="^="?%Assign1%^Assign3:"")))))))))))
			}else If(cmd[1]="settimer")
			{	Transform,Temp_,deref,% cmd[2]
				Loop,% (cmd.MaxIndex()-2,cc%Gui%_B:="",Gui_B:=Gui)
					cc%Gui%_B.=cmd[A_Index+2] " "
				cc%Gui%_B:=RTrim(cc%Gui%_B," ")
				SetTimer,TimerSubCC,%Temp_%
			}else If(cmd[1]="var")
				Temp_:=cmd[2],%Gui%.append(%Temp_%)
			else If(cmd[1]="append")
			{	Transform,Temp_,deref,% (InStr(cmd2[1]," ")?cmd2[1]:(cmd[2]?cmd[2]:(cmd2[2],cmd2[2]:=cmd2[3],cmd2[3]:=cmd2[4],cmd2[4]:=cmd2[5],cmd2[5]:=cmd2[6],cmd2[6]:=cmd2[7])))
				%Gui%.append((Temp_?Temp_:""),(cmd2[2]?cmd2[2]:0),(cmd2[3]?cmd2[3]:""),(cmd2[4]?cmd2[4]:1),(cmd2[5]?cmd2[5]:" "),((cmd2[6]?cmd2[6]:" | ")))
			}else If(cmd[1]="catch")
				(cmd[2]="line"?%Gui%.catch(cmd[3]):(cmd[2]="var"?%Gui%.catch("",cmd[3],cmd[4]):""))
			else If(cmd[1]="clear")
				%Gui%.clear()
			else If(cmd[1]="close")
				%Gui%.close((cmd[2]?cmd[2]:1))
			else If(cmd[1]="color")
				%Gui%.color((cmd[2]?cmd[2]:""))
			else If(cmd[1]="cmd")
				%Gui%.cmd((cmd2[1]?cmd2[1]:""),(cmd2[2]?cmd2[2]:""),(cmd2[3]?cmd2[3]:1))
			else If(cmd[1]="cmdwait")
				%Gui%.cmdWait((cmd2[1]?cmd2[1]:""),(cmd2[2]?cmd2[2]:1))
			else If(cmd[1]="debug")
				%Gui%.log(%Gui%.debug(cmd[2]))
			else If(cmd[1]="destroy"||cmd[1]="exit")
				%Gui%.destroy((cmd[2]?cmd[2]:1))
			else If(cmd[1]="exitapp")
				exitapp
			else If(cmd[1]="help")
			{	If !(cmd[2]=""||cmd[2]="All")
				{	If !Temp_:=%Gui%.Console_Help[cmd[2]]
						Msgbox,% "Help """ cmd[2] """ does not exist. Type 'help' for a list."
					else %Gui%.append("<span class='h1'>[" cmd[2] "]</span><br/>`n&nbsp;&nbsp;&nbsp;&nbsp;" RegExReplace(Temp_,"`n","`n&nbsp;&nbsp;&nbsp;&nbsp;"))
				}else
				{	For Temp_,Check in %Gui%.Console_Help
						Assign1.="`n<span class='h1'>[" Temp_ "]</span><br/>`n&nbsp;&nbsp;&nbsp;&nbsp;" RegExReplace(Check,"`n","`n&nbsp;&nbsp;&nbsp;&nbsp;")
					%Gui%.append("<span class='h2'>ConsoleBar_Commands</span>" Assign1 "`n<br/>`n-----"),Assign1:=""
			}}else If(cmd[1]="log")
			{	Transform,Temp_,deref,% (InStr(cmd2[1]," ")?cmd2[1]:(cmd[2]?cmd[2]:(cmd2[2],cmd2[2]:=cmd2[3],cmd2[3]:=cmd2[4],cmd2[4]:=cmd2[5],cmd2[5]:=cmd2[6],cmd2[6]:=cmd2[7])))
				%Gui%.log((Temp_?Temp_:""),(cmd2[2]?cmd2[2]:0),(cmd2[3]?cmd2[3]:""),(cmd2[4]?cmd2[4]:1),(cmd2[5]?cmd2[5]:" "),(cmd2[6]?cmd2[6]:" | "))
			}else If(cmd[1]="prepend")
			{	Transform,Temp_,deref,% (InStr(cmd2[1]," ")?cmd2[1]:(cmd[2]?cmd[2]:(cmd2[2],cmd2[2]:=cmd2[3],cmd2[3]:=cmd2[4],cmd2[4]:=cmd2[5],cmd2[5]:=cmd2[6],cmd2[6]:=cmd2[7])))
				%Gui%.prepend((Temp_?Temp_:""),(cmd2[2]?cmd2[2]:1),(cmd2[3]?cmd2[3]:""),(cmd2[4]?cmd2[4]:1),(cmd2[5]?cmd2[5]:" "),(cmd2[6]?cmd2[6]:" | "))
			}else If(cmd[1]="pull")
			{	If(cmd[2]="lines"||cmd[2]="line")
				{	Loop,parse,Temp_,`n,% ("`r",Temp_:=%Gui%.pull(),Check:=SubStr(cmd[3],InStr(cmd[3],"-")+1),Temp_2:=0)
					{	If(A_LoopField="")
							Continue
						else Temp_2++
						If(Temp_2>=SubStr(cmd[3],1,(cmd[2]="line"?StrLen(cmd[3]):InStr(cmd[3],"-")-1))&&(cmd[2]="line"?Temp_2<cmd[3]+1:(Temp_2<=Check||Check="End"||Check="Last")))
						{	If(cmd[4]="clipboard")
							{	Clipboard:="",Clipboard.=(cmd[2]="line"?"":"`n") A_LoopField
								ClipWait
							}else Temp_:=cmd[4],%Temp_%.=(cmd[2]="line"?"":"`n") A_LoopField
						}else If(Temp_2>(cmd[2]="line"?cmd[3]:Check))
							break
				}}else If(cmd[2]="clipboard")
				{	Clipboard:=%Gui%.pull()
					ClipWait
				}else Temp_:=cmd[2],%Temp_%:=%Gui%.pull()
			}else If(cmd[1]="run")
				%Gui%.run((cmd[2]?cmd[2]:""))
			else If(cmd[1]="save")
				%Gui%.save((cmd2[2]?cmd2[2]:A_ScriptDir "\AutoHotkey Console Debug.txt"),(cmd2[3]?cmd2[3]:""),(cmd2[2]?cmd2[2]:0))
			else If(cmd[1]="show")
				%Gui%.show((cmd2[1]?cmd2[1]:1),(cmd2[2]?cmd2[2]:1))
			else If(cmd[1]="timesincelastcall")
				%Gui%.timesincelastcall((cmd2[1]?cmd2[1]:1),(cmd2[2]?cmd2[2]:""))
			else If(cmd[1]="update")
				%Gui%.update((cmd[2]?cmd[2]:""))
			ListLines,On
		return
	}
	__delete()
	{	ListLines,Off
		Gui,% this.Name ": destroy"
		ListLines,On
	}
	append(text:="",scroll:=0,delim:="",justify:=1,pad:=" ",colsep:=" | ")
	{	ListLines,Off
		(IsObject(text)?text:=st_PrintArr(text,,""):(delim!=""?text:=AL_Columnize(text,delim,justify,pad,colsep):"")),(text?"":text:="&nbsp;")
		Loop,parse,text,`n
			textO.="<p class='" this.tc "'><span class='num'>" ++this.line ".</span>" this.Check2[(this.line<10?5:(this.line<100?4:(this.line<1000?3:2)))] A_LoopField
		ListLines,% ("On",Temp_:=this.edit,%Temp_%.write(((text~="^\s+$"||text="")?textO:Trim(textO,"`r`n `t")) "</p>"),%Temp_%.getElementById("bod").scrollIntoView(scroll))
	}
	catch(line:="",var:="",value:="")
	{	global catchTemp,catchConsole,catchLine,catchVar,catchValue,catchCaught
		ListLines,Off
		If(line&&var)
			return
		else If line
			catchTemp:=this.debug("lines")
		SetTimer,Console_Catch,20
		catchConsole:=this.name,catchLine:=line,catchVar:=var,catchValue:=value
		return
		Console_Catch:
			ListLines,Off
			If(catchTemp=""&&catchVar=catchValue)
				catchCaught:=1
			else
			{	StringReplace,catchTemp,catchTemp,`n,`n,UseErrorLevel
				Assign1:=ErrorLevel-50,Temp_2:=%catchConsole%.debug("lines")
				ListLines,Off
				Loop,parse,Temp_2,`n
				{	If(A_Index<Assign1)
						Continue
					If(SubStr(A_LoopField,1,4)=(StrLen(catchLine)<2?00 catchLine:(StrLen(catchLine)<3?0 catchLine:catchLine)) ":")
					{	catchCaught:=1
						break
					}else continue
			}}If catchCaught
			{	SetTimer,Console_Catch,Off
				(catchTemp?%catchConsole%.append("Line " catchLine " executed!"):%catchConsole%.append("Var " catchVar " = " catchValue "."))
		}ListLines,On
		return
	}
	clear()
	{	ListLines,Off
		ListLines,% ("On",Temp_:=this.edit,this.line:=0,%Temp_%.write(""),%Temp_%.close(""),%Temp_%.write(this.html))
	}
	close()
	{	ListLines,Off
		Gui,% this.Name ": cancel"
		ListLines,On
	}
	cmd(cmd:="",breakOn:="",AppendConsole:=1)
	{	ListLines,Off
		DllCall("RegisterShellHookWindow",UInt,A_ScriptHwnd),MsgNum:=DllCall("RegisterWindowMessage",Str,"SHELLHOOK"),OnMessage(MsgNum,"ShellMessage"),(cmd!=""?(this.objShell:=ComObjCreate("WScript.Shell"),this.cmd:=cmd):cmd:=this.cmd),objExec:=this.objShell.Exec(cmd)
		While(!objExec.StdOut.AtEndOfStream)
			If((InStr(data,breakOn)&&breakOn!=""),(AppendConsole?this.append(data:=objExec.StdOut.ReadLine()):""),all.=data "`n")
				return (data,OnMessage(MsgNum,""))
		ListLines,On
		return (trim(all,"`r`n"),OnMessage(MsgNum,""))
	}
	cmdWait(cmd:="",AppendConsole:=1)
	{	ListLines,Off
		DllCall("RegisterShellHookWindow",UInt,A_ScriptHwnd),MsgNum:=DllCall("RegisterWindowMessage",Str,"SHELLHOOK"),OnMessage(MsgNum,"ShellMessage"),(cmd!=""?(this.objShell:=ComObjCreate("WScript.Shell"),this.cmd:=cmd):cmd:=this.cmd),objExec:=this.objShell.Exec(cmd)
		While(!objExec.Status,DllCall("Sleep",uint,50))
		{}ListLines,On
		return (data,OnMessage(MsgNum,""),(AppendConsole?this.append(data:=objExec.StdOut.ReadAll()):""))
	}
	color(color:="white") ; these colors are the same as what is defined in the CSS in __new().
	{	ListLines,Off
		ListLines,% ("On",this.tc:=(color="yellow"?"c1":(color="orange"?"c2":(color="white"?"c3":(color="red"?"c4":(color="blue"?"c5":(color="lime"?"c6":(color="green"?"c7":(color="black"?"c8":"c3")))))))))
	}
	debug(debugType)
	{	static id,pSFW,pSW,bkpSFW,bkpSW
		ListLines,Off
		If !id
		{	DetectHiddenWindows,% ("On",d:=A_DetectHiddenWindows)
			Process,Exist
			ControlGet,id,Hwnd,,Edit1,ahk_class AutoHotkey ahk_pid %ErrorLevel%
			DetectHiddenWindows,% (d,astr:=(A_IsUnicode?astr:str),ptr=(A_PtrSize=8?"ptr":uint),hmod=DllCall("GetModuleHandle",str,"user32.dll"),pSFW=DllCall("GetProcAddress",ptr,hmod,astr,"SetForegroundWindow"),pSW=DllCall("GetProcAddress",ptr,hmod,astr,"ShowWindow"),DllCall("VirtualProtect",ptr,pSFW,ptr,8,uint,0x40,"uint*",0),DllCall("VirtualProtect",ptr,pSW,ptr,8,uint,0x40,"uint*",0),bkpSFW=NumGet(pSFW+0,0,"int64"),bkpSW=NumGet(pSW+0,0,"int64"))
		}(A_PtrSize=8?(NumPut(0x0000C300000001B8,pSFW+0,0,"int64"),NumPut(0x0000C300000001B8,pSW+0,0,"int64")):(NumPut(0x0004C200000001B8,pSFW+0,0,"int64"),NumPut(0x0008C200000001B8,pSW+0,0,"int64")))
		IfEqual,debugType,Vars,ListVars
		else IfEqual,debugType,Lines,ListLines
		else IfEqual,debugType,Hotkeys,ListHotkeys
		else IfEqual,debugType,KeyHistory,KeyHistory
		ControlGetText,O,,% ("ahk_id " id,NumPut(bkpSFW,pSFW+0,0,"int64"),NumPut(bkpSW,pSW+0,0,"int64"),debugprev:=debugType)
		ListLines,On
		return O
	}
	destroy()
	{	ListLines,Off
		Gui,% this.Name ": destroy"
		ListLines,On
	}
	eval(In,Append:=0)
	{	ListLines,Off
		Out:=(RegExMatch(In:=RegExReplace(In,"-","#"),"(.*)\(([^\(\)]+)\)(.*)",y)?this.eval(y1 Eval#(y2) y3):Eval#(In))
		ListLines,On
		return (Append?this.append(Out):Out)
	}
	log(text:="",scroll:=0,delim:="",justify:=1,pad:=" ",colsep:=" | ")
	{	ListLines,Off
		FormatTime,time,T0,% this.timeext
		Loop,parse,text,`n,% ("",Log:="<p><span class='num'>" ++this.line ".</span>" this.Check2[(this.line<10?5:(this.line<100?4:(this.line<1000?3:2)))] "<span class='c1'>" (time?"&nbsp;&nbsp;&nbsp;" time "</span>":"</span>"))
			textO.="<p class='" this.tc "'><span class='num'>" ++this.line ".</span>" this.Check2[(this.line<10?5:(this.line<100?4:(this.line<1000?3:2)))] A_LoopField
		Temp_:=this.edit,%Temp_%.write(log textO),%Temp_%.getElementById("bod").scrollIntoView(scroll)
		ListLines,On
	}
	prepend(text:="",scroll:=1,delim:="",justify:=1,pad:=" ",colsep:=" | ")
	{	ListLines,Off
		(text=""?text:=st_PrintArr(text,,""):(delim!=""?text:=AL_Columnize(text,delim,justify,pad,colsep):"")),(text?"":text:="&nbsp;")
		Loop,parse,text,`n,% ("",this.line:=0,Temp_:=this.edit,Assign1:=this.line)
		{	Data:=%Temp_%.getElementById("bod").innerHTML,this.clear()
			ListLines,Off
			textO.="<p class='" this.tc "'><span class='num'>" ++this.line ".</span>" this.Check2[(this.line<10?5:(this.line<100?4:(this.line<1000?3:2)))] A_LoopField
		}Loop,parse,data,`n,% ("",Assign2:=this.line-Assign1)
			Assign1:=RegExReplace(SubStr(A_LoopField,InStr(A_LoopField,".")+1),"(&nbsp;){" (this.line<10?5:(this.line<100?4:(this.line<1000?3:2))) "}"),this.line++,Assign3:=SubStr(A_LoopField,1,InStr(A_LoopField,".")-1),textO.=SubStr(Assign3,1,InStr(Assign3,">",0,0)) SubStr(Assign3,InStr(Assign3,">",0,0)+1)+Assign2 "." this.Check2[(this.line<10?5:(this.line<100?4:(this.line<1000?3:2)))] Assign1
		ListLines,% ("On",%Temp_%.write(textO),%Temp_%.getElementById("bod").scrollIntoView(scroll))
	}
	pull()
	{	ListLines,Off
		ListLines,% ("On",Temp_:=this.edit,Data:=%Temp_%.getElementById("bod").innerText)
		return Data
	}
	run(Label)
	{	GOSUB,%Label%
	}
	save(FileName:="%A_ScriptDir%\AutoHotkey Console Debug.txt",HTML:="",Overwrite:=0)
	{	ListLines,Off
		Transform,FileName,deref,%FileName%
		If(Overwrite,Temp_:=this.edit,Data:=(HTML?%Temp_%.getElementById("bod").innerHTML:%Temp_%.getElementById("bod").innerText))
			FileDelete,%FileName%
		FileAppend,%Data%,%FileName%
		ListLines,On
	}
	show()
	{	ListLines,Off
		Gui,% this.name ":Show"
		ListLines,On
	}
	timeSinceLastCall(id:=1,reset:="")
	{	static arr
		ListLines,Off
		ListLines,% ("On",(!arr?arr:={}:""),(reset?(arr[id,0]:="",arr[id,1]:="",arr[id,3]:=""):(arr[id,arr[id,2]:=!arr[id,2]]:=A_TickCount,time:=abs(arr[id,1]-arr[id,0]))),(time!=""?this.append(time):""))
	}
	update(debugType:="")
	{	ListLines,Off
		ListLines,% ("On",this.clear(),this.line:=0,this.log(this.debug((debugType?debugType:this.debugprev))))
	}
}
st_printArr(array,depth:=10,indentLevel:="&nbsp;&nbsp;&nbsp;")
{	static parent,pArr,depthP
	For k,v in (Array,(!IsObject(pArr)?pArr:=[]:""),(!depthP?depthP:=depth:""))
		((depthP=depth||depthP<depth)?parent:=SubStr(a:=SubStr(parent,1,InStr(parent,",",0,0)-1),1,InStr(a,",",0,0)):""),k:=RegExReplace(k,","),list.=(indentLevel "arr[" pArr[depth]:=parent (k&1=""?"""" k """":k) "]"),((IsObject(v)&&depth>1)?(parent.=k ",",depthP:=depth,list.="`n" st_printArr(v,depth-1,indentLevel "&nbsp;&nbsp;&nbsp;")):list.=" = " v),list.="`n"
	return RTrim(list,"`n<br/>")
}
AL_Columnize(Data,delim="csv",justify=1,pad=" ",colsep=" | ") ;Credit @ tidbit,compacted reduced code by AfterLemon
{	Loop,parse,Data,`n,% ("`r",width:=[],Arr:=[],(InStr(justify,"|")?colMode:=StrSplit(justify,"|"):colMode:=justify))
	{	If(delim="csv",row:=a_index)
			Loop,parse,A_LoopField,csv
				Arr[row,a_index]:=A_LoopField
		else Arr[a_index]:=StrSplit(A_LoopField,delim)
		(Arr[a_index].maxindex()>maxc?maxc:=Arr[a_index].maxindex():"")
	}Loop,% maxr:=Arr.maxindex()
	{	Loop,% (maxc,row:=A_Index)
		{	Loop,% ((width[maxc]?0:maxr),col:=a_index,len:=StrLen(stuff:=Arr[row,col]))
				(StrLen(Arr[a_index,col])>width[col]?width[col]:=StrLen(Arr[a_index,col]):""),PadS.=pad pad
			diff:=abs(len-width[col]),out.=((len<width[col],(isObject(colMode)?justify:=colMode[col]:""))?(justify=3?SubStr(PadS,1,floor(diff/2)) stuff SubStr(PadS,1,ceil(diff/2)):(justify=2?SubStr(PadS,1,diff) stuff:stuff SubStr(PadS,1,diff))):stuff) (col!=maxc?colsep:"")
		}out.="`n"
	}return SubStr(out,1,-2)
}
ShellMessage(wParam,lParam)	; this is used for hiding the cmd window in the console.cmd() method.
{	If(wParam=1)
	{	WinGetClass,wclass,ahk_id %lParam%
		If(wclass="ConsoleWindowClass")
			WinHide,ahk_id %lParam%
}}
Eval#(x)	; Evaluate expression with numbers,+ #(subtract) / *
{	xP:=x,RegExMatch(x,"(.*)(\+|#)(.*)",y),x:=(y2="+"?Eval#(y1)+Eval#(y3):(y2="#"?Eval#(y1)-Eval#(y3):xP)),(x=xP?(RegExMatch(x,"(.*)(\*|/)(.*)",y),x:=(y2="*"?Eval#(y1)*Eval#(y3):(y2="/"?Eval#(y1)/Eval#(y3):xP))):"")
	return (x?x:0)
}
