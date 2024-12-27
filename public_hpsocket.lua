function Msg_SetDataJson(tocard, mainPath, secPath, value, md5, isAsyncWait)
    if isAsyncWait then
        R.App.AddBackendTask(R_HandleCmd(
            [[
			R.HPSocket.SyncAndHandlePackMsg("data", "set", "json", {s}, {s}, {s}, [s], {s})
			R_Unload()
		]],
            tocard, mainPath, secPath, value, md5))
    else
        R.HPSocket.AsyncPackMsg("data", "set", "json", tocard, mainPath, secPath, value, md5)
    end
end

function Msg_SetDataValue(tocard, mainPath, secPath, value, md5, isAsyncWait)
    if isAsyncWait then
        md5 = R.App.GetMd5(R.CloudData.ToString(GetNowAccountPath()))
        R.App.AddBackendTask(R_HandleCmd(
            [[
			R.HPSocket.SyncAndHandlePackMsg("data", "set", "value", {s}, {s}, {s}, {s}, {s})
			R_Unload()
		]],
            tocard, mainPath, secPath, value, md5))
    else
        R.HPSocket.AsyncPackMsg("data", "set", "value", tocard, mainPath, secPath, value, "")
    end
end

function Msg_SetDataValueMul(tocard, mainPath, value, md5, isAsyncWait)
    if isAsyncWait then
        R.App.AddBackendTask(R_HandleCmd(
            [[
			R.HPSocket.SyncAndHandlePackMsg("data", "set", "mulValue", {s}, {s},"", [s], {s})
			R_Unload()
		]],
            tocard, mainPath, value, md5))
    else
        R.HPSocket.AsyncPackMsg("data", "set", "mulValue", tocard, mainPath, "", value, md5)
    end
end

function Msg_DataAdd(tocard, mainPath, value, md5)
    R.App.AddBackendTask(R_HandleCmd(
        [[
			R.HPSocket.SyncAndHandlePackMsg("data", "set", "add", {s}, {s}, "",[s], {s})
			R_Unload()
		]],
        tocard, mainPath, value, md5))
end

function Msg_DataChange(tocard, mainPath, value, md5)
    R.App.AddBackendTask(R_HandleCmd(
        [[
			R.HPSocket.SyncAndHandlePackMsg("data", "set", "change", {s}, {s},"", [s], {s})
			R_Unload()
		]],
        tocard, mainPath, value, md5))
end

function Msg_DataDel(tocard, mainPath, value, md5)
    R.App.AddBackendTask(R_HandleCmd(
        [[
			R.HPSocket.SyncAndHandlePackMsg("data", "set", "del", {s}, {s},"", [s], {s})
			R_Unload()
		]],
        tocard, mainPath, value, md5))
end

function Msg_GetDataMd5(tocard, path, md5, isAsyncWait)
    if isAsyncWait then
        R.App.AddBackendTask(R_HandleCmd(
            [[
        	    R.HPSocket.SyncAndHandlePackMsg("data", "md5", "data", {s}, {s},"", "", {s})
        	    R_Unload()
            ]],
            tocard, path, md5))
    else
        R.HPSocket.AsyncPackMsg("data", "md5", "data", tocard, path, "", "", md5)
    end
end

function Msg_GetData(tocard, path)
    R.HPSocket.SyncAndHandlePackMsg("data", "get", "data", tocard, path)
end

function Msg_GetUpdateLogMd5()
    local md5 = LocalData.Get("updateLog_frame.md5")
    R.HPSocket.AsyncPackMsg("res", "md5", "", "", "updateLog_frame.md5", "", "", md5)

    md5 = LocalData.Get("updateLog" .. R.App.GetRunLua() .. ".md5")
    R.HPSocket.AsyncPackMsg("res", "md5", "", "", "updateLog" .. R.App.GetRunLua() .. ".md5", "", "", md5)
end

function Msg_GetUpdateLog()
    R.HPSocket.SyncAndHandlePackMsg("res", "getjson", "", "", "updateLog_frame.updateLog")
    R.HPSocket.SyncAndHandlePackMsg("res", "getjson", "", "", "updateLog" .. R.App.GetRunLua() .. ".updateLog")
end

function Msg_GetResourceMd5()
    -- R.HPSocket.AsyncMsg("res", "md5", "color_md5")
end

function Msg_GetResource(name)
    -- return tostring(R.HPSocket.SyncMsg("res", "getjson", "color." .. name))
end

function Msg_GetClientListMd5()
    local md5 = LocalData.Get("clientList_md5")
    R.HPSocket.AsyncPackMsg("data", "md5", "client", "", "", "", "", md5)
end

function Msg_GetClientList()
    R.HPSocket.SyncAndHandlePackMsg("data", "get", "client")
end

function Msg_SetClientData(tocard, path, value)
    R.HPSocket.AsyncPackMsg("data", "set", "client", tocard, path, "", value, "")
end

function Msg_GetGoogleAuthCode(key)
    R.App.AddBackendTask(R_HandleCmd(
        [[
			R.HPSocket.SyncAndHandlePackMsg("game", "googleAuth", "", "", "","", {s}, "")
			R_Unload()
		]], key))
end

function Msg_SetGameDataJson(tocard, mainPath, secPath, value, md5)
    -- R.HPSocket.AsyncMsgData("game", "set", "json", tocard, mainPath, secPath, value, md5)
end

function Msg_SetGameDataValue(tocard, mainPath, secPath, value, md5)
    -- R.HPSocket.AsyncMsgData("game", "set", "value", tocard, mainPath, secPath, value, md5)
end

function Msg_GetGameDataJson(tocard, path)
    -- R.HPSocket.AsyncMsgData("game", "get", "json", tocard, path, "", "", "")
end

function Msg_GetGameDataValue(tocard, path)
    -- R.HPSocket.AsyncMsgData("game", "get", "value", tocard, path, "", "", "")
end

function Msg_SetGameDataTask(tocard, value)
    R.HPSocket.AsyncPackMsg("game", "set", "task", tocard, "", "", value, "")
end
