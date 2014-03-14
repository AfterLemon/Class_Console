# Class_Console

This class is meant to simplify debugging for scripts from simple text 
handling, to outputting and logging data & arrays. 

|Name:      |[Class] Console |
|-----------|----------------|
|Version:	| 1.8 (Tue March 11, 2014) |
|Created:	| Tue February 11, 2014    |
|Authors:	| AfterLemon tidbit        | 
|GitHub:	| https://github.com/AfterLemon/Class_Console |
|AHKScript:	| http://ahkscript.org/boards/viewtopic.php?f=6&t=2116&p=14026 | 
|AutoHotkey:| http://www.autohotkey.com/board/topic/101881-class-console-standardized-console-gui-with-methods/ |

## Usage

You can place Class_Console.ahk in your LIB directory (see [http://ahkscript.org/docs/Functions.htm#lib](http://ahkscript.org/docs/Functions.htm#lib))
or use #include (see [http://ahkscript.org/docs/commands/_Include.htm](http://ahkscript.org/docs/commands/_Include.htm))

## Class

This creates a new console object with the name of "Name":

   ```autohotkey
Class_Console(Name,x,y,w,h [,GuiTitle,Timestamp,HTML,Font,Fontsize])
   ```
   
The following methods are available:

**Methods:**

**Append**: Add text to the end of the console without a timestamp:

   ```autohotkey
name.append([text,delim,justify,pad,colsep])
   ```
   
**Catch**: Detect when a variable is a certain value or a certain line of code is executed.
   ```autohotkey
name.catch([line,var,value])
   ```

**Clear**: Remove all the text on the console.

   ```autohotkey
name.clear()
   ```
**Close**: Close console but don't destroy it. Basically you Hide it.

   ```autohotkey
name.close()
   ```

**Color**: Sets text color for following lines. Default is white. Specify "list" to see the color table.   
Available colors: yellow, orange, white, red, blue, lime, green, gray, black 

   ```autohotkey
name.color([c])
   ```
   
**Cmd**: Run (and return) a command-prompt command and get the input line-by-line.

   ```autohotkey
name.cmd(command [,breakOn,AppendConsole])
   ```
**CmdWait**: Run (and return) a command-prompt command and wait for it to fully finish.

   ```autohotkey
name.cmdWait(command [,AppendConsole])
   ```

**Destroy**: Destroy the console, it can not be shown until recreated.

   ```autohotkey
name.destroy()
   ```

**Debug**: Show AHK's debug info: KeyHistory, ListVars (Vars), ListLines (Lines), and ListHotkeys (Hotkeys).

   ```autohotkey
name.debug(debugType)
   ```

**Eval**: Evaluate expression with numbers,+ # - / and *.

   ```autohotkey
name.eval(In [,Append])
   ```

**Log**: Same as append, but with a timestamp.

   ```autohotkey
name.log([text,delim,justify,pad,colsep])
   ```

**Prepend**: Same as append, but adds the text to the TOP (line 1) of the console.

   ```autohotkey
name.prepend([text,delim,justify,pad,colsep])
   ```

**Pull**: Get the current console text.

   ```autohotkey
name.pull()
   ```

**Save**: Save the console to a file.

   ```autohotkey
name.save([FileName,Overwrite (flag)])
   ```

**Show**: Show a closed or recently created console.

   ```autohotkey
name.show(GuiName)
   ```

**timeSinceLastCall**: Get the amount of time (in MS) since the last time this function was called.

   ```autohotkey
name.timeSinceLastCall([id,reset])
   ```

**Update**: This is similar to doing a CLEAR and then LOG(DEBUG()).

   ```autohotkey
name.update(debugType)
   ```

## ConsoleBar_Commands

### !ExitApp

Desc:    Exits entire script.  
Syntax:  ExitApp

### *Catch

Desc:    Detect when a variable is a certain value,  
OR       Detect when a line in ListLines exists.  
Syntax:  catch var varName Value command  
Syntax:  catch var line DebugLineNum Command  
Example: catch var d 4 prepend %d%  
Example: catch line 11 log line 11 was accessed!

### *Settimer

Desc:    Run a  
[command] every N milliseconds (1000=1 second, 5000=5 seconds, etc).  
Syntax:  SetTimer N command  
Example: SetTimer 1000 var Banana

### ?About

Desc:    Show information about this Console and its Creators.  
Syntax:  About

### Append

Desc:    Add text to the end of the console.  
You may use variables such as %varName%.  
Syntax:  Append Text  
Example: Append I'm at the end of the log! For now...

### Clear

Desc:    Clear all text in the console.  
Syntax:  Clear

### Close

Desc:    Close (or hide) the console. It can be re-shown.  
Syntax:  Close

### Cmd

Desc:    Run cmd.exe commands here. You can ping, run programs, whatever you want. Output will go to the console. This gets stuff line-by-line.  
Syntax:  cmd cmd.exe stuff  
Example: Cmd ipconfig

### CmdWait

Desc:    Run cmd.exe commands here. You can ping, run programs, whatever you want. Output will go to the console. This waits for the whole command to finish before printing to the console.  
Syntax:  CmdWait cmd.exe stuff  
Example: CmdWait ipconfig

### Color

Desc:    Apply a color  
[N] to all below lines.  
Available colors: Yellow, Orange, White, Red, Blue, Lime, Green, Gray, Black.  
Or type 'color list' for a visual list of all the colors.  
Syntax:  Color N|List  
Example: color blue  
Example: color list

### Debug

Desc:    Get various AHK debugging info such as Last Lines.  
UNIT should be one of the following: Hotkeys, KeyHistory, Lines or Vars  
Syntax:  debug UNIT  
Example: Debug Vars

### Destroy

Desc:    Destroy the console. It can NOT be re-shown.  
Syntax:  Destroy  
Example: Destroy

### Log

Desc:    Add text to the end of the console with a formatted timestamp above the new text.  
You may use variables such as %varName%.  
Syntax:  Log Text  
Example: Log Some new data

### Operators

Desc:    Create and/or do math or do other unforsaken things to variables, such as append text. You do not need to use quotes around text.  
Available Operators: := .= += -= *= /= //= &= ^= |=  
Syntax:  var+=5  
Example: SomeVar.=New text at the end.

### Prepend

Desc:    Adds text to the TOP of the console, not the bottom.  
You may use variables such as %varName%.  
Syntax:  Prepend Text  
Example: Prepend I'M ON TOP OF THE WOR... CONSOLE!

### Pull

Desc:    Pulls data from console window (line/lines specifies the line numbers) and saves it in a variable (or the clipboard).  
Syntax:  Pull   
[lines|line First-Last|N] VarName|Clipboard  
Example: Pull banana  
OR       Pull lines 1-10 banana  
OR       Pull line 3 banana

### Run

Desc:    Runs a label within the script.  
Syntax:  Run Label  
Example: Run BananaLabel -> BananaLabel: ....

### Save

Desc:    Save the console text to the specified file.  
Syntax:  Save Filepath  
Example: Save C:\blah\log.txt

### Show

Desc:    Show a specified closed (not destroyed) console or reshow the current one.  
Syntax:  Show NAME  
Example: Show Variable

### TimeSinceLastCall

Desc:    ID and Reset are optional. Appends time in milliseconds since the last time this command was run.  
Syntax:  TimeSinceLastCall ID Reset  
Example: TimeSinceLastCall 1

### Update

Desc:    Uses last Debug UNIT, clearing the log and re-running the debug.  
Syntax:  Update  
Example: Debug vars --> SetTimer 3000 Update

### Var

Desc:    Print the value of a variable to the console. no %'s needed.  
-1 = Prepend, 1 = Log. Default is Append.  
Syntax:  Var VariableName (-1,0,1)  
Example: Var Banana

## Example

   ```autohotkey
; create the console with a long time/date timestamp.
; it can now be called using "a." followed by the above method list.
Class_Console("a", 100, 100, 500, 300, 1)
a.show() ; show the console we just made
a.log("Hello!")            ; Print your message to it with a timestamp.
a.append("console class!") ; Add another message but with no timestamp.
Sleep, 2000                ; Wait two seconds before we clear it.
a.clear()                  ; Clear (empty the view) console.
a.cmdWait("ipconfig")      ; Show the 'ipconfig' data in your console.
Sleep, 3000                ; Wait three second.
a.destroy()                ; Permenantly destroy the "a." console. It'll need to be recreated for further use.
; ... Please view the demo files for other examples.
   ```
