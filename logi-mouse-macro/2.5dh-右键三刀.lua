Macro_LoopInterval = 10 --脚本循环间隔（毫秒）

function OnEvent(event, arg, family)
    --if (event == "G_RELEASED" and arg == 4) then --4为罗技键盘G4键

    if (event == "MOUSE_BUTTON_RELEASED" and arg == 5) then --3为罗技鼠标中键，5为侧键前进，4为侧键返回

        Dh_Macro_FullyAuto()
    end
end

function Dh_Macro_FullyAuto()
    if not IsKeyLockOn("capslock") then
        PressAndReleaseKey("capslock")
        Sleep(10)
    end

    if (IsKeyLockOn("capslock")) then
        --按下并释放1键（刀扇）、2键（翅膀）、4键（复仇）

        PressAndReleaseKey("1", "4", "2")
        
        --按住鼠标右键（启动右键飞刀）
        PressMouseButton(3)
        Alt_Pressed = false
        		   
        Times_Key_1 = 0
        Times_Key_4 = 0
    end

    --如果CapsLock键已按下则启动循环，否则退出循环

    while (IsKeyLockOn("capslock")) do               
        Sleep(Macro_LoopInterval) --循环间隔

               
        Times_Key_1 = Times_Key_1 + Macro_LoopInterval
        Times_Key_4 = Times_Key_4 + Macro_LoopInterval
        
        --每0.5秒按下并释放4键（复仇）

        if (Times_Key_4 >= 500) then
            PressAndReleaseKey("4")
            Times_Key_4 = 0
        end
        
        --每1秒按下并释放1键（刀扇）

        if (Times_Key_1 >= 1000) then
            PressAndReleaseKey("1")
            Times_Key_1 = 0
        end

        --按住lalt键中断旋风斩（捡东西）

        if (IsModifierPressed("lalt")) then 
            if not (Alt_Pressed) then
                ReleaseMouseButton(3)
                Alt_Pressed = true
            end
        else
            if (Alt_Pressed) then
                PressMouseButton(3)
                Alt_Pressed = false
            elseif not (IsMouseButtonPressed(3)) then
                ReleaseMouseButton(3)
                PressMouseButton(3)
            end
        end
    end
        
    ReleaseMouseButton(3)
end
