M_ByteString_DeviceName = 1             -- �豸����(������)
M_ByteString_GlobalLogSearch = 2        -- ȫ����־����
M_ByteString_RedPluginPath = 3          -- ��ɫ���·��(������)
M_ByteString_EaDesktopPath = 4          -- EA�����·��(������)
M_ByteString_SteamPath = 5              -- Steam·��(������)
M_ByteString_AccountImportText = 6      -- �ı����˺ŵ���
M_ByteString_SteamAccount = 7           -- ����� steam�˺�(������)
M_ByteString_SteamPwd = 8               -- ����� steam����(������)
M_ByteString_EaID = 9                   -- ����� EAID(������)
M_ByteString_EaAccount = 10             -- ����� EA�˺�(������)
M_ByteString_EaPwd = 11                 -- ����� EA����(������)
M_ByteString_GoogleAuthCode = 12        -- �����ȸ���֤��(������)
M_ByteString_ThreadLogSearch = 13       -- �߳���־����
M_ByteString_CardImportText = 14        -- �ı����ܵ���
M_ByteString_GoogleAuthCodeChange = 15  -- �����ȸ���֤���޸�
M_ByteString_GoogleAuthCodeChanged = 16 -- �����ȸ���֤���޸ĺ��ֵ
M_ByteString_EncryptString = 17         -- �����ַ���
M_ByteString_DecryptString = 18         -- �����ַ���
M_ByteInt_Modal_AccountImport = 1       -- �����˺�ģ̬��
M_ByteInt_Modal_AccountDel = 2          -- ɾ���˺�ģ̬��
M_ByteInt_Modal_InintConfig = 3         -- ��ʼ������ģ̬��
M_ByteInt_Modal_CardImport = 4          -- ���뿨��ģ̬��
M_ByteInt_Modal_CardDel = 5             -- ɾ������ģ̬��
M_ByteInt_Modal_Loading = 6             -- �ȴ�����ģ̬��
M_ByteInt_Modal_EditAccount = 7         -- �༭�˺�ģ̬��
M_ByteInt_Modal_ErrVerify = 8           -- ������֤ģ̬��
M_Int_ChangeAccountPos = 1              -- �����˺�λ��
M_Int_RadioButton_Mode = 2              -- ģʽѡ��ť
M_Int_RadioButton_LogicVersion = 3      -- �߼��汾ѡ��ť
M_Int_SelectionStart_x1 = 4             -- ѡ�����ʼλ��x
M_Int_SelectionStart_y1 = 5             -- ѡ�����ʼλ��y
M_Int_SelectionEnd_x1 = 6               -- ѡ������λ��x
M_Int_SelectionEnd_y1 = 7               -- ѡ������λ��y
M_Int_IsBeginPopupContextItem = 8       -- �Ƿ�ʼ�Ҽ������˵�
M_Int_RadioButton_LoginMode = 9         -- ��¼ģʽ
M_Checkbox_Account = 1                  -- �˺�
M_Checkbox_Card = 2                     -- ����
M_Checkbox_AutoRefreshLog = 3           -- �Զ�ˢ����־

LoginCard = R.SProtect.GetLoginCard(1)
Announcement = "����:  ȫ�°汾������!"
Tasks = { "����1", "����2", "����3", "����4", "����5", "����6" }
Configs = {
    { configName = "Mode", showName = "ģʽ", index = M_Int_RadioButton_Mode, type = "int", defaultValue = 1 }, -- ģʽ
    { configName = "LogicVersion", showName = "�߼��汾", index = M_Int_RadioButton_LogicVersion, type = "int", defaultValue = 1 }, -- �߼��汾
    { configName = "DeviceName", showName = "�豸����", index = M_ByteString_DeviceName, type = "string", defaultValue = "δ֪" }, -- �豸����
    { configName = "LoginMode", showName = "��¼ģʽ", index = M_Int_RadioButton_LoginMode, type = "int", defaultValue = 1 },
    { configName = "RedPluginPath", showName = "���·��", index = M_ByteString_RedPluginPath, type = "string", defaultValue = R.File.GetRunPath() .. "���\\" }, -- ��ɫ���·��
    { configName = "EaDesktopPath", showName = "EA�����·��", index = M_ByteString_EaDesktopPath, type = "string", defaultValue = "C:\\Program Files\\Electronic Arts\\EA Desktop\\EA Desktop\\EADesktop.exe" }, -- EA�����·��
    { configName = "SteamPath", showName = "Steam·��", index = M_ByteString_SteamPath, type = "string", defaultValue = "C:\\Program Files (x86)\\Steam\\steam.exe" }, -- Steam·��
}
Accounts = {
    { jsonName = "id", showName = "���", isShow = true, help = "" },
    { jsonName = "packet", showName = "��", isShow = true, help = "���˺���������𣬿����ڷ����������ֺ�" },
    { jsonName = "steamAccount", showName = "steam����", isShow = true, help = "" },
    { jsonName = "steamPwd", showName = "steam����", isShow = false, help = "" },
    { jsonName = "eaID", showName = "eaID", isShow = false, help = "" },
    { jsonName = "eaAccount", showName = "ea����", isShow = true, help = "" },
    { jsonName = "eaPwd", showName = "ea����", isShow = false, help = "" },
    { jsonName = "googleAuthCode", showName = "�ȸ���֤��", isShow = false, help = "" },
    { jsonName = "task", showName = "����", isShow = true, help = "" },
    { jsonName = "status", showName = "״̬", isShow = true, help = "" },
    { jsonName = "progress", showName = "����", isShow = true, help = "" },
    { jsonName = "coins", showName = "���", isShow = true, help = "" },
    { jsonName = "remark", showName = "��ע", isShow = true, help = "����Ҳ��Ϊ�����˺�λ�õ�����,�뵥������Ҽ��ҵ�->�����˺�λ��<-��ز���" },
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
    { jsonName = "steamAccount", showName = "steam����", index = M_ByteString_SteamAccount },
    { jsonName = "steamPwd", showName = "steam����", index = M_ByteString_SteamPwd },
    { jsonName = "eaID", showName = "eaID", index = M_ByteString_EaID },
    { jsonName = "eaAccount", showName = "ea����", index = M_ByteString_EaAccount },
    { jsonName = "eaPwd", showName = "ea����", index = M_ByteString_EaPwd },
    { jsonName = "googleAuthCode", showName = "�ȸ���֤��", index = M_ByteString_GoogleAuthCode },
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
        title = "���ڼ�����"
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
