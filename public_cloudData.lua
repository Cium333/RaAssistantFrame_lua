CloudData = {}

function CloudData.Set(path, content)
    R.CloudData.Lock()
    R.CloudData.Set(path, content)
    R.CloudData.Unlock()
end

function CloudData.Get(path)
    R.CloudData.RLock()
    local content = R.CloudData.Get(path)
    R.CloudData.RUnlock()
    return content
end

function CloudData.SetJson(path, content)
    R.CloudData.Lock()
    R.CloudData.SetJson(path, content)
    R.CloudData.Unlock()
end

function CloudData.ToString(path, fmt, pathEscape)
    R.CloudData.RLock()
    local content = R.CloudData.ToString(path, fmt, pathEscape)
    R.CloudData.RUnlock()
    return content
end

function CloudData.GetCount(path)
    R.CloudData.RLock()
    local count = R.CloudData.GetCount(path)
    R.CloudData.RUnlock()
    return count
end

function CloudData.Init_Cloud(isAsyncWait)
    local nowSelectedCard = GetNowSelectedCard()
    local md5 = R.App.GetMd5(CloudData.ToString(nowSelectedCard))
    Msg_GetDataMd5(nowSelectedCard, "", md5, isAsyncWait)
end

function CloudData.Clear()
    R.CloudData.Lock()
    R.CloudData.Set(GetNowSelectedCard(), "")
    for i = 1, #Configs, 1 do
        if Configs[i].type == "string" then
            R.MValue.SetByteString(Configs[i].index, "")
        elseif Configs[i].type == "int" then
            R.MValue.SetInt(Configs[i].index, 0)
        end
    end

    R.CloudData.Unlock()
end

function CloudData.Account_Set_Cloud(index, secPath, content, isAsyncWait)
    Msg_SetDataValue(GetNowSelectedCard(), "Account", tostring(index) .. "." .. secPath, content, "", isAsyncWait)
end

function CloudData.Account_Get(index, path)
    R.CloudData.RLock()
    local content = R.CloudData.Get(GetNowAccountPath(index) .. "." .. path)
    R.CloudData.RUnlock()
    return content
end

function CloudData.Account_GetCount()
    R.CloudData.RLock()
    local count = R.CloudData.GetCount(GetNowAccountPath())
    R.CloudData.RUnlock()
    return count
end

function CloudData.Account_Change_Cloud(accountIndex, str)
    if str == "" then
        return
    end
    local rowSplit = R_Split(str, "\n")
    R.BackendData.Lock()
    R.BackendData.Set("Temp")
    for i = 1, #rowSplit, 1 do
        if rowSplit[i] == "" then
            goto continue
        end
        local lineSplit = R_Split(rowSplit[i], ",")
        for index, value in ipairs(LoadAccount) do
            if #lineSplit > index - 1 then
                R.BackendData.Set("Temp." .. tostring(accountIndex) .. "." .. value.jsonName, lineSplit[index])
            end
        end
        lineSplit = nil
        ::continue::
    end
    rowSplit = nil
    local info = R.BackendData.ToString("Temp")
    local md5 = R.App.GetMd5(CloudData.ToString(GetNowAccountPath()))
    Msg_SetDataValueMul(GetNowSelectedCard(), "Account", info, md5, true)
    R.BackendData.Set("Temp")
    R.BackendData.Unlock()
end

function CloudData.Account_LoadByTxt_Cloud(isLoad, str)
    R.BackendData.Lock()
    local info = ""
    if isLoad then
        info = str
    else
        -- info = R.File.Read(Path.GlobalDataTxtLoadPath)
    end
    local rowSplit = R_Split(info, "\n")
    local count = 0
    R.BackendData.Set("Temp")
    for i = 1, #rowSplit, 1 do
        if rowSplit[i] == "" then
            goto continue
        end

        local lineSplit = R_Split(rowSplit[i], ",")
        count = count + 1
        for index, value in ipairs(LoadAccount) do
            if #lineSplit > index - 1 then
                R.BackendData.Set("Temp." .. tostring(count) .. "." .. value.jsonName, lineSplit[index])
            end
        end
        lineSplit = nil
        ::continue::
    end
    rowSplit = nil
    info = R.BackendData.ToString("Temp")
    local md5 = R.App.GetMd5(CloudData.ToString(GetNowAccountPath()))
    R.BackendData.Set("Temp")
    R.BackendData.Unlock()
    Msg_SetDataJson(GetNowSelectedCard(), "Account", "", info, md5, true)
end

function CloudData.Account_Add_Cloud(str)
    if str == "" then
        return
    end
    local rowSplit = R_Split(str, "\n")
    local count = 0
    R.BackendData.Lock()
    R.BackendData.Set("Temp")
    for i = 1, #rowSplit, 1 do
        if rowSplit[i] == "" then
            goto continue
        end
        local lineSplit = R_Split(rowSplit[i], ",")
        count = count + 1
        for index, value in ipairs(LoadAccount) do
            if #lineSplit > index - 1 then
                R.BackendData.Set("Temp." .. tostring(count) .. "." .. value.jsonName, lineSplit[index])
            end
        end
        lineSplit = nil
        ::continue::
    end
    rowSplit = nil
    local info = R.BackendData.ToString("Temp")
    local md5 = R.App.GetMd5(CloudData.ToString(GetNowAccountPath()))
    Msg_DataAdd(GetNowSelectedCard(), "Account", info, md5)
    R.BackendData.Set("Temp")
    R.BackendData.Unlock()
end

function CloudData.Account_DeleteSelected_Cloud()
    R.BackendData.Lock()
    R.BackendData.Set("Temp")
    for i = 1, CloudData.Account_GetCount(), 1 do
        if R_ToNumber(R.Temp.Get("GlobalAccountSelected." .. tostring(i))) == 1 then
            R.BackendData.Set("Temp." .. tostring(i))
        end
    end
    local info = R.BackendData.ToString("Temp")
    local md5 = R.App.GetMd5(CloudData.ToString(GetNowAccountPath()))
    R.BackendData.Set("Temp")
    R.BackendData.Unlock()
    R.Temp.Set("GlobalAccountSelected")
    Msg_DataDel(GetNowSelectedCard(), "Account", info, md5)
end

function CloudData.Account_ChangePos_Cloud(index1, index2)
    local info1, info2 = "", ""
    local count        = CloudData.GetCount(GetNowAccountPath())
    local info, md5    = "", ""

    if count < index1 or count < index2 then
        return
    end

    info1 = CloudData.ToString(GetNowAccountPath(index1), false, true)
    info2 = CloudData.ToString(GetNowAccountPath(index2), false, true)
    R.BackendData.Lock()
    R.BackendData.Set("Temp")
    R.BackendData.SetJson("Temp." .. tostring(index1), info1)
    R.BackendData.SetJson("Temp." .. tostring(index2), info2)
    info = R.BackendData.ToString("Temp")
    md5 = R.App.GetMd5(CloudData.ToString(GetNowAccountPath()))
    R.BackendData.Set("Temp")
    R.BackendData.Unlock()
    Msg_DataChange(GetNowSelectedCard(), "Account", info, md5)
end

-- 1 true 2 false 3 invert
function CloudData.Account_SelectAll_Cloud(type)
    R.BackendData.Lock()
    R.BackendData.Set("Temp")
    for i = 1, CloudData.GetCount(GetNowAccountPath()), 1 do
        local active = R_ToNumber(R.Temp.Get("GlobalAccountSelected." .. tostring(i))) == 1
        local selected = CloudData.Account_Get(i, "selected") == "1"
        if active then
            if type == 1 and not selected then
                R.BackendData.Set("Temp." .. tostring(i) .. "." .. "selected", "1")
            elseif type == 2 and selected then
                R.BackendData.Set("Temp." .. tostring(i) .. "." .. "selected", "0")
            end
        end
    end
    local info = R.BackendData.ToString("Temp")
    local md5 = R.App.GetMd5(CloudData.ToString(GetNowAccountPath()))
    R.BackendData.Set("Temp")
    R.BackendData.Unlock()
    R.Temp.Set("GlobalAccountSelected")
    Msg_SetDataValueMul(GetNowSelectedCard(), "Account", info, md5, true)
end

function CloudData.Account_SetPacket_Cloud(index)
    R.BackendData.Lock()
    R.BackendData.Set("Temp")
    for i = 1, CloudData.GetCount(GetNowAccountPath()), 1 do
        local active = R_ToNumber(R.Temp.Get("GlobalAccountSelected." .. tostring(i))) == 1
        if active then
            R.BackendData.Set("Temp." .. tostring(i) .. "." .. "packet", tostring(index))
        end
    end
    local info = R.BackendData.ToString("Temp")
    local md5 = R.App.GetMd5(CloudData.ToString(GetNowAccountPath()))
    R.BackendData.Set("Temp")
    R.BackendData.Unlock()
    R.Temp.Set("GlobalAccountSelected")
    Msg_SetDataValueMul(GetNowSelectedCard(), "Account", info, md5, true)
end

function CloudData.Config_Set_Cloud(configName, content)
    local md5 = R.App.GetMd5(CloudData.ToString(GetNowConfigPath()))
    Msg_SetDataValue(GetNowSelectedCard(), "Config", configName, content, md5)
end

function CloudData.Config_Get(configName)
    R.CloudData.RLock()
    local content = R.CloudData.Get(GetNowConfigPath(configName))
    R.CloudData.RUnlock()
    return content
end

function CloudData.Config_Init_Cloud()
    R.BackendData.Lock()
    R.BackendData.Set("Temp")
    local function setDefaultConfig_string(configName, index, value)
        R.BackendData.Set("Temp." .. configName, value)
    end

    local function setDefaultConfig_int(configName, index, value)
        R.BackendData.Set("Temp." .. configName, tostring(value))
    end

    for i = 1, #Configs, 1 do
        if Configs[i].type == "string" then
            setDefaultConfig_string(Configs[i].configName, Configs[i].index, Configs[i].defaultValue)
        elseif Configs[i].type == "int" then
            setDefaultConfig_int(Configs[i].configName, Configs[i].index, Configs[i].defaultValue)
        end
    end

    local info = R.BackendData.ToString("Temp")
    local md5 = R.App.GetMd5(CloudData.ToString(GetNowConfigPath()))
    Msg_SetDataJson(GetNowSelectedCard(), "Config", "", info, md5, true)
    R.BackendData.Set("Temp")
    R.BackendData.Unlock()
end

function CloudData.Config_Save_Cloud()
    R.BackendData.Lock()
    R.BackendData.Set("Temp")

    local function getConfig_string(configName, index)
        local value = R.Temp.Get("Config." .. configName)
        R.BackendData.Set("Temp." .. configName, tostring(value))
    end
    local function getConfig_int(configName, index)
        local value = R.Temp.Get("Config." .. configName)
        R.BackendData.Set("Temp." .. configName, tostring(value))
    end

    for i = 1, #Configs, 1 do
        if Configs[i].type == "string" then
            if Configs[i].configName == "DeviceName" then
                local deviceName = R.Temp.Get("Config." .. Configs[i].configName)
                if deviceName ~= CloudData.Config_Get("DeviceName") then
                    CloudData.Client_ChangeDeviceName_Cloud(deviceName)
                end
            end
            getConfig_string(Configs[i].configName, Configs[i].index)
        elseif Configs[i].type == "int" then
            getConfig_int(Configs[i].configName, Configs[i].index)
        end
    end

    local info = R.BackendData.ToString("Temp")
    local md5 = R.App.GetMd5(CloudData.ToString(GetNowConfigPath()))
    Msg_SetDataJson(GetNowSelectedCard(), "Config", "", info, md5, true)
    R.BackendData.Set("Temp")
    R.BackendData.Unlock()
end

function CloudData.Card_Set_Cloud(index, secPath, content)
    if CloudData.Card_Get(index, secPath) == content then
        return
    end
    local md5 = R.App.GetMd5(CloudData.ToString(GetNowCardPath()))
    Msg_SetDataValue(GetNowSelectedCard(), "Card", tostring(index) .. "." .. secPath, content, md5)
end

function CloudData.Card_GetCount()
    R.CloudData.RLock()
    local count = R.CloudData.GetCount(GetNowCardPath())
    R.CloudData.RUnlock()
    return count
end

function CloudData.Card_Add_Cloud(str)
    if str == "" then
        return
    end
    local rowSplit = R_Split(str, "\n")
    local count = 0
    R.BackendData.Lock()
    R.BackendData.Set("Temp")
    for i = 1, #rowSplit, 1 do
        if rowSplit[i] == "" or #rowSplit[i] ~= 34 then
            goto continue
        end

        local card = rowSplit[i]

        if R.String.FindString(CloudData.ToString(GetNowCardPath()), card) == -1 then
            if CloudData.Get(GetNowCardPath(i) .. ".card") == "" then
                count = count + 1
                R_Debug(count, card)
                R.BackendData.Set("Temp." .. tostring(count) .. ".card", card)
            end
        end

        ::continue::
    end
    rowSplit = nil
    local info = R.BackendData.ToString("Temp")
    local md5 = R.App.GetMd5(CloudData.ToString(GetNowCardPath()))
    R.BackendData.Set("Temp")
    R.BackendData.Unlock()
    Msg_DataAdd(GetNowSelectedCard(), "Card", info, md5)
end

function CloudData.Card_SelectAll_Cloud(type)
    R.BackendData.Lock()
    R.BackendData.Set("Temp")
    for i = 2, CloudData.GetCount(GetNowCardPath()), 1 do
        local selected = R_ToNumber(R.Temp.Get("GlobalCardSelected." .. tostring(i))) == 1
        if selected then
            if type == 1 then
                -- true
                R.BackendData.Set("Temp." .. tostring(i) .. "." .. "selected", "1")
            elseif type == 2 then
                -- false
                R.BackendData.Set("Temp." .. tostring(i) .. "." .. "selected", "0")
            end
        end
    end
    local info = R.BackendData.ToString("Temp")
    local md5 = R.App.GetMd5(CloudData.ToString(GetNowCardPath()))
    Msg_SetDataValueMul(GetNowSelectedCard(), "Card", info, md5, true)
    R.BackendData.Set("Temp")
    R.BackendData.Unlock()
end

function CloudData.Card_DeleteSelected_Cloud()
    R.BackendData.Lock()
    R.BackendData.Set("Temp")
    for i = 2, CloudData.Card_GetCount(), 1 do
        if R_ToNumber(R.Temp.Get("GlobalCardSelected." .. tostring(i))) == 1 then
            R.BackendData.Set("Temp." .. tostring(i))
        end
    end
    local info = R.BackendData.ToString("Temp")
    local md5 = R.App.GetMd5(CloudData.ToString(GetNowCardPath()))
    R.BackendData.Set("Temp")
    R.BackendData.Unlock()
    R_Debug(info)
    Msg_DataDel(GetNowSelectedCard(), "Card", info, md5)
end

function CloudData.Card_Get(index, path)
    R.CloudData.RLock()
    local content = R.CloudData.Get(GetNowCardPath(index) .. "." .. path)
    R.CloudData.RUnlock()
    return content
end

function CloudData.Card_FindIndex(findCard)
    R.CloudData.RLock()
    local table = R.CloudData.GetAllPropertyNamesSplit(GetNowCardPath())
    local index = -1
    for i = 1, #table, 1 do
        local card = R.CloudData.Get(GetNowCardPath(i) .. ".card")
        if card == findCard then
            index = i
            break
        end
    end
    R.CloudData.RUnlock()
    return index
end

function CloudData.Client_Select_Cloud()
    local card = R.SProtect.GetLoginCard(1)
    Msg_SetClientData(card, "selected", GetNowSelectedCard())
end

function CloudData.Client_ChangeDeviceName_Cloud(name)
    Msg_SetClientData(GetNowSelectedCard(), "deviceName", name)
end
