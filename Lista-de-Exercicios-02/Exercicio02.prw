#INCLUDE 'TOTVS.CH'
 
#DEFINE nConsumoLKm 12


USER FUNCTION L2Ex02()
    local cEntrada      := ''
    local nTempo        := 0
    local nVelocidade   := 0
    local nDistancia    := 0
    local nCombustivel  := 0
    local cTitulo       := 'Programa para Calculo de Gasto de Combustível'


    while VAL(cEntrada) <= 0
        cEntrada := FwInputBox('Informe o Tempo de Viagem: ', cEntrada)
        if VAL(cEntrada) > 0
            nTempo := VAL(cEntrada)
        endif
    enddo

    cEntrada      := ''
    while VAL(cEntrada) <= 0
        cEntrada := FwInputBox('Informe a Velocidade Média da Viagem: ', cEntrada)
        if VAL(cEntrada) > 0
            nVelocidade := VAL(cEntrada)
        endif
    enddo

    nDistancia   := nTempo * nVelocidade
    nCombustivel := nDistancia / nConsumoLKm
    
    FwAlertInfo('Velocidade Média: ' + CVALTOCHAR(nVelocidade) + CRLF +;
    'Tempo de Viagem: ' + CVALTOCHAR(nTempo) + CRLF +;
    'Distância Percorrida: ' + CVALTOCHAR(nDistancia) + CRLF +;
    'Quantidade de Litros utilizado na Viagem: ' + CVALTOCHAR(nCombustivel), cTitulo)

RETURN
