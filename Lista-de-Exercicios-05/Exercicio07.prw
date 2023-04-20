#INCLUDE 'TOTVS.CH'

User Function L5Ex07()
    local aValA[15]
    local aValB     := {}
    local nCont     := 0
    local cValA     := ''
    local cValB     := ''

    for nCont := 1 TO 15
        aValA[nCont] := RANDOMIZE(1, 50)
        if nCont < 15
            cValA += CVALTOCHAR(aValA[nCont])  + ', '
        else
            cValA += CVALTOCHAR(aValA[nCont])
        endif
    next

    for nCont := LEN(aValA) TO 1 STEP -1
        AADD(aValB, aValA[nCont] )
        if nCont > 1
            cValB += CVALTOCHAR(aValB[nCont-(nCont-LEN(aValB))]) + ', '
        else
            cValB += CVALTOCHAR(aValB[nCont-(nCont-LEN(aValB))])
        endif
    next
    
    FwAlertSuccess( 'Os valores de A: ' + CRLF + cValA + CRLF +;
                    'Os valores de B: ' + CRLF + cValB + CRLF, 'Programa para Inverter um Array para Outro')

Return 
