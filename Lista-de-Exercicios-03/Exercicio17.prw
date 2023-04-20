#INCLUDE 'TOTVS.CH'

USER FUNCTION L3Ex17()
    local cNome     := ''
    local cVertical := ''
    local nCont     := 0

    cNome := FwInputBox('Informe seu Nome: ', cNome)

    For nCont := 1 to  LEN(cNome)
        cVertical += UPPER(SubStr(cNome, nCont, 1)) + CRLF
    next

    FwAlertInfo('Seu Nome: ' + cNome + CRLF + 'O Nome na Vertical: ' + CRLF + cVertical, 'Programa para Calcular a Média Anual da Temperatura')

RETURN
