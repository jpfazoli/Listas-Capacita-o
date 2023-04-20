#INCLUDE 'TOTVS.CH'

User Function L5Ex08()
    local aValA[8]
    local nCont      := 0
    local cValAntes  := ''
    local cValResult := ''
    local nAux       := 0

    for nCont := 1 TO LEN(aValA)
        aValA[nCont] := RANDOMIZE(1, 50)
        if nCont < LEN(aValA)
            cValAntes += CVALTOCHAR(aValA[nCont])  + ', '
        else
            cValAntes += CVALTOCHAR(aValA[nCont])
        endif
    next

    for nCont := 1 TO LEN(aValA)/2
        nAux := aValA[nCont]
        aValA[nCont] := aValA[LEN(aValA) + 1 - nCont]
        aValA[LEN(aValA) + 1 - nCont] := nAux
    next

    for nCont := 1 TO LEN(aValA)
        if nCont < LEN(aValA)
            cValResult += CVALTOCHAR(aValA[nCont])  + ', '
        else
            cValResult += CVALTOCHAR(aValA[nCont])
        endif
    next
    
    FwAlertSuccess( 'Os valores de Antes: ' + CRLF + cValAntes + CRLF +;
                    'Os valores após inversão: ' + CRLF + cValResult + CRLF, 'Programa para Inverter um Array no Próprio Conteudo')

Return 
