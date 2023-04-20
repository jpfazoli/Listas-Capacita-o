#INCLUDE 'TOTVS.CH'


User Function FISA010()
    local lRet     := .T.
    local aParam   := PARAMIXB
    local aArea    := GetArea()
    local aAreaCC2 := CC2->(GetArea())
    local oObj     := NIL
    local cIdPonto := ''
    local cIdModel := ''

    if aParam <> NIL
        oObj     := aParam[1]
        cIdPonto := aParam[2]
        cIdModel := aParam[3]

        if cIdPonto == 'MODELPOS'
            if ExistBlock('ValMunici')
                lRet := ExecBlock('ValMunici', .T.,.T.,{M->CC2_MUN,M->CC2_EST})
            endif
        endif
    endif

    RestArea(aArea)
    RestArea(aAreaCC2)
Return lRet
