#INCLUDE 'TOTVS.CH'


USER FUNCTION L2Ex11B()
    local nI       := 1
    local cValores := ''
    local cTitulo  := 'Programa para Gerar 50 valores aleatorios entre 10 e 99 com While'

    while nI <= 50
        if nI < 50
            cValores += CVALTOCHAR(RANDOMIZE( 10, 99 )) + ', '
        else
            cValores += CVALTOCHAR(RANDOMIZE( 10, 99 ))
        endif
        nI++
    enddo


    FwAlertInfo('Os Valores Gerados foram: ' + cValores , cTitulo)

RETURN
