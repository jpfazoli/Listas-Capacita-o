#INCLUDE 'TOTVS.CH'

User Function ITEM()
    local aArea     := GetArea()
    local aAreaSB1  := SB1->(GetArea())
    local lRet      := .T.
    local aParam    := PARAMIXB
    local oObj      := NIL
    local cIdPonto  := ''
    local cIdModel  := ''

    if aParam <> NIL
        oObj     := aParam[1]
        cIdPonto := aParam[2]
        cIdModel := aParam[3]

        if cIdPonto == 'MODELCOMMITTTS'
            if ExistBlock('ValDesc')
                SB1->B1_DESC := ExecBlock('ValDesc', .F., .F.,SB1->B1_DESC)
            endif
        endif

    endif
    RestArea(aArea)
    RestArea(aAreaSB1)
Return lRet
