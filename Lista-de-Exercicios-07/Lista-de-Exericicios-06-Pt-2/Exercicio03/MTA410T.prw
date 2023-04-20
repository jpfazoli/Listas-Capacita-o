#INCLUDE 'TOTVS.CH'


User Function MTA410I()
    local lRetorno := .T.
    local nPosQuant := aScan(Aheader,{|x| Alltrim(x[2]) == "C6_DESCRI"})
    
    Reclock('SC6',.F.)
    if aCols[n][nPosQuant] != 'Inc. PE - '
        SC6->C6_DESCRI := Alltrim('Inc. PE - ' + SC6->C6_DESCRI)
        MsgInfo(C6_DESCRI)
    endif
    MSUNLOCK()
Return lRetorno
