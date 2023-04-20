#INCLUDE 'TOTVS.CH'

User Function L5Ex11()
    local aValA     := ACLONE(PopArray(10))
    local aValB     := {}
    local nSoma     := 0
    local nI        := 0
    local nJ        := 0


    For nI := 1 TO LEN(aValA)
        nSoma := 0
        for nJ := 1 TO nI
            nSoma += aValA[nJ]
        next
        AADD(aValB, nSoma)
    next

    FwAlertSuccess( 'Os valores do Array A: ' + CRLF + ImprimeArray(aValA) + CRLF +;
                    'Os valores do Array B: ' + CRLF + ImprimeArray(aValB), 'Programa para Construir Array com a Somatoria')

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
