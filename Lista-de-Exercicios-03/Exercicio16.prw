#INCLUDE 'TOTVS.CH'

USER FUNCTION L3Ex16()
    local cNome    := ''
    local cInverso := ''
    local nCont    := 0

    cNome := FwInputBox('Informe seu Nome: ', cNome)

    For nCont := LEN(cNome) to 1 step -1
        cInverso += UPPER(SubStr(cNome, nCont, 1))
    next

    FwAlertInfo('Seu Nome: ' + cNome + CRLF + 'O Nome Invertido: ' + cInverso, 'Programa para Calcular a Média Anual da Temperatura')

RETURN
