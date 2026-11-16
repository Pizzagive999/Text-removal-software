#Requires AutoHotkey v2.0
#SingleInstance Force

; Punctuator Remover v2.0
; Ctrl+Alt+O toggles the cleaner ON/OFF.
; When ON, select text and press Ctrl+Shift+P to clean only that selection.
; Removes: . , ' " : ; [ ]
; Keeps: ! ? ( )

cleanerEnabled := false

^!o::
{
    global cleanerEnabled
    cleanerEnabled := !cleanerEnabled

    if cleanerEnabled
        ToolTip "Punctuator Remover: ON"
    else
        ToolTip "Punctuator Remover: OFF"

    SetTimer () => ToolTip(), -1200
}

^+p::
{
    global cleanerEnabled

    if !cleanerEnabled
    {
        ToolTip "Punctuator Remover is OFF. Press Ctrl+Alt+O to turn it ON."
        SetTimer () => ToolTip(), -1600
        return
    }

    savedClipboard := ClipboardAll()
    A_Clipboard := ""

    Send "^c"

    if !ClipWait(1)
    {
        A_Clipboard := savedClipboard
        ToolTip "No text selected"
        SetTimer () => ToolTip(), -1200
        return
    }

    cleanedText := A_Clipboard

    for character in [".", ",", "'", '"', ":", ";", "[", "]"]
        cleanedText := StrReplace(cleanedText, character, "")

    A_Clipboard := cleanedText
    Send "^v"
    Sleep 300
    A_Clipboard := savedClipboard

    ToolTip "Selected text cleaned!"
    SetTimer () => ToolTip(), -1200
}
