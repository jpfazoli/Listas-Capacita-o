#INCLUDE 'TOTVS.CH'

User Function L5Ex05()
    local aValA[20]
    local aValB[20]
    local aValC[20]
    local nCont     := 0
    local cValA     := ''
    local cValB     := ''
    local cValC     := ''

    for nCont := 1 TO LEN(aValA)
        aValA[nCont] := RANDOMIZE(1, 50)
        aValB[nCont] := RANDOMIZE(1, 50)
        aValC[nCont] := aValA[nCont] + aValB[nCont]
        if nCont < LEN(aValA)
            cValA += CVALTOCHAR(aValA[nCont])  + ', '
            cValB += CVALTOCHAR(aValB[nCont])  + ', '
            cValC += CVALTOCHAR(aValC[nCont])  + ', '
        else
            cValA += CVALTOCHAR(aValA[nCont])
            cValB += CVALTOCHAR(aValB[nCont])
            cValC += CVALTOCHAR(aValC[nCont])
        endif
    next
    
    FwAlertSuccess( 'Os valores de A: ' + CRLF + cValA + CRLF+;
                    'Os valores de B: ' + CRLF + cValB + CRLF+;
                    'Os valores de C: ' + CRLF + cValC, 'Programa para Somar Arrays')

Return 
