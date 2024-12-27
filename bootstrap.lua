function Bootstrap_SetProgress(total, count)
    if total <= 0 or count < 1 or count > total then
        R.Log.Error("Invalid total or count provided.")
        return
    end


    local jump_progress = 1 / total
    for i = 1, 10 do
        local progress = (count - 1 + i * jump_progress) / total
        R.Temp.Set("UI_Update_Progress", tostring(progress))
        R.App.Sleep(1)
    end
end

function Bootstrap_LoadDir(dir, propertyName)
    local isReload = false
    local files = R.File.EnumFiles(dir, "*.lua", true, false)
    for i = 1, #files, 1 do
        local fileName = R.File.GetFileName(files[i], false)
        local script = R.File.Read(files[i])
        local local_md5 = R.App.GetMd5(script)
        local server_md5 = R.Script.GetMd5(propertyName .. "." .. fileName)
        if local_md5 ~= server_md5 then
            R.Log.Debug("Global", files[i], local_md5, server_md5)
            isReload = true
            if R.Temp.Get("UI_Update") == "" then
                R.Temp.Set("UI_Update", "start update")
            end
            R.Temp.Set("UI_Update_Md5", local_md5)
            Bootstrap_SetProgress(#files, i)
            R.Script.SetStr(propertyName .. "." .. fileName, script)
        end
        script = ""
    end
    if isReload then
        R.Temp.Set("reload_" .. propertyName, "1")
    else
        R.Temp.Set("reload_" .. propertyName)
    end
    files = nil
    return isReload
end

function Bootstrap_Local()
    local isReload = false
    R.Script.Lock()
    if Bootstrap_LoadDir(R.Path.Get("TestLuaPath"), "public") then
        isReload = true
    end
    if Bootstrap_LoadDir(R.Path.Get("TestLuaUIPath"), "ui") then
        isReload = true
    end
    if Bootstrap_LoadDir(R.Path.Get("TestLuaServerPath"), "server") then
        isReload = true
    end
    if Bootstrap_LoadDir(R.Path.Get("TestLuaEnginePath"), "engine") then
        isReload = true
    end
    R.Script.Unlock()
    if isReload then
        R.Temp.Set("UI_Update_Md5", "正在重载中")
        R.App.Sleep(100)
        R.Temp.Set("UI_Update")
        R.Temp.Set("UI_Update_Md5")
        R.Temp.Set("UI_Update_Progress")
    end
end

function Bootstrap_LoadServer(propertyName)
    local isReload = false
    local card = R.SProtect.GetLoginCard(1)
    R.CloudData.RLock()
    local logicVersion = R_ToNumber(R.CloudData.Get(card .. ".Config.LogicVersion"))
    R.CloudData.RUnlock()

    if logicVersion == 0 then
        logicVersion = 1
    end
    local type = "master"
    if logicVersion == 2 then
        type = "dev"
    end

    local allMd5 = R.HPSocket.SyncMsg("res", "getjson", "lua.md5." .. type .. "." .. propertyName)
    R.BackendData.Lock()
    R.BackendData.SetJson("lua.md5", allMd5)
    local table = R.BackendData.GetAllPropertyNamesSplit("lua.md5")
    for i = 1, #table, 1 do
        local server_md5 = R.BackendData.Get("lua.md5." .. table[i])
        local local_md5 = R.Script.GetMd5(propertyName .. "." .. table[i])
        if local_md5 ~= server_md5 then
            isReload = true
            if R.Temp.Get("UI_Update") == "" then
                R.Temp.Set("UI_Update", "start update")
            end
            local path = propertyName .. "." .. table[i]
            R.Log.Debug("reload ", path, local_md5, server_md5)
            local script = R.HPSocket.SyncMsg("res", "getvalue", "lua.byte." .. type .. "." .. path)
            R.Script.SetBase64(path, script)
            R.Temp.Set("UI_Update_Md5", local_md5)
            Bootstrap_SetProgress(#table, i)
            script = ""
        end
    end
    if isReload then
        R.Temp.Set("reload_" .. propertyName, "1")
    else
        R.Temp.Set("reload_" .. propertyName)
    end
    R.BackendData.RemoveProperty("", "lua")
    R.BackendData.Unlock()
end

function Bootstrap_Server()
    local isReload = false
    R.Script.Lock()
    if Bootstrap_LoadServer("public") then
        isReload = true
    end
    if Bootstrap_LoadServer("ui") then
        isReload = true
    end
    if Bootstrap_LoadServer("backend") then
        isReload = true
    end
    if Bootstrap_LoadServer("engine") then
        isReload = true
    end
    R.Script.Unlock()
    if isReload then
        R.Temp.Set("UI_Update_Md5", "正在重载中")
        R.App.Sleep(100)
        R.Temp.Set("UI_Update")
        R.Temp.Set("UI_Update_Md5")
        R.Temp.Set("UI_Update_Progress")
    end
end

if R.App.IsDebug() then
    Bootstrap_Local()
else
    Bootstrap_Server()
end
