#INCLUDE 'TOTVS.CH'

#DEFINE NCONSUMO_TINTA 2

User Function L7Ex04()
    local aDados    := {}
    local aCalculo  := {}
    local nLargura  := 0
    local nAltura   := 0
    local nArea     := 0
    local nTinta    := 0
    local nConfirma := 0
    PRIVATE cTitulo   := 'Janela de Calculo de Área e Uso de Tinta para Pintar uma Parede'

    aDados    := TelaDados()//Recebe os dados da Tela de Entrada
    nLargura  := aDados[1]
    nAltura   := aDados[2]
    nConfirma := aDados[3]

    aCalculo  := CalcConsumo(nLargura,nAltura)//Recebe os dados do Calculo de Consumo
    nArea     := aCalculo[1]
    nTinta    := aCalculo[2]

    if nConfirma == 1//Verifica se a Operação não foi cancelada
        FWAlertSuccess( 'Largura da Parede: '     + CVALTOCHAR(nLargura) + ' m'  + CRLF;
                       +'Altura da Parede: '     + CVALTOCHAR(nAltura)   + ' m'  + CRLF;
                       +'Área Total da Parede: ' + CVALTOCHAR(nArea)     + ' m2' + CRLF;
                       +'Consumo de Tinta: '     + CVALTOCHAR(nTinta)    + ' L',   cTitulo)
    endif
Return 

STATIC FUNCTION TelaDados()
    local oDlg      := NIL
    local nLargura  := 0
    local nAltura   := 0
    local nConfirma   := 0

    DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 180,300 PIXEL
    //Entrada de Dados 
    @ 020,030 SAY 'Informe a Largura da Parede: ' SIZE 50,20 OF oDlg PIXEL
    @ 020,080 MSGET nLargura                      SIZE 50,10 OF oDlg PIXEL PICTURE '@R 999,999.99 m'
    @ 040,030 SAY 'Informe a Altura da Parede: '  SIZE 50,20 OF oDlg PIXEL
    @ 040,080 MSGET nAltura                       SIZE 50,10 OF oDlg PIXEL PICTURE '@R 999,999.99 m'

    //Botões de Cacular e Confirmar
    @ 060,045 BUTTON 'Calcular' SIZE 030,011 OF oDlg ACTION (nConfirma := 1, oDlg:End()) PIXEL 
    DEFINE SBUTTON FROM 060,085 TYPE 2 ACTION (nConfirma := 2, oDlg:End()) ENABLE OF oDlg

    ACTIVATE MSDIALOG oDlg CENTERED

Return {nLargura,nAltura,nConfirma}


STATIC FUNCTION CalcConsumo(nLargura, nAltura)
    local nArea     := 0
    local nTinta    := 0

    nArea   := nLargura * nAltura
    nTinta  := nArea / NCONSUMO_TINTA

Return {nArea,nTinta}
