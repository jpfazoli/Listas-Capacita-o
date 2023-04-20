#INCLUDE 'TOTVS.CH'

User Function L5Ex04()
    local aValores[10]
    local nCont     := 0
    local cValores  := ''

    for nCont := 1 TO 10
        aValores[nCont] := nCont * 2
        if nCont < 10
            cValores += CVALTOCHAR(aValores[nCont])  + ', '
        else
            cValores += CVALTOCHAR(aValores[nCont])
        endif
    next
    
    FwAlertSuccess('Os valores que foram Colocados: ' + cValores, 'Programa para Popular Array')

Return 
