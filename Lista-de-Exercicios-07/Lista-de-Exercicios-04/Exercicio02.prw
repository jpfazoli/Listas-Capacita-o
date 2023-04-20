#INCLUDE 'TOTVS.CH'


User Function L7Ex02()
    local aEntrada  := {}
    local nCotacao  := 0
    local nDolar    := 0
    local nReal     := 0
    local nCancelar := 0

    aEntrada := JanRecebe() //Recebe os valores da Função de Entrada
    nCotacao := aEntrada[1]
    nDolar   := aEntrada[2]

    nReal    := nDolar * nCotacao //Calculo da Conversão do Dólar

    if nCancelar == 1 //Verifica se a Operação não foi cancelada
        FWAlertSuccess( 'Cotação do Dólar: ' + CVALTOCHAR(nCotacao) + CRLF;
                       +'Dólar:.U$'          + CVALTOCHAR(nDolar)   + CRLF;
                       +'Real:..R$'          + CVALTOCHAR(nReal),   'Janela de Conversão de Dólar para Real')
    endif
Return 

Static Function JanRecebe()
    local oDlg        := NIL
    local aValores    := {}
    local nCotacao    := 0
    local nDolar      := 0
    local nCancelado  := 0
    local cTitulo     := 'Janela de Conversão de Dólar para Real'

    DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 170,300 PIXEL

    @ 020,030 SAY 'Quantidade de Dólar: '    SIZE 50,20 OF oDlg PIXEL
    @ 020,070 MSGET nCotacao                 SIZE 50,10 OF oDlg PIXEL PICTURE '@E R$ 999.99' //Entrada de Dados

    @ 040,030 SAY 'Cotação Atual do Dólar: ' SIZE 40,20 OF oDlg PIXEL
    @ 040,070 MSGET nDolar                   SIZE 50,10 OF oDlg PIXEL PICTURE '@E R$ 999,999,999.99'

    @ 060,040 BUTTON 'Converter' SIZE 030,011 OF oDlg ACTION (nCancelado := 1, oDlg:End()) PIXEL 
    DEFINE SBUTTON FROM 060,080 TYPE 2 ACTION (nCancelado := 2, oDlg:End()) ENABLE OF oDlg

    ACTIVATE MSDIALOG oDlg CENTERED

    AADD(aValores, nCotacao)
    AADD(aValores, nDolar)
    AADD(aValores, nCancelado)

return aValores
