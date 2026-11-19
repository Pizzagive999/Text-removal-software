#Requires AutoHotkey v2.0
#SingleInstance Force

; Text Formatting Toolkit v5.0
; Ctrl+Alt+O = turn cleaning ON/OFF
; Ctrl+Alt+P = clean ONLY the currently selected text (when ON)
;
; Removes: . , ' " : ; [ ] -
; Keeps: ! ? ( )
; Also changes standalone "an" to "a".
; Lowercases the first character of each sentence, except standalone "I".

cleanerEnabled := false
cleanerStatusFile := A_Temp "\TextToolkitCleanerStatus.ini"
disableCleanerMsg := DllCall("RegisterWindowMessage", "Str", "TextToolkit_DisableCleaner", "UInt")
OnMessage(disableCleanerMsg, DisableCleaner)
OnExit(CleanerExit)
WriteCleanerStatus()

; --- STARTUP GUIDE ---
MyGui := Gui("+AlwaysOnTop -MinimizeBox -MaximizeBox", "Quick Guide")
MyGui.SetFont("s10.5", "Segoe UI")
MyGui.Add("Text", "w320", "Text Formatting Toolkit Loaded!")
MyGui.Add("Text", "xp y+10 w320", "Press Ctrl+Alt+O to turn cleaning ON/OFF.`nWhen ON: highlight text, then press Ctrl+Alt+P.")
MyGui.Add("Button", "w90 x125 y+15 Default", "Got it").OnEvent("Click", CloseGuide)
MyGui.Show("w340")

ShowStatus("Text Toolkit loaded - cleaning is OFF", 1800)

^!o::
{
    global cleanerEnabled
    cleanerEnabled := !cleanerEnabled

    WriteCleanerStatus()
    if cleanerEnabled
        ShowStatus("Text Toolkit: CLEANING ON")
    else
        ShowStatus("Text Toolkit: CLEANING OFF")
}

^!p::
{
    global cleanerEnabled

    if !cleanerEnabled
    {
        ShowStatus("Cleaning is OFF - press Ctrl+Alt+O to turn it ON")
        return
    }

    savedClipboard := ClipboardAll()
    A_Clipboard := ""
    Send "^c"

    if !ClipWait(2)
    {
        A_Clipboard := savedClipboard
        ShowStatus("No text selected, or copying was blocked")
        return
    }

    cleanedText := A_Clipboard
    cleanedText := SmartSentenceLower(cleanedText)
    cleanedText := RegExReplace(cleanedText, "i)\ban\b", "a")

    for character in [".", ",", "'", '"', ":", ";", "[", "]", "-"]
        cleanedText := StrReplace(cleanedText, character, "")

    A_Clipboard := cleanedText
    Send "^v"
    Sleep 400
    A_Clipboard := savedClipboard
    ShowStatus("Selected text cleaned!")
}

SmartSentenceLower(text)
{
    result := ""
    atSentenceStart := true

    Loop Parse, text
    {
        char := A_LoopField

        if atSentenceStart
        {
            if (char = " " || char = "`t" || char = "`r" || char = "`n")
            {
                result .= char
                continue
            }

            currentIndex := A_Index
            nextChar := (currentIndex < StrLen(text)) ? SubStr(text, currentIndex + 1, 1) : ""
            isWordI := (StrLower(char) = "i")
                && (nextChar = "" || !RegExMatch(nextChar, "^[A-Za-z0-9_]$"))

            if isWordI
                result .= "I"
            else
                result .= StrLower(char)

            atSentenceStart := false
        }
        else
        {
            result .= char
        }

        if (char = "." || char = "!" || char = "?")
            atSentenceStart := true
    }

    return result
}

ShowStatus(message, duration := 1400)
{
    ToolTip message
    SetTimer () => ToolTip(), -duration
}

CloseGuide(*)
{
    global MyGui
    MyGui.Destroy()
}


; Shared status lets Text Restoration Toolkit detect when this cleaner is ON.
WriteCleanerStatus()
{
    global cleanerEnabled, cleanerStatusFile
    IniWrite(cleanerEnabled ? "1" : "0", cleanerStatusFile, "Cleaner", "Enabled")
    IniWrite(A_Pid, cleanerStatusFile, "Cleaner", "PID")
    IniWrite(A_ScriptHwnd, cleanerStatusFile, "Cleaner", "HWND")
}

; The restoration toolkit sends this message after the user chooses YES.
DisableCleaner(wParam, lParam, msg, hwnd)
{
    global cleanerEnabled
    cleanerEnabled := false
    WriteCleanerStatus()
    ShowStatus("Text Toolkit: CLEANING OFF (paused by Restoration Toolkit)")
    return 1
}

CleanerExit(*)
{
    global cleanerStatusFile
    try
    {
        storedPid := IniRead(cleanerStatusFile, "Cleaner", "PID", "0")
        if (storedPid = A_Pid)
            IniWrite("0", cleanerStatusFile, "Cleaner", "Enabled")
    }
}
