#INCLUDE 'TOTVS.CH'

User Function L5Ex09()
    local aValA[8]
    local aValB      := {}
    local nCont      := 0
    local cValA  := ''
    local cValB := ''

    for nCont := 1 TO LEN(aValA)
        aValA[nCont] := VAL(FwInputBox('Informe Valores para ser Armazenado: ',''))
        AADD(aValB, aValA[nCont] * 3)
        if nCont < LEN(aValA)
            cValA += CVALTOCHAR(aValA[nCont])  + ', '
            cValB += CVALTOCHAR(aValB[nCont])  + ', '
        else
            cValA += CVALTOCHAR(aValA[nCont])
            cValB += CVALTOCHAR(aValB[nCont])
        endif
    next
    
    FwAlertSuccess( 'Os valores do Array A: ' + CRLF + cValA + CRLF +;
                    'Os valores do Array B: ' + CRLF + cValB + CRLF, 'Programa para Construir Array com o Triplo')

Return 
