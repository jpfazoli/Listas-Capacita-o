#INCLUDE 'TOTVS.CH'

User Function L4Ex09()
    local oDlg      := NIL
    local cCond     := 0
    local aValores  := {'1=Homem','2=Mulher'}
    local lValido   := .T.
    local nCont     := 0
    local nAltura   := 0
    local nPeso     := 0
    local nIdade     := 0
    local nTMB      := 0
    local nLinJan   := 350
    local nColJan   := 300
    local cTitulo   := 'Janela de Calculo de IMC'

    while lValido
        DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO nLinJan,nColJan PIXEL
        @ 015,060 SAY 'ALTURA: ' SIZE 60,20 OF oDlg PIXEL
        @ 025,045 MSGET nAltura SIZE 50,10 OF oDlg PIXEL PICTURE '@R 9.99 M'
        @ 045,060 SAY 'PESO:' SIZE 60,20 OF oDlg PIXEL
        @ 055,045 MSGET nPeso SIZE 50,10 OF oDlg PIXEL PICTURE '@R 999.99 Kg'
        @ 075,060 SAY 'IDADE:' SIZE 60,20 OF oDlg PIXEL
        @ 085,045 MSGET nIdade SIZE 50,10 OF oDlg PIXEL PICTURE '@R 999 Anos'
        @ 105,040 MSCOMBOBOX oCombo VAR cCond ITEMS aValores SIZE 60,15 OF oDlg PIXEL 
        @ 125,045 BUTTON 'Calcular' SIZE 030,011 OF oDlg ACTION (nOpcao := 1,oDlg:END()) PIXEL 
        DEFINE SBUTTON FROM 125,080 TYPE 2 ACTION (nOpcao := 2, oDlg:End()) ENABLE OF oDlg

        if nCont > 0
            @ 145,030 SAY cMsg SIZE 100,40 OF oDlg PIXEL COLOR CLR_RED
        endif

        ACTIVATE MSDIALOG oDlg CENTERED

        if nOpcao == 1
            if cCond == '1'
                nTMB := 66.5 + (13.75 * nPeso) + (5.003 * (nAltura * 100) - (6.75 * nIdade))
                cMsg := 'Taxa Metabólica Basal = ' + CVALTOCHAR(nTMB)
            else
                nTMB := 655.1 + (9.563 * nPeso) + (1.85 * (nAltura * 100) - (4.676 * nIdade))
                cMsg := 'Taxa Metabólica Basal = ' + CVALTOCHAR(nTMB)
            endif
            nCont++

        else
            lValido := .F.

        endif

    enddo

Return 
