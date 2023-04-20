#INCLUDE 'TOTVS.CH'


User Function MT120PCOL()
    local aArea     := GetArea()
    local aAreaSC7  := SC7->(GetArea())
    Local lRet      := .T.
    Local nPosTES   := aScan(aHeader,{|x| Alltrim(x[2]) == 'C7_TES'})
     
    if Empty(aCols [n][nPosTES])
        FwAlertError('Tipo de Entrada não informado','Atenção')
        lRet := .f.
    endif
    
    RestArea(aArea)
    RestArea(aAreaSC7)
Return lRet
