#INCLUDE 'TOTVS.CH'


USER FUNCTION L2Ex13()
    local nI        := 1
    local cEntrada  := ''
    local nLimite   := 0
    local nMultiplo := 0
    local cValores  := ''
    local cTitulo   := 'Programa para Imprimir todos os Multiplos de um valor entre 1 e um limite'

    cEntrada  := FwInputBox('Informe o valor Multiplo: ', cEntrada)
    nMultiplo := VAL(cEntrada)
    cEntrada  := ''
    cEntrada  := FwInputBox('Informe um Limite: ', cEntrada)
    nLimite := VAL(cEntrada)

    for nI := 1 TO nLimite
        if nI % nMultiplo == 0
            if nI < nLimite
                cValores += CVALTOCHAR(nI) + ', '
            else
                cValores += CVALTOCHAR(nI)
            endif
        endif
    next


    FwAlertInfo('Os Valores Multiplos de ' + CVALTOCHAR(nMultiplo) + ' entre 1 e ' + CVALTOCHAR(nLimite) + ': ' + cValores , cTitulo)

RETURN
