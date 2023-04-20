#INCLUDE 'TOTVS.CH'


User Function L4Ex03()
    local oDlg      := NIL
    local nSalario  := 0
    local nReajuste := 0
    local nSlFinal  := 0
    local cTitulo   := 'Janela de Reajuste de Salário'

    DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 180,300 PIXEL
    @ 020,030 SAY 'Informe o Salário: ' SIZE 50,20 OF oDlg PIXEL
    @ 017,080 MSGET nSalario SIZE 50,10 OF oDlg PIXEL PICTURE '@R R$ 999,999.99'
    @ 040,030 SAY 'Informe o Reajuste: ' SIZE 50,20 OF oDlg PIXEL
    @ 037,080 MSGET nReajuste SIZE 50,10 OF oDlg PIXEL PICTURE '@R 99.9%'
    @ 060,040 BUTTON 'Reajustar' SIZE 030,011 OF oDlg ACTION (nOpcao := 1, oDlg:End()) PIXEL 
    DEFINE SBUTTON FROM 060,080 TYPE 2 ACTION (nOpcao := 2, oDlg:End()) ENABLE OF oDlg

    ACTIVATE MSDIALOG oDlg CENTERED

    nSlFinal := nSalario + (nSalario * (nReajuste / 100))

    if nOpcao == 1
        FWAlertSuccess('Sálario Informado: R$' + Alltrim(Str(nSalario,,2)) + CRLF;
                       +'Reajuste: ' + Alltrim(Str(nReajuste,,2)) + '%' + CRLF;
                       +'Sálario Final: R$' + Alltrim(Str(nSlFinal,,2)), 'Janela de Reajuste de Salário')
    endif
Return 
