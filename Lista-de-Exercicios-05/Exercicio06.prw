#INCLUDE 'TOTVS.CH'

User Function L5Ex06()
    local aValA[10]
    local aValB[10]
    local aValC     := {}
    local nCont     := 0
    local cValA     := ''
    local cValB     := ''
    local cValC     := ''

    for nCont := 1 TO LEN(aValA)
        aValA[nCont] := RANDOMIZE(1, 50)
        aValB[nCont] := RANDOMIZE(1, 50)
        if nCont < LEN(aValA)
            cValA += CVALTOCHAR(aValA[nCont])  + ', '
            cValB += CVALTOCHAR(aValB[nCont])  + ', '
        else
            cValA += CVALTOCHAR(aValA[nCont])
            cValB += CVALTOCHAR(aValB[nCont])
        endif
    next

    for nCont := 1 TO (LEN(aValA) * 2)
        if nCont % 2 = 1
            AADD(aValC, aValA[(nCont+1)/2])
        else
            AADD(aValC, aValB[nCont/2])
        endif
        
        if nCont < 20
            cValC += CVALTOCHAR(aValC[nCont])  + ', '
        else
            cValC += CVALTOCHAR(aValC[nCont])
        endif
    next
    
    FwAlertSuccess( 'Os valores de A: ' + CRLF + cValA + CRLF +;
                    'Os valores de B: ' + CRLF + cValB + CRLF + CRLF +;
                    'Os valores de C: ' + CRLF + cValC, 'Programa para Mesclar Arrays')

Return 
