#INCLUDE 'TOTVS.CH'


User Function A410EXC()
    local lRetorno := .T.
    local aArea    := GetArea()
    local aAreaSC5 := SC5->(GetArea())

    if ExistBlock('ValAuto')
        lRetorno := ExecBlock('ValAuto',.F.,.F.,SC5->C5_ZZINCLU)
    endif

    RestArea(aArea)
    RestArea(aAreaSC5)
Return lRetorno
