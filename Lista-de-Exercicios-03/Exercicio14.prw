#INCLUDE 'TOTVS.CH'

USER FUNCTION L3Ex14()
    local aValores := {}
    local nEntrada := 0
    local nCont    := 1
    local cMsg     := ''

    for nCont := 1 TO 5
        nEntrada :=  VAL(FwInputBox('Informe valores para armazenar: ', ''))
        AADD(aValores, nEntrada)
    Next

    For nCont := 1 TO 5
        if nCont < 5
            cMsg += CVALTOCHAR(aValores[nCont]) + ', '
        else
            cMsg += CVALTOCHAR(aValores[nCont])
        endif
    Next

    FwAlertInfo('Os valores informados no Array: ' + cMsg, 'Programa para Imprimir os valores de um Array')

RETURN
