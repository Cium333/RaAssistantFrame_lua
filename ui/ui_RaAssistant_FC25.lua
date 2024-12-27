-- fc25
local windowWidth, windowHeight = ImGui.GetWindowRect()

local Rect_MenuBarHeight = 25
local Rect_LogHeight = 0.25 * windowHeight
local Rect_Left = 5
local Rect_TabBarHeight = 30

-- Ԥ���㳣��ֵ
local adjustedWindowHeight = windowHeight - Rect_LogHeight - Rect_MenuBarHeight - Rect_TabBarHeight - 11
local adjustedClientWidth = 0.8 * windowWidth - 9

local Rect_MainTabBarPosY = Rect_MenuBarHeight + Rect_TabBarHeight - 3
local Rect_MainTabBarHeight = adjustedWindowHeight
local Rect_MainTabBarWidth = windowWidth - 10
local Rect_ClientListWidth = 0.2 * windowWidth
local Rect_ClientDetailWidth = adjustedClientWidth
local Rect_ClientDetailPosX = Rect_ClientListWidth + Rect_Left
local Rect_LogPosY = windowHeight - Rect_LogHeight + Rect_TabBarHeight - 22
local Rect_LogChildHeight = Rect_LogHeight - Rect_TabBarHeight + 18
local Rect_ConsoleStatusPosX = Rect_ClientDetailPosX + 5
local Rect_ConsoleStatusPosY = Rect_MainTabBarPosY + Rect_TabBarHeight - 2
local Rect_ConsoleStatusWidth = adjustedClientWidth - 10
local Rect_ConsoleStatusHeight = 40
local Rect_ConsoleAccountListPosX = Rect_ConsoleStatusPosX
local Rect_ConsoleAccountListPosY = Rect_ConsoleStatusPosY + Rect_ConsoleStatusHeight + 4
local Rect_ConsoleAccountListWidth = adjustedClientWidth - 10
local Rect_ConsoleAccountListHeight = (Rect_MainTabBarHeight - Rect_TabBarHeight - 11 - Rect_ConsoleStatusHeight + 4)
local Rect_ConsoleSettingPosX = Rect_ClientDetailPosX + 5
local Rect_ConsoleSettingPosY = Rect_MainTabBarPosY + Rect_TabBarHeight - 2
local Rect_ConsoleSettingWidth = adjustedClientWidth - 10
local Rect_ConsoleSettingHeight = Rect_MainTabBarHeight - Rect_TabBarHeight - 3
local Rect_CardPosX = Rect_ClientDetailPosX + 5
local Rect_CardPosY = Rect_MainTabBarPosY + Rect_TabBarHeight - 2
local Rect_CardWidth = adjustedClientWidth - 10
local Rect_CardHeight = Rect_MainTabBarHeight - Rect_TabBarHeight - 3

-- ? ����ѡ������
function ListRectDraw(selectJsonPath, ...)
    local args = { ... }

    -- ��������Ч��
    for i, arg in ipairs(args) do
        if R.MValue.GetByteInt(R_ToNumber(arg)) ~= 0 then
            return
        end
    end

    local isWindowFocused = ImGui.IsWindowFocused(ImGuiFocusedFlags_ChildWindows)
    local isWindowHovered = ImGui.IsWindowHovered(ImGuiFocusedFlags_ChildWindows)

    if isWindowFocused then
        if isWindowHovered then
            if R.MValue.GetInt(M_Int_IsBeginPopupContextItem) == 0 then
                if R.Temp.Get("Drawing") == "" and ImGui.GetKeyStatus(1) then
                    -- ������갴��
                    R.MValue.SetInt(M_Int_SelectionEnd_x1, 0)
                    R.MValue.SetInt(M_Int_SelectionEnd_y1, 0)
                    local selectionStart_x1, selectionStart_y1 = ImGui.GetMousePos()
                    R.MValue.SetInt(M_Int_SelectionStart_x1, selectionStart_x1)
                    R.MValue.SetInt(M_Int_SelectionStart_y1, selectionStart_y1)
                    if ImGui.GetKeyStatus(17) or ImGui.GetKeyStatus(16) then

                    else
                        R.Temp.Set(selectJsonPath)
                        R.Temp.Set("Drawing", "1")
                    end
                elseif R.Temp.Get("Drawing") == "1" and not ImGui.GetKeyStatus(1) then
                    -- �������̧��
                    R.Temp.Set("Drawing")
                    R.MValue.SetInt(M_Int_SelectionStart_x1, 0)
                    R.MValue.SetInt(M_Int_SelectionStart_y1, 0)
                    R.MValue.SetInt(M_Int_SelectionEnd_x1, 0)
                    R.MValue.SetInt(M_Int_SelectionEnd_y1, 0)
                end

                if R.Temp.Get("Drawing") == "1" then
                    -- ����ѡ������
                    local selectionEnd_x1, selectionEnd_y1 = ImGui.GetMousePos()
                    local selectionStart_x1 = R.MValue.GetInt(M_Int_SelectionStart_x1)
                    local selectionStart_y1 = R.MValue.GetInt(M_Int_SelectionStart_y1)
                    ImGui.AddRectFilled(selectionStart_x1, selectionStart_y1, selectionEnd_x1, selectionEnd_y1,
                        "#3B7ECE", 0.7, 0, 15)
                end
            end
        else
            if ImGui.GetKeyStatus(1) or ImGui.GetKeyStatus(2) then
                R.Temp.Set(selectJsonPath)
                R.Temp.Set("Drawing")
                R.MValue.SetInt(M_Int_IsBeginPopupContextItem, 0)
            end
        end
    elseif isWindowFocused then
        if ImGui.GetKeyStatus(1) or ImGui.GetKeyStatus(2) then
            R.MValue.SetInt(M_Int_IsBeginPopupContextItem, 0)
            R.Temp.Set(selectJsonPath)
        end
    end
end

function RectSelectInLoop(selectPath, i)
    -- ��鴰���Ƿ�۽�
    if not ImGui.IsWindowFocused(ImGuiFocusedFlags_ChildWindows) then
        return
    end
    if not ImGui.IsWindowHovered(ImGuiFocusedFlags_ChildWindows) then
        return
    end
    -- ����ض�������״̬
    if ImGui.GetKeyStatus(17) and ImGui.GetKeyStatus(65) then
        R.Temp.Set(selectPath .. "." .. tostring(i), "1")
    end

    if R.MValue.GetInt(M_Int_IsBeginPopupContextItem) ~= 0 then
        return
    end

    -- ��鴰���Ƿ���ͣ���һ���״̬
    if R.Temp.Get("Drawing") == "1" then
        local _, cursorPosY = ImGui.GetCursorScreenPos()
        local frameHeight = ImGui.GetFrameHeight()
        cursorPosY = cursorPosY - frameHeight

        local selectionStart_y1 = R.MValue.GetInt(M_Int_SelectionStart_y1)
        local _, selectionEnd_y1 = ImGui.GetMousePos()

        -- ������С�����Y����
        local minY = math.min(selectionStart_y1, selectionEnd_y1)
        local maxY = math.max(selectionStart_y1, selectionEnd_y1)
        -- ������Ƿ���ѡ��������
        if cursorPosY > minY - frameHeight and cursorPosY < maxY then
            R.Temp.Set(selectPath .. "." .. tostring(i), "1")
        end
    end
end

function ListSelect(selectPath, selected, count, i)
    if R.Temp.Get("Drawing") == "" then
        if ImGui.GetKeyStatus(17) then
            R.Temp.Set(selectPath .. "." .. tostring(i), selected == 1 and "" or "1")
        elseif ImGui.GetKeyStatus(16) then
            local nowAccountSelected = 0
            for j = 1, count, 1 do
                if R_ToNumber(R.Temp.Get(selectPath .. "." .. tostring(j))) == 1 then
                    nowAccountSelected = j
                    break
                end
            end
            if nowAccountSelected ~= 0 then
                if nowAccountSelected > i then
                    for k = i, nowAccountSelected, 1 do
                        R.Temp.Set(selectPath .. "." .. tostring(k), "1")
                    end
                else
                    for k = i, nowAccountSelected, -1 do
                        R.Temp.Set(selectPath .. "." .. tostring(k), "1")
                    end
                end
            else
                R.Temp.Set(selectPath .. "." .. tostring(i), "1")
            end
        else
            -- R.Temp.Set("GlobalAccountSelected")
            -- R.Temp.Set("GlobalAccountSelected." .. tostring(i), selected == 1 and "0" or "1")
        end
    end
end

-- ��ʾ��ʼ�����ؽ���
if R.Temp.Get("��ʼ�����") ~= "2" or R.Temp.Get("��ʼ��.���ݷ���������") ~= "1" then
    if R.Temp.Get("��ʼ�����") == "" or R.Temp.Get("��ʼ��.���ݷ���������") ~= "1" then
        if R.Temp.Get("��ʼ��.���ݷ���������") ~= "1" then
            if R.Temp.Get("��ʼ�����") == "2" then
                R_Debug("���ݷ���������")
                R.Temp.Set("��ʼ�����", "1")
            end
        end
        ImGui.SetNextWindowPos(0, 0)
        ImGui.SetNextWindowSize(windowWidth, windowHeight)
        if ImGui.Begin("##BeginInit", 0, Bit.bor(ImGuiWindowFlags_NoTitleBar, ImGuiWindowFlags_NoResize)) then
            ImGui.SetNextWindowPos(windowWidth / 2, windowHeight / 2, 0, 0.5, 0.5)
            if ImGui.BeginChildStr("ChildStrInit", windowWidth / 2, windowHeight / 4, true, 0) then
                local title = "��ʼ����"
                local interval = 200                                                   -- ÿ0.1��
                local dots = math.floor(R.UITimepiece.GetMillisecond() / interval) % 6 -- ÿ0.1����£���ൽ4
                title = title .. string.rep(".", dots)                                 -- ���ݼ���ĵ������ɱ���
                ImGui.Spacing()
                ImGui.Spacing()
                ImGui.SetWindowFontScale(1.5)
                ImGui.Text(title)
                ImGui.Text("ȫ�����ݳ�ʼ��--->")
                ImGui.SameLine()
                ImGui.TextColored(
                    (R.Temp.Get("��ʼ��.ȫ������") == "1" and "#36ad6a" or "#de576d"),
                    (R.Temp.Get("��ʼ��.ȫ������") == "1" and "�ɹ�" or "��ʼ����" .. string.rep(".", dots)))

                ImGui.Text("��֤����������--->")
                ImGui.SameLine()
                ImGui.TextColored(
                    (R.Temp.Get("��ʼ��.��֤����������") == "1" and "#36ad6a" or "#de576d"),
                    (R.Temp.Get("��ʼ��.��֤����������") == "1" and "�ɹ�" or "������" .. string.rep(".", dots)))

                ImGui.Text("���ݷ���������--->")
                ImGui.SameLine()
                ImGui.TextColored(
                    (R.Temp.Get("��ʼ��.���ݷ���������") == "1" and "#36ad6a" or "#de576d" or "#FFFFFF"),
                    (R.Temp.Get("��ʼ��.���ݷ���������") == "1" and "�ɹ�" or R.Temp.Get("��ʼ��.���ݷ���������") .. string.rep(".", dots) or " "))
                ImGui.SetWindowFontScale(1)
                ImGui.EndChild()
            end
            ImGui.End()
        end
        return
    elseif R.Temp.Get("��ʼ�����") == "1" then -- ��ʼ��
        R.Temp.Set("GlobalClientIndex", "1")
        R.Temp.Set("GlobalClientSelected", R.SProtect.GetLoginCard(1))
        R_Load("������������")
        CloudData.Clear()
        CloudData.Client_Select_Cloud() -- ѡ��ǰ��¼�Ŀͻ���
        CloudData.Init_Cloud(true)
        -- ��ʼ��checkbox
        R.MValue.InitCheckbox(M_Checkbox_AutoRefreshLog, 1)
        R.MValue.SetCheckbox(M_Checkbox_AutoRefreshLog, 1, 1)

        Msg_GetUpdateLogMd5()     -- ��ȡ������־md5
        Msg_GetClientListMd5()    -- ��ȡ�ͻ����б�md5

        R.UpdateTimepiece.Begin() -- ����ʱ����ѯ
        --R.gdi.Init(0)
        R_Debug("��ʼ�����")
        R.Temp.Set("��ʼ�����", "2")
        return
    elseif R.Temp.Get("�˳�����") == "1" then
        return
    end
end

function UI_FC25_UiTimepiece_Handle()
    if R.Temp.Get("��ʼ�����") ~= "2" then
        return
    end
    local nowTime = R_ToNumber(R.UpdateTimepiece.GetMillisecond())
    if nowTime >= 1000 then
        local count = R_ToNumber(R.Temp.Get("UITimepieceCount")) + 1
        if count >= 30 then
            R.App.AddBackendTask(R.Encrypt.Decrypt(Cmd_UiTimepiece_Handle))
            count = 0
            R.Temp.Set("UITimepieceCount")
        end
        R.UpdateTimepiece.Begin()
        CloudData.Init_Cloud(false)
        Msg_GetClientListMd5()
        R.Temp.Set("UITimepieceCount", tostring(count))
    end
end

UI_FC25_UiTimepiece_Handle() -- ��ʱ��

ImGui.SetNextWindowPos(0, 0)
ImGui.SetNextWindowSize(windowWidth, windowHeight)
if ImGui.Begin("##main", 0, Bit.bor(ImGuiWindowFlags_NoTitleBar,
        ImGuiWindowFlags_NoResize,
        ImGuiWindowFlags_NoBringToFrontOnFocus,
        ImGuiWindowFlags_MenuBar,
        ImGuiWindowFlags_NoScrollbar,
        ImGuiWindowFlags_NoScrollWithMouse,
        ImGuiWindowFlags_NoCollapse)) then
    if ImGui.BeginMenuBar() then
        ImGui.TextColored("#00FF7F", Announcement)
        ImGui.EndMenuBar()
    end
    if ImGui.BeginTabBar("##MainTabBar", 0) then
        -- ? MainTabItem ��ҳ
        if ImGui.BeginTabItem("��ҳ") then
            ImGui.SetNextWindowPos(Rect_Left, Rect_MainTabBarPosY)
            -- ? ClientList �ͻ����б�
            if ImGui.BeginChildStr("##clientList", Rect_ClientListWidth, Rect_MainTabBarHeight, true, ImGuiWindowFlags_NoScrollbar) then
                ImGui.SetCursorPos(5, 4)
                if ImGui.BeginTabBar("##ClientListTabBar", 0) then
                    if ImGui.BeginTabItem("�ͻ����б�") then
                        local table = LocalData.GetAllPropertyNamesSplit("clientList")
                        ImGui.Spacing()
                        for i = 1, #table, 1 do
                            ImGui.SetCursorPosX(5)
                            local card = table[i]
                            local path = "clientList." .. table[i]
                            local name = LocalData.Get(path .. ".deviceName")
                            local ip = LocalData.Get(path .. ".ip")
                            local online = LocalData.Get(path .. ".online")
                            online = online == "true" and "����" or "����"
                            if card == LoginCard then
                                ImGui.TextColored("#4098fc", "(����)")
                            elseif online == "����" then
                                ImGui.TextColored("#de576d", "(����)")
                            elseif online == "����" then
                                ImGui.TextColored("#00FF7F", "(����)")
                            end
                            ImGui.SameLine(0, 10)

                            local showName = (name == "δ֪" or name == "") and card or name
                            local isSelected = R_ToNumber(R.Temp.Get("GlobalClientIndex"))
                            if ImGui.SelectableBool(showName, isSelected == i, 0, 0, 0) then
                                R_Load("������������")
                                R.Temp.Set("GlobalClientSelected", card)
                                R.Temp.Set("GlobalClientIndex", tostring(i))
                                CloudData.Clear()
                                CloudData.Client_Select_Cloud()
                                CloudData.Init_Cloud(true)
                            end

                            if ImGui.IsItemHovered() then
                                local tooltip = "�豸��: " ..
                                    name .. "\nIP��ַ: " .. ip .. "\n����: " .. card .. "\n״̬: " .. online
                                ImGui.SetTooltip(tooltip)
                            end
                        end
                        table = nil
                        ImGui.EndTabItem()
                    end
                    ImGui.EndTabBar()
                end
                ImGui.EndChild()
            end
            -- ? ClientDetail �ͻ�������
            ImGui.SetNextWindowPos(Rect_ClientDetailPosX, Rect_MainTabBarPosY)
            if ImGui.BeginChildStr("##clientDetail", Rect_ClientDetailWidth, Rect_MainTabBarHeight, true, Bit.bor(ImGuiWindowFlags_NoScrollbar, ImGuiWindowFlags_NoScrollWithMouse)) then
                ImGui.SetCursorPos(5, 4)
                if ImGui.BeginTabBar("##ClientDetailTabBar", 0) then
                    -- ? ����̨
                    if ImGui.BeginTabItem("����̨") then
                        -- ? ����̨״̬
                        ImGui.SetNextWindowPos(Rect_ConsoleStatusPosX, Rect_ConsoleStatusPosY)
                        if ImGui.BeginChildStr("##consoleStatus", Rect_ConsoleStatusWidth, Rect_ConsoleStatusHeight, true, Bit.bor(ImGuiWindowFlags_NoScrollbar, ImGuiWindowFlags_NoScrollWithMouse)) then
                            ImGui.BulletText("����״̬: ����")
                            ImGui.SameLine(0, 10)
                            ImGui.BulletText("�ܽ��: 999999999999")
                            ImGui.EndChild()
                        end
                        -- ? ����̨�˺��б�
                        ImGui.SetNextWindowPos(Rect_ConsoleAccountListPosX,
                            Rect_ConsoleAccountListPosY)
                        -- ImGui.SetNextWindowContentSize(2000, Rect_ConsoleAccountListHeight)
                        if ImGui.BeginChildStr("##consoleClientList", Rect_ConsoleAccountListWidth, Rect_ConsoleAccountListHeight, true, ImGuiWindowFlags_HorizontalScrollbar) then
                            local count = 0
                            for _, text in ipairs(Accounts) do
                                if text.isShow then
                                    count = count + 1
                                end
                            end
                            ImGui.Columns(count, "##ConsoleAccountListColumns", false)
                            for _, text in ipairs(Accounts) do
                                if text.isShow then
                                    ImGui.Text(text.showName)
                                    if text.help ~= "" then
                                        ImGui.SameLine(0, 5)
                                        ImGui.HelpMarker("?", text.help)
                                    end
                                    ImGui.NextColumn()
                                end
                            end

                            ImGui.Separator()

                            count = CloudData.Account_GetCount()

                            for i = 1, count, 1 do
                                local steamAccount = CloudData.Account_Get(i, "steamAccount")
                                local eaAccount = CloudData.Account_Get(i, "eaAccount")
                                local status = CloudData.Account_Get(i, "status")
                                local packetIndex = R_ToNumber(CloudData.Account_Get(i, "packet"))
                                local packet, packetColor = "", ""
                                if packetIndex > 0 and packetIndex <= #Packets then
                                    packet = Packets[packetIndex].showName
                                    packetColor = Packets[packetIndex].color
                                else
                                    packet = Packets[1].showName
                                    packetColor = Packets[1].color
                                end
                                if status == "" then
                                    status = "����"
                                end
                                local task = CloudData.Account_Get(i, "task")
                                if task == "" then
                                    task = "��"
                                end
                                if steamAccount == "" or eaAccount == "" then
                                    goto continue
                                end

                                ImGui.PushIDInt(i)
                                ImGui.AlignTextToFramePadding()
                                ImGui.SetColumnWidth(-1, 0.065 * Rect_ConsoleAccountListWidth)
                                if count ~= R.MValue.GetCheckboxCount(M_Checkbox_Account) then
                                    -- update checkbox
                                    R.MValue.InitCheckbox(M_Checkbox_Account, count)
                                    for i = 1, count, 1 do
                                        if CloudData.Account_Get(i, "selected") == "1" then
                                            R.MValue.SetCheckbox(M_Checkbox_Account, i, 1)
                                        else
                                            R.MValue.SetCheckbox(M_Checkbox_Account, i, 0)
                                        end
                                    end
                                end

                                if CloudData.Account_Get(i, "selected") == "1" then
                                    R.MValue.SetCheckbox(M_Checkbox_Account, i, 1)
                                else
                                    R.MValue.SetCheckbox(M_Checkbox_Account, i, 0)
                                end
                                if ImGui.Checkbox(tostring(i), M_Checkbox_Account, i) then
                                    if CloudData.Account_Get(i, "selected") == "1" then
                                        CloudData.Account_Set_Cloud(i, "selected", "0", true)
                                    else
                                        CloudData.Account_Set_Cloud(i, "selected", "1", true)
                                    end
                                end
                                ImGui.NextColumn()

                                ImGui.AlignTextToFramePadding()
                                ImGui.SetColumnWidth(-1, 0.05 * Rect_ConsoleAccountListWidth)
                                ImGui.PushStyleColor(0, packetColor)
                                ImGui.Text(packet)
                                ImGui.PopStyleColor(1)
                                ImGui.NextColumn()


                                ImGui.AlignTextToFramePadding()
                                ImGui.SetColumnWidth(-1, 0.13 * Rect_ConsoleAccountListWidth)
                                local selected = R_ToNumber(R.Temp.Get("GlobalAccountSelected." .. tostring(i)))
                                if ImGui.SelectableBool(steamAccount, selected == 1, Bit.bor(ImGuiSelectableFlags_SpanAllColumns, ImGuiSelectableFlags_AllowItemOverlap), 0, 0) then
                                    ListSelect("GlobalAccountSelected", selected, count, i)
                                end
                                local rclick = ImGui.IsItemHovered() and ImGui.GetKeyStatus(2)
                                if rclick and selected == 0 then
                                    R.Temp.Set("GlobalAccountSelected")
                                    R.Temp.Set("GlobalAccountSelected." .. tostring(i), selected == 1 and "0" or "1")
                                end

                                if ImGui.IsItemHovered() then
                                    AccountTooptip(i)
                                end

                                if selected == 1 then
                                    if ImGui.BeginPopupContextItem("##ConsoleAccountListPopup", 1) then
                                        R.MValue.SetInt(M_Int_IsBeginPopupContextItem, 1)
                                        local selectedCount = 0
                                        local tooltip = ""
                                        for j = 1, count, 1 do
                                            if R_ToNumber(R.Temp.Get("GlobalAccountSelected." .. tostring(j))) == 1 then
                                                selectedCount = selectedCount + 1
                                                local tooltip_steamAccount = CloudData.Account_Get(j, "steamAccount")
                                                local tooltip_eaAccount = CloudData.Account_Get(j, "eaAccount")
                                                tooltip = tooltip ..
                                                    tooltip_steamAccount .. " - " .. tooltip_eaAccount .. "\n"
                                            end
                                        end
                                        if ImGui.MenuItemBool("ѡ���˺�����: " .. tostring(selectedCount) .. " ��") then
                                            R.Temp.Set("GlobalAccountSelected")
                                            R.MValue.SetInt(M_Int_IsBeginPopupContextItem, 0)
                                        end
                                        if ImGui.IsItemHovered() then
                                            ImGui.BeginTooltip()
                                            ImGui.Text(tooltip)
                                            ImGui.EndTooltip()
                                        end
                                        ImGui.Separator()
                                        if ImGui.BeginMenu("��ʼ����->") then
                                            for t = 1, #Tasks, 1 do
                                                if ImGui.MenuItemBool(Tasks[t]) then
                                                    for k = 1, count, 1 do
                                                        if R_ToNumber(R.Temp.Get("GlobalAccountSelected." .. tostring(k))) == 1 then
                                                            local taskCmd = "run|" ..
                                                                CloudData.Config_Get("Mode") .. "|" ..
                                                                Tasks[t] .. "|" .. tostring(k)
                                                            Msg_SetGameDataTask(GetNowSelectedCard(), taskCmd)
                                                            if CloudData.Config_Get("Mode") == "1" then
                                                                break
                                                            end
                                                        end
                                                    end
                                                    R.Temp.Set("GlobalAccountSelected")
                                                    R.MValue.SetInt(M_Int_IsBeginPopupContextItem, 0)
                                                end
                                            end
                                            ImGui.EndMenu()
                                        end
                                        ImGui.PushStyleColor(0, "#fcb040")
                                        if ImGui.MenuItemBool("��������ֹͣ") then
                                            R.MValue.SetInt(M_Int_IsBeginPopupContextItem, 0)
                                        end
                                        ImGui.PopStyleColor(1)

                                        ImGui.Separator()

                                        if ImGui.MenuItemBool("ѡ��") then
                                            R_Load("����ѡ���˺�")
                                            R.App.AddBackendTask([[CloudData.Account_SelectAll_Cloud(1)]])
                                            R.MValue.SetInt(M_Int_IsBeginPopupContextItem, 0)
                                        end
                                        if ImGui.MenuItemBool("ȡ��ѡ��") then
                                            R_Load("����ȡ��ѡ���˺�")
                                            R.App.AddBackendTask([[CloudData.Account_SelectAll_Cloud(2)]])
                                            R.MValue.SetInt(M_Int_IsBeginPopupContextItem, 0)
                                        end
                                        ImGui.PushStyleColor(0, "#de576d")
                                        if ImGui.MenuItemBool("ɾ���˺�") then
                                            R.MValue.SetByteInt(M_ByteInt_Modal_AccountDel, i)
                                            R.MValue.SetInt(M_Int_IsBeginPopupContextItem, 0)
                                        end
                                        ImGui.PopStyleColor(1)


                                        ImGui.Separator()
                                        local editLabel = "�޸��˺�"
                                        if selectedCount ~= 1 then
                                            ImGui.PushStyleColor(0, "#de576d")
                                            editLabel = editLabel .. "(��ѡʱ�޷��޸�)"
                                        end
                                        if ImGui.MenuItemBool(editLabel) then
                                            if selectedCount == 1 then
                                                for _, value in ipairs(LoadAccount) do
                                                    local title = CloudData.Account_Get(i, value.jsonName)
                                                    R.MValue.SetByteString(value.index, title)
                                                end
                                                R.MValue.SetByteInt(M_ByteInt_Modal_EditAccount, 1)
                                                R.MValue.SetInt(M_Int_IsBeginPopupContextItem, 0)
                                            end
                                        end
                                        if selectedCount ~= 1 then
                                            ImGui.PopStyleColor(1)
                                        end

                                        if ImGui.MenuItemBool("���������˺�") then
                                            R.Temp.Set("GlobalAccountSelected")

                                            for _, value in ipairs(LoadAccount) do
                                                R.MValue.SetByteString(value.index, "")
                                            end

                                            R.MValue.SetByteString(M_ByteString_AccountImportText, "")
                                            R.MValue.SetByteInt(M_ByteInt_Modal_AccountImport, i)
                                            R.MValue.SetInt(M_Int_IsBeginPopupContextItem, 0)
                                        end
                                        local changeAccountPos = R.MValue.GetInt(M_Int_ChangeAccountPos)
                                        local changeAccountPosButtonText = "�����˺�λ��"
                                        if changeAccountPos == 0 then
                                            changeAccountPosButtonText = "�����˺�λ��"
                                        elseif changeAccountPos == 1 then
                                            ImGui.PushStyleColor(0, "#de576d")
                                            changeAccountPosButtonText = "���������˺�λ��"
                                        end
                                        if ImGui.MenuItemBool(changeAccountPosButtonText) then
                                            R.Temp.Set("GlobalAccountSelected")
                                            if changeAccountPos == 0 then
                                                R.MValue.SetInt(M_Int_ChangeAccountPos, 1)
                                            else
                                                R.MValue.SetInt(M_Int_ChangeAccountPos, 0)
                                            end
                                            R.MValue.SetInt(M_Int_IsBeginPopupContextItem, 0)
                                        end
                                        if changeAccountPos == 1 then
                                            ImGui.PopStyleColor(1)
                                        end

                                        if ImGui.BeginMenu("���÷���->") then
                                            for t = 1, #Packets, 1 do
                                                ImGui.PushStyleColor(0, Packets[t].color)
                                                if ImGui.MenuItemBool(Packets[t].showName) then
                                                    R_Load("���������˺ŷ���")
                                                    R.App.AddBackendTask(R_HandleCmd(
                                                        [[CloudData.Account_SetPacket_Cloud({i})]], t))
                                                    R.MValue.SetInt(M_Int_IsBeginPopupContextItem, 0)
                                                end
                                                ImGui.PopStyleColor(1)
                                            end
                                            ImGui.EndMenu()
                                        end

                                        ImGui.Separator()

                                        ImGui.PushStyleColor(0, "#de576d")
                                        if ImGui.MenuItemBool("ǿ��ֹͣ") then
                                            if CloudData.Config_Get("Mode") == "1" then
                                                local cmd = "stop|1"
                                                Msg_SetGameDataTask(GetNowSelectedCard(), cmd)
                                            else
                                                for k = 1, count, 1 do
                                                    if R_ToNumber(R.Temp.Get("GlobalAccountSelected." .. tostring(k))) == 1 then
                                                        local cmd = "stop|" .. tostring(k)
                                                        Msg_SetGameDataTask(GetNowSelectedCard(), cmd)
                                                    end
                                                end
                                            end
                                            R.MValue.SetInt(M_Int_IsBeginPopupContextItem, 0)
                                        end
                                        ImGui.PopStyleColor(1)

                                        ImGui.EndPopup()
                                    end
                                end

                                RectSelectInLoop("GlobalAccountSelected", i)

                                ImGui.NextColumn()

                                ImGui.AlignTextToFramePadding()
                                ImGui.SetColumnWidth(-1, 0.2 * Rect_ConsoleAccountListWidth)
                                ImGui.Text(eaAccount)
                                ImGui.NextColumn()

                                ImGui.AlignTextToFramePadding()
                                ImGui.SetColumnWidth(-1, 0.1 * Rect_ConsoleAccountListWidth)
                                ImGui.Text(task)
                                ImGui.NextColumn()

                                ImGui.AlignTextToFramePadding()
                                ImGui.SetColumnWidth(-1, 0.135 * Rect_ConsoleAccountListWidth)
                                ImGui.Text(status)
                                ImGui.NextColumn()

                                ImGui.AlignTextToFramePadding()
                                ImGui.SetColumnWidth(-1, 0.1 * Rect_ConsoleAccountListWidth)
                                ImGui.PushStyleColor(ImGuiCol_PlotHistogram, "#18a058")
                                ImGui.ProgressBar(i * 0.1,
                                    0.1 * Rect_ConsoleAccountListWidth - 15, 0, "")
                                ImGui.PopStyleColor(1)
                                ImGui.NextColumn()

                                ImGui.AlignTextToFramePadding()
                                ImGui.SetColumnWidth(-1, 0.08 * Rect_ConsoleAccountListWidth)
                                ImGui.Text("99999999")
                                ImGui.NextColumn()

                                ImGui.AlignTextToFramePadding()

                                ImGui.SetColumnWidth(-1, 0.115 * Rect_ConsoleAccountListWidth)
                                if R.MValue.GetInt(M_Int_ChangeAccountPos) == 1 then
                                    if ImGui.Button("����", 0.055 * Rect_ConsoleAccountListWidth, 0) then
                                        if i > 1 then
                                            R_Load("�����ƶ��˺�")
                                            R.App.AddBackendTask(R_HandleCmd(
                                                [[CloudData.Account_ChangePos_Cloud({i},{i})]], i, i - 1))
                                        end
                                    end
                                    ImGui.SameLine(0, 4)
                                    if ImGui.Button("����", 0.055 * Rect_ConsoleAccountListWidth, 0) then
                                        if i < CloudData.Account_GetCount() then
                                            R_Load("�����ƶ��˺�")
                                            R.App.AddBackendTask(R_HandleCmd(
                                                [[CloudData.Account_ChangePos_Cloud({i},{i})]],
                                                i, i + 1))
                                        end
                                    end
                                else
                                    ImGui.Text("��ע11223��ע1122334455766773445576677")
                                end


                                ImGui.NextColumn()
                                ImGui.PopID()

                                if R.MValue.GetByteInt(M_ByteInt_Modal_EditAccount) == i then
                                    ImGui.OpenPopup("�޸��˺�")
                                    ImGui.SetNextWindowPos(windowWidth / 2, windowHeight / 2, ImGuiCond_Appearing,
                                        0.5, 0.5)
                                    if ImGui.BeginPopupModal("�޸��˺�", M_ByteInt_Modal_EditAccount, ImGuiWindowFlags_AlwaysAutoResize) then
                                        ImGui.BulletText("Steam�˺�: " .. steamAccount)
                                        ImGui.BulletText("Steam����: " .. CloudData.Account_Get(i, "steamPwd"))
                                        ImGui.BulletText("EAID: " .. CloudData.Account_Get(i, "eaID"))
                                        ImGui.BulletText("EA����: " .. eaAccount)
                                        ImGui.BulletText("EA����: " .. CloudData.Account_Get(i, "eaPwd"))
                                        ImGui.BulletText("�ȸ���֤��: " .. CloudData.Account_Get(i, "googleAuthCode"))

                                        ImGui.SetNextItemWidth(windowWidth / 2 - ImGui.CalcTextSize("##Steam�˺�"))
                                        ImGui.InputTextWithHint("Steam�˺�", "������Steam�˺�",
                                            M_ByteString_SteamAccount, 1024, 0)
                                        ImGui.SetNextItemWidth(windowWidth / 2 - ImGui.CalcTextSize("##Steam����"))
                                        ImGui.InputTextWithHint("Steam����", "������Steam����",
                                            M_ByteString_SteamPwd, 1024, 0)
                                        ImGui.SetNextItemWidth(windowWidth / 2 - ImGui.CalcTextSize("##EAID"))
                                        ImGui.InputTextWithHint("EAID", "������EAID",
                                            M_ByteString_EaID, 1024, 0)
                                        ImGui.SetNextItemWidth(windowWidth / 2 - ImGui.CalcTextSize("##EA����"))
                                        ImGui.InputTextWithHint("EA����", "������EA����",
                                            M_ByteString_EaAccount, 1024, 0)
                                        ImGui.SetNextItemWidth(windowWidth / 2 - ImGui.CalcTextSize("##EA����"))
                                        ImGui.InputTextWithHint("EA����", "������EA����",
                                            M_ByteString_EaPwd, 1024, 0)
                                        ImGui.SetNextItemWidth(windowWidth / 2 - ImGui.CalcTextSize("##�ȸ���֤��"))
                                        ImGui.InputTextWithHint("�ȸ���֤��", "������ȸ���֤��",
                                            M_ByteString_GoogleAuthCode, 1024, 0)
                                        if ImGui.Button("�޸�", windowWidth / 2, 40) then
                                            local str = ""
                                            for _, value in ipairs(LoadAccount) do
                                                str = str .. R.MValue.GetByteString(value.index) .. ","
                                                R.MValue.SetByteString(value.index, "")
                                            end
                                            R_Load("�����޸��˺�")
                                            R.App.AddBackendTask(R_HandleCmd([[CloudData.Account_Change_Cloud({i},[s])]],
                                                i, str))

                                            R.MValue.SetByteInt(M_ByteInt_Modal_EditAccount, 0)
                                            ImGui.CloseCurrentPopup()
                                            ImGui.SetItemDefaultFocus()
                                        end
                                        ImGui.EndPopup()
                                    end
                                end

                                -- ɾ��ѡ���˺�ȷ�ϴ���
                                if R.MValue.GetByteInt(M_ByteInt_Modal_AccountDel) == i then
                                    ImGui.OpenPopup("ȷ��ɾ��ѡ���˺�")
                                    ImGui.SetNextWindowPos(windowWidth / 2, windowHeight / 2,
                                        ImGuiCond_Appearing,
                                        0.5, 0.5)
                                    if ImGui.BeginPopupModal("ȷ��ɾ��ѡ���˺�", M_ByteInt_Modal_AccountDel, ImGuiWindowFlags_AlwaysAutoResize) then
                                        if ImGui.BeginChildStr("##delSelectedAccount", windowWidth / 2, windowHeight / 2, true, 0) then
                                            for j = 1, CloudData.Account_GetCount(), 1 do
                                                if R_ToNumber(R.Temp.Get("GlobalAccountSelected." .. tostring(j))) == 1 then
                                                    local steamAccount = CloudData.Account_Get(j, "steamAccount")
                                                    local eaID = CloudData.Account_Get(j, "eaID")
                                                    local eaAccount = CloudData.Account_Get(j, "eaAccount")
                                                    ImGui.BulletText(steamAccount ..
                                                        " - " .. eaID .. " - " .. eaAccount)
                                                end
                                            end

                                            ImGui.EndChild()
                                        end
                                        if ImGui.Button("ȷ��ɾ��", windowWidth / 2 * 0.7, 30) then
                                            R.MValue.SetByteInt(M_ByteInt_Modal_AccountDel, 0)
                                            R_Load("����ɾ���˺�")
                                            R.App.AddBackendTask([[
                                                CloudData.Account_DeleteSelected_Cloud()
                                            ]])
                                        end
                                        ImGui.SameLine(0, 10)
                                        if ImGui.Button("ȡ��", windowWidth / 2 * 0.3 - 10, 30) then
                                            R.MValue.SetByteInt(M_ByteInt_Modal_AccountDel, 0)
                                        end
                                        ImGui.EndPopup()
                                    end
                                end
                                :: continue ::
                            end

                            ImGui.Columns(1, "##AccountListColumnsbottom")
                            ImGui.Separator()
                            ListRectDraw("GlobalAccountSelected", M_ByteInt_Modal_EditAccount, M_ByteInt_Modal_AccountDel)

                            if count == 0 then
                                if ImGui.IsWindowHovered() then
                                    ImGui.SetTooltip("�Ҽ������˺�")
                                end
                            end

                            if R.MValue.GetInt(M_Int_IsBeginPopupContextItem) == 0 then
                                if ImGui.BeginPopupContextWindow("##ConsoleAccountListNoAccountPopup", 1) then
                                    R.Temp.Set("GlobalAccountSelected")
                                    ImGui.PushStyleColor(0, "#fcb040")
                                    if ImGui.MenuItemBool("���������˺�") then
                                        for _, value in ipairs(LoadAccount) do
                                            R.MValue.SetByteString(value.index, "")
                                        end
                                        R.MValue.SetByteString(M_ByteString_AccountImportText, "")
                                        R.MValue.SetByteInt(M_ByteInt_Modal_AccountImport, 1)
                                    end
                                    ImGui.PopStyleColor(1)
                                    ImGui.EndPopup()
                                end
                            end

                            -- �����˺Ŵ���
                            if R.MValue.GetByteInt(M_ByteInt_Modal_AccountImport) == 1 then
                                ImGui.OpenPopup("���������˺�")

                                ImGui.SetNextWindowPos(windowWidth / 2, windowHeight / 2, ImGuiCond_Appearing,
                                    0.5, 0.5)
                                ImGui.SetNextWindowSize(windowWidth / 2, windowHeight / 2 + 100)
                                if ImGui.BeginPopupModal("���������˺�", M_ByteInt_Modal_AccountImport, ImGuiWindowFlags_NoResize) then
                                    if ImGui.BeginTabBar("##AccountTabBar", 0) then
                                        if ImGui.BeginTabItem("�������") then
                                            ImGui.SetWindowFontScale(1.2)
                                            ImGui.SetNextItemWidth(windowWidth / 2 - ImGui.CalcTextSize("##Steam�˺�"))
                                            ImGui.InputTextWithHint("Steam�˺�", "������Steam�˺�",
                                                M_ByteString_SteamAccount, 1024, 0)
                                            ImGui.SetNextItemWidth(windowWidth / 2 - ImGui.CalcTextSize("##Steam����"))
                                            ImGui.InputTextWithHint("Steam����", "������Steam����",
                                                M_ByteString_SteamPwd, 1024, 0)
                                            ImGui.SetNextItemWidth(windowWidth / 2 - ImGui.CalcTextSize("##EAID"))
                                            ImGui.InputTextWithHint("EAID", "������EAID",
                                                M_ByteString_EaID, 1024, 0)
                                            ImGui.SetNextItemWidth(windowWidth / 2 - ImGui.CalcTextSize("##EA����"))
                                            ImGui.InputTextWithHint("EA����", "������EA����",
                                                M_ByteString_EaAccount, 1024, 0)
                                            ImGui.SetNextItemWidth(windowWidth / 2 - ImGui.CalcTextSize("##EA����"))
                                            ImGui.InputTextWithHint("EA����", "������EA����",
                                                M_ByteString_EaPwd, 1024, 0)
                                            ImGui.SetNextItemWidth(windowWidth / 2 - ImGui.CalcTextSize("##�ȸ���֤��"))
                                            ImGui.InputTextWithHint("�ȸ���֤��", "������ȸ���֤��",
                                                M_ByteString_GoogleAuthCode, 1024, 0)
                                            ImGui.SetWindowFontScale(1)
                                            if ImGui.Button("���", windowWidth / 2, 30) then
                                                local steamAccount = R.MValue.GetByteString(
                                                    M_ByteString_SteamAccount)
                                                local steamPwd = R.MValue.GetByteString(M_ByteString_SteamPwd)
                                                local eaID = R.MValue.GetByteString(M_ByteString_EaID)
                                                local eaAccount = R.MValue.GetByteString(M_ByteString_EaAccount)
                                                local eaPwd = R.MValue.GetByteString(M_ByteString_EaPwd)
                                                local googleAuthCode = R.MValue.GetByteString(
                                                    M_ByteString_GoogleAuthCode)

                                                local str = steamAccount .. "," .. steamPwd .. "," .. eaID .. "," ..
                                                    eaAccount .. "," .. eaPwd .. "," .. googleAuthCode
                                                R_Load("��������˺�")
                                                R.App.AddBackendTask(R_HandleCmd(
                                                    [[CloudData.Account_Add_Cloud([s])]],
                                                    str))

                                                R.MValue.SetByteString(M_ByteString_SteamAccount, "")
                                                R.MValue.SetByteString(M_ByteString_SteamPwd, "")
                                                R.MValue.SetByteString(M_ByteString_EaID, "")
                                                R.MValue.SetByteString(M_ByteString_EaAccount, "")
                                                R.MValue.SetByteString(M_ByteString_EaPwd, "")
                                                R.MValue.SetByteString(M_ByteString_GoogleAuthCode, "")
                                                R.MValue.SetByteInt(M_ByteInt_Modal_AccountImport, 0)
                                                ImGui.CloseCurrentPopup()
                                                ImGui.SetItemDefaultFocus()
                                            end

                                            ImGui.EndTabItem()
                                        end
                                        if ImGui.BeginTabItem("�������") then
                                            ImGui.BulletText("��Ӹ�ʽ(��Ӣ�Ķ��ŷָ�): steam�˺�,steam����,EAID,ea����,ea����,�ȸ���֤��")

                                            ImGui.InputTextMultiline("##accountImportText",
                                                M_ByteString_AccountImportText, 1024 * 16, windowWidth / 2,
                                                windowHeight / 2 - 30, 0)
                                            if ImGui.Button("�������", windowWidth / 2 - 16, -1) then
                                                local str = R.MValue.GetByteString(M_ByteString_AccountImportText)
                                                R_Load("��������˺�")
                                                R.App.AddBackendTask(R_HandleCmd(
                                                    [[CloudData.Account_Add_Cloud([s])]],
                                                    str))
                                                R.MValue.SetByteString(M_ByteString_AccountImportText, "")
                                                R.MValue.SetByteInt(M_ByteInt_Modal_AccountImport, 0)
                                                ImGui.CloseCurrentPopup()
                                                ImGui.SetItemDefaultFocus()
                                            end
                                            ImGui.EndTabItem()
                                        end
                                        if ImGui.BeginTabItem("����") then
                                            if ImGui.Button("���ļ�->�˺ŵ����ļ�.txt �е���", windowWidth / 2 - 16, 30) then
                                                R_Load("���ڵ����˺�")
                                                R.App.AddBackendTask(R_HandleCmd(
                                                    [[CloudData.Account_LoadByTxt_Cloud(false)]]))
                                                R.MValue.SetByteInt(M_ByteInt_Modal_AccountImport, 0)
                                                ImGui.CloseCurrentPopup()
                                                ImGui.SetItemDefaultFocus()
                                            end
                                            ImGui.BulletText("�����ʽ(��Ӣ�Ķ��ŷָ�): steam�˺�,steam����,EAID,ea����,ea����,�ȸ���֤��")
                                            ImGui.PushStyleColor(ImGuiCol_Text, "#de576d")
                                            ImGui.BulletText("ע��: ����Ḳ��ԭ���˺�,����������ǰ���ı����λ��")
                                            ImGui.PopStyleColor(1)
                                            ImGui.InputTextMultiline("##accountImportText",
                                                M_ByteString_AccountImportText, 1024 * 16, windowWidth / 2,
                                                windowHeight / 2 - 80, 0)

                                            if ImGui.Button("����", windowWidth / 2 - 16, -1) then
                                                local str = R.MValue.GetByteString(M_ByteString_AccountImportText)
                                                R_Load("���ڵ����˺�")
                                                R.App.AddBackendTask(R_HandleCmd(
                                                    [[CloudData.Account_LoadByTxt_Cloud(true, [s])]], str))

                                                R.MValue.SetByteInt(M_ByteInt_Modal_AccountImport, 0)
                                                ImGui.CloseCurrentPopup()
                                                ImGui.SetItemDefaultFocus()
                                            end
                                            ImGui.EndTabItem()
                                        end
                                        ImGui.EndTabBar()
                                    end
                                    ImGui.EndPopup()
                                end
                            end

                            ImGui.EndChild()
                        end
                        ImGui.EndTabItem()
                    end
                    -- ? �����б�
                    if ImGui.BeginTabItem("����") then
                        ImGui.SetNextWindowPos(Rect_ConsoleSettingPosX, Rect_ConsoleSettingPosY)
                        if ImGui.BeginChildStr("##consoleSetting", Rect_ConsoleSettingWidth, Rect_ConsoleSettingHeight, true, 0) then
                            local isSave = false
                            for i = 1, #Configs, 1 do
                                if Configs[i].type == "string" then
                                    if R.MValue.GetByteString(Configs[i].index) ~= "" and R.MValue.GetByteString(Configs[i].index) ~= CloudData.Config_Get(Configs[i].configName) then
                                        isSave = true
                                        break
                                    end
                                elseif Configs[i].type == "int" then
                                    if R.MValue.GetInt(Configs[i].index) ~= 0 and R.MValue.GetInt(Configs[i].index) ~= R_ToNumber(CloudData.Config_Get(Configs[i].configName)) then
                                        isSave = true
                                        break
                                    end
                                end
                            end

                            if isSave and not IsLoading() then
                                ImGui.PushStyleColor(ImGuiCol_Button, "#2D9643")
                                ImGui.PushStyleColor(ImGuiCol_ButtonHovered, "#36ad6a")
                                ImGui.PushStyleColor(ImGuiCol_ButtonActive, "#248642")
                                if ImGui.Button("--->�����˰�ť��������<---", -1, 30) then
                                    local function getConfig_string(configName, index)
                                        local value = R.MValue.GetByteString(index)
                                        R.Temp.Set("Config." .. configName, tostring(value))
                                    end
                                    local function getConfig_int(configName, index)
                                        local value = R.MValue.GetInt(index)
                                        R.Temp.Set("Config." .. configName, tostring(value))
                                    end

                                    for i = 1, #Configs, 1 do
                                        if Configs[i].type == "string" then
                                            if Configs[i].configName == "DeviceName" then
                                                CloudData.Client_ChangeDeviceName_Cloud(R.MValue.GetByteString(Configs
                                                    [i].index))
                                            end
                                            getConfig_string(Configs[i].configName, Configs[i].index)
                                        elseif Configs[i].type == "int" then
                                            getConfig_int(Configs[i].configName, Configs[i].index)
                                        end
                                    end
                                    R_Load("���ڱ�������")
                                    R.App.AddBackendTask([[CloudData.Config_Save_Cloud()]])
                                end
                                ImGui.PopStyleColor(3)
                            elseif ImGui.Button("��ʼ������", -1, 30) then
                                R.MValue.SetByteInt(M_ByteInt_Modal_InintConfig, 1)
                            end


                            if R.MValue.GetByteInt(M_ByteInt_Modal_InintConfig) == 1 then
                                ImGui.OpenPopup("��ʼ������")
                                ImGui.SetNextWindowPos(windowWidth / 2, windowHeight / 2, ImGuiCond_Appearing,
                                    0.5, 0.5)
                                if ImGui.BeginPopupModal("��ʼ������", M_ByteInt_Modal_InintConfig, ImGuiWindowFlags_AlwaysAutoResize) then
                                    ImGui.TextColored("#de576d", "��ʼ�����û�������������������ΪĬ��ֵ��")
                                    ImGui.Text("ȷ�ϳ�ʼ������?")
                                    if ImGui.Button("ȷ��", 200, 30) then
                                        local function setDefaultConfig_string(configName, index, value)
                                            R.MValue.SetByteString(index, value)
                                        end
                                        local function setDefaultConfig_int(configName, index, value)
                                            R.MValue.SetInt(index, value)
                                        end

                                        for i = 1, #Configs, 1 do
                                            if Configs[i].type == "string" then
                                                setDefaultConfig_string(Configs[i].configName, Configs[i].index,
                                                    Configs[i].defaultValue)
                                            elseif Configs[i].type == "int" then
                                                setDefaultConfig_int(Configs[i].configName, Configs[i].index,
                                                    Configs[i].defaultValue)
                                            end
                                        end
                                        R_Load("���ڳ�ʼ������")
                                        R.App.AddBackendTask([[CloudData.Config_Init_Cloud()]])
                                        R.MValue.SetByteInt(M_ByteInt_Modal_InintConfig, 0)
                                    end
                                    ImGui.SameLine(0, 10)
                                    if ImGui.Button("ȡ��", -1, 30) then
                                        R.MValue.SetByteInt(M_ByteInt_Modal_InintConfig, 0)
                                    end
                                    ImGui.EndPopup()
                                end
                            end
                            ImGui.Separator()
                            local texts = { "���", "������", "������" }
                            ImGui.Columns(#texts, "##ConsoleConfigListColumns", false)
                            for _, text in ipairs(texts) do
                                ImGui.Text(text)
                                ImGui.NextColumn()
                            end
                            texts = nil
                            ImGui.Separator()

                            for i = 1, #Configs, 1 do
                                local showName = Configs[i].showName
                                local configValue = CloudData.Config_Get(Configs[i].configName)
                                if showName == "" or configValue == "" then
                                    goto continue
                                end

                                ImGui.PushIDInt(i)
                                ImGui.AlignTextToFramePadding()
                                ImGui.SetColumnWidth(-1, 0.05 * Rect_ConsoleSettingWidth)
                                ImGui.Text(tostring(i))
                                ImGui.NextColumn()

                                ImGui.AlignTextToFramePadding()
                                ImGui.SetColumnWidth(-1, 0.3 * Rect_ConsoleSettingWidth)
                                -- selected = R_ToNumber(R.Temp.Get("GlobalConfigSelected"))
                                ImGui.SelectableBool(showName, false,
                                    Bit.bor(ImGuiSelectableFlags_SpanAllColumns,
                                        ImGuiSelectableFlags_AllowItemOverlap), 0, 0)

                                -- ImGui.Text(showName)
                                ImGui.NextColumn()
                                ImGui.AlignTextToFramePadding()
                                ImGui.SetColumnWidth(-1, 0.635 * Rect_ConsoleSettingWidth)

                                if Configs[i].configName == "Mode" then
                                    if R.MValue.GetInt(M_Int_RadioButton_Mode) == 0 then
                                        R.MValue.SetInt(M_Int_RadioButton_Mode, R_ToNumber(configValue))
                                    end
                                    ImGui.RadioButtonIntPtr("������ģʽ", M_Int_RadioButton_Mode, 1)
                                    ImGui.SameLine(0, 10)
                                    ImGui.RadioButtonIntPtr("�ര��ģʽ", M_Int_RadioButton_Mode, 2)
                                elseif Configs[i].configName == "LogicVersion" then
                                    if R.MValue.GetInt(M_Int_RadioButton_LogicVersion) == 0 then
                                        R.MValue.SetInt(M_Int_RadioButton_LogicVersion, R_ToNumber(configValue))
                                    end
                                    ImGui.RadioButtonIntPtr("��ʽ��", M_Int_RadioButton_LogicVersion, 1)
                                    ImGui.SameLine(0, 10)
                                    ImGui.RadioButtonIntPtr("���԰�", M_Int_RadioButton_LogicVersion, 2)
                                elseif Configs[i].configName == "DeviceName" then
                                    if R.MValue.GetByteString(M_ByteString_DeviceName) == "" then
                                        R.MValue.SetByteString(M_ByteString_DeviceName, configValue)
                                    end
                                    ImGui.SetNextItemWidth(200)
                                    ImGui.InputTextWithHint("##�豸����", "�������豸����", M_ByteString_DeviceName, 1024, 0)
                                elseif Configs[i].configName == "LoginMode" then
                                    if R.MValue.GetInt(M_Int_RadioButton_LoginMode) == 0 then
                                        R.MValue.SetInt(M_Int_RadioButton_LoginMode, R_ToNumber(configValue))
                                    end
                                    ImGui.RadioButtonIntPtr("steam��¼", M_Int_RadioButton_LoginMode, 1)
                                    ImGui.SameLine(0, 10)
                                    ImGui.RadioButtonIntPtr("ea��¼", M_Int_RadioButton_LoginMode, 2)
                                    ImGui.SameLine(0, 10)
                                    ImGui.RadioButtonIntPtr("NCC��¼", M_Int_RadioButton_LoginMode, 3)
                                elseif Configs[i].configName == "RedPluginPath" then
                                    if R.MValue.GetByteString(M_ByteString_RedPluginPath) == "" then
                                        R.MValue.SetByteString(M_ByteString_RedPluginPath, configValue)
                                    end
                                    ImGui.SetNextItemWidth(-1)
                                    ImGui.InputTextWithHint("##���·��", "��������·��", M_ByteString_RedPluginPath, 1024, 0)
                                elseif Configs[i].configName == "EaDesktopPath" then
                                    if R.MValue.GetByteString(M_ByteString_EaDesktopPath) == "" then
                                        R.MValue.SetByteString(M_ByteString_EaDesktopPath, configValue)
                                    end
                                    ImGui.SetNextItemWidth(-1)
                                    ImGui.InputTextWithHint("##EA�����·��", "������EA�����·��", M_ByteString_EaDesktopPath,
                                        1024, 0)
                                elseif Configs[i].configName == "SteamPath" then
                                    if R.MValue.GetByteString(M_ByteString_SteamPath) == "" then
                                        R.MValue.SetByteString(M_ByteString_SteamPath, configValue)
                                    end
                                    ImGui.SetNextItemWidth(-1)
                                    ImGui.InputTextWithHint("##Steam·��", "������Steam·��", M_ByteString_SteamPath, 1024,
                                        0)
                                else
                                    ImGui.Text(configValue)
                                end

                                ImGui.NextColumn()
                                ImGui.PopID()

                                ::continue::
                            end
                            ImGui.Separator()

                            ImGui.EndChild()
                        end
                        ImGui.EndTabItem()
                    end
                    -- ? �����б�
                    if ImGui.BeginTabItem("���ܹ���") then
                        ImGui.SetNextWindowPos(Rect_CardPosX, Rect_CardPosY)
                        if ImGui.BeginChildStr("##cardList", Rect_CardWidth, Rect_CardHeight, true, 0) then
                            ListRectDraw("GlobalCardSelected", M_ByteInt_Modal_CardImport, M_ByteInt_Modal_CardDel)
                            local texts = { "���", "����", "״̬", "ʹ�ý���", "����ʱ��" }
                            ImGui.Columns(#texts, "##ConsoleCardListColumns", false)
                            for _, text in ipairs(texts) do
                                ImGui.Text(text)
                                ImGui.NextColumn()
                            end
                            texts = nil
                            ImGui.Separator()

                            local count = CloudData.Card_GetCount()
                            for i = 1, count, 1 do
                                local card = CloudData.Card_Get(i, "card")
                                local status = CloudData.Card_Get(i, "status")
                                if status == "" then
                                    status = "normal"
                                end

                                local threadStatus = R.Thread.Get(i, "STATUS")
                                if threadStatus ~= "" and status == "normal" then
                                    status = "������"
                                end

                                local expireTime = CloudData.Card_Get(i, "expireTime")
                                if expireTime == "" then
                                    expireTime = "δ֪"
                                end
                                local expireTimestamp = R_ToNumber(CloudData.Card_Get(i, "expireTimestamp"))

                                if card == "" then
                                    goto continue
                                end

                                ImGui.PushIDInt(i)
                                ImGui.AlignTextToFramePadding()
                                ImGui.SetColumnWidth(-1, 0.065 * Rect_ConsoleAccountListWidth)
                                if count ~= R.MValue.GetCheckboxCount(M_Checkbox_Card) then
                                    -- update checkbox
                                    R.MValue.InitCheckbox(M_Checkbox_Card, count)
                                    for j = 1, count, 1 do
                                        if CloudData.Card_Get(j, "selected") == "1" then
                                            R.MValue.SetCheckbox(M_Checkbox_Card, j, 1)
                                        else
                                            R.MValue.SetCheckbox(M_Checkbox_Card, j, 0)
                                        end
                                    end
                                end

                                if CloudData.Card_Get(i, "selected") == "1" then
                                    R.MValue.SetCheckbox(M_Checkbox_Card, i, 1)
                                else
                                    R.MValue.SetCheckbox(M_Checkbox_Card, i, 0)
                                end
                                if ImGui.Checkbox(tostring(i), M_Checkbox_Card, i) then
                                    R.MValue.SetCheckbox(M_Checkbox_Card, i, 0)
                                    if CloudData.Card_Get(i, "selected") == "1" then
                                        if i ~= 1 then
                                            R_Load("����ȡ��ѡ�п���")
                                            CloudData.Card_Set_Cloud(i, "selected", "0")
                                        end
                                    else
                                        R_Load("����ѡ�п���")
                                        CloudData.Card_Set_Cloud(i, "selected", "1")
                                    end
                                end
                                ImGui.NextColumn()

                                ImGui.AlignTextToFramePadding()
                                ImGui.SetColumnWidth(-1, 0.33 * Rect_ConsoleAccountListWidth)
                                local selected = R_ToNumber(R.Temp.Get("GlobalCardSelected." .. tostring(i)))
                                if ImGui.SelectableBool(card, selected == 1, Bit.bor(ImGuiSelectableFlags_SpanAllColumns, ImGuiSelectableFlags_AllowItemOverlap), 0, 0) then
                                    ListSelect("GlobalCardSelected", selected, count, i)
                                end

                                local rclick = ImGui.IsItemHovered() and ImGui.GetKeyStatus(2)
                                if rclick and selected == 0 then
                                    R.Temp.Set("GlobalCardSelected")
                                    R.Temp.Set("GlobalCardSelected." .. tostring(i), selected == 1 and "0" or "1")
                                end

                                if selected == 1 then
                                    if ImGui.BeginPopupContextItem("##ConsoleCardListPopup", 1) then
                                        R.MValue.SetInt(M_Int_IsBeginPopupContextItem, 1)
                                        local selectedCount = 0
                                        local tooltip = ""
                                        for j = 1, count, 1 do
                                            if R_ToNumber(R.Temp.Get("GlobalCardSelected." .. tostring(j))) == 1 then
                                                selectedCount = selectedCount + 1
                                                local tooltip_card = CloudData.Card_Get(j, "card")
                                                tooltip = tooltip .. tooltip_card .. "\n"
                                            end
                                        end
                                        if ImGui.MenuItemBool("����ѡ�п���") then
                                            R.App.SetClipboard(tooltip)
                                            R.MValue.SetInt(M_Int_IsBeginPopupContextItem, 0)
                                            R.Temp.Set("GlobalCardSelected")
                                        end
                                        if ImGui.IsItemHovered() then
                                            ImGui.BeginTooltip()
                                            ImGui.Text(tooltip)
                                            ImGui.EndTooltip()
                                        end
                                        ImGui.Separator()

                                        ImGui.PushStyleColor(0, "#fcb040")
                                        if ImGui.MenuItemBool("������ʱ��") then
                                            CardGetSelectedExpireTimestamp()
                                            R.MValue.SetInt(M_Int_IsBeginPopupContextItem, 0)
                                        end
                                        ImGui.PopStyleColor(1)


                                        if count == 1 and R.Temp.Get("GlobalCardSelected.1") == "1" then

                                        else
                                            ImGui.Separator()

                                            if ImGui.MenuItemBool("ѡ��") then
                                                R_Load("����ѡ�п���")
                                                CloudData.Card_SelectAll_Cloud(1)
                                                R.MValue.SetInt(M_Int_IsBeginPopupContextItem, 0)
                                                R.Temp.Set("GlobalCardSelected")
                                            end
                                            if ImGui.MenuItemBool("ȡ��ѡ��") then
                                                R_Load("����ȡ��ѡ�п���")
                                                CloudData.Card_SelectAll_Cloud(2)
                                                R.MValue.SetInt(M_Int_IsBeginPopupContextItem, 0)
                                                R.Temp.Set("GlobalCardSelected")
                                            end

                                            ImGui.PushStyleColor(0, "#de576d")
                                            if ImGui.MenuItemBool("ɾ������") then
                                                R.MValue.SetByteInt(M_ByteInt_Modal_CardDel, i)
                                                R.MValue.SetInt(M_Int_IsBeginPopupContextItem, 0)
                                            end
                                            ImGui.PopStyleColor(1)
                                            ImGui.Separator()
                                        end

                                        if ImGui.MenuItemBool("��ӿ���") then
                                            R.MValue.SetByteString(M_ByteString_CardImportText, "")
                                            R.MValue.SetByteInt(M_ByteInt_Modal_CardImport, 1)
                                        end

                                        ImGui.EndPopup()
                                    end
                                end

                                if ImGui.IsItemHovered() then
                                    ImGui.BeginTooltip()
                                    ImGui.Text("ststus: " .. status)
                                    ImGui.EndTooltip()
                                end

                                RectSelectInLoop("GlobalCardSelected", i)

                                ImGui.NextColumn()

                                ImGui.AlignTextToFramePadding()
                                ImGui.SetColumnWidth(-1, 0.2 * Rect_ConsoleAccountListWidth)
                                ImGui.Text(status)
                                ImGui.NextColumn()

                                ImGui.AlignTextToFramePadding()
                                ImGui.SetColumnWidth(-1, 0.2 * Rect_ConsoleAccountListWidth)
                                local ratio = GetCardPrograss(expireTimestamp)
                                local color = GetCardColor(ratio)
                                ImGui.PushStyleColor(ImGuiCol_PlotHistogram, color)
                                ImGui.ProgressBar(ratio, 0.2 * Rect_ConsoleAccountListWidth - 10, 0, "")
                                ImGui.PopStyleColor(1)
                                ImGui.NextColumn()

                                ImGui.AlignTextToFramePadding()
                                ImGui.SetColumnWidth(-1, 0.16 * Rect_ConsoleAccountListWidth)
                                ImGui.Text(expireTime)
                                ImGui.NextColumn()
                                ImGui.PopID()

                                -- ɾ��ѡ�п���ȷ�ϴ���
                                if R.MValue.GetByteInt(M_ByteInt_Modal_CardDel) == i then
                                    ImGui.OpenPopup("ȷ��ɾ��ѡ�п���")
                                    ImGui.SetNextWindowPos(windowWidth / 2, windowHeight / 2,
                                        ImGuiCond_Appearing,
                                        0.5, 0.5)
                                    if ImGui.BeginPopupModal("ȷ��ɾ��ѡ�п���", M_ByteInt_Modal_CardDel, ImGuiWindowFlags_AlwaysAutoResize) then
                                        ImGui.Text("ȷ��ɾ��ѡ�п���?(��һ�ſ��ܲ��ᱻɾ��)")

                                        if ImGui.BeginChildStr("##delSelectedAccount", windowWidth / 2, windowHeight / 2, true, 0) then
                                            for j = 2, CloudData.Card_GetCount(), 1 do
                                                if R_ToNumber(R.Temp.Get("GlobalCardSelected." .. tostring(j))) == 1 then
                                                    local card = CloudData.Card_Get(j, "card")
                                                    ImGui.BulletText(tostring(j) .. "-" .. card)
                                                end
                                            end

                                            ImGui.EndChild()
                                        end
                                        if ImGui.Button("ȷ��ɾ��", windowWidth / 2 * 0.7, 30) then
                                            R_Load("����ɾ������")
                                            CardLogout()
                                            CloudData.Card_DeleteSelected_Cloud()
                                            R.Temp.Set("GlobalCardSelected")
                                            R.MValue.SetByteInt(M_ByteInt_Modal_CardDel, 0)
                                        end
                                        ImGui.SameLine(0, 10)
                                        if ImGui.Button("ȡ��", windowWidth / 2 * 0.3 - 10, 30) then
                                            R.MValue.SetByteInt(M_ByteInt_Modal_CardDel, 0)
                                        end
                                        ImGui.EndPopup()
                                    end
                                end

                                -- ���뿨�ܴ���
                                if R.MValue.GetByteInt(M_ByteInt_Modal_CardImport) == i then
                                    ImGui.OpenPopup("�������ӿ���")
                                    ImGui.SetNextWindowPos(windowWidth / 2, windowHeight / 2, ImGuiCond_Appearing,
                                        0.5, 0.5)
                                    if ImGui.BeginPopupModal("�������ӿ���", M_ByteInt_Modal_CardImport, ImGuiWindowFlags_AlwaysAutoResize) then
                                        ImGui.BulletText("ÿ��һ�ſ���")
                                        ImGui.InputTextMultiline("##cardImportText",
                                            M_ByteString_CardImportText, 1024 * 16, windowWidth / 2,
                                            windowHeight / 2, 0)
                                        if ImGui.Button("�������", -1, 30) then
                                            local str = R.MValue.GetByteString(M_ByteString_CardImportText)
                                            R_Load("������ӿ���")
                                            CloudData.Card_Add_Cloud(str)
                                            R.Temp.Set("GlobalCardSelected")
                                            R.MValue.SetByteInt(M_ByteInt_Modal_CardImport, 0)
                                            ImGui.CloseCurrentPopup()
                                            ImGui.SetItemDefaultFocus()
                                        end
                                        ImGui.EndPopup()
                                    end
                                end
                                ::continue::
                            end
                            ImGui.Columns(1, "##CardListBottom")
                            ImGui.Separator()

                            if count == 0 then
                                if ImGui.IsWindowHovered() then
                                    ImGui.SetTooltip("�Ҽ���ӿ���")
                                end
                            end

                            if R.MValue.GetInt(M_Int_IsBeginPopupContextItem) == 0 then
                                if ImGui.BeginPopupContextWindow("##ConsoleAccountListNoAccountPopup", 1) then
                                    R.Temp.Set("GlobalAccountSelected")
                                    ImGui.PushStyleColor(0, "#fcb040")
                                    if ImGui.MenuItemBool("��ӿ���") then
                                        R.MValue.SetByteString(M_ByteString_CardImportText, "")
                                        R.MValue.SetByteInt(M_ByteInt_Modal_CardImport, 1)
                                    end
                                    ImGui.PopStyleColor(1)
                                    ImGui.EndPopup()
                                end
                            end

                            ImGui.EndChild()
                        end
                        ImGui.EndTabItem()
                    end
                    ImGui.EndTabBar()
                end
                ImGui.EndChild()
            end
            ImGui.EndTabItem()
        end
        -- ? UpdateLogTabItem ������־
        if ImGui.BeginTabItem("������־") then
            ImGui.SetNextWindowPos(Rect_Left, Rect_MainTabBarPosY)
            if ImGui.BeginChildStr("##updateLog", Rect_MainTabBarWidth, Rect_MainTabBarHeight, true, 0) then
                ImGui.SetCursorPos(5, 4)
                if ImGui.BeginTabBar("##updateLogTabBar") then
                    if ImGui.BeginTabItem("���") then
                        local updateLogCount = LocalData.GetCount("updateLog_frame.updateLog")
                        if updateLogCount > 0 then
                            ImGui.SetCursorPosY(Rect_MenuBarHeight)
                        end
                        for i = 0, updateLogCount - 1, 1 do
                            local version = LocalData.Get("updateLog_frame.updateLog[" .. tostring(i) .. "].version")
                            local contentCount = LocalData.GetCount("updateLog_frame.updateLog[" ..
                                tostring(i) .. "].content")
                            ImGui.SetCursorPosX(5)
                            ImGui.TextColored("#a2d2ff", "�汾: " .. version)
                            for k = 0, contentCount - 1, 1 do
                                local content = LocalData.Get("updateLog_frame.updateLog[" ..
                                    tostring(i) .. "].content[" .. tostring(k) .. "].content")
                                local level = LocalData.Get("updateLog_frame.updateLog[" ..
                                    tostring(i) .. "].content[" .. tostring(k) .. "].level")
                                local timestamp = LocalData.Get("updateLog_frame.updateLog[" ..
                                    tostring(i) .. "].content[" .. tostring(k) .. "].timestamp")
                                if level == "important" then
                                    ImGui.PushStyleColor(ImGuiCol_Text, "#E45151")
                                    ImGui.BulletText(content)
                                    ImGui.PopStyleColor(1)
                                elseif level == "separator" then
                                    ImGui.Dummy(0, 14)
                                else
                                    ImGui.BulletText(content)
                                end

                                if ImGui.IsItemHovered() then
                                    ImGui.SetTooltip(timestamp)
                                end
                            end
                            ImGui.Separator()
                        end
                        ImGui.EndTabItem()
                    end

                    if ImGui.BeginTabItem("�ű�") then
                        local path = "updateLog" .. R.App.GetRunLua() .. ".updateLog"
                        local updateLogCount = LocalData.GetCount(path)
                        if updateLogCount > 0 then
                            ImGui.SetCursorPosY(Rect_MenuBarHeight)
                        end
                        for i = 0, updateLogCount - 1, 1 do
                            local version = LocalData.Get(path .. "[" .. tostring(i) .. "].version")
                            local contentCount = LocalData.GetCount(path .. "[" ..
                                tostring(i) .. "].content")
                            ImGui.SetCursorPosX(5)
                            ImGui.TextColored("#a2d2ff", "�汾: " .. version)
                            for k = 0, contentCount - 1, 1 do
                                local content = LocalData.Get(path .. "[" ..
                                    tostring(i) .. "].content[" .. tostring(k) .. "].content")
                                local level = LocalData.Get(path .. "[" ..
                                    tostring(i) .. "].content[" .. tostring(k) .. "].level")
                                local timestamp = LocalData.Get(path .. "[" ..
                                    tostring(i) .. "].content[" .. tostring(k) .. "].timestamp")
                                if level == "important" then
                                    ImGui.PushStyleColor(ImGuiCol_Text, "#E45151")
                                    ImGui.BulletText(content)
                                    ImGui.PopStyleColor(1)
                                elseif level == "separator" then
                                    ImGui.Dummy(0, 14)
                                else
                                    ImGui.BulletText(content)
                                end

                                if ImGui.IsItemHovered() then
                                    ImGui.SetTooltip(timestamp)
                                end
                            end
                            ImGui.Separator()
                        end
                        ImGui.EndTabItem()
                    end
                    ImGui.EndTabBar()
                end
                ImGui.EndChild()
            end


            ImGui.EndTabItem()
        end

        -- ? ToolKitTabItem ������
        if ImGui.BeginTabItem("������") then
            ImGui.SetNextWindowPos(Rect_Left, Rect_MainTabBarPosY)
            if ImGui.BeginChildStr("##GlobalToolKit", Rect_MainTabBarWidth, Rect_MainTabBarHeight, true, Bit.bor(ImGuiWindowFlags_NoScrollbar, ImGuiWindowFlags_NoScrollWithMouse)) then
                ImGui.SetNextWindowPos(Rect_Left + 5, Rect_MainTabBarPosY + 5)
                if ImGui.BeginChildStr("##GoogleAuthTool", 0.2 * Rect_MainTabBarWidth, 117, true, Bit.bor(ImGuiWindowFlags_NoScrollbar, ImGuiWindowFlags_NoScrollWithMouse)) then
                    ImGui.SetCursorPos(5, 0)
                    ImGui.SetWindowFontScale(1.2)
                    ImGui.Text("�ȸ������֤��")
                    ImGui.SetWindowFontScale(1)

                    ImGui.SetCursorPosX(5)
                    ImGui.SetNextItemWidth(0.2 * Rect_MainTabBarWidth)
                    ImGui.SetWindowFontScale(1.2)
                    ImGui.InputTextWithHint("##GoogleAuthCodeChange", "������ȸ���֤��", M_ByteString_GoogleAuthCodeChange,
                        17,
                        Bit.bor(ImGuiInputTextFlags_CharsUppercase, ImGuiInputTextFlags_AutoSelectAll,
                            ImGuiInputTextFlags_CharsNoBlank))
                    ImGui.SetWindowFontScale(1)
                    ImGui.Spacing()
                    ImGui.SetCursorPosX(5)
                    if ImGui.Button("��ȡ��֤��", 0.2 * Rect_MainTabBarWidth, 30) then
                        local code = R.MValue.GetByteString(M_ByteString_GoogleAuthCodeChange)
                        if #code == 16 then
                            R_Load("���ڻ�ȡ��֤��")
                            Msg_GetGoogleAuthCode(code)
                        end
                    end
                    if R.Temp.Get("GoogleAuthCode") ~= "" then
                        R.MValue.SetByteString(M_ByteString_GoogleAuthCodeChanged, R.Temp.Get("GoogleAuthCode"))
                    end
                    ImGui.Spacing()
                    ImGui.SetCursorPosX(5)

                    ImGui.SetNextItemWidth(0.2 * Rect_MainTabBarWidth)
                    ImGui.SetWindowFontScale(1.2)

                    ImGui.InputTextWithHint("##GoogleAuthCodeChanged", "6λ��", M_ByteString_GoogleAuthCodeChanged, 17,
                        Bit.bor(ImGuiInputTextFlags_ReadOnly, ImGuiInputTextFlags_AutoSelectAll))
                    ImGui.SetWindowFontScale(1)

                    ImGui.EndChild()
                end


                if R.App.IsDebug() then
                    if ImGui.Button("���Բ���", 100, 30) then
                        Msg_GetUpdateLogMd5()
                    end

                    ImGui.SetNextWindowPos(Rect_Left + 5 + 0.2 * Rect_MainTabBarWidth + 4, Rect_MainTabBarPosY + 5)
                    if ImGui.BeginChildStr("##EncryptTool", 0.5 * Rect_MainTabBarWidth, Rect_MainTabBarHeight - 10, true, Bit.bor(ImGuiWindowFlags_NoScrollbar, ImGuiWindowFlags_NoScrollWithMouse)) then
                        ImGui.SetCursorPos(5, 0)
                        ImGui.SetWindowFontScale(1.2)
                        ImGui.Text("�ӽ��ܹ���")
                        ImGui.SetWindowFontScale(1)
                        ImGui.SetCursorPos(5, 30)
                        ImGui.InputTextMultiline("##EncryptText", M_ByteString_EncryptString,
                            1024 * 16, 0.5 * Rect_MainTabBarWidth - 10,
                            (Rect_MainTabBarHeight) / 2 - 50,
                            Bit.bor(ImGuiInputTextFlags_AutoSelectAll, 1024))
                        ImGui.SetCursorPos(5, (Rect_MainTabBarHeight) / 2 - 16)
                        if ImGui.Button("����", (0.5 * Rect_MainTabBarWidth) / 2 - 10, 30) then
                            local str = R.MValue.GetByteString(M_ByteString_EncryptString)
                            local res = R.Encrypt.Encrypt(str)
                            R.MValue.SetByteString(M_ByteString_DecryptString, res)
                            R.App.SetClipboard(res)
                        end
                        ImGui.SameLine(0, 5)
                        if ImGui.Button("����", (0.5 * Rect_MainTabBarWidth) / 2 - 5, 30) then
                            local str = R.MValue.GetByteString(M_ByteString_DecryptString)
                            local res = R.Encrypt.Decrypt(str)
                            R.MValue.SetByteString(M_ByteString_EncryptString, res)
                        end
                        ImGui.SetCursorPos(5, (Rect_MainTabBarHeight) / 2 + 19)
                        ImGui.InputTextMultiline("##DecryptText", M_ByteString_DecryptString,
                            1024 * 16, 0.5 * Rect_MainTabBarWidth - 10,
                            (Rect_MainTabBarHeight) / 2 - 33,
                            Bit.bor(ImGuiInputTextFlags_AutoSelectAll, 1024))

                        ImGui.EndChild()
                    end
                end



                -- if R.Temp.Get("draw") == "1" then
                -- 	R.gdi.BeginPaint(0)
                -- 	local x, y = R.App.GetMousePos()
                -- 	R_Debug("draw", x, y)
                -- 	R.gdi.DrawRect(100, 100, x, y, 0, 0, 0, 0)
                -- 	R.gdi.EndPaint()
                -- end


                ImGui.EndChild()
            end
            ImGui.EndTabItem()
        end

        ImGui.EndTabBar()
    end

    if ImGui.BeginTabBar("##LogTabBar", 0) then
        if ImGui.BeginTabItem("ȫ����־") then
            ImGui.SetNextWindowPos(Rect_Left, Rect_LogPosY)
            if ImGui.BeginChildStr("##GlobalLog", Rect_MainTabBarWidth, Rect_LogChildHeight, true, Bit.bor(ImGuiWindowFlags_NoScrollbar, ImGuiWindowFlags_NoScrollWithMouse)) then
                ImGui.SetCursorPos(5, 5)
                ImGui.SetNextItemWidth(300)
                ImGui.InputTextWithHint("##ȫ����־����", "������־", M_ByteString_GlobalLogSearch, 256, 0)
                ImGui.SameLine(0, 10)
                if ImGui.Button("����", 100, 0) then
                    R.Temp.Set("GlobalLogSerchText", R.MValue.GetByteString(M_ByteString_GlobalLogSearch))
                    if R.Temp.Get("GlobalLogSerchText") ~= "" then
                        R.MValue.SetCheckbox(M_Checkbox_AutoRefreshLog, 1, 0)
                        R_Load("����������־")
                        R.App.AddBackendTask([[
    						local count = R.Log.GetCount("Global")
    						local searchText = R.Temp.Get("GlobalLogSerchText")
    						local found = false
    						R.Temp.Set("GlobalLogSelected")
    						for i = 1, count do
    							local _, _, content = R.Log.Get("Global", i)
    							if R.String.FindString(content, searchText, true) > -1 then
    								local sindex = tostring(i)
    								if R.Temp.Get("GlobalLogSearchFindText") == searchText and R_ToNumber(R.Temp.Get("GlobalLogSearchFindIndex")) >= i then
    									goto continue
    								end
    								R.Temp.Set("GlobalLogSearchFindIndex", sindex)
    								R.Temp.Set("GlobalLogSearchFindText", searchText)
    								R.Temp.Set("GlobalLogSerchIndex", sindex)
    								R.Temp.Set("GlobalLogSelected", sindex)
    								R.Temp.Set("GlobalLogNowPage", tostring(math.ceil(i / 100)))
    								found = true
    								break
    							end
    							::continue::
    						end

    						if not found and searchText ~= "" then
    							for i = 1, count do
    								local _, _, content = R.Log.Get("Global", i)
    								if R.String.FindString(content, searchText, true) > -1 then
    									local sindex = tostring(i)
    									R.Temp.Set("GlobalLogSearchFindIndex", sindex)
    									R.Temp.Set("GlobalLogSearchFindText", searchText)
    									R.Temp.Set("GlobalLogSerchIndex", sindex)
    									R.Temp.Set("GlobalLogSelected", sindex)
    									R.Temp.Set("GlobalLogNowPage", tostring(math.ceil(i / 100)))
    									break
    								end
    							end
    						end
    						R_Unload()
    					]])
                    end
                end
                ImGui.SameLine(0, 10)
                local totalLogs = R.Log.GetCount("Global")
                local itemsPerPage = 100
                local maxPage = math.ceil(totalLogs / itemsPerPage)
                local nowPage = R_ToNumber(R.Temp.Get("GlobalLogNowPage"))
                if nowPage == 0 then
                    nowPage = 1
                end
                -- ? �Զ������һҳ
                if R.MValue.GetCheckbox(M_Checkbox_AutoRefreshLog, 1) == 1 then
                    nowPage = maxPage
                    if R.Temp.Get("GlobalLogSelected") ~= tostring(nowPage) then
                        R.Temp.Set("GlobalLogNowPage", tostring(nowPage))
                    end
                end

                if ImGui.Button("��һҳ", 100, 0) then
                    if nowPage > 1 then
                        R.MValue.SetCheckbox(M_Checkbox_AutoRefreshLog, 1, 0)
                        R.Temp.Set("GlobalLogNowPage", tostring(nowPage - 1))
                    end
                end

                ImGui.SameLine(0, 10)

                ImGui.SetCursorPosY(3)
                ImGui.Text("�� " ..
                    tostring(nowPage) .. " ҳ " .. "�� " .. tostring(maxPage) .. " ҳ")

                ImGui.SameLine(0, 10)
                ImGui.SetCursorPosY(5)

                if ImGui.Button("��һҳ", 100, 0) then
                    if nowPage < maxPage then
                        R.MValue.SetCheckbox(M_Checkbox_AutoRefreshLog, 1, 0)
                        R.Temp.Set("GlobalLogNowPage", tostring(nowPage + 1))
                    end
                end
                ImGui.SameLine(0, 10)
                if ImGui.Checkbox("�Զ�������־", M_Checkbox_AutoRefreshLog, 1) then
                    local isSelected = R.MValue.GetCheckbox(M_Checkbox_AutoRefreshLog, 1)
                    if isSelected == 0 then
                        isSelected = 1
                        R.MValue.SetCheckbox(M_Checkbox_AutoRefreshLog, 1, 1)
                    else
                        isSelected = 0
                        R.MValue.SetCheckbox(M_Checkbox_AutoRefreshLog, 1, 0)
                    end
                end

                ImGui.SameLine(0, 10)
                if ImGui.Button("�����־", 0, 0) then
                    R_ClearLog()
                    nowPage = 1
                    R.Temp.Set("GlobalLogNowPage", tostring(nowPage))
                    R.Temp.Set("GlobalLogSerchIndex")
                    R.Temp.Set("GlobalLogSelected")
                end
                if ImGui.BeginChildStr("##GlobalLogDetail", Rect_MainTabBarWidth - 10, Rect_LogChildHeight - 44 + 8 + 5, false, 0) then
                    local isSelected = R_ToNumber(R.Temp.Get("GlobalLogSelected"))
                    local searchText = R.MValue.GetByteString(M_ByteString_GlobalLogSearch)

                    for i = itemsPerPage * (nowPage - 1) + 1, itemsPerPage * nowPage, 1 do
                        local time, level, content = R.Log.Get("Global", i)
                        local message = "Global - " .. tostring(content)
                        if content ~= "" then
                            if ImGui.SelectableBool("Ra - " .. tostring(i), isSelected == i, 0, 0, 0) then
                                -- R.Temp.Set("GlobalLogSelected", isSelected == i and "-1" or tostring(i))
                            end

                            if ImGui.IsItemHovered() then
                                if #content > 100 then
                                    local height = #content / 60 * 40 + 40
                                    if height > windowHeight then
                                        height = windowHeight - 100
                                    end
                                    local x, y = ImGui.GetMousePos()
                                    ImGui.SetNextWindowPos(x - windowWidth / 3, y - height, 0, 0, 0)
                                    ImGui.SetNextWindowSize(windowWidth / 3, height)
                                    ImGui.BeginTooltip()
                                    local tooltip = tostring(content)
                                    ImGui.TextWrapped(tooltip)
                                    ImGui.EndTooltip()
                                end
                            end

                            ImGui.SameLine(80, 0)
                            ImGui.TextColored("#de576d", tostring(time))
                            ImGui.SameLine(240, 0)

                            if level == "debug" then
                                ImGui.TextColored("#4098fc", "[DEBUG]")
                            elseif level == "info" then
                                ImGui.TextColored("#36ad6a", "[INFO]")
                            elseif level == "err" then
                                ImGui.TextColored("#de576d", "[ERROR]")
                            else
                                ImGui.Text(tostring(level))
                            end

                            ImGui.SameLine(325, 0)

                            if searchText ~= "" and R.String.FindString(message, searchText, true) > -1 then
                                ImGui.TextColored("#fcb040", message)
                                if R.Temp.Get("GlobalLogSerchIndex") == tostring(i) then
                                    R.Temp.Set("GlobalLogSerchIndex")
                                    ImGui.SetScrollHereY(0.5)
                                end
                            else
                                ImGui.Text(message)
                                if R.MValue.GetCheckbox(M_Checkbox_AutoRefreshLog, 1) == 1 then
                                    ImGui.SetScrollHereY(1)
                                end
                            end
                        end
                    end

                    ImGui.EndChild()
                end
                ImGui.EndChild()
            end

            ImGui.EndTabItem()
        end
        if ImGui.BeginTabItem("�߳���־") then
            ImGui.SetNextWindowPos(Rect_Left, Rect_LogPosY)
            if ImGui.BeginChildStr("##ThreadLog", Rect_MainTabBarWidth, Rect_LogChildHeight, true, ImGuiWindowFlags_NoScrollbar) then
                ImGui.SetCursorPos(5, 5)
                ImGui.SetNextItemWidth(300)
                ImGui.InputTextWithHint("##�߳���־����", "������־", M_ByteString_ThreadLogSearch, 256, 0)
                ImGui.SameLine(0, 10)
                if ImGui.Button("����", 100, 0) then
                    R.Temp.Set("ThreadLogSerchText", R.MValue.GetByteString(M_ByteString_ThreadLogSearch))
                    if R.Temp.Get("ThreadLogSerchText") ~= "" then
                        R.MValue.SetCheckbox(M_Checkbox_AutoRefreshLog, 1, 0)
                        R_Load("����������־")
                        R.App.AddBackendTask([[
    						local count = R.Log.GetCount("Thread-" .. R.Temp.Get("ThreadLogComboIndex"))
    						local searchText = R.Temp.Get("ThreadLogSerchText")
    						local found = false
    						R.Temp.Set("ThreadLogSelected")
    						for i = 1, count do
    							local _, _, content = R.Log.Get("Thread-" .. R.Temp.Get("ThreadLogComboIndex"), i)
    							if R.String.FindString(content, searchText, true) > -1 then
    								local sindex = tostring(i)
    								if R.Temp.Get("ThreadLogSearchFindText") == searchText and R_ToNumber(R.Temp.Get("ThreadLogSearchFindIndex")) >= i then
    									goto continue
    								end
    								R.Temp.Set("ThreadLogSearchFindIndex", sindex)
    								R.Temp.Set("ThreadLogSearchFindText", searchText)
    								R.Temp.Set("ThreadLogSerchIndex", sindex)
    								R.Temp.Set("ThreadLogSelected", sindex)
    								R.Temp.Set("ThreadLogNowPage", tostring(math.ceil(i / 100)))
    								found = true
    								break
    							end
    							::continue::
    						end

    						if not found and searchText ~= "" then
    							for i = 1, count do
    								local _, _, content = R.Log.Get("Thread-" .. R.Temp.Get("ThreadLogComboIndex"), i)
    								if R.String.FindString(content, searchText, true) > -1 then
    									local sindex = tostring(i)
    									R.Temp.Set("ThreadLogSearchFindIndex", sindex)
    									R.Temp.Set("ThreadLogSearchFindText", searchText)
    									R.Temp.Set("ThreadLogSerchIndex", sindex)
    									R.Temp.Set("ThreadLogSelected", sindex)
    									R.Temp.Set("ThreadLogNowPage", tostring(math.ceil(i / 100)))
    									break
    								end
    							end
    						end
    						R_Unload()
    					]])
                    end
                end
                ImGui.SameLine(0, 10)

                local totalLogs = R.Log.GetCount("Thread-" .. R.Temp.Get("ThreadLogComboIndex"))
                local itemsPerPage = 100
                local maxPage = math.ceil(totalLogs / itemsPerPage)
                local nowPage = R_ToNumber(R.Temp.Get("ThreadLogNowPage"))
                if nowPage == 0 then
                    nowPage = 1
                end
                -- ? �Զ������һҳ
                if R.MValue.GetCheckbox(M_Checkbox_AutoRefreshLog, 1) == 1 then
                    nowPage = maxPage
                    if R.Temp.Get("ThreadLogNowPage") ~= tostring(nowPage) then
                        R.Temp.Set("ThreadLogNowPage", tostring(nowPage))
                    end
                end

                if ImGui.Button("��һҳ", 100, 0) then
                    if nowPage > 1 then
                        R.MValue.SetCheckbox(M_Checkbox_AutoRefreshLog, 1, 0)
                        R.Temp.Set("ThreadLogNowPage", tostring(nowPage - 1))
                    end
                end

                ImGui.SameLine(0, 10)

                ImGui.SetCursorPosY(3)
                ImGui.Text("�� " ..
                    tostring(nowPage) .. " ҳ " .. "�� " .. tostring(maxPage) .. " ҳ")

                ImGui.SameLine(0, 10)
                ImGui.SetCursorPosY(5)

                if ImGui.Button("��һҳ", 100, 0) then
                    if nowPage < maxPage then
                        R.MValue.SetCheckbox(M_Checkbox_AutoRefreshLog, 1, 0)
                        R.Temp.Set("ThreadLogNowPage", tostring(nowPage + 1))
                    end
                end
                ImGui.SameLine(0, 10)
                if ImGui.Checkbox("�Զ�������־", M_Checkbox_AutoRefreshLog, 1) then
                    local isSelected = R.MValue.GetCheckbox(M_Checkbox_AutoRefreshLog, 1)
                    if isSelected == 0 then
                        isSelected = 1
                        R.MValue.SetCheckbox(M_Checkbox_AutoRefreshLog, 1, 1)
                    else
                        isSelected = 0
                        R.MValue.SetCheckbox(M_Checkbox_AutoRefreshLog, 1, 0)
                    end
                end
                ImGui.SameLine(0, 10)

                local index = R_ToNumber(R.Temp.Get("ThreadLogComboIndex"))
                local isSelected = false
                local count = CloudData.Account_GetCount()
                local ThreadLog = {}
                for i = 1, count, 1 do
                    ThreadLog[i] = "�߳�-" .. tostring(i)
                end
                if index == 0 then
                    R.Temp.Set("ThreadLogComboIndex", "1")
                    index = 1
                end
                local combo_label = ThreadLog[index]

                ImGui.SetNextItemWidth(200)
                if ImGui.BeginCombo("##�߳�ѡ��", combo_label, 0) then
                    for i = 1, #ThreadLog, 1 do
                        if index == i then
                            isSelected = true
                        else
                            isSelected = false
                        end
                        if ImGui.SelectableBool(ThreadLog[i], isSelected, 0, 0, 0) then
                            R.Temp.Set("ThreadLogComboIndex", tostring(i))
                        end

                        if isSelected then
                            ImGui.SetItemDefaultFocus()
                        end
                    end
                    ImGui.EndCombo()
                end

                ImGui.SameLine(0, 10)
                if ImGui.Button("�����־", 0, 20) then
                    R.Log.Clear("Thread-" .. R.Temp.Get("ThreadLogComboIndex"))
                    nowPage = 1
                    R.Temp.Set("ThreadLogNowPage", tostring(nowPage))
                    R.Temp.Set("ThreadLogSerchIndex")
                    R.Temp.Set("ThreadLogSelected")
                end

                if ImGui.BeginChildStr("##ThreadLogDetail", Rect_MainTabBarWidth - 10, Rect_LogChildHeight - 44 + 8 + 5, false, 0) then
                    local isSelected = R_ToNumber(R.Temp.Get("ThreadLogSelected"))
                    local searchText = R.MValue.GetByteString(M_ByteString_ThreadLogSearch)

                    for i = itemsPerPage * (nowPage - 1) + 1, itemsPerPage * nowPage, 1 do
                        local time, level, content = R.Log.Get("Thread-" .. R.Temp.Get("ThreadLogComboIndex"), i)
                        local message = "Thread - " .. tostring(content)
                        if content ~= "" then
                            if ImGui.SelectableBool("Ra - " .. tostring(i), isSelected == i, 0, 0, 0) then
                                -- R.Temp.Set("ThreadLogSelected", isSelected == i and "-1" or tostring(i))
                            end

                            if ImGui.IsItemHovered() then
                                if #content > 300 then
                                    local height = #content / 60 * 40 + 40
                                    local x, y = ImGui.GetMousePos()
                                    ImGui.SetNextWindowPos(x - windowWidth / 3, y - height, 0, 0, 0)
                                    ImGui.SetNextWindowSize(windowWidth / 3, height)
                                    ImGui.BeginTooltip()
                                    local tooltip = tostring(content)
                                    ImGui.TextWrapped(tooltip)
                                    ImGui.EndTooltip()
                                end
                            end

                            ImGui.SameLine(80, 0)
                            ImGui.TextColored("#de576d", tostring(time))
                            ImGui.SameLine(240, 0)

                            if level == "debug" then
                                ImGui.TextColored("#4098fc", "[DEBUG]")
                            elseif level == "info" then
                                ImGui.TextColored("#36ad6a", "[INFO]")
                            elseif level == "err" then
                                ImGui.TextColored("#de576d", "[ERROR]")
                            else
                                ImGui.Text(tostring(level))
                            end

                            ImGui.SameLine(325, 0)

                            if searchText ~= "" and R.String.FindString(message, searchText, true) > -1 then
                                ImGui.TextColored("#fcb040", message)
                                if R.Temp.Get("ThreadLogSerchIndex") == tostring(i) then
                                    R.Temp.Set("ThreadLogSerchIndex")
                                    ImGui.SetScrollHereY(0.5)
                                end
                            else
                                ImGui.Text(message)
                                if R.MValue.GetCheckbox(M_Checkbox_AutoRefreshLog, 1) == 1 then
                                    ImGui.SetScrollHereY(1)
                                end
                            end
                        end
                    end

                    ImGui.EndChild()
                end


                ImGui.EndChild()
            end
            ImGui.EndTabItem()
        end
        ImGui.EndTabBar()
    end
    -- ? InternetWindow ����
    if R.Temp.Get("waitingServerResponse") ~= "" then
        if R.MValue.GetByteInt(M_ByteInt_Modal_Loading) == 0 then
            R.MValue.SetByteInt(M_ByteInt_Modal_Loading, 1)
        end
    else
        if R.MValue.GetByteInt(M_ByteInt_Modal_Loading) == 1 then
            R.MValue.SetByteInt(M_ByteInt_Modal_Loading, 0)
        end
    end

    if R.SProtect.GetErrCode(LoginCard) ~= 0 then
        R.MValue.SetByteInt(M_ByteInt_Modal_ErrVerify, 1)
    else
        R.MValue.SetByteInt(M_ByteInt_Modal_ErrVerify, 0)
    end

    if R.MValue.GetByteInt(M_ByteInt_Modal_ErrVerify) == 1 then
        ImGui.OpenPopup("��֤����")
        ImGui.SetNextWindowPos(windowWidth / 2, windowHeight / 2,
            ImGuiCond_Appearing,
            0.5, 0.5)
        ImGui.SetNextWindowSize(windowWidth / 2, windowHeight / 2)
        if ImGui.BeginPopupModal("��֤����", M_ByteInt_Modal_ErrVerify, Bit.bor(ImGuiWindowFlags_AlwaysAutoResize, ImGuiWindowFlags_NoMove)) then
            local title = R.SProtect.GetErrMsg(LoginCard) or "δ֪����"
            ImGui.SetWindowFontScale(1.5)
            ImGui.SetCursorPos(windowWidth / 4 - ImGui.CalcTextSize(title) / 2, windowHeight / 4 - 10)
            ImGui.TextColored("#de576d", title)
            ImGui.SetWindowFontScale(1)
            ImGui.EndPopup()
        end
    elseif R.MValue.GetByteInt(M_ByteInt_Modal_Loading) == 1 then
        ImGui.OpenPopup("�ȴ�����")
        ImGui.SetNextWindowPos(windowWidth / 2, windowHeight / 2,
            ImGuiCond_Appearing,
            0.5, 0.5)
        ImGui.SetNextWindowSize(windowWidth / 2, windowHeight / 2)
        if ImGui.BeginPopupModal("�ȴ�����", M_ByteInt_Modal_Loading, Bit.bor(ImGuiWindowFlags_AlwaysAutoResize, ImGuiWindowFlags_NoMove)) then
            local title = R.Temp.Get("waitingServerResponse")
            local interval = 400                                                   -- ÿ0.1��
            local dots = math.floor(R.UITimepiece.GetMillisecond() / interval) % 6 -- ÿ0.1����£���ൽ4
            title = title .. string.rep(".", dots)                                 -- ���ݼ���ĵ������ɱ���
            ImGui.SetWindowFontScale(1.2)
            ImGui.SetCursorPos(windowWidth / 4 - ImGui.CalcTextSize(title) / 2, windowHeight / 4 - 20)

            ImGui.Text(title)
            ImGui.SetWindowFontScale(1)
            ImGui.SetCursorPos(windowWidth / 4 - 50, windowHeight / 4 + 40)

            if ImGui.Button("ȡ��", 100, 30) then
                R_Unload()
            end
            ImGui.EndPopup()
        end
    end
    ImGui.End()
end
