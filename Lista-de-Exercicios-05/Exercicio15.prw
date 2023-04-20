#INCLUDE 'TOTVS.CH'

User Function L5Ex15()
    local aValA     := ACLONE(PopArray(12))
    local cAntes    := ImprimeArray(aValA)
    local nAux      := 0
    local nI        := 0
    local nJ        := 0

    for nJ := 1 TO LEN(aValA)-1 
        for nI := 1 TO LEN(aValA)-1
            if aValA[nI] > aValA[nI+1]
                nAux        := aValA[nI]
                aValA[nI]   := aValA[nI+1]
                aValA[nI+1] := nAux
            endif
        next
    next 

    FwAlertSuccess( 'Os valores do Array Antes: ' + CRLF + cAntes + CRLF +;
                    'Os valores do Array Depois: ' + CRLF + ImprimeArray(aValA), 'Programa para Ordenar em Ordem Crescente')

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
