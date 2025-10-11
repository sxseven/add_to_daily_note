class DailyNoteInput {
    __New() {
        this.result := ""
        this.canceled := false
        this.gui := Gui("+AlwaysOnTop")
        this.gui.SetFont("s13", "KaiTi")
        this.gui.Title := "添加内容"
        screenWidth := A_ScreenWidth
        screenHeight := A_ScreenHeight

        ; === 可配置参数 ===
        ; 计算输入框大小
        editWidth := Round(screenWidth * 0.2)
        editHeight := Round(screenHeight * 0.1)
        ; 计算按钮宽度
        btnWidth := Round(editWidth * 0.2)
        btnSpacing := 10  ; 按钮之间的间距
        ; 计算 GUI 显示位置（屏幕比例，坐标原点为屏幕左上角）
        xPos := Round(screenWidth * 0.25)
        yPos := Round(screenHeight * 0.55)
        
        ; 添加多行编辑框
        this.edit := this.gui.Add("Edit", "W" editWidth " H" editHeight " Multi WantReturn")
        
        ; === 动态计算按钮位置（靠右）===
        totalBtnWidth := btnWidth * 2 + btnSpacing
        buttonX := editWidth - totalBtnWidth  ; 从编辑框右侧往左推
        
        ; 添加按钮（放在编辑框下方，靠右）
        okBtn := this.gui.Add("Button", "Section x" buttonX " w" btnWidth " Default", "确定")
        cancelBtn := this.gui.Add("Button", "x+" btnSpacing " w" btnWidth, "取消")
        
        ; 绑定事件
        okBtn.OnEvent("Click", this.OkClick.Bind(this))
        cancelBtn.OnEvent("Click", this.CancelClick.Bind(this))
        
        
        this.gui.Show("x" xPos " y" yPos)
        this.gui.OnEvent("Close", this.CancelClick.Bind(this))
        
        this.waiting := true
        while this.waiting {
            Sleep(100)
        }
    }
    
    OkClick(*) {
        this.result := this.edit.Value
        this.canceled := false
        this.gui.Destroy()
        this.waiting := false
    }
    
    CancelClick(*) {
        this.canceled := true
        this.gui.Destroy()
        this.waiting := false
    }
}

^+d::
{
    inputDialog := DailyNoteInput()
    
    if (inputDialog.canceled or inputDialog.result = "")
        return

    psScript := "请修改为你自己的ps1文件绝对地址"
    safeInput := StrReplace(inputDialog.result, '"', '""')
    cmd := Format('powershell.exe -ExecutionPolicy Bypass -File "{1}" "{2}"', psScript, safeInput)
    
    Run(cmd, , "Hide")
    
    ToolTip("记录已保存", , , 1)
    SetTimer(RemoveToolTip, -1000)
}

RemoveToolTip() {
    ToolTip()
}