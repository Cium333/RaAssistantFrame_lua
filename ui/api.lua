local Call_Button = 1
local Call_Text = 2
local Call_BulletText = 3
local Call_TextColored = 4
local Call_InputTextWithHint = 5
local Call_BeginCombo = 6
local Call_EndCombo = 7
local Call_SameLine = 8
local Call_Separator = 9
local Call_SetNextItemWidth = 10
local Call_BeginPopupModal = 11
local Call_EndPopup = 12
local Call_CloseCurrentPopup = 13
local Call_SetItemDefaultFocus = 14
local Call_BeginPopupContextItem = 15
local Call_BeginChildStr = 16
local Call_EndChild = 17
local Call_Columns = 18
local Call_NextColumn = 19
local Call_SetColumnWidth = 20
local Call_AlignTextToFramePadding = 21
local Call_Checkbox = 22
local Call_PushIDInt = 23
local Call_PopID = 24
local Call_SelectableBool = 25
local Call_IsItemHovered = 26
local Call_SetTooltip = 27
local Call_OpenPopup = 28
local Call_SetNextWindowPos = 29
local Call_SetNextWindowSize = 30
local Call_BeginTabBar = 31
local Call_EndTabBar = 32
local Call_BeginTabItem = 33
local Call_EndTabItem = 34
local Call_HelpMarker = 35
local Call_RadioButtonIntPtr = 36
local Call_BeginMenuBar = 37
local Call_EndMenuBar = 38
local Call_Begin = 39
local Call_End = 40
local Call_GetWindowRect = 41
local Call_Timepiece = 42
local Call_MValue = 43
local Call_SetScrollHereY = 44
local Call_SetWindowFontScale = 45
local Call_CalcItemWidth = 46
local Call_PushStyleColorVec4 = 47
local Call_PopStyleColor = 48
local Call_ProgressBar = 49
local Call_SetCursorPos = 50
local Call_CalcTextSize = 51
local Call_GetColumnOffset = 52
local Call_SetColumnOffset = 53
local Call_InputTextMultiline = 54
local Call_Spacing = 55
local Call_BeginTooltip = 56
local Call_EndTooltip = 57
local Call_TextWrapped = 58
local Call_GetMousePos = 59
local Call_GetKeyStatus = 60
local Call_PushStyleVarVec2 = 61
local Call_PopStyleVar = 62
local Call_MenuItemBool = 63
local Call_BeginMenu = 64
local Call_EndMenu = 65
local Call_AddRect = 66
local Call_GetCursorScreenPos = 67
local Call_GetContentRegionAvail = 68
local Call_GetFrameHeight = 69
local Call_IsWindowFocused = 70
local Call_IsWindowHovered = 71
local Call_AddRectFilled = 72
local Call_GetScrollY = 73
local Call_GetScrollMaxY = 74
local Call_SetScrollY = 75
local Call_PushStyleVarFloat = 76
local Call_StyleColorsDark = 77
local Call_SetCursorPosX = 78
local Call_SetCursorPosY = 79
local Call_SetNextWindowContentSize = 80
local Call_BeginPopupContextWindow = 81
local Call_Dummy = 82
local Call_IsAnyItemHovered= 83
-----------------------------------------------------------------------------------------------------------------------

ImGui = {}

ImGuiWindowFlags_NoTitleBar = 1
ImGuiWindowFlags_NoResize = 2
ImGuiWindowFlags_NoMove = 4
ImGuiWindowFlags_NoScrollbar = 8
ImGuiWindowFlags_NoScrollWithMouse = 16
ImGuiWindowFlags_NoCollapse = 32
ImGuiWindowFlags_AlwaysAutoResize = 64
ImGuiWindowFlags_NoBackground = 128
ImGuiWindowFlags_NoSavedSettings = 256
ImGuiWindowFlags_NoMouseInputs = 512
ImGuiWindowFlags_MenuBar = 1024
ImGuiWindowFlags_HorizontalScrollbar = 2048
ImGuiWindowFlags_NoFocusOnAppearing = 4096
ImGuiWindowFlags_NoBringToFrontOnFocus = 8192
ImGuiWindowFlags_AlwaysVerticalScrollbar = 16384
ImGuiWindowFlags_AlwaysHorizontalScrollbar = 32768
ImGuiWindowFlags_AlwaysUseWindowPadding = 65536
ImGuiWindowFlags_NoNavInputs = 262144
ImGuiWindowFlags_NoNavFocus = 524288
ImGuiWindowFlags_UnsavedDocument = 1048576
ImGuiWindowFlags_NoNav = 786432
ImGuiWindowFlags_NoDecoRtion = 43
ImGuiWindowFlags_NoInputs = 786944
ImGuiWindowFlags_Modal = 134217728
ImGuiSelectableFlags_SpanAllColumns = 2
ImGuiSelectableFlags_AllowItemOverlap = 16
ImGuiCol_Text = 0
ImGuiCol_TextDisabled = 1
ImGuiCol_WindowBg = 2
ImGuiCol_ChildBg = 3
ImGuiCol_PopupBg = 4
ImGuiCol_Border = 5
ImGuiCol_BorderShadow = 6
ImGuiCol_FrameBg = 7
ImGuiCol_FrameBgHovered = 8
ImGuiCol_FrameBgActive = 9
ImGuiCol_TitleBg = 10
ImGuiCol_TitleBgActive = 11
ImGuiCol_TitleBgCollapsed = 12
ImGuiCol_MenuBarBg = 13
ImGuiCol_ScrollbarBg = 14
ImGuiCol_ScrollbarGrab = 15
ImGuiCol_ScrollbarGrabHovered = 16
ImGuiCol_ScrollbarGrabActive = 17
ImGuiCol_CheckMark = 18
ImGuiCol_SliderGrab = 19
ImGuiCol_SliderGrabActive = 20
ImGuiCol_Button = 21
ImGuiCol_ButtonHovered = 22
ImGuiCol_ButtonActive = 23
ImGuiCol_Header = 24
ImGuiCol_HeaderHovered = 25
ImGuiCol_HeaderActive = 26
ImGuiCol_Separator = 27
ImGuiCol_SeparatorHovered = 28
ImGuiCol_SeparatorActive = 29
ImGuiCol_ResizeGrip = 30
ImGuiCol_ResizeGripHovered = 31
ImGuiCol_ResizeGripActive = 32
ImGuiCol_Tab = 33
ImGuiCol_TabHovered = 34
ImGuiCol_TabActive = 35
ImGuiCol_TabUnfocused = 36
ImGuiCol_TabUnfocusedActive = 37
ImGuiCol_PlotLines = 38
ImGuiCol_PlotLinesHovered = 39
ImGuiCol_PlotHistogram = 40
ImGuiCol_PlotHistogramHovered = 41
ImGuiCol_TextSelectedBg = 42
ImGuiCol_DragDropTarget = 43
ImGuiCol_NavHighlight = 44
ImGuiCol_NavWindowingHighlight = 45
ImGuiCol_NavWindowingDimBg = 46
ImGuiCol_ModalWindowDimBg = 47
ImGuiStyleVar_Alpha = 0
ImGuiStyleVar_WindowPadding = 1
ImGuiStyleVar_WindowRounding = 2
ImGuiStyleVar_WindowBorderSize = 3
ImGuiStyleVar_WindowMinSize = 4
ImGuiStyleVar_WindowTitleAlign = 5
ImGuiStyleVar_ChildRounding = 6
ImGuiStyleVar_ChildBorderSize = 7
ImGuiStyleVar_PopupRounding = 8
ImGuiStyleVar_PopupBorderSize = 9
ImGuiStyleVar_FramePadding = 10
ImGuiStyleVar_FrameRounding = 11
ImGuiStyleVar_FrameBorderSize = 12
ImGuiStyleVar_ItemSpacing = 13
ImGuiStyleVar_ItemInnerSpacing = 14
ImGuiStyleVar_IndentSpacing = 15
ImGuiStyleVar_ScrollbarSize = 16
ImGuiStyleVar_ScrollbarRounding = 17
ImGuiStyleVar_GrabMinSize = 18
ImGuiStyleVar_GrabRounding = 19
ImGuiStyleVar_TabRounding = 20
ImGuiStyleVar_ButtonTextAlign = 21
ImGuiStyleVar_SelectableTextAlign = 22
ImGuiCond_Appearing = 8
ImGuiInputTextFlags_CharsUppercase = 4
ImGuiInputTextFlags_CharsNoBlank = 8
ImGuiInputTextFlags_AutoSelectAll = 16
ImGuiInputTextFlags_ReadOnly = 16384
ImGuiFocusedFlags_None = 0
ImGuiFocusedFlags_ChildWindows = 1
ImGuiFocusedFlags_AnyWindow = 4
ImGuiInputTextFlags_EnterReturnsTrue = 32
-----------------------------------------------------------------------------------------------------------------------


-- string int int -> boolean
function ImGui.Button(lable, x, y)
    return R_Call(Call_Button, lable, x, y)
end

-- string -> nil
function ImGui.Text(fmt)
    R_Call(Call_Text, fmt)
end

-- string -> nil
function ImGui.BulletText(fmt)
    R_Call(Call_BulletText, fmt)
end

-- int int int int string -> nil
function ImGui.TextColored(hex, fmt)
    local r, g, b, a = HexToImVec4(hex)
    R_Call(Call_TextColored, r, g, b, a, fmt)
end

-- string string int int int -> boolean
function ImGui.InputTextWithHint(lable, hint, index, size, flags)
    return R_Call(Call_InputTextWithHint, lable, hint, index, size, flags)
end

-- string string int -> boolean
function ImGui.BeginCombo(lable, preview, flags)
    return R_Call(Call_BeginCombo, lable, preview, flags)
end

function ImGui.EndCombo()
    R_Call(Call_EndCombo)
end

-- int int -> nil
function ImGui.SameLine(x, spacing)
    R_Call(Call_SameLine, x, spacing)
end

function ImGui.Separator()
    R_Call(Call_Separator)
end

-- int -> nil
function ImGui.SetNextItemWidth(width)
    R_Call(Call_SetNextItemWidth, width)
end

-- string int int -> boolean
function ImGui.BeginPopupModal(name, index, flags)
    return R_Call(Call_BeginPopupModal, name, index, flags)
end

function ImGui.EndPopup()
    R_Call(Call_EndPopup)
end

function ImGui.CloseCurrentPopup()
    R_Call(Call_CloseCurrentPopup)
end

function ImGui.SetItemDefaultFocus()
    R_Call(Call_SetItemDefaultFocus)
end

-- string int -> boolean
function ImGui.BeginPopupContextItem(id, flags)
    return R_Call(Call_BeginPopupContextItem, id, flags)
end

-- string int int boolean int -> boolean
function ImGui.BeginChildStr(id, x, y, border, flags)
    return R_Call(Call_BeginChildStr, id, x, y, border, flags)
end

function ImGui.EndChild()
    R_Call(Call_EndChild)
end

-- int string boolean -> nil
function ImGui.Columns(count, id, border)
    R_Call(Call_Columns, count, id, border)
end

function ImGui.NextColumn()
    R_Call(Call_NextColumn)
end

-- int int -> nil
function ImGui.SetColumnWidth(index, width)
    R_Call(Call_SetColumnWidth, index, width)
end

function ImGui.AlignTextToFramePadding()
    R_Call(Call_AlignTextToFramePadding)
end

-- string int -> boolean
function ImGui.Checkbox(lable, index1, index2)
    return R_Call(Call_Checkbox, lable, index1, index2)
end

-- int -> nil
function ImGui.PushIDInt(id)
    R_Call(Call_PushIDInt, id)
end

function ImGui.PopID()
    R_Call(Call_PopID)
end

-- string boolean int int int -> boolean
function ImGui.SelectableBool(lable, selected, flags, x, y)
    return R_Call(Call_SelectableBool, lable, selected, flags, x, y)
end

-- int -> boolean
function ImGui.IsItemHovered(flags)
    return R_Call(Call_IsItemHovered, flags)
end

-- string -> nil
function ImGui.SetTooltip(fmt)
    R_Call(Call_SetTooltip, fmt)
end

-- string int -> nil
function ImGui.OpenPopup(id, flags)
    R_Call(Call_OpenPopup, id, flags)
end

-- int int -> nil
function ImGui.SetNextWindowPos(x, y, cond, pivot_x, pivot_y)
    R_Call(Call_SetNextWindowPos, x, y, cond, R_ToNumber(pivot_x), R_ToNumber(pivot_y))
end

-- int int -> nil
function ImGui.SetNextWindowSize(x, y)
    R_Call(Call_SetNextWindowSize, x, y)
end

-- string int -> boolean
function ImGui.BeginTabBar(id, flags)
    return R_Call(Call_BeginTabBar, id, flags)
end

function ImGui.EndTabBar()
    R_Call(Call_EndTabBar)
end

-- string int int -> boolean
function ImGui.BeginTabItem(lable, index, flags)
    return R_Call(Call_BeginTabItem, lable, index, flags)
end

function ImGui.EndTabItem()
    R_Call(Call_EndTabItem)
end

-- string string -> nil
function ImGui.HelpMarker(tip, desc)
    R_Call(Call_HelpMarker, tip, desc)
end

-- string int int -> boolean
function ImGui.RadioButtonIntPtr(lable, index, button)
    return R_Call(Call_RadioButtonIntPtr, lable, index, button)
end

-- nil -> boolean
function ImGui.BeginMenuBar()
    return R_Call(Call_BeginMenuBar)
end

function ImGui.EndMenuBar()
    R_Call(Call_EndMenuBar)
end

-- string int int -> boolean
function ImGui.Begin(name, index, flags)
    return R_Call(Call_Begin, name, index, flags)
end

function ImGui.End()
    R_Call(Call_End)
end

function ImGui.GetWindowRect()
    local x, y = R_Call(Call_GetWindowRect)
    return x, y
end

R.UITimepiece = {}
function R.UITimepiece.Begin()
    R_Call(Call_Timepiece, 1)
end

-- nil -> number
function R.UITimepiece.GetSecond()
    return (R_Call(Call_Timepiece, 2))
end

-- nil -> number
function R.UITimepiece.GetMillisecond()
    return (R_Call(Call_Timepiece, 3))
end

R.MValue = {}
-- int -> int
function R.MValue.GetByteInt(index)
    return R_ToNumber(R_Call(Call_MValue, 1, index))
end

-- int -> string
function R.MValue.GetByteString(index)
    return tostring(R_Call(Call_MValue, 2, index))
end

-- int -> int
function R.MValue.GetInt(index)
    return R_ToNumber(R_Call(Call_MValue, 3, index))
end

-- int int -> nil
function R.MValue.SetByteInt(index, value)
    R_Call(Call_MValue, 4, index, value)
end

-- int string -> nil
function R.MValue.SetByteString(index, value)
    R_Call(Call_MValue, 5, index, value)
end

-- int int -> nil
function R.MValue.SetInt(index, value)
    R_Call(Call_MValue, 6, index, value)
end

-- int int -> nil
function R.MValue.InitCheckbox(index, index2)
    R_Call(Call_MValue, 7, index, index2)
end

-- int int int -> nil
function R.MValue.SetCheckbox(boxIndex, arrIndex, value)
    R_Call(Call_MValue, 8, boxIndex, arrIndex, value)
end

-- int int -> int
function R.MValue.GetCheckbox(index, index2)
    return R_ToNumber(R_Call(Call_MValue, 9, index, index2))
end

function R.MValue.GetCheckboxCount(index)
    return R_ToNumber(R_Call(Call_MValue, 10, index))
end

function ImGui.SetScrollHereY(y)
    R_Call(Call_SetScrollHereY, y)
end

function ImGui.SetWindowFontScale(scale)
    R_Call(Call_SetWindowFontScale, scale)
end

-- nil -> int
function ImGui.CalcItemWidth()
    return R_ToNumber(R_Call(Call_CalcItemWidth))
end

function ImGui.PushStyleColor(index, hex)
    local r, g, b, a = HexToImVec4(hex)
    R_Call(Call_PushStyleColorVec4, index, r, g, b, a)
end

function ImGui.PushStyleColorVec4(index, r, g, b, a)
    R_Call(Call_PushStyleColorVec4, index, r, g, b, a)
end

function ImGui.PopStyleColor(count)
    R_Call(Call_PopStyleColor, count)
end

-- number int int string -> nil
function ImGui.ProgressBar(fRction, x, y, overlay)
    R_Call(Call_ProgressBar, fRction, x, y, overlay)
end

-- int int -> nil
function ImGui.SetCursorPos(x, y)
    R_Call(Call_SetCursorPos, x, y)
end

-- string -> int int
function ImGui.CalcTextSize(str)
    local x, y = R_Call(Call_CalcTextSize, str)
    return R_ToNumber(x), R_ToNumber(y)
end

-- int -> number
function ImGui.GetColumnOffset(index)
    return R_ToNumber(R_Call(Call_GetColumnOffset, index))
end

-- int number -> nil
function ImGui.SetColumnOffset(index, offset_x)
    R_Call(Call_SetColumnOffset, index, offset_x)
end

-- string int int int int -> nil
function ImGui.InputTextMultiline(label, index, bufsize, x, y, flags)
    R_Call(Call_InputTextMultiline, label, index, bufsize, R_ToNumber(x), R_ToNumber(y), flags)
end

function ImGui.Spacing()
    R_Call(Call_Spacing)
end

function ImGui.BeginTooltip()
    R_Call(Call_BeginTooltip)
end

function ImGui.EndTooltip()
    R_Call(Call_EndTooltip)
end

-- string -> nil
function ImGui.TextWrapped(fmt)
    R_Call(Call_TextWrapped, fmt)
end

-- nil -> number number
function ImGui.GetMousePos()
    return R_Call(Call_GetMousePos)
end

-- int -> boolean
function ImGui.GetKeyStatus(key)
    return R_Call(Call_GetKeyStatus, key)
end

-- int number number -> nil
function ImGui.PushStyleVarVec2(index, x, y)
    R_Call(Call_PushStyleVarVec2, index, x, y)
end

function ImGui.PopStyleVar(count)
    R_Call(Call_PopStyleVar, count)
end

-- string -> boolean
function ImGui.MenuItemBool(label)
    return R_Call(Call_MenuItemBool, label)
end

-- string boolean -> boolean
function ImGui.BeginMenu(label, enabled)
    return R_Call(Call_BeginMenu, label, enabled)
end

function ImGui.EndMenu()
    R_Call(Call_EndMenu)
end

function ImGui.AddRect(x1, y1, x2, y2, color, rouding, rounding_corners, thickness)
    local r, g, b, a = HexToImVec4(color)
    R_Call(Call_AddRect, x1, y1, x2, y2, r, g, b, a, rouding, rounding_corners, thickness)
end

function ImGui.GetCursorScreenPos()
    return R_Call(Call_GetCursorScreenPos)
end

function ImGui.GetContentRegionAvail()
    return R_Call(Call_GetContentRegionAvail)
end

function ImGui.GetFrameHeight()
    return R_Call(Call_GetFrameHeight)
end

function ImGui.IsWindowFocused(flag)
    return R_Call(Call_IsWindowFocused, flag)
end

function ImGui.IsWindowHovered(flag)
    return R_Call(Call_IsWindowHovered, flag)
end

function ImGui.AddRectFilled(x1, y1, x2, y2, color, alpha, rouding, rounding_corners)
    local r, g, b, a = HexToImVec4(color, alpha)
    R_Call(Call_AddRectFilled, x1, y1, x2, y2, r, g, b, a, rouding, rounding_corners)
end

function ImGui.GetScrollY()
    return R_Call(Call_GetScrollY)
end

function ImGui.GetScrollMaxY()
    return R_Call(Call_GetScrollMaxY)
end

function ImGui.SetScrollY(y)
    R_Call(Call_SetScrollY, y)
end

function ImGui.PushStyleVarFloat(idx, val)
    R_Call(Call_PushStyleVarFloat, idx, val)
end

function ImGui.StyleColorsDark()
    R_Call(Call_StyleColorsDark)
end

function ImGui.SetCursorPosX(x)
    R_Call(Call_SetCursorPosX, x)
end

function ImGui.SetCursorPosY(y)
    R_Call(Call_SetCursorPosY, y)
end

function ImGui.SetNextWindowContentSize(x, y)
    R_Call(Call_SetNextWindowContentSize, x, y)
end

function ImGui.BeginPopupContextWindow(id, flags)
    return R_Call(Call_BeginPopupContextWindow, id, flags)
end

function ImGui.Dummy(x, y)
    R_Call(Call_Dummy, x, y)
end

function ImGui.IsAnyItemHovered()
    return R_Call(Call_IsAnyItemHovered)
end

MakeReadOnlyTable(ImGui)
