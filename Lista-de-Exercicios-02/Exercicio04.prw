#INCLUDE 'TOTVS.CH'

USER FUNCTION L2Ex04()
    local cEntrada      := ''
    local nA            := 0
    local nB            := 0
    local nResultado    := 0
    local cTitulo       := 'Programa para Calcular o Quadrado da Diferença de Dois Valores'

    cEntrada   := FwInputBox('Informe o Primeiro Valor: ', cEntrada)
    nA         := VAL(cEntrada)

    cEntrada   := ''
    cEntrada   := FwInputBox('Informe o Segundo Valor: ', cEntrada)
    nB         := VAL(cEntrada)

    nResultado := ( nA - nB )^2
    
    FwAlertInfo('Resultado da Equação: ' + CRLF + '( ' + CVALTOCHAR(nA) + ' - ' + CVALTOCHAR(nB) + ' ) ^ 2 = ' + CVALTOCHAR(nResultado), cTitulo)

RETURN
