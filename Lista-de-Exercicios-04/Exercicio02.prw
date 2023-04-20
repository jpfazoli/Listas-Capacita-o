#INCLUDE 'TOTVS.CH'


User Function L4Ex02()
    local oDlg     := NIL
    local nCotacao := 0
    local nDolar   := 0
    local nReal    := 0
    local cTitulo := 'Janela de Conversão de Dólar para Real'

    DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 170,300 PIXEL
    @ 020,030 SAY 'Quantidade de Dólar: ' SIZE 50,20 OF oDlg PIXEL
    @ 020,070 MSGET nCotacao SIZE 50,10 OF oDlg PIXEL PICTURE '@E R$ 999.99'
    @ 040,030 SAY 'Cotação Atual do Dólar: ' SIZE 40,20 OF oDlg PIXEL
    @ 040,070 MSGET nDolar SIZE 50,10 OF oDlg PIXEL PICTURE '@E R$ 999,999,999.99'
    @ 060,040 BUTTON 'Converter' SIZE 030,011 OF oDlg ACTION (nOpcao := 1, oDlg:End()) PIXEL 
    DEFINE SBUTTON FROM 060,080 TYPE 2 ACTION (nOpcao := 2, oDlg:End()) ENABLE OF oDlg

    ACTIVATE MSDIALOG oDlg CENTERED

    nReal := nDolar * nCotacao

    if nOpcao == 1
        FWAlertSuccess('Cotação do Dólar: ' + CVALTOCHAR(nCotacao) + CRLF;
                       +'Dólar: ' + CVALTOCHAR(nDolar) + CRLF;
                       +'Real: ' + CVALTOCHAR(nReal), 'Janela de Conversão de Dólar para Real')
    endif
Return 
