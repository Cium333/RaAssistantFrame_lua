LocalData = {}

function LocalData.Set(path, content)
    R.LocalData.Lock()
    R.LocalData.Set(path, content)
    R.LocalData.Unlock()
end

function LocalData.Get(path)
    R.LocalData.RLock()
    local content = R.LocalData.Get(path)
    R.LocalData.RUnlock()
    return content
end

function LocalData.GetCount(path)
    R.LocalData.RLock()
    local count = R.LocalData.GetCount(path)
    R.LocalData.RUnlock()
    return count
end

function LocalData.SetJson(path, content)
    R.LocalData.Lock()
    R.LocalData.SetJson(path, content)
    R.LocalData.Unlock()
end

function LocalData.ToString(path, fmt, pathEscape)
    R.LocalData.RLock()
    local content = R.LocalData.ToString(path, fmt, pathEscape)
    R.LocalData.RUnlock()
    return content
end

function LocalData.RemoveProperty(path, property)
    R.LocalData.Lock()
    R.LocalData.RemoveProperty(path, property)
    R.LocalData.Unlock()
end

function LocalData.GetAllPropertyNamesSplit(path)
    R.LocalData.RLock()
    local content = R.LocalData.GetAllPropertyNamesSplit(path)
    R.LocalData.RUnlock()
    return content
end

function LocalData.EscapePath(path)
    R.LocalData.RLock()
    local content = R.LocalData.EscapePath(path)
    R.LocalData.RUnlock()
    return content
end

function LocalData.SaveRunPath(fileName, jsonName)
    local savePath = R.LocalData.Get("runPath") .. fileName
    local data = LocalData.ToString(jsonName, true)
    R.File.Write(savePath, data)
end

function LocalData.SaveInternalResourcePath(fileName, jsonName)
    local savePath = R.LocalData.Get("InternalResourcePath") .. fileName
    local data = LocalData.ToString(jsonName, true)
    R.File.Write(savePath, data)
end

function LocalData.LoadFromInternalResourcePath(fileName, jsonName)
    local readPath = R.LocalData.Get("InternalResourcePath") .. fileName
    local data = R.File.Read(readPath)
    LocalData.SetJson(jsonName, data)
end

function LocalData.ClientReload(json)
    R.LocalData.Lock()
    local server_md5 = R.App.GetMd5(json)
    R.LocalData.SetJson("clientList_dev", json)
    local table = R.LocalData.GetAllPropertyNamesSplit("clientList_dev")
    local array = {}
    local count = 0
    for i = 1, #table, 1 do
        local card = table[i]
        if card == R.SProtect.GetLoginCard(1) then
            R.LocalData.SetJson("clientList." .. card, R.LocalData.ToString("clientList_dev." .. card))
        else
            count = count + 1
            array[count] = card
        end
    end
    table = nil
    -- ?????????งา?  1-1-name
    for i = 1, #array, 1 do
        for j = 1, #array - i, 1 do
            local card_1 = array[i]
            local deviceName_1 = R.LocalData.Get("clientList_dev." .. card_1 .. ".deviceName")
            local card_2 = array[j]
            local deviceName_2 = R.LocalData.Get("clientList_dev." .. card_2 .. ".deviceName")
            local spilit_1 = R_Split(deviceName_1, "-")
            local spilit_2 = R_Split(deviceName_2, "-")
            local index_1_1, index_1_2, index_2_1, index_2_2 = 999, 999, 999, 999
            if #spilit_1 > 1 then
                index_1_1 = R_ToNumber(spilit_1[1])
            end
            if #spilit_1 > 2 then
                index_1_2 = R_ToNumber(spilit_1[2])
            end
            if #spilit_2 > 1 then
                index_2_1 = R_ToNumber(spilit_2[1])
            end
            if #spilit_2 > 2 then
                index_2_2 = R_ToNumber(spilit_2[2])
            end
            if index_1_1 < index_2_1 or (index_1_1 == index_2_1 and index_1_2 < index_2_2) then
                array[i], array[j] = array[j], array[i]
            end
            spilit_1 = nil
            spilit_2 = nil
            :: continue::
        end
    end

    for i = 1, #array, 1 do
        R.LocalData.SetJson("clientList." .. array[i], R.LocalData.ToString("clientList_dev." .. array[i]))
    end

    array = nil

    R.LocalData.Set("clientList_md5", server_md5)
    R.LocalData.RemoveProperty("", "clientList_dev")
    R.LocalData.Unlock()

    local updateLogCount = LocalData.GetCount("updateLog")
    if updateLogCount > 0 then
        local i = 0
        local version = LocalData.Get("updateLog[" .. tostring(i) .. "].version")
        if R.Temp.Get("WindowTitle") ~= version then
            R.Temp.Set("WindowTitle", version)
            R.App.SetWindowTitle(" - " .. version)
        end
    end
end
