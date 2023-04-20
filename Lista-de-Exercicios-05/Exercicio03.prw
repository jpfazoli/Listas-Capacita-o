#INCLUDE 'TOTVS.CH'

User Function L5Ex03()
    local aValores  := {}
    local nEntrada  := 0
    local nCont     := 0
    local cValores  := ''

    for nCont := 1 TO 30
        nEntrada := RANDOMIZE(1, 30)
        AADD(aValores, nEntrada)
        if nCont < 30
            cValores += CVALTOCHAR(aValores[nCont])  + ', '
        else
            cValores += CVALTOCHAR(aValores[nCont])
        endif
    next
    
    FwAlertSuccess('Os valores que foram Colocados: ' + cValores, 'Programa para Popular Array')

Return 
