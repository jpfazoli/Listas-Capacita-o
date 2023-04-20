#INCLUDE 'TOTVS.CH'


User Function CRMA980()
    local aArea     := GetArea()
    local aAreaSA1  := SA1->(GetArea())
    local aParam    := PARAMIXB
    local lRet      := .T.
    local oObj      := NIL
    local cIdPonto  := ''
    local cIdModel  := ''

    if aParam <> NIL
        oObj     := aParam[1]
        cIdPonto := aParam[2]
        cIdModel := aParam[3]

        if cIdPonto == 'MODELCOMMITTTS'
            if INCLUI
                SA1->A1_MSBLQL := '1'
            endif
        endif

    endif

    RestArea(aArea)
    RestArea(aAreaSA1)
Return lRet
