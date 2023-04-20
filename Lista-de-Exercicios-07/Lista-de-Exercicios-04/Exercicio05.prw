#INCLUDE 'TOTVS.CH'

#DEFINE nPRECO_KM  0.15
#DEFINE nPRECO_DIA 60

User Function L7Ex05()
    local aDados    := {}
    local nKm       := 0
    local nDias     := 0
    local nConfirma := 0
    local nCusto    := 0
    Private cTitulo   := 'Janela de Calculo de Custo de Aluguel de Carro'

    aDados    := TelaDados()//Recebe os dados da Tela de Entrada
    nKm       := aDados[1]
    nDias     := aDados[2]
    nConfirma := aDados[3]


    nCusto := (nPRECO_KM * nKm) + (nPRECO_DIA * nDias)

    if nConfirma == 1 // Valida se a Operação foi cancelada
        FWAlertSuccess('Custo por Dia (' + CVALTOCHAR(nDias) + 'Dias x R$' + alltrim(Str(nPRECO_DIA,,2)) + ')...: R$' + alltrim(Str((nPRECO_DIA * nDias),,2)) + CRLF;
                       +'Custo por Km (' + CVALTOCHAR(nKm) + 'Km x R$' + alltrim(Str(nPRECO_KM,,2)) + ')...: R$' + alltrim(Str((nPRECO_KM * nKm),,2)) + CRLF;
                       +'Preco Total...................................: R$ ' + alltrim(Str(nCusto,,2)), cTitulo)
    endif
Return 

STATIC FUNCTION TelaDados()
    local oDlg      := NIL
    local nKm       := 0
    local nDias     := 0
    local nConfirma := 0

    DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 180,300 PIXEL

    @ 020,020 SAY 'Informe os Km Percorridos: '    SIZE 60,20 OF oDlg PIXEL
    @ 020,080 MSGET nKm                            SIZE 50,10 OF oDlg PIXEL PICTURE '@R 9,999.99 Km'
    @ 040,020 SAY 'Informe a Quantidade de Dias: ' SIZE 60,20 OF oDlg PIXEL
    @ 040,080 MSGET nDias                          SIZE 50,10 OF oDlg PIXEL PICTURE '@R 9,999 Dias'

    @ 060,045 BUTTON 'Calcular' SIZE 030,011 OF oDlg ACTION (nConfirma := 1, oDlg:End()) PIXEL 
    DEFINE SBUTTON FROM 060,085 TYPE 2 ACTION (nConfirma := 2, oDlg:End()) ENABLE OF oDlg

    ACTIVATE MSDIALOG oDlg CENTERED

Return {nKm, nDias, nConfirma}
