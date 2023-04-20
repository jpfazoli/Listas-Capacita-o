#INCLUDE 'TOTVS.CH'

User Function L5Ex10()
    local aValA     := ACLONE(PopArray(10))
    local aValB     := ACLONE(PopArray(15))
    local aValC[25]
    local nCont     := 0


    For nCont := 1 TO LEN(aValC)
        if nCont <= 10
            aValC[nCont] := aValA[nCont]
        else
            aValC[nCont] := aValB[nCont-10]
        endif
    next

    FwAlertSuccess( 'Os valores do Array A: ' + CRLF + ImprimeArray(aValA) + CRLF +;
                    'Os valores do Array B: ' + CRLF + ImprimeArray(aValB) + CRLF + CRLF +;
                    'Os valores do Array C: ' + CRLF + ImprimeArray(aValC), 'Programa para Unir Arrays')

Return 

STATIC FUNCTION PopArray(nTam)
    local nCont := 0
    local aArray[nTam]

    for nCont := 1 TO nTam
        aArray[nCont] := RANDOMIZE( 1, 100)
    next

Return aArray

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
