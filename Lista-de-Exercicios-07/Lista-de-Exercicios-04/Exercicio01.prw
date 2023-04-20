#INCLUDE 'TOTVS.CH'


User Function L7Ex01()
    local oDlg    := NIL
    local nValor1 := 0
    local nValor2 := 0
    local cTitulo := 'Janela de Operações.'

    while nValor1 < 1 .OR. nValor2 < 1
        DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 170,300 PIXEL

        @ 005,040 SAY 'Informe Valores Positivos' SIZE 170,20 OF oDlg PIXEL
        @ 020,030 SAY 'Primeiro Valor: ' SIZE 50,20 OF oDlg PIXEL
        @ 017,070 MSGET nValor1          SIZE 50,10 OF oDlg PIXEL PICTURE '@E 999,999,999'

        @ 040,030 SAY 'Segundo Valor: '  SIZE 50,20 OF oDlg PIXEL
        @ 037,070 MSGET nValor2          SIZE 50,10 OF oDlg PIXEL PICTURE '@E 999,999,999'

        DEFINE SBUTTON FROM 060,040 TYPE 1 ACTION (nOpcao := 1, oDlg:End()) ENABLE OF oDlg
        DEFINE SBUTTON FROM 060,080 TYPE 2 ACTION (nOpcao := 2, oDlg:End()) ENABLE OF oDlg

        ACTIVATE MSDIALOG oDlg CENTERED
    enddo

    if nOpcao == 1
        FWAlertSuccess( 'Soma: '            + CVALTOCHAR(nValor1 + nValor2) + CRLF;
                       +'Subtração: '       + CVALTOCHAR(nValor1 - nValor2) + CRLF;
                       +'Multiplicação: '   + CVALTOCHAR(nValor1 * nValor2) + CRLF;
                       +'Divisão: '         + CVALTOCHAR(nValor1 / nValor2) , 'Resultado das Operações.')
    endif
Return 

