#Requires AutoHotkey v2.0
scrollUp := false
scrollDown := false
PgUp:: {
    global scrollUp, scrollDown
    scrollUp := !scrollUp
    if scrollUp {
        scrollDown := false
        SetTimer scrollDownFunc, 0
    }
    SetTimer scrollUpFunc, scrollUp ? 1 : 0
    updateTip()
}
PgDn:: {
    global scrollUp, scrollDown
    scrollDown := !scrollDown
    if scrollDown {
        scrollUp := false
        SetTimer scrollUpFunc, 0
    }
    SetTimer scrollDownFunc, scrollDown ? 1 : 0
    updateTip()
}
scrollUpFunc() {
    Send "{WheelUp 5}"
}
scrollDownFunc() {
    Send "{WheelDown 5}"
}
updateTip() {
    global scrollUp, scrollDown
    text := "滚轮状态:`n"
    text .= "上滚: " (scrollUp ? "开启" : "关闭") "`n"
    text .= "下滚: " (scrollDown ? "开启" : "关闭")
    sw := A_ScreenWidth
    sh := A_ScreenHeight
    ToolTip(text, sw - 150, sh - 80)
}
