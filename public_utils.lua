M_ByteString_DeviceName = 1             -- 设备名称(配置项)
M_ByteString_GlobalLogSearch = 2        -- 全局日志搜索
M_ByteString_RedPluginPath = 3          -- 红色插件路径(配置项)
M_ByteString_EaDesktopPath = 4          -- EA桌面端路径(配置项)
M_ByteString_SteamPath = 5              -- Steam路径(配置项)
M_ByteString_AccountImportText = 6      -- 文本框账号导入
M_ByteString_SteamAccount = 7           -- 输入框 steam账号(配置项)
M_ByteString_SteamPwd = 8               -- 输入框 steam密码(配置项)
M_ByteString_EaID = 9                   -- 输入框 EAID(配置项)
M_ByteString_EaAccount = 10             -- 输入框 EA账号(配置项)
M_ByteString_EaPwd = 11                 -- 输入框 EA密码(配置项)
M_ByteString_GoogleAuthCode = 12        -- 输入框谷歌验证码(配置项)
M_ByteString_ThreadLogSearch = 13       -- 线程日志搜索
M_ByteString_CardImportText = 14        -- 文本框卡密导入
M_ByteString_GoogleAuthCodeChange = 15  -- 输入框谷歌验证码修改
M_ByteString_GoogleAuthCodeChanged = 16 -- 输入框谷歌验证码修改后的值
M_ByteString_EncryptString = 17         -- 加密字符串
M_ByteString_DecryptString = 18         -- 解密字符串
M_ByteInt_Modal_AccountImport = 1       -- 导入账号模态框
M_ByteInt_Modal_AccountDel = 2          -- 删除账号模态框
M_ByteInt_Modal_InintConfig = 3         -- 初始化配置模态框
M_ByteInt_Modal_CardImport = 4          -- 导入卡密模态框
M_ByteInt_Modal_CardDel = 5             -- 删除卡密模态框
M_ByteInt_Modal_Loading = 6             -- 等待加载模态框
M_ByteInt_Modal_EditAccount = 7         -- 编辑账号模态框
M_ByteInt_Modal_ErrVerify = 8           -- 错误验证模态框
M_Int_ChangeAccountPos = 1              -- 调整账号位置
M_Int_RadioButton_Mode = 2              -- 模式选择按钮
M_Int_RadioButton_LogicVersion = 3      -- 逻辑版本选择按钮
M_Int_SelectionStart_x1 = 4             -- 选择框起始位置x
M_Int_SelectionStart_y1 = 5             -- 选择框起始位置y
M_Int_SelectionEnd_x1 = 6               -- 选择框结束位置x
M_Int_SelectionEnd_y1 = 7               -- 选择框结束位置y
M_Int_IsBeginPopupContextItem = 8       -- 是否开始右键弹出菜单
M_Int_RadioButton_LoginMode = 9         -- 登录模式
M_Checkbox_Account = 1                  -- 账号
M_Checkbox_Card = 2                     -- 卡密
M_Checkbox_AutoRefreshLog = 3           -- 自动刷新日志

LoginCard = R.SProtect.GetLoginCard(1)
Announcement = "公告:  全新版本发布啦!"
Tasks = { "任务1", "任务2", "任务3", "任务4", "任务5", "任务6" }
Configs = {
    { configName = "Mode", showName = "模式", index = M_Int_RadioButton_Mode, type = "int", defaultValue = 1 }, -- 模式
    { configName = "LogicVersion", showName = "逻辑版本", index = M_Int_RadioButton_LogicVersion, type = "int", defaultValue = 1 }, -- 逻辑版本
    { configName = "DeviceName", showName = "设备名称", index = M_ByteString_DeviceName, type = "string", defaultValue = "未知" }, -- 设备名称
    { configName = "LoginMode", showName = "登录模式", index = M_Int_RadioButton_LoginMode, type = "int", defaultValue = 1 },
    { configName = "RedPluginPath", showName = "红挂路径", index = M_ByteString_RedPluginPath, type = "string", defaultValue = R.File.GetRunPath() .. "红挂\\" }, -- 红色插件路径
    { configName = "EaDesktopPath", showName = "EA桌面端路径", index = M_ByteString_EaDesktopPath, type = "string", defaultValue = "C:\\Program Files\\Electronic Arts\\EA Desktop\\EA Desktop\\EADesktop.exe" }, -- EA桌面端路径
    { configName = "SteamPath", showName = "Steam路径", index = M_ByteString_SteamPath, type = "string", defaultValue = "C:\\Program Files (x86)\\Steam\\steam.exe" }, -- Steam路径
}
Accounts = {
    { jsonName = "id", showName = "序号", isShow = true, help = "" },
    { jsonName = "packet", showName = "组", isShow = true, help = "该账号所属的组别，可用于分组与组内轮号" },
    { jsonName = "steamAccount", showName = "steam邮箱", isShow = true, help = "" },
    { jsonName = "steamPwd", showName = "steam密码", isShow = false, help = "" },
    { jsonName = "eaID", showName = "eaID", isShow = false, help = "" },
    { jsonName = "eaAccount", showName = "ea邮箱", isShow = true, help = "" },
    { jsonName = "eaPwd", showName = "ea密码", isShow = false, help = "" },
    { jsonName = "googleAuthCode", showName = "谷歌验证码", isShow = false, help = "" },
    { jsonName = "task", showName = "任务", isShow = true, help = "" },
    { jsonName = "status", showName = "状态", isShow = true, help = "" },
    { jsonName = "progress", showName = "进度", isShow = true, help = "" },
    { jsonName = "coins", showName = "金币", isShow = true, help = "" },
    { jsonName = "remark", showName = "备注", isShow = true, help = "这里也作为调整账号位置的区域,请单击鼠标右键找到->调整账号位置<-相关操作" },
}

Packets = {
    { showName = "T1",  color = "#A888B5" },
    { showName = "T2",  color = "#d65db1" },
    { showName = "T3",  color = "#845ec2" },
    { showName = "T4",  color = "#ff6f91" },
    { showName = "T5",  color = "#2c73d2" },
    { showName = "T6",  color = "#00c9a7" },
    { showName = "T7",  color = "#26C6DA" },
    { showName = "T8",  color = "#FF7043" },
    { showName = "T9",  color = "#9CCC65" },
    { showName = "T10", color = "#FFEE58" },
}

LoadAccount = {
    { jsonName = "steamAccount", showName = "steam邮箱", index = M_ByteString_SteamAccount },
    { jsonName = "steamPwd", showName = "steam密码", index = M_ByteString_SteamPwd },
    { jsonName = "eaID", showName = "eaID", index = M_ByteString_EaID },
    { jsonName = "eaAccount", showName = "ea邮箱", index = M_ByteString_EaAccount },
    { jsonName = "eaPwd", showName = "ea密码", index = M_ByteString_EaPwd },
    { jsonName = "googleAuthCode", showName = "谷歌验证码", index = M_ByteString_GoogleAuthCode },
}

function GetNowSelectedCard()
    return tostring(R.Temp.Get("GlobalClientSelected"))
end

function GetNowAccountPath(index)
    if index then
        return tostring(GetNowSelectedCard() .. ".Account." .. tostring(index))
    else
        return tostring(GetNowSelectedCard() .. ".Account")
    end
end

function GetNowConfigPath(configName)
    if configName == nil then
        configName = ""
    end
    return tostring(GetNowSelectedCard() .. ".Config." .. configName)
end

function GetNowCardPath(index)
    if index then
        return tostring(GetNowSelectedCard() .. ".Card." .. tostring(index))
    else
        return tostring(GetNowSelectedCard() .. ".Card")
    end
end

function R_Debug(...)
    R.Log.Debug("Global", ...)
end

function R_Info(...)
    R.Log.Info("Global", ...)
end

function R_Error(...)
    R.Log.Error("Global", ...)
end

function R_ClearLog()
    R.Log.Clear("Global")
end

function R_Load(title)
    if title == nil then
        title = "正在加载中"
    end
    R.Temp.Set("waitingServerResponse", title)
end

function R_Unload()
    if R.Temp.Get("waitingServerResponse") ~= "" then
        R.Temp.Set("waitingServerResponse")
    end
end

function IsLoading()
    return R.Temp.Get("waitingServerResponse") ~= ""
end

function R_SProtect_Login(id, card)
    R.SProtect.Login(id, card)
    local index = CloudData.Card_FindIndex(card)
    if index == -1 then
        return
    end
    if CloudData.Card_Get(index, "card") == "" then
        return
    end
    local expireTime = R.SProtect.GetExpireTimeStr(card)
    local expireTimestamp = R.SProtect.GetExpireTimestamp(card)
    local errCode = R.SProtect.GetErrCode(card)
    local errMsg = R.SProtect.GetErrMsg(card)
    if errCode ~= 0 then
        CloudData.Card_Set_Cloud(index, "status", errMsg)
    else
        CloudData.Card_Set_Cloud(index, "status", "normal")
    end
    CloudData.Card_Set_Cloud(index, "expireTime", expireTime)
    CloudData.Card_Set_Cloud(index, "expireTimestamp", expireTimestamp)
end

function R_SProtect_Logout(card)
    R.SProtect.Logout(card)
    local index = CloudData.Card_FindIndex(card)
    if index == -1 then
        return
    end
    if CloudData.Card_Get(index, "card") == "" then
        return
    end
    CloudData.Card_Set_Cloud(index, "status", "")
    CloudData.Card_Set_Cloud(index, "expireTime", "")
    CloudData.Card_Set_Cloud(index, "expireTimestamp", "")
end

function R_SProtect_NormalVerify(card)
    R.SProtect.NormalVerify(card)
    local index = CloudData.Card_FindIndex(card)
    if index == -1 then
        return
    end
    if CloudData.Card_Get(index, "card") == "" then
        return
    end
    local expireTime = R.SProtect.GetExpireTimeStr(card)
    local expireTimestamp = R.SProtect.GetExpireTimestamp(card)
    local errCode = R.SProtect.GetErrCode(card)
    local errMsg = R.SProtect.GetErrMsg(card)
    if errCode ~= 0 then
        CloudData.Card_Set_Cloud(index, "status", errMsg)
    else
        CloudData.Card_Set_Cloud(index, "status", "normal")
    end
    CloudData.Card_Set_Cloud(index, "expireTime", expireTime)
    CloudData.Card_Set_Cloud(index, "expireTimestamp", expireTimestamp)
end

function R_SProtect_NormalVerifyAll()
    R.CloudData.RLock()
    local table = R.CloudData.GetAllPropertyNamesSplit(GetNowCardPath())
    R.CloudData.RUnlock()
    for i = 1, #table, 1 do
        local card = CloudData.Get(GetNowCardPath(i) .. ".card")
        if R.SProtect.GetOffStatus(card) == 1 then
            -- R.App.AddBackendTask(R_HandleCmd([[R_SProtect_NormalVerify({s})]], card))
            R_SProtect_NormalVerify(card)
        end
    end
    table = nil
end

function R_HandleCmd(cmd, ...)
    local arg = { ... }
    local res = cmd
    for i = 1, #arg, 1 do
        local positions = {
            i = R.String.FindString(res, "{i}", true),
            s = R.String.FindString(res, "{s}", true),
            s2 = R.String.FindString(res, "[s]", true)
        }

        local minValue = math.huge
        local minKey = nil

        for key, value in pairs(positions) do
            if value ~= -1 and value < minValue then
                minValue = value
                minKey = key
            end
        end


        if minValue == math.huge or not minKey then
            goto continue
        end

        local valueToReplace = R_ToNumber(arg[i])
        if minKey == "i" then
            res = R.String.ReplaceString(res, 1, "{i}", valueToReplace)
        elseif minKey == "s" then
            res = R.String.ReplaceString(res, 1, "{s}", '"' .. tostring(arg[i]) .. '"')
        elseif minKey == "s2" then
            res = R.String.ReplaceString(res, 1, "[s]", '[[' .. tostring(arg[i]) .. ']]')
        end

        ::continue::
    end
    return res
end

--R_SProtect_NormalVerify({s})
Cmd_R_SProtect_NormalVerify =
[[DxIdAQ8ZPwMGGxsFFDAFSRJINhMykTOqEhQuPwYMqA0JHWJgNf9CYA==]]

--R_SProtect_Login({{i}},{s})
Cmd_R_SProtect_Login =
[[01cu9Glzc3xuL258emJYp1RoemSIVXxLenVYK2h8dGB6Bgdo++4H]]

--R_SProtect_Logout({s})
Cmd_R_SProtect_Logout = [[EgUVTk8JNBsBKh0JORISDwk1NgMbFKsdHBM5NHpmLcoDZg==]]

-- R_SProtect_NormalVerifyAll()
-- Msg_GetUpdateLogMd5()
-- Msg_GetResourceMd5()
Cmd_UiTimepiece_Handle =
[[Oxo9KiwsYBZDDgQtBTkWJiYWQzoZBz0uKBs7LQQEPTscLCw9KGE9FjxgfC4vYSUuYSwIOg6uKjobLDtgJiYtLHwEhok9JTAlIB8kQkkk7DVJ]]
