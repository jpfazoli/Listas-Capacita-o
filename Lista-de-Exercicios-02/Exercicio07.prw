#INCLUDE 'TOTVS.CH'

USER FUNCTION L2Ex07()
    local cEntrada := ''
    local nHrIni   := 0
    local nHrFim   := 0
    local nDuracao := 0
    local cTitulo  := 'Programa para Calculo da Dura��o de uma Partida de Poker'

    cEntrada   := ''
    cEntrada   := FwInputBox('Informe o Hor�rio de Inicio do Jogo: ', cEntrada)
    nHrIni     := VAL(cEntrada)
    cEntrada   := ''
    cEntrada   := FwInputBox('Informe o Hor�rio de Fim do Jogo: ', cEntrada)
    nHrFim     := VAL(cEntrada)

    if nHrFim > nHrIni
        nDuracao := nHrFim - nHrIni 
    elseif nHrIni > nHrFim
        nDuracao := 24 - (nHrIni - nHrFim)
    elseif nHrIni == nHrFim
        nDuracao := 0
    endif

    FwAlertInfo('Hor�rio de Inicio: ' + CVALTOCHAR(nHrIni) + ':00' + CRLF + 'Hor�rio de Fim: ' + CVALTOCHAR(nHrFim) + ':00' + CRLF + 'Dura��o do Jogo: ' + CVALTOCHAR(nDuracao) + ' horas' , cTitulo)

RETURN
