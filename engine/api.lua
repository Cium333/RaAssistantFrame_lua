local Call_Window = 1
local Call_Dm = 2
local Call_DD = 3
local Call_SendInput = 4
local Call_OpenCV = 5
local Call_RapidOCR = 6

Engine = {}
Engine.Window = {
    -- -> hwnd,table
    Find = function(title, class, parentHandle, searchAll, pid, processName, isView)
        return R_Call(Call_Window, 1, title, class, parentHandle, searchAll, pid, processName, isView)
    end,
    GetTitle = function(hwnd)
        return tostring(R_Call(Call_Window, 2, hwnd))
    end,
    GetClass = function(hwnd)
        return tostring(R_Call(Call_Window, 3, hwnd))
    end,
    GetRect = function(hwnd)
        return R_Call(Call_Window, 4, hwnd)
    end,
    Move = function(hwnd, x, y, width, height)
        R_Call(Call_Window, 5, hwnd, x, y, width, height)
    end,
    Active = function(hwnd)
        R_Call(Call_Window, 6, hwnd)
    end,
    HwndToPid = function(hwnd)
        return R_Call(Call_Window, 7, hwnd)
    end,
    EnumWindow = function(hwnd)
        return R_Call(Call_Window, 8, hwnd)
    end,
    SetTitle = function(hwnd, title)
        R_Call(Call_Window, 9, hwnd, title)
    end
}

Engine.Dm = {
    Create = function(id)
        R_Call(Call_Dm, 1, id)
    end,
    BindWindow = function(id, hwnd, display, mouse, keypad, public, mode)
        return R_ToNumber(R_Call(Call_Dm, 2, id, hwnd, display, mouse, keypad, public, mode))
    end,
    UnbindWindow = function(id)
        R_Call(Call_Dm, 3, id)
    end,
    FindColor = function(id, x1, y1, x2, y2, color, sim)
        local table = { ret = 0, x = 0, y = 0 }
        table.ret, table.x, table.y = R_Call(Call_Dm, 4, id, x1, y1, x2, y2, color, sim)
        return table
    end,
    FindMultiColor = function(id, x1, y1, x2, y2, firstColor, offsetColor, sim, dir)
        local table = { ret = 0, x = 0, y = 0 }
        table.ret, table.x, table.y = R_Call(Call_Dm, 5, id, x1, y1, x2, y2, firstColor, offsetColor, sim, dir)
        return table
    end,
    FindPic = function(id, x1, y1, x2, y2, pic, color, sim, dir)
        local table = { ret = -1, x = 0, y = 0 }
        table.ret, table.x, table.y = R_Call(Call_Dm, 6, id, x1, y1, x2, y2, pic, color, sim, dir)
        return table
    end,
    FindString = function(id, hwnd, addr, value, type, step, thread, mode)
        return tostring(R_Call(Call_Dm, 7, id, hwnd, addr, value, type, step, thread, mode))
    end,
    FindeStrFast = function(id, x1, y1, x2, y2, str, color, sim)
        local table = { ret = -1, x = 0, y = 0 }
        table.ret, table.x, table.y = R_Call(Call_Dm, 8, id, x1, y1, x2, y2, str, color, sim)
        return table
    end,
    Ocr = function(id, x1, y1, x2, y2, color, sim)
        return tostring(R_Call(Call_Dm, 9, id, x1, y1, x2, y2, color, sim))
    end,
    GetColorNum = function(id, x1, y1, x2, y2, color, sim)
        return R_ToNumber(R_Call(Call_Dm, 10, id, x1, y1, x2, y2, color, sim))
    end,
    SetDict = function(index, file)
        return R_ToNumber(R_Call(Call_Dm, 11, index, file))
    end,
    MoveTo = function(id, x, y)
        R_Call(Call_Dm, 12, id, x, y)
    end,
    MoveR = function(id, rx, ry)
        R_Call(Call_Dm, 13, id, rx, ry)
    end,
    LeftUp = function(id)
        R_Call(Call_Dm, 14, id)
    end,
    LeftDown = function(id)
        R_Call(Call_Dm, 15, id)
    end,
    LeftClick = function(id)
        R_Call(Call_Dm, 16, id)
    end,
    LeftDoubleClick = function(id)
        R_Call(Call_Dm, 17, id)
    end,
    KeyUp = function(id, vk)
        R_Call(Call_Dm, 18, id, vk)
    end,
    KeyDown = function(id, vk)
        R_Call(Call_Dm, 19, id, vk)
    end,
    KeyPress = function(id, vk)
        R_Call(Call_Dm, 20, id, vk)
    end,
    KeyPressStr = function(id, str, delay)
        return R_ToNumber(R_Call(Call_Dm, 21, id, str, delay))
    end,
    SendString = function(id, hwnd, str)
        R_Call(Call_Dm, 22, id, hwnd, str)
    end,
    SendString2 = function(id, hwnd, str)
        R_Call(Call_Dm, 23, id, hwnd, str)
    end,
    Capture = function(id, x1, y1, x2, y2, file)
        return R_ToNumber(R_Call(Call_Dm, 24, id, x1, y1, x2, y2, file))
    end,
    ClientToScreen = function(id, hwnd, x, y)
        local table = { ret = 0, x = 0, y = 0 }
        table.ret, table.x, table.y = R_Call(Call_Dm, 25, id, hwnd, x, y)
        return table
    end,
    GetScreenDataBmp = function(id, x1, y1, x2, y2)
        local table = { ret = 0, x = 0, y = 0 }
        table.ret, table.x, table.y = R_Call(Call_Dm, 26, id, x1, y1, x2, y2)
        return table
    end
}

Engine.DD = {
    Keypad = function(vk, status)
        R_Call(Call_DD, 1, vk, status)
    end,
    KeyString = function(content)
        R_Call(Call_DD, 2, content)
    end,
    Mouse = function(status)
        R_Call(Call_DD, 3, status)
    end,
    Move = function(x, y)
        R_Call(Call_DD, 4, x, y)
    end,
    MoveR = function(rx, ry)
        R_Call(Call_DD, 5, rx, ry)
    end,
    Wheel = function(delta)
        R_Call(Call_DD, 6, delta)
    end
}

Engine.SendInput = {
    Key = function(vk, status, isFunctionKey)
        R_Call(Call_SendInput, 1, vk, status, isFunctionKey)
    end,
    -- no chinese support
    SendStr = function(str)
        R_Call(Call_SendInput, 2, str)
    end,
    Wheel = function(delta)
        R_Call(Call_SendInput, 3, delta)
    end,
    Move = function(x, y)
        R_Call(Call_SendInput, 4, x, y)
    end,
    MoveR = function(rx, ry)
        R_Call(Call_SendInput, 5, rx, ry)
    end,
    LeftDown = function()
        R_Call(Call_SendInput, 6)
    end,
    LeftUp = function()
        R_Call(Call_SendInput, 7)
    end,
    LeftClick = function()
        R_Call(Call_SendInput, 8)
    end,
    RightDown = function()
        R_Call(Call_SendInput, 9)
    end,
    RightUp = function()
        R_Call(Call_SendInput, 10)
    end,
    RightClick = function()
        R_Call(Call_SendInput, 11)
    end,
}

Engine.OpenCV = {
    MatchTemplate = function(bigImg, smallImg, method)
        local table = { ret = 0, x = 0, y = 0, w = 0, h = 0 }
        table.ret, table.x, table.y, table.w, table.h = R_Call(Call_OpenCV, 1, bigImg, smallImg, method)
        return table
    end,
    MatchTemplateMulti = function(bigImg, smallImg, maxCount, method)
        local res = ""
        local resTable = {}
        res = R_Call(Call_OpenCV, 2, bigImg, smallImg, maxCount, method)
        local lines = R_Split(res, "|")
        for _, v in ipairs(lines) do
            local t = R_Split(v, ",")
            if #t == 5 then
                local x = tonumber(t[1])
                local y = tonumber(t[2])
                local w = tonumber(t[3])
                local h = tonumber(t[4])
                local sim = tonumber(t[5])
                table.insert(resTable, { x = x, y = y, w = w, h = h, sim = sim })
            end
        end
        return resTable
    end,
    CreateFromMem = function(p, size, mode)
        return R_Call(Call_OpenCV, 3, p, size, mode)
    end,
    CreateFromBytes = function(bytes, mode)
        return R_Call(Call_OpenCV, 4, bytes, mode)
    end,
    Destory = function(p)
        R_Call(Call_OpenCV, 5, p)
    end,
    IsNull = function(p)
        return R_Call(Call_OpenCV, 6, p)
    end
}

Engine.RapidOCR = {
    Init = function(tid, threadNum, detectionModel, directionModel, recognitionModel, recognitionDictionary)
        return R_ToNumber(R_Call(Call_RapidOCR, 1, tid, threadNum, detectionModel, directionModel, recognitionModel,
            recognitionDictionary))
    end,
    Free = function(tid)
        R_Call(Call_RapidOCR, 2, tid)
    end,
    Ocr = function(tid, pImg, sImg, method, padding, maxSideLen, boxScoreThresh, boxThresh, unClipRatio, doAngle,
                   mostangle)
        return tostring(R_Call(Call_RapidOCR, 3, tid, pImg, sImg, method, padding, maxSideLen, boxScoreThresh, boxThresh,
            unClipRatio, doAngle, mostangle))
    end,
    FindeStr = function(tid, pImg, sImg, str, padding, maxSideLen, boxScoreThresh, boxThresh, unClipRatio, doAngle,
                        mostangle)
        return tostring(R_Call(Call_RapidOCR, 4, tid, pImg, sImg, str, padding, maxSideLen, boxScoreThresh, boxThresh,
            unClipRatio, doAngle, mostangle))
    end
}
