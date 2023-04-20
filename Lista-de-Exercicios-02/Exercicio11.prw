#INCLUDE 'TOTVS.CH'


USER FUNCTION L2Ex11A()
    local nI       := 1
    local cValores := ''
    local cTitulo  := 'Programa para Gerar 50 valores aleatorios entre 10 e 99 com For'

    For nI := 1 TO 50
        if nI < 50
            cValores += CVALTOCHAR(RANDOMIZE( 10, 99 )) + ', '
        else
            cValores += CVALTOCHAR(RANDOMIZE( 10, 99 ))
        endif
    next


    FwAlertInfo('Os Valores Gerados foram: ' + cValores , cTitulo)

RETURN
