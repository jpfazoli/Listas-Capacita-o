#INCLUDE 'TOTVS.CH'

User Function L5Ex12()
    local aValA[5]
    local aValB[5]
    local nI        := 0

    For nI := 1 TO LEN(aValA)
        aValA[nI] := VAL(FwInputBox('Informe valores para armazenar: ', ''))
        aValB[nI] := -aValA[nI]
    next

    FwAlertSuccess( 'Os valores do Array A: ' + CRLF + ImprimeArray(aValA) + CRLF +;
                    'Os valores do Array B: ' + CRLF + ImprimeArray(aValB), 'Programa para Construir Array com o Inverso')

Return 

STATIC FUNCTION ImprimeArray(aArray)
    local cMsg  := ''
    local nCont := 0

    for nCont := 1 TO LEN(aArray)
        if nCont < LEN(aArray)
            cMsg += CVALTOCHAR(aArray[nCont])  + ', '
        else
            cMsg += CVALTOCHAR(aArray[nCont])
        endif
    next
Return cMsg
