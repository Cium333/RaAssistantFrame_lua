-- ? public + engine

function R_Engine_Run()
    R_Init()

    while true do
        if R_Engine_IsStop() then
            return
        end

        if R_Engine_IsReload() then
            return
        end

        R_ThreadDebug("Test...", R_Engine_GetThreadData("STATUS"))
        R_Engine_SetAccountStatus("Test - " .. R.EngineTimepiece.GetSecond(G_ThreadID) .. "s")
        R_Engine_Sleep(100)
    end
end

R_Engine_Run()
R_Engine_SetAccountStatus("")
R_ThreadInfo("Engine Run End")
