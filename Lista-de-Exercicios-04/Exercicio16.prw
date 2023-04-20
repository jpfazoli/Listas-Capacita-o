#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'


User Function L4Ex16()
    local oDlg      := NIL
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ''
    local cTitulo   := 'Busca de Produto'
    local cCodigo   := ''
    local cNome     := ''
    local cUF       := ''
    local aValores  := {'1=AC','2=AL','3=AP','4=AM','5=BA','6=CE','7=DF','8=ES','9=GO','10=MA','11=MT','12=MS','13=MG','14=PA','15=PB','16=PR';
    ,'17=PE','18=PI','19=RJ','20=RN','21=RS','22=RO','23=RR','24=SC','25=SP','26=SE','27=TO'}
    local aUF       := {'AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'}
    local cMsg      := ''
    local nCont     := 0
    local nLinha    := 20
    local nLinJan   := 150
    local nColJan   := 350

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SA1' MODULO 'COM'

        DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO nLinJan,nColJan PIXEL
        @ 020,020 SAY 'Informe a UF para Buscar: ' SIZE 60,20 OF oDlg PIXEL
        @ 020,080 MSCOMBOBOX oCombo VAR cUF ITEMS aValores SIZE 60,15 OF oDlg PIXEL 
        @ 040,045 BUTTON 'Buscar' SIZE 030,011 OF oDlg ACTION (nOpcao := 1,oDlg:END()) PIXEL 
        @ 040,085 BUTTON 'Cancelar' SIZE 030,011 OF oDlg ACTION (nOpcao := 2,oDlg:END()) PIXEL 
        
        ACTIVATE MSDIALOG oDlg CENTERED

        if nOpcao == 1
            cQuery := 'SELECT A1_COD, A1_NOME FROM ' + RetSqlName('SA1') + CRLF
            cQuery += "WHERE A1_EST = '" + aUF[VAL(cUF)] + "' AND D_E_L_E_T_ = ' '"

            TCQUERY cQuery ALIAS &(cAlias) NEW

            &(cAlias)->(DbGoTop())

            nLinha := 20
            While &(cAlias)->(!EoF())
                nLinha    += 5
                nLinJan   += 10
                nCont++
                cCodigo   := &(cAlias)->(A1_COD)
                cNome     := &(cAlias)->(A1_NOME)
                cMsg      += cCodigo + '......' + cNome + CRLF
                DBSKIP()
            enddo

            DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO nLinJan,350 PIXEL
            @ 010,075 SAY 'Resultado' SIZE 80,10 OF oDlg PIXEL
            @ 020,020 SAY 'Código' SIZE 80,10 OF oDlg PIXEL
            @ 020,050 SAY 'Nome' SIZE 80,10 OF oDlg PIXEL

            @ 030,020 SAY cMsg SIZE 150,(10*nCont) OF oDlg PIXEL
            @ nLinha + 40,075 BUTTON 'Cancelar' SIZE 030,011 OF oDlg ACTION (nOpcao := 2,oDlg:END()) PIXEL 

            ACTIVATE MSDIALOG oDlg CENTERED

        endif
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)
Return 
