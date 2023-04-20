#INCLUDE 'TOTVS.CH'
  
USER FUNCTION L2Ex03()
    local cEntrada      := ''
    local nTempo        := 0
    local nVelocidade   := 0
    local nDistancia    := 0
    local nCombustivel  := 0
    local cTitulo       := 'Programa para Calculo de Gasto de Combust�vel'


    while VAL(cEntrada) <= 0
        cEntrada := FwInputBox('Informe o Tempo de Viagem (Hora): ', cEntrada)
        if VAL(cEntrada) > 0
            nTempo := VAL(cEntrada)
        endif
    enddo

    cEntrada      := ''
    while VAL(cEntrada) <= 0
        cEntrada := FwInputBox('Informe a Velocidade M�dia da Viagem (Km/h): ', cEntrada)
        if VAL(cEntrada) > 0
            nVelocidade := VAL(cEntrada)
        endif
    enddo

    cEntrada      := ''
    while VAL(cEntrada) <= 0
        cEntrada := FwInputBox('Informe o Consumo de Combust�vel por Km do Veiculo(Km/L): ', cEntrada)
        if VAL(cEntrada) > 0
            nConsumoLKm := VAL(cEntrada)
        endif
    enddo

    nDistancia   := nTempo * nVelocidade
    nCombustivel := nDistancia / nConsumoLKm
    
    FwAlertInfo('Velocidade M�dia: ' + CVALTOCHAR(nVelocidade) + ' Km/h' + CRLF +;
    'Tempo de Viagem: ' + CVALTOCHAR(nTempo) + ' h' + CRLF +;
    'Dist�ncia Percorrida: ' + CVALTOCHAR(nDistancia) + ' Km' + CRLF +;
    'Consumo de Combust�vel por Km: ' + CVALTOCHAR(nDistancia) + ' Km/L' + CRLF +;
    'Quantidade de Litros utilizado na Viagem: ' + CVALTOCHAR(nCombustivel) + ' L', cTitulo)

RETURN
