function R_Engine_Run()
    local task = R_Engine_GetThreadData("TASK")
    local accountID = R_ToNumber(R_Engine_GetThreadData("ACCOUNTID"))
    -- R_ThreadInfo("HelpEngine", "task", task, "accountID", accountID)

    R_Engine_SetThreadData("", "")
    R_Engine_SetThreadData("TASK", task)
    R_Engine_SetThreadData("ACCOUNTID", accountID)

    -- R_ThreadInfo("HelpEngine Init Success")

    while true do
        if R_Engine_IsStop() then
            return
        end

        if R_Engine_IsReload() then
            return
        end

        R_ThreadDebug("Help Test ...", R_Engine_GetThreadData("STATUS"))

        R_Engine_Sleep(1000)
    end
end

R_Engine_Run()
R_ThreadInfo("HelpEngine Run End")
