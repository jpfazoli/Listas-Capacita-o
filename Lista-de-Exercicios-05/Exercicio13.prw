#INCLUDE 'TOTVS.CH'

User Function L5Ex13()
    local aResultado := ACLONE(PopLetras(50))

    FwAlertSuccess( 'Os valores Gerados: ' + CRLF + ImprimeArray(aResultado), 'Programa para Gerar Letras Aleatorias')

Return 

STATIC FUNCTION PopLetras(nTam)
    local nCont  := 0
    local nLetra := 0
    local aArray[nTam]

    for nCont := 1 TO nTam
        nLetra        := RANDOMIZE( 65, 90)
        aArray[nCont] := CHR(nLetra)
    next

Return aArray

STATIC FUNCTION ImprimeArray(aArray)
    local cMsg  := ''
    local nCont := 0

    for nCont := 1 TO LEN(aArray)
        if nCont < LEN(aArray)
            cMsg += aArray[nCont]  + ', '
        else
            cMsg += aArray[nCont]
        endif
    next
Return cMsg
