#INCLUDE 'TOTVS.CH'

USER FUNCTION L3Ex19()
    local cFrase     := ''
    local nEspaco    := 0
    local aVogais    := {0,0,0,0,0}
    local nCont      := 0

    cFrase := FwInputBox('Informe uma Frase: ', cFrase)

    For nCont := 1 to  LEN(cFrase)
        if UPPER(SubStr(cFrase, nCont, 1)) == ' '
            nEspaco++
        endif
        if UPPER(SubStr(cFrase, nCont, 1)) == 'A'
            aVogais[1]++
        elseif UPPER(SubStr(cFrase, nCont, 1)) == 'E'
            aVogais[2]++
        elseif UPPER(SubStr(cFrase, nCont, 1)) == 'I'
            aVogais[3]++
        elseif UPPER(SubStr(cFrase, nCont, 1)) == 'O'
            aVogais[4]++
        elseif UPPER(SubStr(cFrase, nCont, 1)) == 'U'
            aVogais[5]++
        endif
    next

    FwAlertInfo('Sua Frase: ' + cFrase + CRLF + 'Quantidade de Espaços: ' + CVALTOCHAR(nEspaco) + CRLF + 'Quantidade de Vogais: '+ CRLF + 'A: '+ cValtochar(aVogais[1]) + ', E:';
     + cValtochar(aVogais[2]) + ', I:' + cValtochar(aVogais[3]) + ', O:' + cValtochar(aVogais[4]) + ', U:'+ cValtochar(aVogais[5]), 'Programa para Calcular a Média Anual da Temperatura')

RETURN
