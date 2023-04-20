#INCLUDE 'TOTVS.CH'


USER FUNCTION L2Ex15()
    local nI        := 1
    local cEntrada  := ''
    local nQtd      := 0
    local nProximo  := 0
    local aValores  := {1,1}
    local cValores  := ''
    local cTitulo   := 'Programa para Imprimir os N primeiros n�meros da Sequencia de Fibonacci'

    while VAL(cEntrada) < 1
        cEntrada   := FwInputBox('Informe a quantidade de n�meros a buscar: ', cEntrada)
        nQtd       := VAL(cEntrada)
    enddo

    for nI := 3 TO nQtd
        nProximo := aValores[nI-1] + aValores[nI-2]
        AADD(aValores, nProximo)
    next

    for nI := 1 to nQtd
        if nI < nQtd
            cValores += CVALTOCHAR(aValores[nI]) + ', '
        else
            cValores += CVALTOCHAR(aValores[nI])
        endif
    next

    FwAlertInfo('Os valores da sequencia de Fibonacci at� a posi��o' + CVALTOCHAR(nQtd) + ' s�o: ' + cValores , cTitulo)


RETURN
