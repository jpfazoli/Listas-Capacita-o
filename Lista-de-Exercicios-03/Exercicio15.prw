#INCLUDE 'TOTVS.CH'

USER FUNCTION L3Ex15()
    local aTemp    := {}
    local nEntrada := 0
    local nCont    := 1
    local nSoma    := 0
    local nMedia   := 0
    local cMsg     := ''

    for nCont := 1 TO 12
        nEntrada :=  VAL(FwInputBox('Informe a Temperatura do Mes de ' + MesExtenso(nCont) + ': ', ''))
        AADD(aTemp, nEntrada)
        nSoma    += nEntrada
    Next

    nMedia := nSoma / 12

    for nCont := 1 TO 12
        if aTemp[nCont] > nMedia
            cMsg += MesExtenso(nCont) + ': ' + CVALTOCHAR(aTemp[nCont]) + ' Graus' + CRLF
        endif
    next

    FwAlertInfo('A M�dia Anual de Temperatura: ' + CVALTOCHAR(nMedia) + '�C'+ CRLF + 'Meses com temperatura acima da M�dia: ' + CRLF + cMsg, 'Programa para Calcular a M�dia Anual da Temperatura')

RETURN
