#INCLUDE 'TOTVS.CH'

User Function L5Ex01()
    local aSemana  := {'Domingo','Segunda-Feira','Terça-Feira','Quarta-Feira','Quinta-Feira','Sexta-Feira','Sábado'}
    local aDigitos := {'1','2','3','4','5','6','7'}
    local cEscolha := ''
    local nEscolha := 0
    local oDlg     := NIL
    local cTitulo  := 'Dia da Semana'
    local nLinJan  := 180
    local nColJan  := 300
    local lValido  := .T.
    local nOpcao   := 0
    local nCont    := 0

    while lValido
        DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO nLinJan,nColJan PIXEL
        @ 020,040 SAY 'Informe um dos valores' SIZE 80,10 OF oDlg PIXEL
        @ 040,035 MSCOMBOBOX oCombo VAR cEscolha ITEMS aDigitos SIZE 80,10 OF oDlg PIXEL
        @ 060,040 BUTTON 'Confirmar' SIZE 030,011 OF oDlg ACTION (nOpcao := 1,oDlg:END()) PIXEL 
        DEFINE SBUTTON FROM 060,075 TYPE 2 ACTION (nOpcao := 2, oDlg:End()) ENABLE OF oDlg

        if nCont > 0
            @ 085,035 SAY ('O dia Informado Corresponde a ' + aSemana[nEscolha]) SIZE 80,30 OF oDlg PIXEL
        endif

        ACTIVATE MSDIALOG oDlg CENTERED

        if nOpcao == 2
            lValido := .F.
        else
            nCont++
            nEscolha := VAL(cEscolha)
            nLinJan  := 230
        endif

    enddo

Return 
