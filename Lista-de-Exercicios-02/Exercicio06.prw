#INCLUDE 'TOTVS.CH'


USER FUNCTION L2Ex06()
    local cEntrada := ''
    local aValores := {}
    local cDiv2    := ''
    local cDiv3    := ''
    local cDiv2e3  := ''
    local cValores := ''
    local nCont    := 0
    local cTitulo  := 'Programa para Ler 4 Valores e Informar os Divisiveis por 2 e 3'

    for nCont := 1 TO 4
        cEntrada   := ''
        cEntrada   := FwInputBox('Informe o '+ CVALTOCHAR(nCont) + '° Valor: ', cEntrada)
        AADD(aValores, VAL(cEntrada))
        cValores += cEntrada + ' '
        if aValores[nCont] % 2 == 0
            cDiv2 += cEntrada + ' '
        endif
        if aValores[nCont] % 3 == 0
            cDiv3 += cEntrada + ' '
        endif
        if (aValores[nCont] % 2 == 0) .AND. (aValores[nCont] % 3 == 0)
            cDiv2e3 += cEntrada + ' '
        endif
    next


    FwAlertInfo('Valores Informados: ' + cValores + CRLF + 'Os valores Dívisiveis por 2: ' + cDiv2 + CRLF+ 'Os valores Dívisiveis por 3: ' + cDiv3 + CRLF+ 'Os valores Dívisiveis por 2 e 3: ' + cDiv2e3 , cTitulo)

RETURN
