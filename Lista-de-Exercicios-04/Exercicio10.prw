#INCLUDE 'TOTVS.CH'

User Function L4Ex10()
    local oDlg      := NIL
    local lValido   := .T.
    local nHoras    := 0
    local nVlHora   := 0
    local nSlBruto  := 0
    local nSlLiquido:= 0
    local nIR       := 0
    local nINSS     := 0
    local nFGTS     := 0
    local nValorIR  := 0
    local nDesconto := 0
    local nLinJan   := 170
    local nColJan   := 300
    local cTitulo   := 'Janela de Calculo de IMC'

    while lValido
        nHoras    := 0
        nVlHora   := 0
        DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO nLinJan,nColJan PIXEL
        @ 020,020 SAY 'Horas Trabalhadas: ' SIZE 60,20 OF oDlg PIXEL
        @ 017,080 MSGET nHoras SIZE 50,10 OF oDlg PIXEL PICTURE '@R 9999'
        @ 040,020 SAY 'Valor da Hora: ' SIZE 60,20 OF oDlg PIXEL
        @ 037,080 MSGET nVlHora SIZE 50,10 OF oDlg PIXEL PICTURE '@R R$ 999,999.99'
        @ 060,030 BUTTON 'Calcular' SIZE 030,011 OF oDlg ACTION (nOpcao := 1,oDlg:END()) PIXEL 
        DEFINE SBUTTON FROM 060,090 TYPE 2 ACTION (nOpcao := 2, oDlg:End()) ENABLE OF oDlg

        ACTIVATE MSDIALOG oDlg CENTERED

        if nOpcao == 1
            nSlBruto := nHoras * nVlHora
            if nSlBruto < 1200
                nIR := 0
            elseif nSlBruto < 1800
                nIR := 5
            elseif nSlBruto < 2500
                nIR := 10
            else
                nIR := 20
            endif

            nValorIR   := nSlBruto * (nIR/100)
            nINSS      := nSlBruto * 0.1
            nFGTS      := nSlBruto * 0.11
            nDesconto  := nValorIR + nINSS
            nSlLiquido := nSlBruto - nDesconto

            DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 250,350 PIXEL
            @ 010,050 SAY 'FOLHA DE PAGAMENTO' SIZE 100,20 OF oDlg PIXEL
            @ 020,020 SAY ('Salário Bruto (' + Alltrim(Str(nVlHora,,2)) + ' * ' + Alltrim(Str(nHoras,,2)) + '):') SIZE 100,20 OF oDlg PIXEL
            @ 020,120 SAY ('R$ '+ Alltrim(str(nSlBruto,,2))) SIZE 60,20 OF oDlg PIXEL
            @ 030,020 SAY ('( - ) IR (' + Alltrim(Str(nIR,,2)) + ' %):') SIZE 100,20 OF oDlg PIXEL
            @ 030,120 SAY ('R$ '+ Alltrim(str(nValorIR,,2))) SIZE 60,20 OF oDlg PIXEL
            @ 040,020 SAY ('( - ) INSS (10%):') SIZE 100,20 OF oDlg PIXEL
            @ 040,120 SAY ('R$ '+ Alltrim(str(nINSS,,2))) SIZE 60,20 OF oDlg PIXEL
            @ 050,020 SAY ('FGTS (11%):') SIZE 100,20 OF oDlg PIXEL
            @ 050,120 SAY ('R$ '+ Alltrim(str(nFGTS,,2))) SIZE 60,20 OF oDlg PIXEL
            @ 060,020 SAY ('Total de Descontos:') SIZE 100,20 OF oDlg PIXEL
            @ 060,120 SAY ('R$ '+ Alltrim(str(nDesconto,,2))) SIZE 60,20 OF oDlg PIXEL
            @ 070,020 SAY ('Salário Líquido:') SIZE 100,20 OF oDlg PIXEL
            @ 070,120 SAY ('R$ '+ Alltrim(str(nSlLiquido,,2))) SIZE 60,20 OF oDlg PIXEL
            @ 090,043 SAY 'Deseja fazer um Novo Calculo?' SIZE 100,20 OF oDlg PIXEL
            @ 100,045 BUTTON 'Novo' SIZE 030,011 OF oDlg ACTION (nOpcao := 1,oDlg:END()) PIXEL 
            @ 100,085 BUTTON 'Cancelar' SIZE 030,011 OF oDlg ACTION (nOpcao := 2,oDlg:END()) PIXEL 

            ACTIVATE MSDIALOG oDlg CENTERED

            if nOpcao == 2
                lValido := .F.
            endif
        else
            lValido := .F.

        endif

    enddo

Return 
