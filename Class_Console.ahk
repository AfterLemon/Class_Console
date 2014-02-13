class console
{	Time:=A_Now
 
	__new(Name,x,y,w,h,TimeFormat:=1,Font:="Courier New",FontSize:=10)
	{	global
		If(Name="")
		{	random,n,0
			Name:="DebugID" n
		}If(TimeFormat!=0&&TimeFormat!=1){
			timeformat:=this.time
			FormatTime,timeext,%timeformat%,%TimeFormat%
			this.timeext:=timeext
		}else If(TimeFormat=1)
			this.timeext:=this.time
		Name2:=Name
		,Name:=regExReplace(Name,"i)[^a-z0-9#_@$]{1,253}","_")
		,this.Name:=Name
		,this.edit:=Name this.time
		Gui,% Name ":destroy"
		Gui,% Name ":Font",s%FontSize% cDDDDDD,%Font%
		Gui,% Name ":color",000000
		Gui,% Name ":add",edit,% "x0 y-1 w" w " h" h " readonly hscroll v" this.edit
		Gui,% Name ":+hwnd" Name "HWND -minimizebox +Border"
		Gui,% Name ":show",Hide,% "Console """ Name2 """"
		this.hwnd:=%Name%hwnd,DHW:=A_DetectHiddenWindows
		DetectHiddenWindows,On
		WinGet,S,Style,% "ahk_id " this.hwnd
		DetectHiddenWindows,%DHW%
		this.TVDef:=[x,y,w+2,h+24,S]
	}
	__delete()
	{	Gui,% this.Name ": destroy"
	}
 
	append(text:="",delim:="",justify:=1,pad:=" ",colsep:=" | ")
	{	If(IsObject(text))
			text:=st_PrintArr(text)
		else If(delim!="")
			text:=AL_Columnize(text,delim,justify,pad,colsep)
		GuiControlGet,Data,% this.Name ":",% this.edit
		GuiControl,% this.Name ":",% this.edit,% ((text~="^\s+$"||text="")?Data "`n" text:trim(Data "`n" text,"`r`n `t"))
		SendMessage,0x115,7,0,Edit1,% "ahk_id " this.hwnd
	}
	clear()
	{	GuiControl,% this.Name ":",% this.edit,
	}
	close(TV:=1)
	{	If TV
			this.TV(this.hwnd,100,100)
		Gui,% this.Name ": cancel"
	}
	debug(debugType)
	{	static id,pSFW,pSW,bkpSFW,bkpSW
		ListLines,Off
		If !id{
			d:=A_DetectHiddenWindows
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
		ListLines,On
		this.debugprev:=debugType
	return O
	}
	destroy(TV:=1)
	{	If TV
			this.TV(this.hwnd,100,100)
		Gui,% this.Name ": destroy"
	}
	log(text:="",delim:="",justify:=1,pad:=" ",colsep:=" | ")
	{	If(IsObject(text))
			text:=st_PrintArr(text)
		else If(delim!="")
			text:=AL_Columnize(text,delim,justify,pad,colsep)
		GuiControlGet,Data,% this.Name ":",% this.edit
		GuiControl,% this.Name ":",% this.edit,% ((text~="^\s+$"||text="")?Data (this.timeext?"`n" this.timeext:"") "`n" text:trim(Data (this.timeext?"`n" this.timeext:"") "`n" text,"`r`n `t"))
		SendMessage,0x115,7,0,Edit1,% "ahk_id " this.hwnd
	}
	prepend(text:="",delim:="",justify:=1,pad:=" ",colsep:=" | ")
	{	If(IsObject(text))
			text:=st_PrintArr(text)
		else If(delim!="")
			text:=AL_Columnize(text,delim,justify,pad,colsep)
		GuiControlGet,Data,% this.Name ":",% this.edit
		GuiControl,% this.Name ":",% this.edit,% ((text~="^\s+$"||text="")?text "`n" Data:trim(text "`n" Data,"`r`n `t"))
	}
	pull()
	{	GuiControlGet,Data,% this.Name ":",% this.edit
	return Data
	}
	save(FileName:="AutoHotkey Console Debug.txt",Overwrite:=1)
	{	FileAppend,% this.pull(),%FileName%,%Overwrite%
	}
	show(Show:=1,TV:=1)
	{	If TV{
			DHW:=A_DetectHiddenWindows
			DetectHiddenWindows,On
			(Show?this.TV(this.hwnd,100,100,this.TVDef*):this.TV(this.hwnd,100,100))
			DetectHiddenWindows,%DHW%
		}else WinShow,ahk_id %HWND%
	}
	TV(HWND,HeightStep:=100,WidthStep:=100,TVDef*)
	{	static p:=[]
		WinDelay:=A_WinDelay
		If TVDef
			p[HWND]:=TVDef
		SetWinDelay,-1
		If p[HWND].1{
			x:=p[HWND].1+(p[HWND].3/2),y:=p[HWND].2+(p[HWND].4/2),Step:=p[HWND].4/HeightStep,Step2:=p[HWND].3/WidthStep
			WinMove,ahk_id %HWND%,,x,y,(p[HWND].5&0xC00000?-3:3),(p[HWND].5&0xC00000?-25:3)
			WinShow,ahk_id %HWND%
			Loop,% WidthStep
				WinMove,ahk_id %HWND%,,% xn:=x-((Step2*A_Index)/2),,% wn:=p[HWND].3-(Step2*(WidthStep-A_Index))
			If(p[HWND].5&0xC00000)
				WinSet,Style,+0xC00000,ahk_id %HWND%
			Loop,% HeightStep
				WinMove,ahk_id %HWND%,,,% yn:=y-((Step*A_Index)/2),,% hn:=p[HWND].4-(Step*(HeightStep-A_Index))
			p[HWND]:=""
		}else{
			WinGetPos,x,y,w,h,ahk_id %HWND%
			WinGet,S,Style,ahk_id %HWND%
			p[HWND]:=[x,y,w,h,S],Step:=(h-3)/HeightStep,Step2:=(w-3)/WidthStep
			Loop,% HeightStep
				WinMove,ahk_id %HWND%,,,% y:=y+(Step/2),,% h:=h-Step
			WinSet,Style,-0xC00000,ahk_id %HWND%
			WinSet,Redraw,,ahk_id %HWND%
			Loop,% WidthStep
				WinMove,ahk_id %HWND%,,% x:=x+(Step2/2),,% w:=w-Step2
			WinHide,ahk_id %HWND%
			WinMove,ahk_id %HWND%,,% p[HWND].1,% p[HWND].2,% p[HWND].3,% p[HWND].4
		}SetWinDelay,%WinDelay%
	}
	update(debugType:="")
	{	this.clear(),this.log(this.debug((debugType?debugType:this.debugprev)))
	}
}
 
st_printArr(array,depth:=5,indentLevel:="")
{	static parent,sub,depthP
	For k,v in (Array,(!depthP?depthP:=depth:""))
		(depthP!=depth?sub+=1:(sub:=0,parent:="")),list.=(sub>=1?indentLevel "arr[" parent k "]":indentLevel "arr[" k "]"),((IsObject(v)&&depth>1)?(parent.=k ",",list.="`n" st_printArr(v,depth-1,indentLevel "    ")):list.=" = " v),list.="`n"
	return RTrim(list,"`n")
}
 
AL_columnize(Data,delim="csv",justify=1,pad=" ",colsep=" | "){ ;Credit @ tidbit,compacted reduced code by AfterLemon
	width:=[],Arr:=[],(InStr(justify,"|")?colMode:=StrSplit(justify,"|"):colMode:=justify)
	Loop,parse,Data,`n,`r
	{	If(delim="csv",row:=a_index)
			Loop,parse,A_LoopField,csv
				Arr[row,a_index]:=A_LoopField
		else Arr[a_index]:=StrSplit(A_LoopField,delim)
		(Arr[a_index].maxindex()>maxc?maxc:=Arr[a_index].maxindex():"")
	}Loop,% maxr:=Arr.maxindex(){
		Loop,% (maxc,row:=A_Index){
			Loop,% ((width[maxc]?0:maxr),col:=a_index,len:=StrLen(stuff:=Arr[row,col]))
				(StrLen(Arr[a_index,col])>width[col]?width[col]:=StrLen(Arr[a_index,col]):""),PadS.=pad pad
			diff:=abs(len-width[col]),out.=((len<width[col],(isObject(colMode)?justify:=colMode[col]:""))?(justify=3?SubStr(PadS,1,floor(diff/2)) stuff SubStr(PadS,1,ceil(diff/2)):(justify=2?SubStr(PadS,1,diff) stuff:stuff SubStr(PadS,1,diff))):stuff) (col!=maxc?colsep:"")
		}out.="`r`n"
}return SubStr(out,1,-2)
}
