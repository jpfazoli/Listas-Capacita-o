#INCLUDE 'TOTVS.CH'

User Function L5Ex02()
    local aValores  := {}
    local cEntrada  := 0
    local nCont     := 0
    local cMsg      := ''
    local cValores  := ''

    for nCont := 1 TO 10
        cEntrada := FwInputBox('Informe os valores para Armazenar: ','')
        AADD(aValores, cEntrada)
        if nCont < 10
            cValores += aValores[nCont]  + ', '
        else
            cValores += aValores[nCont]
        endif
    next

    for nCont := LEN(aValores) TO 1 STEP -1
        if nCont > 1
            cMsg += aValores[nCont] + ', '
        else
            cMsg += aValores[nCont]
        endif
    next
    
    FwAlertSuccess('Os valores que foram Informados: ' + cValores + CRLF + 'Os valores Invertidos: ' + cMsg, 'Programa Inverte Apresentação')

Return 
