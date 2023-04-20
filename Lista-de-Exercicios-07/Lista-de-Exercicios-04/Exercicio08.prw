#INCLUDE 'TOTVS.CH'

User Function L7Ex08()
    local oDlg       := NIL
    local lValido    := .T.
    local nCont      := 0
    local nAltura    := 0
    local nPeso      := 0
    local nOpcao     := 0
    local nLinJan    := 250
    local nColJan    := 300
    local cTitulo    := 'Janela de Calculo de IMC'

    while lValido
        DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO nLinJan,nColJan PIXEL
        //Entrada de Dados de Peso e Altura
        @ 015,060 SAY 'ALTURA: '    SIZE 60,20 OF oDlg PIXEL
        @ 025,050 MSGET nAltura     SIZE 50,10 OF oDlg PIXEL PICTURE '@R 9.99 M'
        @ 045,060 SAY 'PESO:'       SIZE 60,20 OF oDlg PIXEL
        @ 055,050 MSGET nPeso       SIZE 50,10 OF oDlg PIXEL PICTURE '@R 999.99 Kg'

        //Botões de Confirmação
        @ 075,045 BUTTON 'Calcular' SIZE 030,011 OF oDlg ACTION (nOpcao := 1,oDlg:END()) PIXEL 
        DEFINE SBUTTON FROM 075,080 TYPE 2 ACTION (nOpcao := 2, oDlg:End()) ENABLE OF oDlg

        if nCont > 0 //Verifica se é a primeira execução
            @ 090,030 SAY cMsg SIZE 100,40 OF oDlg PIXEL COLOR CLR_RED
        endif

        ACTIVATE MSDIALOG oDlg CENTERED

        if nOpcao == 1
            cMsg := CalcImc(nPeso,nAltura)
            nCont++
        else
            lValido := .F.
        endif

    enddo

Return 

STATIC FUNCTION CalcImc(nPeso,nAltura)
    local nIMC

    nIMC := nPeso / (nAltura^2)

    if nIMC < 18.5
        cMsg := 'Magreza - Obesidade (Grau): 0'
    elseif nIMC < 24.9
        cMsg := 'Normal - Obesidade (Grau): 0'
    elseif nIMC < 29.9
        cMsg := 'SobrePeso - Obesidade (Grau): I'
    elseif nIMC < 39.9
        cMsg := 'Obesidade - Obesidade (Grau): II'
    else
        cMsg := 'Obesidade Grave - Obesidade (Grau): III'
    endif

Return cMsg
