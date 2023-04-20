#INCLUDE 'TOTVS.CH'


User Function L7Ex03()
    local aDados    := {}
    local nSalario  := 0
    local nReajuste := 0
    local nConfirma := 0
    local nSlFinal  := 0

    aDados    := TelaDados() //Recebe o Retorno da Função TelaDados
    nSalario  := aDados[1]
    nReajuste := aDados[2]
    nConfirma := aDados[3]
    
    nSlFinal := nSalario + (nSalario * (nReajuste / 100))

    if nConfirma == 1 //Verifica se a Operação foi cancelada
        FWAlertSuccess('Sálario Informado: R$'  + Alltrim(Str(nSalario,,2))        + CRLF;
                       +'Reajuste: '            + Alltrim(Str(nReajuste,,2)) + '%' + CRLF;
                       +'Sálario Final: R$'     + Alltrim(Str(nSlFinal,,2)),       'Janela de Reajuste de Salário')
    endif
Return 

STATIC FUNCTION TelaDados()
    local oDlg      := NIL
    local nSalario  := 0
    local nReajuste := 0
    local nConfirma := 0
    local cTitulo   := 'Janela de Reajuste de Salário'

    DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 180,300 PIXEL
    //Entradas de Dados
    @ 020,030 SAY 'Informe o Salário: '  SIZE 50,20 OF oDlg PIXEL
    @ 017,080 MSGET nSalario             SIZE 50,10 OF oDlg PIXEL PICTURE '@R R$ 999,999.99'
    @ 040,030 SAY 'Informe o Reajuste: ' SIZE 50,20 OF oDlg PIXEL
    @ 037,080 MSGET nReajuste            SIZE 50,10 OF oDlg PIXEL PICTURE '@R 99.9%'

    //Botões de Resposta
    @ 060,040 BUTTON 'Reajustar' SIZE 030,011 OF oDlg ACTION (nConfirma := 1, oDlg:End()) PIXEL 
    DEFINE SBUTTON FROM 060,080 TYPE 2 ACTION (nConfirma := 2, oDlg:End()) ENABLE OF oDlg

    ACTIVATE MSDIALOG oDlg CENTERED

Return {nSalario,nReajuste,nConfirma}
