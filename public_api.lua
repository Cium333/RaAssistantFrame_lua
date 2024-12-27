Bit = require("bit")
function MakeReadOnlyTable(table)
    return setmetatable({}, {
        __index = table,
        __newindex = function()
            error("Attempt to modify a Const value", 2)
        end,
        __metatable = false
    })
end

local Public_Call_CloudData = 1
local Public_Call_LocalData = 2
local Public_Call_Temp = 3
local Public_Call_Path = 4
local Public_Call_File = 5
local Public_Call_Log = 6
local Public_Call_App = 7
local Public_Call_SProtect = 8
local Public_Call_HPSocket = 9
local Public_Call_UpdateTimepiece = 10
local Public_Call_Script = 11
local Public_Call_Process = 12
local Public_Call_Engine = 13
local Public_Call_Thread = 14
local Public_Call_ColorResource = 15
local Public_Call_gdi = 16
local Public_Call_LDlsconsole = 17
local Public_Call_String = 18
local Public_Call_Encrypt = 19
local Public_Call_EngineTimepiece = 20
local Public_Call_BackendData = 21

R = {}
R.CloudData = {
    Lock = function()
        R_Call_Public(Public_Call_CloudData, 1)
    end,
    Unlock = function()
        R_Call_Public(Public_Call_CloudData, 2)
    end,
    RLock = function()
        R_Call_Public(Public_Call_CloudData, 3)
    end,
    RUnlock = function()
        R_Call_Public(Public_Call_CloudData, 4)
    end,
    Get = function(path)
        return tostring(R_Call_Public(Public_Call_CloudData, 5, path))
    end,
    Set = function(path, content)
        R_Call_Public(Public_Call_CloudData, 6, path, content)
    end,
    SetJson = function(path, content)
        R_Call_Public(Public_Call_CloudData, 7, path, content)
    end,
    ToString = function(path, fmt, pathEscape)
        return tostring(R_Call_Public(Public_Call_CloudData, 8, path, fmt, pathEscape))
    end,
    GetCount = function(path)
        return R_ToNumber(R_Call_Public(Public_Call_CloudData, 9, path))
    end,
    RemoveProperty = function(path, property)
        R_Call_Public(Public_Call_CloudData, 10, path, property)
    end,
    GetAllPropertyNamesSplit = function(path)
        local res = R_Call_Public(Public_Call_CloudData, 11, path)
        return R_Split(res, "|")
    end,
    EscapePath = function(path)
        return tostring(R_Call_Public(Public_Call_CloudData, 12, path))
    end
}

R.LocalData = {
    Lock = function()
        R_Call_Public(Public_Call_LocalData, 1)
    end,
    Unlock = function()
        R_Call_Public(Public_Call_LocalData, 2)
    end,
    RLock = function()
        R_Call_Public(Public_Call_LocalData, 3)
    end,
    RUnlock = function()
        R_Call_Public(Public_Call_LocalData, 4)
    end,
    Get = function(path)
        return tostring(R_Call_Public(Public_Call_LocalData, 5, path))
    end,
    Set = function(path, content)
        R_Call_Public(Public_Call_LocalData, 6, path, content)
    end,
    SetJson = function(path, content)
        R_Call_Public(Public_Call_LocalData, 7, path, content)
    end,
    ToString = function(path, fmt, pathEscape)
        return tostring(R_Call_Public(Public_Call_LocalData, 8, path, fmt, pathEscape))
    end,
    GetCount = function(path)
        return R_ToNumber(R_Call_Public(Public_Call_LocalData, 9, path))
    end,
    RemoveProperty = function(path, property)
        R_Call_Public(Public_Call_LocalData, 10, path, property)
    end,
    GetAllPropertyNamesSplit = function(path)
        local res = R_Call_Public(Public_Call_LocalData, 11, path)
        return R_Split(res, "|")
    end,
    EscapePath = function(path)
        return tostring(R_Call_Public(Public_Call_LocalData, 12, path))
    end
}
R.Temp = {
    Get = function(path)
        return tostring(R_Call_Public(Public_Call_Temp, 1, path))
    end,
    Set = function(path, content)
        R_Call_Public(Public_Call_Temp, 2, path, content)
    end,
    GetCount = function(path)
        return R_ToNumber(R_Call_Public(Public_Call_Temp, 3, path))
    end,
    GetAllPropertyNamesSplit = function(path)
        local res = R_Call_Public(Public_Call_Temp, 4, path)
        return R_Split(res, "|")
    end,
}
R.Path = {
    Get = function(path)
        return R_Call_Public(Public_Call_Path, 1, path)
    end,
    Set = function(path, content)
        R_Call_Public(Public_Call_Path, 2, path, content)
    end
}
R.File = {
    Write = function(path, content)
        R_Call_Public(Public_Call_File, 1, path, content)
    end,
    WriteUtf8 = function(path, content)
        R_Call_Public(Public_Call_File, 2, path, content)
    end,
    Read = function(path)
        return tostring(R_Call_Public(Public_Call_File, 3, path))
    end,
    ReadUtf8 = function(path)
        return tostring(R_Call_Public(Public_Call_File, 4, path))
    end,
    ReadToBase64 = function(path)
        return tostring(R_Call_Public(Public_Call_File, 10, path))
    end,
    GetRunPath = function()
        return tostring(R_Call_Public(Public_Call_File, 5))
    end,
    GetSpecificPath = function(type, isLongPath)
        return tostring(R_Call_Public(Public_Call_File, 6, type, isLongPath))
    end,
    CreatDirectory = function(path)
        R_Call_Public(Public_Call_File, 7, path)
    end,

    EnumFiles = function(path, fileName, isLongPath, isSearchAllSubFolder)
        local res = R_Call_Public(Public_Call_File, 8, path, fileName, isLongPath, isSearchAllSubFolder)
        return R_Split(res, "|")
    end,
    GetFileName = function(path, isSuffix)
        return tostring(R_Call_Public(Public_Call_File, 9, path, isSuffix))
    end,
}
R.Log = {
    split = function(...)
        local args = { ... }
        local result = ""
        for i, arg in ipairs(args) do
            result = result .. arg .. " | "
        end
        return string.sub(result, 1, -4)
    end,
    Debug = function(head, ...)
        if R.App.IsDebug() then
            R_Call_Public(Public_Call_Log, 1, head, R.Log.split(...))
        end
    end,
    Info = function(head, ...)
        R_Call_Public(Public_Call_Log, 2, head, R.Log.split(...))
    end,
    Error = function(head, ...)
        R_Call_Public(Public_Call_Log, 3, head, R.Log.split(...))
    end,
    Get = function(head, index)
        return R_Call_Public(Public_Call_Log, 4, head, index)
    end,
    GetCount = function(head)
        return R_ToNumber(R_Call_Public(Public_Call_Log, 5, head))
    end,
    Clear = function(head)
        R_Call_Public(Public_Call_Log, 6, head)
    end
}
R.App = {
    GetRandom      = function(min, max)
        return R_ToNumber(R_Call_Public(Public_Call_App, 1, min, max))
    end,
    GetMd5         = function(content)
        return tostring(R_Call_Public(Public_Call_App, 2, content))
    end,

    IsDebug        = function()
        return R_Call_Public(Public_Call_App, 3)
    end,

    Sleep          = function(time)
        R_Call_Public(Public_Call_App, 4, time)
    end,

    AddBackendTask = function(script)
        R_Call_Public(Public_Call_App, 5, script)
    end,
    GetMousePos    = function()
        return R_Call_Public(Public_Call_App, 6)
    end,
    GetTimestamp   = function(isSecond)
        return R_ToNumber(R_Call_Public(Public_Call_App, 7, isSecond))
    end,
    SetClipboard   = function(content)
        R_Call_Public(Public_Call_App, 8, content)
    end,
    GetMaxThread   = function()
        return R_ToNumber(R_Call_Public(Public_Call_App, 9))
    end,
    SetWindowTitle = function(title)
        R_Call_Public(Public_Call_App, 12, title)
    end,
    GetRunLua      = function()
        return tostring(R_Call_Public(Public_Call_App, 13))
    end,
}
R.SProtect = {
    NormalVerify = function(card)
        R_Call_Public(Public_Call_SProtect, 1, card)
    end,
    ReVerify = function(card)
        R_Call_Public(Public_Call_SProtect, 2, card)
    end,
    GetExpireTimeStr = function(card)
        return tostring(R_Call_Public(Public_Call_SProtect, 3, card))
    end,
    GetExpireTimestamp = function(card)
        return R_ToNumber(R_Call_Public(Public_Call_SProtect, 4, card))
    end,
    GetErrCode = function(card)
        return R_ToNumber(R_Call_Public(Public_Call_SProtect, 5, card))
    end,
    GetErrMsg = function(card)
        return tostring(R_Call_Public(Public_Call_SProtect, 6, card))
    end,
    GetLoginCard = function(id)
        return tostring(R_Call_Public(Public_Call_SProtect, 7, id))
    end,
    Login = function(id, card)
        return R_Call_Public(Public_Call_SProtect, 8, id, card)
    end,
    GetNote = function(card)
        return tostring(R_Call_Public(Public_Call_SProtect, 9, card))
    end,
    GetActiveTimestamp = function(card)
        return R_ToNumber(R_Call_Public(Public_Call_SProtect, 10, card))
    end,
    Logout = function(card)
        R_Call_Public(Public_Call_SProtect, 11, card)
    end,
    GetOffStatus = function(card)
        return R_ToNumber(R_Call_Public(Public_Call_SProtect, 12, card))
    end,
    FindCardIndex = function(card)
        return R_ToNumber(R_Call_Public(Public_Call_SProtect, 13, card))
    end
}
R.HPSocket = {
    SyncMsg = function(head1, head2, content, time)
        return tostring(R_Call_Public(Public_Call_HPSocket, 1, head1, head2, content, time))
    end,
    AsyncMsg = function(head1, head2, content)
        R_Call_Public(Public_Call_HPSocket, 2, head1, head2, content)
    end,
    SyncAndHandlePackMsg = function(head1, head2, type, toCard, mainPath, secPath, value, md5)
        R_Call_Public(Public_Call_HPSocket, 3, head1, head2, type, toCard, mainPath, secPath, value, md5)
    end,
    AsyncPackMsg = function(head1, head2, type, toCard, mainPath, secPath, value, md5)
        R_Call_Public(Public_Call_HPSocket, 4, head1, head2, type, toCard, mainPath, secPath, value, md5)
    end
}

R.UpdateTimepiece = {
    Begin = function()
        R_Call_Public(Public_Call_UpdateTimepiece, 1)
    end,
    GetSecond = function()
        return R_Call_Public(Public_Call_UpdateTimepiece, 2)
    end,
    GetMillisecond = function()
        return R_Call_Public(Public_Call_UpdateTimepiece, 3)
    end
}
R.Script = {
    Lock = function()
        R_Call_Public(Public_Call_Script, 1)
    end,
    Unlock = function()
        R_Call_Public(Public_Call_Script, 2)
    end,
    RLock = function()
        R_Call_Public(Public_Call_Script, 3)
    end,
    RUnlock = function()
        R_Call_Public(Public_Call_Script, 4)
    end,

    SetBase64 = function(path, script)
        R_Call_Public(Public_Call_Script, 5, path, script)
    end,
    SetStr = function(path, script)
        R_Call_Public(Public_Call_Script, 6, path, script)
    end,
    GetMd5 = function(path)
        return tostring(R_Call_Public(Public_Call_Script, 7, path))
    end
}

R.Process = {
    Kill = function(pid)
        R_Call_Public(Public_Call_Process, 1, pid)
    end,
    NameGetPid = function(name, isSensitive)
        return R_ToNumber(R_Call_Public(Public_Call_Process, 2, name, isSensitive))
    end
}

R.Engine = {
    Run = function(index)
        R_Call_Public(Public_Call_Engine, 1, index)
    end
}

R.Thread = {
    Get = function(id, path)
        return tostring(R_Call_Public(Public_Call_Thread, 1, id, path))
    end,
    Set = function(id, path, content)
        R_Call_Public(Public_Call_Thread, 2, id, path, content)
    end
}

R.ColorResource = {
    Lock = function()
        R_Call_Public(Public_Call_ColorResource, 1)
    end,
    Unlock = function()
        R_Call_Public(Public_Call_ColorResource, 2)
    end,
    RLock = function()
        R_Call_Public(Public_Call_ColorResource, 3)
    end,
    RUnlock = function()
        R_Call_Public(Public_Call_ColorResource, 4)
    end,
    Get = function(path)
        return tostring(R_Call_Public(Public_Call_ColorResource, 5, path))
    end,
    Set = function(path, content)
        R_Call_Public(Public_Call_ColorResource, 6, path, content)
    end,
    SetJson = function(path, content)
        R_Call_Public(Public_Call_ColorResource, 7, path, content)
    end,
    ToString = function(path, fmt, pathEscape)
        return tostring(R_Call_Public(Public_Call_ColorResource, 8, path, fmt, pathEscape))
    end,
    GetCount = function(path)
        return R_ToNumber(R_Call_Public(Public_Call_ColorResource, 9, path))
    end,
    RemoveProperty = function(path, property)
        R_Call_Public(Public_Call_ColorResource, 10, path, property)
    end,
    GetAllPropertyNamesSplit = function(path)
        local res = R_Call_Public(Public_Call_ColorResource, 11, path)
        return R_Split(res, "|")
    end,
    EscapePath = function(path)
        return tostring(R_Call_Public(Public_Call_ColorResource, 12, path))
    end
}
R.gdi = {
    Lock = function()
        R_Call_Public(Public_Call_gdi, 1)
    end,
    Unlock = function()
        R_Call_Public(Public_Call_gdi, 2)
    end,
    Init = function(hwnd)
        R_Call_Public(Public_Call_gdi, 3, hwnd)
    end,
    BeginPaint = function(type)
        R_Call_Public(Public_Call_gdi, 4, type)
    end,
    EndPaint = function()
        R_Call_Public(Public_Call_gdi, 5)
    end,
    DrawRect = function(x1, y1, x2, y2, fillColor, fillType, borderColor, borderType)
        R_Call_Public(Public_Call_gdi, 6, x1, y1, x2, y2, fillColor, fillType, borderColor, borderType)
    end,
    DrawPic = function(byte, x1, y1, x2, y2, type)
        R_Call_Public(Public_Call_gdi, 7, byte, x1, y1, x2, y2, type)
    end,
    DrawRound = function(x1, y1, x2, y2, fillColor, borderColor)
        R_Call_Public(Public_Call_gdi, 8, x1, y1, x2, y2, fillColor, borderColor)
    end,
    DrawLine = function(x1, y1, x2, y2, color, width, type)
        R_Call_Public(Public_Call_gdi, 9, x1, y1, x2, y2, color, width, type)
    end,
    DrawText = function(text, x1, y1, x2, y2, align, color, fontSize, fontName, overbold, tilt, underline, opaquebg,
                        bgColor)
        return R_Call_Public(Public_Call_gdi, 10, text, x1, y1, x2, y2, align, color, fontSize, fontName, overbold, tilt,
            underline, opaquebg, bgColor)
    end,
    DrawText2 = function(text, x, y, color, fontSize, fontName, overbold, tilt, underline, opaquebg, bgColor)
        return R_Call_Public(Public_Call_gdi, 11, text, x, y, color, fontSize, fontName, overbold, tilt, underline,
            opaquebg, bgColor)
    end,
}

R.LDlsconsole = {
    GetAllSimulators = function()
        return R_Call_Public(Public_Call_LDlsconsole, 1)
    end,
    StartSimulator = function(index)
        R_Call_Public(Public_Call_LDlsconsole, 2, index)
    end,
    StartApp = function(index, packagename)
        R_Call_Public(Public_Call_LDlsconsole, 3, index, packagename)
    end,
    CloseApp = function(index, packagename)
        R_Call_Public(Public_Call_LDlsconsole, 4, index, packagename)
    end,
    CustomCMD = function(cmd)
        R_Call_Public(Public_Call_LDlsconsole, 5, cmd)
    end
}

R.String = {
    FindString    = function(str, sub, isUpper)
        return R_ToNumber(R_Call_Public(Public_Call_String, 1, str, sub, isUpper))
    end,
    ReplaceString = function(str, count, sub, newSub, ...)
        return tostring(R_Call_Public(Public_Call_String, 2, str, count, sub, newSub, ...))
    end
}

R.Encrypt = {
    Encrypt = function(str)
        return tostring(R_Call_Public(Public_Call_Encrypt, 1, str))
    end,
    Decrypt = function(str)
        return tostring(R_Call_Public(Public_Call_Encrypt, 2, str))
    end
}

R.EngineTimepiece = {
    Begin = function(threadID)
        R_Call_Public(Public_Call_EngineTimepiece, 1, threadID)
    end,
    GetSecond = function(threadID)
        return R_Call_Public(Public_Call_EngineTimepiece, 2, threadID)
    end,
    GetMillisecond = function(threadID)
        return R_Call_Public(Public_Call_EngineTimepiece, 3, threadID)
    end,
    GetTime = function(threadID)
        return R_Call_Public(Public_Call_EngineTimepiece, 4, threadID)
    end
}

R.BackendData = {
    Lock = function()
        R_Call_Public(Public_Call_BackendData, 1)
    end,
    Unlock = function()
        R_Call_Public(Public_Call_BackendData, 2)
    end,
    RLock = function()
        R_Call_Public(Public_Call_BackendData, 3)
    end,
    RUnlock = function()
        R_Call_Public(Public_Call_BackendData, 4)
    end,
    Get = function(path)
        return tostring(R_Call_Public(Public_Call_BackendData, 5, path))
    end,
    Set = function(path, content)
        R_Call_Public(Public_Call_BackendData, 6, path, content)
    end,
    SetJson = function(path, content)
        R_Call_Public(Public_Call_BackendData, 7, path, content)
    end,
    ToString = function(path, fmt, pathEscape)
        return tostring(R_Call_Public(Public_Call_BackendData, 8, path, fmt, pathEscape))
    end,
    GetCount = function(path)
        return R_ToNumber(R_Call_Public(Public_Call_BackendData, 9, path))
    end,
    RemoveProperty = function(path, property)
        R_Call_Public(Public_Call_BackendData, 10, path, property)
    end,
    GetAllPropertyNamesSplit = function(path)
        local res = R_Call_Public(Public_Call_BackendData, 11, path)
        return R_Split(res, "|")
    end,
    EscapePath = function(path)
        return tostring(R_Call_Public(Public_Call_BackendData, 12, path))
    end
}

MakeReadOnlyTable(R)

function R_ToNumber(n)
    local ret = tonumber(n)
    if ret == nil then
        ret = 0
    end
    return ret
end

function R_Split(text, delimiter)
    local results = {}
    if not text or text == "" or not delimiter then
        return results
    end

    for word in string.gmatch(text, "([^" .. delimiter .. "]+)") do
        table.insert(results, word)
    end

    return results
end
