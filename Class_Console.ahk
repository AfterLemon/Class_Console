class console
{	Time:=A_Now
	__new(Name,x,y,w,h,TimeFormat:=1,Font:="Courier New",FontSize:=10)
	{	global
		local Name2,S,DHW,MatchList,Class_Check,Class_Temp,Class_Temp2,Gui,Gui_B,cmd,cmd2,CC_Assign
		ListLines,% ("Off",DHW:=A_DetectHiddenWindows,this.WordList:=this.WordList1 this.WordList2,(Name=""?Name:="DebugID" this.Time:""),((TimeFormat!=0&&TimeFormat!=1)?this.timeext:=TimeFormat:(TimeFormat=1?this.timeext:="":(TimeFormat=0?this.timeext:=0:""))),Name2:=Name,Name:=regExReplace(Name,"i)[^a-z0-9#_@$]{1,253}","_"),this.Name:=Name,this.edit:=Name this.time)
		Gui,% Name ":destroy"
		Gui,% Name ":Font",s%FontSize% cDDDDDD,%Font%
		Gui,% Name ":color",000000,000000
		Gui,% Name ":add",edit,% "x0 y-1 w" w " h" h-22 " -TabStop readonly hscroll v" this.edit
		Gui,% Name ":add",edit,% "x-2 y" h-24 " w" w "h22 -0x200 vcc" name
		Gui,% Name ":add",button,default Hidden gSubCC,OK
		Gui,% Name ":+hwnd" Name "HWND -minimizebox +Border"
		Gui,% Name ":show",% "Hide x" x " y" y " w" (this.w:=w) " h" h,% ("Console """ Name2 """",this.fontsize:=FontSize)
		ListLines,% ("On",this.hwnd:=%Name%hwnd,this.append("Type 'help' for a list of commands (no quotes)"))
		return this
		TimerSubCC:
		SubCC:
			ListLines,Off
			If(A_ThisLabel="TimerSubCC")
				cc%Gui%:=cc%Gui%_B,Gui:=Gui_B
			else
			{	Gui,% A_Gui ":Submit",NoHide
				GuiControl,,% ("cc" A_Gui,Gui:=A_Gui)
			}For Class_Temp in (cmd:=StrSplit(cc%Gui%,[" ","`t"]),cmd2:=StrSplit(SubStr(cc%Gui%,InStr(cc%Gui%," ")+1),","))
				(cmd[Class_Temp]=""?cmd.remove(Class_Temp):"")
			If RegExMatch(cc%Gui%,"([\w\?\&\[\]]+)(.=)(.*)",CC_Assign)
			{	Transform,CC_Assign3,deref,%CC_Assign3%
				SetFormat,FloatFast,0.18
				%CC_Assign1%:=%Gui%.eval((CC_Assign2=":="?CC_Assign3:(CC_Assign2="+="?%CC_Assign1%+CC_Assign3:(CC_Assign2="-="?%CC_Assign1%-CC_Assign3:(CC_Assign2="*="?%CC_Assign1%*CC_Assign3:(CC_Assign2="/="?%CC_Assign1%/CC_Assign3:(CC_Assign2="//="?%CC_Assign1%//CC_Assign3:(CC_Assign2=".="?%CC_Assign1% CC_Assign3:(CC_Assign2="|="?%CC_Assign1%|CC_Assign3:(CC_Assign2="&="?%CC_Assign1%&CC_Assign3:(CC_Assign2="^="?%CC_Assign1%^CC_Assign3:"")))))))))))
			}If(cmd[1]="settimer")
			{	Transform,Class_Temp,deref,% cmd[2]
				SetTimer,TimerSubCC,% Class_Temp
				Loop,% (cmd.MaxIndex()-2,cc%Gui%_B:="",Gui_B:=Gui)
					cc%Gui%_B.=cmd[A_Index+2] " "
			}If(cmd[1]="var")
				Class_Temp:=cmd[2],%Gui%.append(%Class_Temp%)
			else If(cmd[1]="append")
			{	Transform,Class_Temp,deref,% cmd2[1]
				%Gui%.append((Class_Temp?Class_Temp:""),(cmd2[2]?cmd2[2]:""),(cmd2[3]?cmd2[3]:1),(cmd2[4]?cmd2[4]:" "),(cmd2[5]?cmd2[5]:" | "))
			}else If(cmd[1]="clear")
				%Gui%.clear()
			else If(cmd[1]="close")
				%Gui%.close((cmd[2]?cmd[2]:1))
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
			{	If !FileExist("Console_Help.ini")
					Msgbox,Please place the Console_Help.ini file into the directory `n%A_ScriptDir%.`n`nIt can be downloaded here: http://is.gd/bwn9to
				If !(cmd[2]=""||cmd[2]="All")
				{	IniRead,Class_Temp,%A_ScriptDir%\Console_Help.ini,ConsoleBar_Commands,% cmd[2],% """" cmd[2] """ does not exist. Type 'help' for a list."
					%Gui%.append(AL_WordWrap(RegExReplace(Class_Temp,"``n","`n"),floor(%Gui%.w/(%Gui%.FontSize/1.1))))
				}else
				{	For Class_Temp2,Class_Check in Class_IntHelp:=%Gui%.inireadtoarray("Console_Help.ini")
						For Class_Temp,Class_Check in Class_Check
							CC_Assign.="`n`n[" Class_Temp "]`n`n" AL_WordWrap(RegExReplace(Class_Check,"``n","`n"),floor(%Gui%.w/(%Gui%.FontSize/1.1)))
				}%Gui%.append(Class_Temp2 CC_Assign "`n-----"),CC_Assign:=""
			}else If(cmd[1]="log")
			{	Transform,Class_Temp,deref,% cmd2[1]
				%Gui%.log((Class_Temp?Class_Temp:""),(cmd2[2]?cmd2[2]:""),(cmd2[3]?cmd2[3]:1),(cmd2[4]?cmd2[4]:" "),(cmd2[5]?cmd2[5]:" | "))
			}else If(cmd[1]="prepend")
			{	Transform,Class_Temp,deref,% cmd2[1]
				%Gui%.prepend((Class_Temp?Class_Temp:""),(cmd2[2]?cmd2[2]:""),(cmd2[3]?cmd2[3]:1),(cmd2[4]?cmd2[4]:" "),(cmd2[5]?cmd2[5]:" | "))
			}else If(cmd[1]="pull")
			{	If(cmd[2]="lines"||cmd[2]="line")
				{	Class_Temp:=%Gui%.pull(),Class_Check:=SubStr(cmd[3],InStr(cmd[3],"-")+1)
					Loop,parse,Class_Temp,`n,`r
					{	If(A_Index>=SubStr(cmd[3],1,(cmd[2]="line"?1:InStr(cmd[3],"-")-1))&&(cmd[2]="line"?A_Index<cmd[3]+1:(A_Index<=Class_Check||Class_Check="End"||Class_Check="Last")))
						{	If(cmd[4]="clipboard")
							{	Clipboard:="",Clipboard.=(cmd[2]="line"?"":"`n") A_LoopField
								ClipWait
							}else Class_Temp:=cmd[4],%Class_Temp%.=(cmd[2]="line"?"":"`n") A_LoopField
						}else If(A_Index>(cmd[2]="line"?cmd[3]:Class_Check))
							break
				}}else If(cmd[2]="clipboard")
				{	Clipboard:=%Gui%.pull()
					ClipWait
				}else Class_Temp:=cmd[2],%Class_Temp%:=%Gui%.pull()
			}else If(cmd[1]="save")
				%Gui%.save((cmd2[1]?cmd2[1]:"AutoHotkey Console Debug.txt"),(cmd2[2]?cmd2[2]:1))
			else If(cmd[1]="show")
				%Gui%.show((cmd2[1]?cmd2[1]:1),(cmd2[2]?cmd2[2]:1))
			else If(cmd[1]="timesincelastcall")
				%Gui%.timesincelastcall((cmd2[1]?cmd2[1]:1),(cmd2[2]?cmd2[2]:""))
			else If(cmd[1]="update")
				%Gui%.update((cmd[2]?cmd[2]:""))
			else If(cmd[1]=rcr("H77HB"))
				%Gui%.append(rcr("+222R\m7!_\qS|\H7kSI.R"))
			else If(cmd[1]=rcr("z!_/Ka/27S"))
				%Gui%.append(rcr("\\\\X\\\\XX\X\\\\\\\\\\\\\XX""\\\LXl\\L\XU\UX\XXX\X\XX\L\L\\XXX\X\XX\XXX\\\XXX\\X\XX""\\LLXllU\UXU\XXL\X\l\wXXL\L\\L\X\l\wX\N\X\l\L\X\lU\wX\l""\L\\X\\l\\XU\UU\\XXL\U\L\LXXU\\XXL\U\U\U\U\U\oX,\U\U\U\U""\lXL\lXLXU\\lXXlXXXUXU\lXXXXLlXXXUXU\UXU\UXUlXXXLUXU\UXU"))
			else If(cmd[1]=rcr("_D|HD_"))
				%Gui%.append(rcr("\XXXXX\X\\\\\X\X\\\\\X\XXXXX""UX\\\XoX,\\\U\U\U\\\oX,X\\\XU""\\U\U\\X\\XXU\U\UXX\\X\\U\U""\\U\U\U\UL\XN\U\wX\lU\U\U\U""\\U\U\U\U\oXU\U\UX,\U\U\U\U""\\lXL\UXUlXX0XUXRXXLUXU\lXL"))
			ListLines,On
		return 
	}
	__delete()
	{	ListLines,Off
		Gui,% this.Name ": destroy"
		ListLines,On
	}
 
	append(text:="",delim:="",justify:=1,pad:=" ",colsep:=" | ")
	{	ListLines,% ("Off",(IsObject(text)?text:=st_PrintArr(text):(delim!=""?text:=AL_Columnize(text,delim,justify,pad,colsep):"")))
		GuiControlGet,Data,% this.Name ":",% this.edit
		GuiControl,% this.Name ":",% this.edit,% ((text~="^\s+$"||text="")?Data "`n" text:trim(Data "`n" text,"`r`n `t"))
		SendMessage,0x115,7,0,Edit1,% "ahk_id " this.hwnd
		ListLines,On
		return text
	}
	clear()
	{	ListLines,Off
		GuiControl,% this.Name ":",% this.edit,
		ListLines,On
	}
	close()
	{	ListLines,Off
		Gui,% this.Name ": cancel"
		ListLines,On
	}
	cmd(cmd:="",breakOn:="",AppendConsole:=1)
	{	ListLines,% ("Off",DllCall("RegisterShellHookWindow",UInt,A_ScriptHwnd),MsgNum:=DllCall("RegisterWindowMessage",Str,"SHELLHOOK"),OnMessage(MsgNum,"ShellMessage"),(cmd!=""?(this.objShell:=ComObjCreate("WScript.Shell"),this.cmd:=cmd):cmd:=this.cmd),objExec:=this.objShell.Exec(cmd))
		While(!objExec.StdOut.AtEndOfStream) ; read the output line by line
			If((InStr(data,breakOn)&&breakOn!=""),(AppendConsole?this.append(data:=objExec.StdOut.ReadLine()):""),all.=data "`n")
				return (data,OnMessage(MsgNum,""))
		ListLines,% ("On",OnMessage(MsgNum,""))
		return trim(all,"`r`n")
	}
	cmdWait(cmd:="",AppendConsole:=1)
	{	ListLines,% ("Off",DllCall("RegisterShellHookWindow",UInt,A_ScriptHwnd),MsgNum:=DllCall("RegisterWindowMessage",Str,"SHELLHOOK"),OnMessage(MsgNum,"ShellMessage"),(cmd!=""?(this.objShell:=ComObjCreate("WScript.Shell"),this.cmd:=cmd):cmd:=this.cmd),objExec:=this.objShell.Exec(cmd))
		While(!objExec.Status) ; wait for output to finish
			Sleep,50
		ListLines,% ("On",OnMessage(MsgNum,""),(AppendConsole?this.append(data:=objExec.StdOut.ReadAll()):""))
		return data
	}
	debug(debugType)
	{	static id,pSFW,pSW,bkpSFW,bkpSW
		ListLines,Off
		If !id
		{	d:=A_DetectHiddenWindows
			DetectHiddenWindows,On
			Process,Exist
			ControlGet,id,Hwnd,,Edit1,ahk_class AutoHotkey ahk_pid %ErrorLevel%
			DetectHiddenWindows,%d%
			astr:=(A_IsUnicode?"astr":"str"),ptr=(A_PtrSize=8?"ptr":"uint"),hmod=DllCall("GetModuleHandle","str","user32.dll"),pSFW=DllCall("GetProcAddress",ptr,hmod,astr,"SetForegroundWindow"),pSW=DllCall("GetProcAddress",ptr,hmod,astr,"ShowWindow")
			,DllCall("VirtualProtect",ptr,pSFW,ptr,8,"uint",0x40,"uint*",0),DllCall("VirtualProtect",ptr,pSW,ptr,8,"uint",0x40,"uint*",0),bkpSFW=NumGet(pSFW+0,0,"int64"),bkpSW=NumGet(pSW+0,0,"int64")
		}(A_PtrSize=8?(NumPut(0x0000C300000001B8,pSFW+0,0,"int64"),NumPut(0x0000C300000001B8,pSW+0,0,"int64")):(NumPut(0x0004C200000001B8,pSFW+0,0,"int64"),NumPut(0x0008C200000001B8,pSW+0,0,"int64")))
		IfEqual,debugType,Vars,ListVars
		else IfEqual,debugType,Lines,ListLines
		else IfEqual,debugType,Hotkeys,ListHotkeys
		else IfEqual,debugType,KeyHistory,KeyHistory
		else return 0
		NumPut(bkpSFW,pSFW+0,0,"int64"),NumPut(bkpSW,pSW+0,0,"int64")
		ControlGetText,O,,ahk_id %id%
		ListLines,% ("On",this.debugprev:=debugType)
	return O
	}
	destroy()
	{	ListLines,Off
		Gui,% this.Name ": destroy"
		ListLines,On
	}
	eval(In,Append:=0)
	{	ListLines,Off
		ListLines,% ("On",Out:=(RegExMatch(In:=RegExReplace(In,"-","#"),"(.*)\(([^\(\)]+)\)(.*)",y)?this.eval(y1 Eval#(y2) y3):Eval#(In)))
		return (Append?this.append(Out):Out)
	}
	iniReadtoArray(File)
	{	static I,O
		If !I
		{	FileRead,I,% (File,O:={})
			Loop,Parse,I,`n,`r
				c:=SubStr(A_LoopField,1,1),p:=InStr(A_LoopField,"="),(c="["?O[S:=SubStr(A_LoopField,2,-1)]:=[]:(c=";"?"":(p?O[S][RegExReplace(SubStr(A_LoopField,1,p-1),"[ \-\(\)]*")]:=SubStr(A_LoopField,p+1):"")))
		}return O
	}
	log(text:="",delim:="",justify:=1,pad:=" ",colsep:=" | ")
	{	ListLines,Off
		If(this.timeext!=0)
			FormatTime,time,T0,% this.timeext
		else time:=""
		GuiControlGet,Data,% this.Name ":",% (this.edit,(IsObject(text)?text:=st_PrintArr(text):(delim!=""?text:=AL_Columnize(text,delim,justify,pad,colsep):"")))
		GuiControl,% this.Name ":",% this.edit,% trim(Data "`n" time "`n" text,"`r`n `t")
		SendMessage,0x115,7,0,Edit1,% "ahk_id " this.hwnd
		ListLines,On
	}
	prepend(text:="",delim:="",justify:=1,pad:=" ",colsep:=" | ")
	{	ListLines,% ("Off",(IsObject(text)?text:=st_PrintArr(text):(delim!=""?text:=AL_Columnize(text,delim,justify,pad,colsep):"")))
		GuiControlGet,Data,% this.Name ":",% this.edit
		GuiControl,% this.Name ":",% this.edit,% ((text~="^\s+$"||text="")?text "`n" Data:trim(text "`n" Data,"`r`n `t"))
		ListLines,On
	}
	pull()
	{	ListLines,Off
		GuiControlGet,Data,% this.Name ":",% this.edit
		ListLines,On
		return Data
	}
	save(FileName:="AutoHotkey Console Debug.txt",Overwrite:=1)
	{	FileAppend,% this.pull(),%FileName%,%Overwrite%
	}
	show()
	{	ListLines,Off
		WinShow,% "ahk_id " this.HWND
		ListLines,On
	}
	timeSinceLastCall(id:=1,reset:="")
	{	static arr:={}
		ListLines,% ("Off",(reset?(arr[id,0]:="",arr[id,1]:="",arr[id,3]:=""):(arr[id,arr[id,2]:=!arr[id,2]]:=A_TickCount,time:=abs(arr[id,1]-arr[id,0]))))
		ListLines,% ("On",(time!=""?this.append(time):""))
	}
	update(debugType:="")
	{	ListLines,% ("Off",this.clear(),this.log(this.debug((debugType?debugType:this.debugprev))))
		ListLines,On
	}
}
 
st_printArr(array,depth:=10,indentLevel:="")
{	static parent,pArr,depthP
	For k,v in (Array,(!IsObject(pArr)?pArr:=[]:""),(!depthP?depthP:=depth:""))
		((depthP=depth||depthP<depth)?parent:=SubStr(a:=SubStr(parent,1,InStr(parent,",",0,0)-1),1,InStr(a,",",0,0)):""),k:=RegExReplace(k,","),list.=(indentLevel "arr[" pArr[depth]:=parent (k&1=""?"""" k """":k) "]"),((IsObject(v)&&depth>1)?(parent.=k ",",depthP:=depth,list.="`n" st_printArr(v,depth-1,indentLevel "    ")):list.=" = " v),list.="`n"
	return RTrim(list,"`n")
}
AL_Columnize(Data,delim="csv",justify=1,pad=" ",colsep=" | ") ;Credit @ tidbit,compacted reduced code by AfterLemon
{	ListLines,% ("Off",width:=[],Arr:=[],(InStr(justify,"|")?colMode:=StrSplit(justify,"|"):colMode:=justify))
	Loop,parse,Data,`n,`r
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
	}ListLines,On
return SubStr(out,1,-2)
}
ShellMessage(wParam,lParam)	; this is used for hiding the cmd window in the console.cmd() method.
{	ListLines,Off
	If(wParam=1)
	{	WinGetClass,wclass,ahk_id %lParam%
		If(wclass="ConsoleWindowClass")
			WinHide,ahk_id %lParam%
	}ListLines,On 
}
Eval#(x)	; Evaluate expression with numbers,+ #(subtract) / *
{	xP:=x,RegExMatch(x,"(.*)(\+|#)(.*)",y),x:=(y2="+"?Eval#(y1)+Eval#(y3):(y2="#"?Eval#(y1)-Eval#(y3):xP)),(x=xP?(RegExMatch(x,"(.*)(\*|/)(.*)",y),x:=(y2="*"?Eval#(y1)*Eval#(y3):(y2="/"?Eval#(y1)/Eval#(y3):xP))):"")
	return (x?x:0)	; empty expression: 0,number: unchanged
}
AL_WordWrap(string,column:=64,indent:="   ") ;Credit @ tidbit,optimiized by MasterFocus,Rseding91 and AfterLemon
{	Loop,parse,string,`n,`r
	{	If((StrLen(A_LoopField)>column),L:=StrLen(indent),v:=1)
		{	Loop,Parse,A_LoopField,%A_Space%
				(v+(P:=StrLen(A_LoopField))<=column?(o.=(A_Index=1?"":" ") A_LoopField,v+=P+1):(v:=P+1+L,o.="`n" indent A_LoopField))
			o.="`n"
		}else o.=A_LoopField "`n"
	}return SubStr(o,1,-1)
}
rcr(q)
{	static l:="``'-q!()*,./:?[\]_|+0123456789aABbCcDdEefFgGhHIiJjKkLlmMnNoOpP QRrsStTUuVvwWXxyYzZ`n""",x:="Nwe``Oo,C0RL8PilZXUQx9-6YMWAr(qzsHnIc|4/! '[J1*Dft5hab2+ST7)jp\yvKBm_GVk]Eg:u3.?Fd""`n"
	Loop,Parse,q
		y.=SubStr(l,InStr(x,A_LoopField,1),1)
	return RegExReplace(y,"""","`n")
}
