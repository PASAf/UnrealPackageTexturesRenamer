Gui, New
Gui, Add, Text,, .uc directory:
Gui, Add, Edit, vSource
Gui, Add, Button, x135 y23 gSOpen, ...
Gui, Add, Text, xm, Textures directory:
Gui, Add, Edit, vDest
Gui, Add, Button, x135 y70 gDOpen, ...
Gui, Add, Button, xm, Do
Gui, Show,, Textures renamer
return

SOpen:
DirSelect, oSource
GuiControl,, Source, %oSource%
return

DOpen:
DirSelect, oDest
GuiControl,, Dest, %oDest%
return

ButtonDo:
Gui, Submit
SrcList := ""
Loop, Files, %Source%\*.uc
{
	SrcList .= A_LoopFileName "`n"
}

Loop, Parse, %SrcList%, `n
{
	Loop, Read, %Source%\%A_LoopField%
	{
		if(InStr(A_LoopReadLine, "#EXEC TEXTURE IMPORT") != 1)
		{
			continue
		}
		else
		{
			NamePosStart 		:= InStr(A_LoopReadLine, "NAME=") + 5
			NamePosEnd 			:= InStr(A_LoopReadLine, "FILE=", false, NamePosStart)
			Name 				:= Trim(SubStr(A_LoopReadLine, NamePosStart, NamePosEnd-NamePosStart))
			RealNamePosStart	:= NamePosEnd + 5
			RealNamePosEnd		:= InStr(A_LoopReadLine, "GROUP=", false, RealNamePosStart)
			RealName 			:= Trim(SubStr(A_LoopReadLine, RealNamePosStart, RealNamePosEnd-RealNamePosStart))
			Extension			:= SubStr(RealName, -4)
			RunWait, xcopy "%Dest%\%Name%%Extension%" "%Dest%\%RealName%*",,UseErrorLevel
			if (A_LastError != 0)
			{
				MsgBox, 16, Error, There error araised while trying to copy`n%Dest%\%Name%%Extension%`nto`n%Dest%\%RealName%`nTexture mentioned in %A_LoopField%:%A_Index%
			}
			else if (FileExist(Dest . "\" . Name . Extension) == "")
			{
				MsgBox, 48, Warning, Texture`n%Dest%\%Name%%Extension%`nmentioned in %A_LoopField%:%A_Index% not found!
			}
		}
	}
}
