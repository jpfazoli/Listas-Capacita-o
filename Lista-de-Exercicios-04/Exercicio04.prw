#INCLUDE 'TOTVS.CH'

#DEFINE nConsumo 2

User Function L4Ex04()
    local oDlg      := NIL
    local nLargura  := 0
    local nAltura   := 0
    local nArea     := 0
    local cTitulo   := 'Janela de Calculo de Área e Uso de Tinta para Pintar uma Parede'

    DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 180,300 PIXEL
    @ 020,030 SAY 'Informe a Largura da Parede: ' SIZE 50,20 OF oDlg PIXEL
    @ 020,080 MSGET nLargura SIZE 50,10 OF oDlg PIXEL PICTURE '@R 999,999.99 m'
    @ 040,030 SAY 'Informe a Altura da Parede: ' SIZE 50,20 OF oDlg PIXEL
    @ 040,080 MSGET nAltura SIZE 50,10 OF oDlg PIXEL PICTURE '@R 999,999.99 m'
    @ 060,045 BUTTON 'Calcular' SIZE 030,011 OF oDlg ACTION (nOpcao := 1, oDlg:End()) PIXEL 
    DEFINE SBUTTON FROM 060,085 TYPE 2 ACTION (nOpcao := 2, oDlg:End()) ENABLE OF oDlg

    ACTIVATE MSDIALOG oDlg CENTERED

    nArea := nLargura * nAltura

    nTinta := nArea / nConsumo

    if nOpcao == 1
        FWAlertSuccess('Largura da Parede: ' + CVALTOCHAR(nLargura) + ' m' + CRLF;
                       +'Altura da Parede: ' + CVALTOCHAR(nAltura) + ' m' + CRLF;
                       +'Área Total da Parede: ' + CVALTOCHAR(nArea) + ' m2' + CRLF;
                       +'Consumo de Tinta: ' + CVALTOCHAR(nTinta) + ' L', 'Janela de Conversão de Dólar para Real')
    endif
Return 
