#INCLUDE 'TOTVS.CH'


USER FUNCTION L2Ex14()
    local nI        := 1
    local cEntrada  := ''
    local nQtd      := 0
    local cControle := ''
    local cValores  := ''
    local cTitulo   := 'Programa para Imprimir os N primeiros n�meros Pares ou Impares'

    cEntrada   := FwInputBox('Informe a quantidade de n�meros a buscar: ', cEntrada)
    nQtd       := VAL(cEntrada)
    cControle  := FwInputBox('Informe se deseja valores pares ou Impares (Par/Impar): ', cControle)
    cControle  := UPPER(cControle) 

    if cControle == 'PAR'
        for nI := 1 to nQtd
            cSoma += (nI-1) * 2 
            if nI < nQtd
                cValores += CVALTOCHAR((nI-1) * 2) + ', '
            else
                cValores += CVALTOCHAR((nI-1) * 2)
            endif
        next
        FwAlertInfo('Os ' + CVALTOCHAR(nQtd) + '� Primeiros N�meros Naturais Pares s�o: ' + cValores , cTitulo)
    elseif cControle == 'IMPAR'
        for nI := 1 to nQtd
            cSoma += (nI - 1) * 2
            if nI < nQtd
                cValores += CVALTOCHAR(1 + ((nI - 1) * 2)) + ', '
            else
                cValores += CVALTOCHAR(nI * 3)
            endif
        next
        FwAlertInfo('Os ' + CVALTOCHAR(nQtd) + '� Primeiros N�meros Naturais �mpares s�o: ' + cValores , cTitulo)
    endif

    

RETURN
