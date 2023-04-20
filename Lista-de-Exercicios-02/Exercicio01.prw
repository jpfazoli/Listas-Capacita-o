#INCLUDE 'TOTVS.CH'


USER FUNCTION L2Exerc01()
    local cEntrada      := ''
    local aValores      := {}
    local nCont         := 1
    local cTitulo       := 'Programa para Operação de Soma, Subtração, produto e quociente de 2 valores'
    
    for nCont := 1 TO 2
        cEntrada := ''
        while VAL(cEntrada) <= 0
            cEntrada := FwInputBox('Informe o ' + CVALTOCHAR(nCont) + '° Número: ', cEntrada)
            if VAL(cEntrada) > 0
                AADD(aValores, VAL(cEntrada))
            endif
        enddo
    next

    
    FwAlertInfo('Resultado das Operações: ' + CRLF + CVALTOCHAR(aValores[1]) + ' + ' + CVALTOCHAR(aValores[2]) + ' = ' + CVALTOCHAR(aValores[1] + aValores[2]) + CRLF +;
    CVALTOCHAR(aValores[1]) + ' - ' + CVALTOCHAR(aValores[2]) + ' = ' + CVALTOCHAR(aValores[1] - aValores[2]) + CRLF +;
    CVALTOCHAR(aValores[1]) + ' * ' + CVALTOCHAR(aValores[2]) + ' = ' + CVALTOCHAR(aValores[1] * aValores[2]) + CRLF +;
    CVALTOCHAR(aValores[1]) + ' / ' + CVALTOCHAR(aValores[2]) + ' = ' + CVALTOCHAR(aValores[1] / aValores[2]) + CRLF, cTitulo)

RETURN
