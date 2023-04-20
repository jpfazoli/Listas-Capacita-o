#INCLUDE 'TOTVS.CH'

User Function L5Ex14()
    local aResultado := ACLONE(PopLetrasDiff(12))

    ImprimeArray(aResultado)

Return 

STATIC FUNCTION PopLetrasDiff(nTam)
    local nCont         := 0
    local nJ            := 0
    local nLetra        := 0
    local aArray[nTam]
    local lIgual        := .T.

    for nCont := 1 TO nTam
        lIgual := .T.

        while lIgual
            lIgual := .F.
            nLetra := RANDOMIZE( 65, 90)

            for nJ := 1 TO nCont-1
                if nLetra == ASC(aArray[nJ])
                    lIgual := .T.
                endif
            next
        enddo

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

    FwAlertSuccess( 'Os valores Gerados: ' + CRLF + cMsg, 'Programa para Gerar Letras Aleatorias')
Return
