#INCLUDE 'TOTVS.CH'


USER FUNCTION L2Ex12()
    local nI       := 1
    local cValores := ''
    local cTitulo  := 'Programa para Imprimir todos os Multiplos de 3 entre 1 e 100'

    for nI := 1 TO 100
        if nI % 3 == 0
            if nI < 100
                cValores += CVALTOCHAR(nI) + ', '
            else
                cValores += CVALTOCHAR(nI)
            endif
        endif
    next


    FwAlertInfo('Os Valores Multiplos de 3 entre 1 e 100: ' + cValores , cTitulo)

RETURN
