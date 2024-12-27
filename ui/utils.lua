function GetCardPrograss(expireTimestamp)
    if expireTimestamp == 0 then
        return 0
    end
    local nowTimestamp  = os.time()
    local remainingTime = expireTimestamp - nowTimestamp
    local ratio         = remainingTime / (24 * 60 * 60)
    return ratio / 365
end

function GetCardColor(ratio)
    local r = 1 - ratio
    local greenMultiplier = 0.6
    local g = ratio * greenMultiplier
    local b = 0

    return string.format("#%02x%02x%02x",
        math.floor(r * 255),
        math.floor(g * 255),
        math.floor(b * 255))
end

function HexToImVec4(hex, a)
    -- hex = hex:gsub("#", "")
    hex = R.String.ReplaceString(hex, -1, "#", "", " ", "")

    local r = tonumber(hex:sub(1, 2), 16) / 255
    local g = tonumber(hex:sub(3, 4), 16) / 255
    local b = tonumber(hex:sub(5, 6), 16) / 255
    if a == nil then
        a = 1.0
    end

    return r, g, b, a
end

function AccountTooptip(index)
    local tooltip = ""
    for i, value in ipairs(Accounts) do
        if i == 1 then
            tooltip = tooltip .. value.showName .. ": " .. tostring(index) .. "\n"
        elseif value.jsonName == "packet" then
            local packetIndex = R_ToNumber(CloudData.Account_Get(i, "packet"))
            local packet = ""
            if packetIndex > 0 and packetIndex <= #Packets then
                packet = Packets[packetIndex].showName
            else
                packet = Packets[1].showName
            end
            tooltip = tooltip .. value.showName .. ": " .. packet .. "\n"
        else
            tooltip = tooltip .. value.showName .. ": " .. CloudData.Account_Get(index, value.jsonName) .. "\n"
        end
    end
    ImGui.SetTooltip(tooltip)
end

function CardGetSelectedExpireTimestamp()
    if GetNowSelectedCard() == LoginCard then
        for i = 1, CloudData.Card_GetCount(), 1 do
            local selected = R_ToNumber(R.Temp.Get("GlobalCardSelected." .. tostring(i))) == 1
            if selected then
                local card = CloudData.Card_Get(i, "card")
                if R.SProtect.GetOffStatus(card) == 1 then
                    R_Debug("card ", card, "R_SProtect_NormalVerify")
                    --R_SProtect_NormalVerify({s})
                    local cmd = R_HandleCmd(
                        R.Encrypt.Decrypt(Cmd_R_SProtect_NormalVerify), card)
                    R.App.AddBackendTask(cmd)
                else
                    R_Debug("card ", card, "R_SProtect_Login")
                    --R_SProtect_Login({{i}},{s})
                    local cmd = R_HandleCmd(R.Encrypt.Decrypt(Cmd_R_SProtect_Login),
                        i, card)
                    R.App.AddBackendTask(cmd)
                end
            end
        end
    end
end

function CardLogout()
    for i = 1, CloudData.Card_GetCount(), 1 do
        local selected = R_ToNumber(R.Temp.Get("GlobalCardSelected." .. tostring(i))) == 1
        if selected then
            local card = CloudData.Card_Get(i, "card")
            --R_SProtect_Logout({s})
            local cmd = R_HandleCmd(R.Encrypt.Decrypt(Cmd_R_SProtect_Logout), card)
            R.App.AddBackendTask(cmd)
        end
    end
end

-- function PushStyle()
--     -- ImGui.StyleColorsDark()
--     ImGui.PushStyleVarFloat(ImGuiStyleVar_WindowRounding, 0)
--     ImGui.PushStyleVarFloat(ImGuiStyleVar_TabRounding, 0)
--     ImGui.PushStyleVarFloat(ImGuiStyleVar_ScrollbarRounding, 0)

--     ImGui.PushStyleVarVec2(ImGuiStyleVar_FramePadding, 2, 0)
--     ImGui.PushStyleVarVec2(ImGuiStyleVar_ItemSpacing, 6, 2)
--     ImGui.PushStyleVarVec2(ImGuiStyleVar_ItemInnerSpacing, 2, 4)
--     ImGui.PushStyleVarFloat(ImGuiStyleVar_Alpha, 0.95)
--     ImGui.PushStyleVarFloat(ImGuiStyleVar_FrameRounding, 2)
--     ImGui.PushStyleVarFloat(ImGuiStyleVar_IndentSpacing, 6)
--     ImGui.PushStyleVarFloat(ImGuiStyleVar_GrabMinSize, 14)
--     ImGui.PushStyleVarFloat(ImGuiStyleVar_GrabRounding, 16)
--     ImGui.PushStyleVarFloat(ImGuiStyleVar_ScrollbarSize, 12)
--     ImGui.PushStyleVarFloat(ImGuiStyleVar_ScrollbarRounding, 16)

--     ImGui.PushStyleColorVec4(ImGuiCol_Tab, 0.47, 0.77, 0.83, 0.14)
--     ImGui.PushStyleColorVec4(ImGuiCol_TabHovered, 0.92, 0.18, 0.29, 0.86)
--     ImGui.PushStyleColorVec4(ImGuiCol_TabActive, 0.92, 0.18, 0.29, 1)
--     ImGui.PushStyleColorVec4(ImGuiCol_Text, 0.86, 0.93, 0.89, 0.78)
--     ImGui.PushStyleColorVec4(ImGuiCol_TextDisabled, 0.86, 0.93, 0.89, 0.28)
--     -- ImGui.PushStyleColorVec4 (ImGuiCol_WindowBg,0.13, 0.14, 0.17, 1)
--     ImGui.PushStyleColorVec4(ImGuiCol_WindowBg, 0, 0, 0, 0.95)
--     -- ImGui.PushStyleColorVec4(ImGuiCol_Border, 0.31, 0.31, 1, 0.5)
--     ImGui.PushStyleColorVec4(ImGuiCol_BorderShadow, 0, 0, 0, 0)
--     ImGui.PushStyleColorVec4(ImGuiCol_FrameBg, 0.2, 0.22, 0.27, 1)
--     ImGui.PushStyleColorVec4(ImGuiCol_FrameBgHovered, 0.92, 0.18, 0.29, 0.78)
--     ImGui.PushStyleColorVec4(ImGuiCol_FrameBgActive, 0.92, 0.18, 0.29, 1)
--     ImGui.PushStyleColorVec4(ImGuiCol_TitleBg, 0.2, 0.22, 0.27, 1)
--     ImGui.PushStyleColorVec4(ImGuiCol_TitleBgCollapsed, 0.2, 0.22, 0.27, 0.75)
--     ImGui.PushStyleColorVec4(ImGuiCol_TitleBgActive, 0.92, 0.18, 0.29, 1)
--     ImGui.PushStyleColorVec4(ImGuiCol_MenuBarBg, 0.2, 0.22, 0.27, 0.47)
--     ImGui.PushStyleColorVec4(ImGuiCol_ScrollbarBg, 0.2, 0.22, 0.27, 1)
--     ImGui.PushStyleColorVec4(ImGuiCol_ScrollbarGrab, 0.09, 0.15, 0.16, 1)
--     ImGui.PushStyleColorVec4(ImGuiCol_ScrollbarGrabHovered, 0.92, 0.18, 0.29, 0.78)
--     ImGui.PushStyleColorVec4(ImGuiCol_ScrollbarGrabActive, 0.92, 0.18, 0.29, 1)
--     ImGui.PushStyleColorVec4(ImGuiCol_CheckMark, 0.71, 0.22, 0.27, 1)
--     ImGui.PushStyleColorVec4(ImGuiCol_SliderGrab, 0.47, 0.77, 0.83, 0.14)
--     ImGui.PushStyleColorVec4(ImGuiCol_SliderGrabActive, 0.92, 0.18, 0.29, 1)
--     ImGui.PushStyleColorVec4(ImGuiCol_Button, 0.47, 0.77, 0.83, 0.14)
--     ImGui.PushStyleColorVec4(ImGuiCol_ButtonHovered, 0.92, 0.18, 0.29, 0.86)
--     ImGui.PushStyleColorVec4(ImGuiCol_ButtonActive, 0.92, 0.18, 0.29, 1)
--     ImGui.PushStyleColorVec4(ImGuiCol_Header, 0.92, 0.18, 0.29, 0.76)
--     ImGui.PushStyleColorVec4(ImGuiCol_HeaderHovered, 0.92, 0.18, 0.29, 0.86)
--     ImGui.PushStyleColorVec4(ImGuiCol_HeaderActive, 0.92, 0.18, 0.29, 1)
--     ImGui.PushStyleColorVec4(ImGuiCol_Separator, 0.14, 0.16, 0.19, 1)
--     ImGui.PushStyleColorVec4(ImGuiCol_SeparatorHovered, 0.92, 0.18, 0.29, 0.78)
--     ImGui.PushStyleColorVec4(ImGuiCol_SeparatorActive, 0.92, 0.18, 0.29, 1)
--     ImGui.PushStyleColorVec4(ImGuiCol_ResizeGrip, 0.47, 0.77, 0.83, 0.04)
--     ImGui.PushStyleColorVec4(ImGuiCol_ResizeGripHovered, 0.92, 0.18, 0.29, 0.78)
--     ImGui.PushStyleColorVec4(ImGuiCol_ResizeGripActive, 0.92, 0.18, 0.29, 1)
--     ImGui.PushStyleColorVec4(ImGuiCol_PlotLines, 0.86, 0.93, 0.89, 0.63)
--     ImGui.PushStyleColorVec4(ImGuiCol_PlotLinesHovered, 0.92, 0.18, 0.29, 1)
--     ImGui.PushStyleColorVec4(ImGuiCol_PlotHistogram, 0.86, 0.93, 0.89, 0.63)
--     ImGui.PushStyleColorVec4(ImGuiCol_PlotHistogramHovered, 0.92, 0.18, 0.29, 1)
--     ImGui.PushStyleColorVec4(ImGuiCol_TextSelectedBg, 0.92, 0.18, 0.29, 0.43)
--     -- ImGui.PushStyleColorVec4(ImGuiCol_PopupBg, 0.2, 0.22, 0.27, 0.99)
--     ImGui.PushStyleColorVec4(ImGuiCol_PopupBg, 0, 0, 0, 0.95)
-- end

-- function PopStyle()
--     ImGui.PopStyleVar(13)
--     ImGui.PopStyleColor(39)
-- end
