#INCLUDE 'TOTVS.CH'


USER FUNCTION L2Ex05()
    local cEntrada := ''
    local nDolar   := 0
    local nCotacao := 0
    local nReal    := 0
    local cTitulo  := 'Programa para Convers�o de D�lar para Real'

    cEntrada   := FwInputBox('Informe a Quantidade em Dolar: ', cEntrada)
    nDolar     := VAL(cEntrada)

    cEntrada   := ''
    cEntrada   := FwInputBox('Informe a Cota��o atual do Dolar: ', cEntrada)
    nCotacao   := VAL(cEntrada)

    nReal := nDolar * nCotacao
    
    FwAlertInfo('Valor em D�lar: U$' + CVALTOCHAR(nDolar) + CRLF + 'Cota��o atual do D�lar: ' + CVALTOCHAR(nCotacao) + CRLF+ 'Valor Convertido em Real: R$' + CVALTOCHAR(nReal) , cTitulo)

RETURN
