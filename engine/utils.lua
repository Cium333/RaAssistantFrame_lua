function R_Init()
    local task = R_Engine_GetThreadData("TASK")
    local accountID = R_ToNumber(R_Engine_GetThreadData("ACCOUNTID"))
    -- R_ThreadInfo("task", task, "accountID", accountID)

    R_Engine_SetThreadData("", "")
    R_Engine_SetThreadData("STATUS", "RUNNING")
    R_Engine_SetThreadData("TASK", task)
    R_Engine_SetThreadData("ACCOUNTID", accountID)

    R_Engine_InitSprotect()
    R_Engine_SetAccountStatus("Run")
    R_Engine_SetAccountProgress(0.01)
    R_Engine_SetAccountTask(task)
    R.EngineTimepiece.Begin(G_ThreadID)
    -- R_ThreadInfo("Engine Init Success")
end

function R_Engine_IsStop()
    if R_Engine_GetThreadData("STOP") == "1" then
        return true
    end
    return false
end

function R_Engine_IsRest()
    if R_Engine_GetThreadData("REST") == "1" then
        return true
    end
    return false
end

function R_Engine_IsReload()
    if R_Engine_GetThreadData("RELOAD") == "1" then
        R_ThreadDebug("Reload")
        return true
    end
    return false
end

function R_Engine_Sleep(time)
    local onetime = 100
    if tonumber(time) <= onetime then
        R.App.Sleep(time)
        return
    end
    local looptimes = math.floor(time / onetime)
    local lesstimes = time % onetime
    for i = 1, looptimes do
        if R_Engine_IsStop() then
            return
        end

        R.App.Sleep(onetime)
    end

    if lesstimes > 0 then
        R.App.Sleep(lesstimes)
    end
end

function R_ThreadDebug(...)
    local threadID = G_ThreadID
    if threadID > R.App.GetMaxThread() / 3 then
        threadID = threadID - R.App.GetMaxThread() / 3
        R.Log.Debug("Thread-" .. tostring(threadID), "Help", ...)
    else
        R.Log.Debug("Thread-" .. tostring(threadID), ...)
    end
end

function R_ThreadInfo(...)
    local threadID = G_ThreadID
    if threadID > R.App.GetMaxThread() / 3 then
        threadID = threadID - R.App.GetMaxThread() / 3
        R.Log.Info("Thread-" .. tostring(threadID), "Help", ...)
    else
        R.Log.Info("Thread-" .. tostring(threadID), ...)
    end
end

function R_ThreadError(...)
    local threadID = G_ThreadID
    if threadID > R.App.GetMaxThread() / 3 then
        threadID = threadID - R.App.GetMaxThread() / 3
        R.Log.Error("Thread-" .. tostring(threadID), "Help", ...)
    else
        R.Log.Error("Thread-" .. tostring(threadID), ...)
    end
end

function R_FindPic(name)
    local table = { ret = 0, x = 0, y = 0 }
    if not R_GetColorResource(name) then
        return table
    end
    local type, rect, pic, color, sim, dir = "", "", "", "", "", ""
    local x1, y1, x2, y2 = 0, 0, 0, 0
    R.ColorResource.RLock()
    type = R.ColorResource.Get(name .. ".type")
    rect = R.ColorResource.Get(name .. ".rect")
    pic = R.ColorResource.Get(name .. ".pic")
    color = R.ColorResource.Get(name .. ".color")
    sim = R.ColorResource.Get(name .. ".sim")
    dir = R.ColorResource.Get(name .. ".dir")
    R.ColorResource.RUnlock()

    if type ~= "multiColor" then
        return table
    end

    local rectTable = R_Split(rect, ",")
    if #rectTable ~= 4 then
        return table
    end

    x1, y1, x2, y2 = R_ToNumber(rectTable[1]), R_ToNumber(rectTable[2]), R_ToNumber(rectTable[3]),
        R_ToNumber(rectTable[4])

    table = Engine.Dm.FindPic(G_ThreadID, x1, y1, x2, y2, pic, color, sim, dir)
    R_ThreadDebug("FindMultiColor", name, x1, y1, x2, y2, pic, color, sim, dir)
    R_ThreadDebug("FindMultiColorRet", table.ret, table.x, table.y)
    return table
end

function R_FindMultiColor(name)
    local table = { ret = 0, x = 0, y = 0 }
    if not R_GetColorResource(name) then
        return table
    end

    local type, rect, firstColor, offsetColor, sim, dir = "", "", "", "", "", ""
    local x1, y1, x2, y2 = 0, 0, 0, 0
    R.ColorResource.RLock()
    type = R.ColorResource.Get(name .. ".type")
    rect = R.ColorResource.Get(name .. ".rect")
    firstColor = R.ColorResource.Get(name .. ".firstColor")
    offsetColor = R.ColorResource.Get(name .. ".offsetColor")
    sim = R.ColorResource.Get(name .. ".sim")
    dir = R.ColorResource.Get(name .. ".dir")
    R.ColorResource.RUnlock()

    if type ~= "multiColor" then
        return table
    end

    local rectTable = R_Split(rect, ",")
    if #rectTable ~= 4 then
        return table
    end

    x1, y1, x2, y2 = R_ToNumber(rectTable[1]), R_ToNumber(rectTable[2]), R_ToNumber(rectTable[3]),
        R_ToNumber(rectTable[4])

    table = Engine.Dm.FindMultiColor(G_ThreadID, x1, y1, x2, y2, firstColor, offsetColor, sim, dir)
    R_ThreadDebug("FindMultiColor", name, x1, y1, x2, y2, firstColor, offsetColor, sim, dir)
    R_ThreadDebug("FindMultiColorRet", table.ret, table.x, table.y)
    return table
end

function R_GetColorResource(name)
    local type = ""
    R.ColorResource.RLock()
    type = R.ColorResource.Get(name .. ".type")
    R.ColorResource.RUnlock()

    if type == "" then
        R.ColorResource.Lock()
        local res = Msg_GetResource(name)
        if res ~= "" then
            R.ColorResource.SetJson(name, res)
        end
        type = R.ColorResource.Get(name .. ".type")
        R.ColorResource.Unlock()
    end

    if type == "" then
        return false
    end

    return true
end

function R_Engine_GetAccountID(isMain)
    return R_ToNumber(R_Engine_GetThreadData("ACCOUNTID", isMain))
end

function R_Engine_SetAccountTask(task)
    local accountID = R_Engine_GetAccountID()
    if accountID == 0 then
        R_ThreadError("accountID is 0")
        return
    end
    CloudData.Account_Set_Cloud(accountID, "task", task, false)
end

function R_Engine_SetAccountStatus(status)
    local accountID = R_Engine_GetAccountID()
    if accountID == 0 then
        R_ThreadError("accountID is 0")
        return
    end
    -- if CloudData.Account_Get(accountID, "status") == status then
    -- 	return
    -- end
    CloudData.Account_Set_Cloud(accountID, "status", status, false)
end

function R_Engine_SetAccountProgress(progress)
    local accountID = R_Engine_GetAccountID()
    if accountID == 0 then
        R_ThreadError("accountID is 0")
        return
    end
    CloudData.Account_Set_Cloud(accountID, "progress", progress, false)
end

function R_Engine_SetAccountCoin(coin)
    local accountID = R_Engine_GetAccountID()
    if accountID == 0 then
        R_ThreadError("accountID is 0")
        return
    end
    CloudData.Account_Set_Cloud(accountID, "coin", coin, false)
end

function R_Engine_GetAccountCoin()
    local accountID = R_Engine_GetAccountID()
    if accountID == 0 then
        R_ThreadError("accountID is 0")
        return
    end
    return CloudData.Account_Get(accountID, "coin")
end

function R_Engine_SetThreadData(key, value, isMain)
    local threadID = G_ThreadID
    if isMain then
        threadID = threadID + R.App.GetMaxThread() / 3
    end
    R.Thread.Set(threadID, key, value)
end

function R_Engine_GetThreadData(key, isMain)
    local threadID = G_ThreadID
    if isMain then
        threadID = threadID + R.App.GetMaxThread() / 3
    end
    return R.Thread.Get(G_ThreadID, key)
end

function R_Engine_InitSprotect()
    if CloudData.Config_Get("Mode") == "1" then
        local card = R.SProtect.GetLoginCard(1)
        R_ThreadDebug("card verify ", card)
        R.SProtect.NormalVerify(card)
        R_Engine_SetThreadData("SPROTECT", card)
        return true
    end

    for i = 2, CloudData.Card_GetCount(), 1 do
        if CloudData.Card_Get(i, "selected") == "1" then
            local status = CloudData.Card_Get(i, "status")
            local card = CloudData.Card_Get(i, "card")
            if status == "normal" then
                local res = R.SProtect.Login(i, card)
                if not res then
                    return false
                end
                R_Engine_SetThreadData("SPROTECT", card)
                return true
            end
        end
    end
    return false
end
