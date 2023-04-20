#INCLUDE 'TOTVS.CH'

#DEFINE nPrecoKm  0.15
#DEFINE nPrecoDia 60

User Function L4Ex05()
    local oDlg      := NIL
    local nKm       := 0
    local nDias     := 0
    local nCusto    := 0
    local cTitulo   := 'Janela de Calculo de Custo de Aluguel de Carro'

    DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 180,300 PIXEL
    @ 020,020 SAY 'Informe os Km Percorridos: ' SIZE 60,20 OF oDlg PIXEL
    @ 020,080 MSGET nKm SIZE 50,10 OF oDlg PIXEL PICTURE '@R 9,999.99 Km'
    @ 040,020 SAY 'Informe a Quantidade de Dias: ' SIZE 60,20 OF oDlg PIXEL
    @ 040,080 MSGET nDias SIZE 50,10 OF oDlg PIXEL PICTURE '@R 9,999 Dias'
    @ 060,045 BUTTON 'Calcular' SIZE 030,011 OF oDlg ACTION (nOpcao := 1, oDlg:End()) PIXEL 
    DEFINE SBUTTON FROM 060,085 TYPE 2 ACTION (nOpcao := 2, oDlg:End()) ENABLE OF oDlg

    ACTIVATE MSDIALOG oDlg CENTERED

    nCusto := (nPrecoKm * nKm) + (nPrecoDia * nDias)

    if nOpcao == 1
        FWAlertSuccess('Custo por Dia (' + CVALTOCHAR(nDias) + 'Dias x R$' + alltrim(Str(nPrecoDia,,2)) + ')...: R$' + alltrim(Str((nPrecoDia * nDias),,2)) + CRLF;
                       +'Custo por Km (' + CVALTOCHAR(nKm) + 'Km x R$' + alltrim(Str(nPrecoKm,,2)) + ')...: R$' + alltrim(Str((nPrecoKm * nKm),,2)) + CRLF;
                       +'Preco Total...................................: R$ ' + alltrim(Str(nCusto,,2)), cTitulo)
    endif
Return 
