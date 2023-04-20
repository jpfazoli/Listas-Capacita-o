#INCLUDE 'TOTVS.CH'


USER FUNCTION L2Ex10()
    local cEntrada := ''
    local aValores := {}
    local cValores := ''
    local nMaior   := 0
    local nMenor   := 0
    local nCont    := 1
    local cTitulo  := 'Programa para Recber 5 valores e informar o maior e o menor'

    For nCont := 1 TO 5
        cEntrada := ''
        cEntrada := FwInputBox('Informe um valor de 1 a 12: ', cEntrada)
        AADD(aValores, VAL(cEntrada))
        cValores += cEntrada + ' '
    next

    nMaior := aValores[1]
    nMenor := aValores[1]

    For nCont := 1 TO 5
        if aValores[nCont] > nMaior
            nMaior := aValores[nCont]
        endif

        if aValores[nCont] < nMenor
            nMenor := aValores[nCont]
        endif
    next

    FwAlertInfo('Os Valores Informados: ' + cValores + CRLF + 'O Menor Valor Informado: ' + CVALTOCHAR(nMenor) + CRLF + 'O Maior Valor Informado: ' + CVALTOCHAR(nMaior), cTitulo)

RETURN
