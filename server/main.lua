-- ? public + server
local head = G_AsyncHead
local res = G_AsyncResponse
local head_name, head_type, head_card, head_mainPath, head_secPath = "", "", "", "", ""
local split_head = R_Split(head, "|")
if #split_head > 0 then
    head_name = split_head[1]
end
if #split_head > 1 then
    head_type = split_head[2]
end
if #split_head > 2 then
    head_card = split_head[3]
end
if #split_head > 3 then
    head_mainPath = split_head[4]
end
if #split_head > 4 then
    head_secPath = split_head[5]
end
split_head = nil
function NameHandle()
    if head_name == "err" then
        R_Debug("Error head_name", res)
        return
    end

    if head_name == "resource" then
        ResourceHandle()
    elseif head_name == "data-set" then
        DataHandle_set()
    elseif head_name == "data-md5" then
        DataHandle_md5()
    elseif head_name == "data-get" then
        DataHandle_get()
    elseif head_name == "broadcast" then
        BroadcastHandle()
    elseif head_name == "game" then
        GameHandle()
    end
end

function ResourceHandle()
    if head_type == "md5" then
        ResourceHandle_md5()
    elseif head_type == "getjson" then
        ResourceHandle_getjson()
    end
end

function ResourceHandle_md5()
    if R.String.FindString(head_mainPath, "updateLog", true) then
        local local_md5 = LocalData.Get(head_mainPath)
        if res ~= local_md5 then
            Msg_GetUpdateLog()
        end
    elseif head_mainPath == "color_md5" then
        R.ColorResource.RLock()
        local local_md5 = R.ColorResource.Get(head_mainPath)
        R.ColorResource.RUnlock()
        if res ~= local_md5 then
            R.ColorResource.Lock()
            R.ColorResource.Set()
            R.ColorResource.Set(head_mainPath, res)
            R.ColorResource.Unlock()
        end
    end
end

function ResourceHandle_getjson()
    if R.String.FindString(head_mainPath, "updateLog", true) then
        local server_md5 = R.App.GetMd5(res)
        local md5Path = R.String.ReplaceString(head_mainPath, 1, ".updateLog", "")
        R.LocalData.Lock()
        R.LocalData.SetJson(head_mainPath, res)
        R.LocalData.Set(md5Path .. ".md5", server_md5)
        R.LocalData.Unlock()
    end
end

function DataHandle_set()
    if head_card ~= GetNowSelectedCard() then
        R_Debug("set error, card not match")
        return
    end

    if head_type == "value" then
        CloudData.SetJson(head_card .. "." .. head_mainPath .. "." .. head_secPath, res)
    elseif head_type == "client" then
        LocalData.ClientReload(res)
    else
        CloudData.SetJson(head_card .. "." .. head_mainPath, res)
    end
end

function DataHandle_md5()
    if res == "diff" then
        if head_type == "data" then
            Msg_GetData(head_card, head_mainPath)
        elseif head_type == "client" then
            Msg_GetClientList()
        end
    end
end

function DataHandle_get()
    if head_type == "data" then
        if head_card ~= GetNowSelectedCard() then
            R_Debug("set error, card not match")
            return
        end
        CloudData.SetJson(head_card .. "." .. head_mainPath, res)
    elseif head_type == "client" then
        LocalData.ClientReload(res)
    end
end

function GameHandle()
    if head_type == "googleAuth" then
        R.Temp.Set("GoogleAuthCode", res)
    end
end

function BroadcastHandle()
    if head_type == "json" then
        CloudData.SetJson(head_card .. "." .. head_mainPath, res)
    elseif head_type == "value" then
        CloudData.Set(head_card .. "." .. head_mainPath .. "." .. head_secPath, res)
    elseif head_type == "mulValue" then
        CloudData.SetJson(head_card .. "." .. head_mainPath, res)
    elseif head_type == "add" then
        CloudData.SetJson(head_card .. "." .. head_mainPath, res)
    elseif head_type == "change" then
        CloudData.SetJson(head_card .. "." .. head_mainPath, res)
    elseif head_type == "del" then
        CloudData.SetJson(head_card .. "." .. head_mainPath, res)
    elseif head_type == "client" then
        LocalData.ClientReload(res)
    elseif head_type == "updateLog" then
        local server_md5 = R.App.GetMd5(res)
        R.LocalData.Lock()
        R.LocalData.SetJson(head_type, res)
        R.LocalData.Set(head_type .. "_md5", server_md5)
        R.LocalData.Unlock()
    elseif head_type == "color" then
        R.ColorResource.Lock()
        R.ColorResource.Set()
        R.ColorResource.Set("color_md5", res)
        R.ColorResource.Unlock()
    elseif head_type == "lua" then
        local logicVersion = R_ToNumber(CloudData.Config_Get("LogicVersion"))
        if logicVersion == 0 then
            logicVersion = 1
        end
        local type = "master"
        if logicVersion == 2 then
            type = "dev"
        end
        if type == res then
            R.Temp.Set("boostrap_broadcast", "1")
        end
    elseif head_type == "task" then
        local type = ""
        local split_res = R_Split(res, "|")
        if #split_res > 0 then
            type = split_res[1]
        end
        if type == "run" then
            local task = ""
            local mode = 0
            local accountID = 0
            local threadID, threadHelpID = 0, 0

            if #split_res == 4 then
                mode = R_ToNumber(split_res[2])
                task = split_res[3]
                accountID = R_ToNumber(split_res[4])
            else
                R_Error("run task split error")
                return
            end

            if mode == 1 then
                threadID = 1
                threadHelpID = 51
            else
                threadID = accountID
                threadHelpID = threadID + R.App.GetMaxThread() / 3
            end
            if R.Thread.Get(threadID, "STATUS") ~= "" then
                R_Error("Thread is running, can't run new task")
                return
            end

            R.Thread.Set(threadID, "TASK", task)
            R.Thread.Set(threadID, "ACCOUNTID", tostring(accountID))
            R.Thread.Set(threadHelpID, "TASK", task)
            R.Thread.Set(threadHelpID, "ACCOUNTID", tostring(accountID))
            R.Engine.Run(threadID)
        elseif type == "stop" then
            local threadID, threadHelpID = 0, 0
            if #split_res == 2 then
                threadID = R_ToNumber(split_res[2])
            else
                R_Error("stop task split error")
                return
            end
            threadHelpID = threadID + R.App.GetMaxThread() / 3
            R.Thread.Set(threadID, "STOP", "1")
            R.Thread.Set(threadHelpID, "STOP", "1")
        end
        split_res = nil
    end
end

NameHandle()
head = nil
res = nil
head_name, head_type, head_card, head_mainPath, head_secPath = "", "", "", "", ""
G_AsyncHead = nil
G_AsyncResponse = nil
