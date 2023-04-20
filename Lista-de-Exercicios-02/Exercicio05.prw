#INCLUDE 'TOTVS.CH'


USER FUNCTION L2Ex05()
    local cEntrada := ''
    local nDolar   := 0
    local nCotacao := 0
    local nReal    := 0
    local cTitulo  := 'Programa para Conversão de Dólar para Real'

    cEntrada   := FwInputBox('Informe a Quantidade em Dolar: ', cEntrada)
    nDolar     := VAL(cEntrada)

    cEntrada   := ''
    cEntrada   := FwInputBox('Informe a Cotação atual do Dolar: ', cEntrada)
    nCotacao   := VAL(cEntrada)

    nReal := nDolar * nCotacao
    
    FwAlertInfo('Valor em Dólar: U$' + CVALTOCHAR(nDolar) + CRLF + 'Cotação atual do Dólar: ' + CVALTOCHAR(nCotacao) + CRLF+ 'Valor Convertido em Real: R$' + CVALTOCHAR(nReal) , cTitulo)

RETURN
