#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'


User Function L4Ex11()
    local oDlg      := NIL
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ''
    local cTitulo   := 'Busca de Produto'
    local cProduto  := Space(15)
    local cCodigo   := ''
    local cDesc     := ''
    local nPreco    := ''
    local lValido   := .T.
    local nCont     := 0
    local nLinha    := 20
    local nLinJan   := 150
    local nColJan   := 350

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    while lValido
        nCont := 0
        DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO nLinJan,nColJan PIXEL
        @ 020,020 SAY 'Informe o Código do Produto: ' SIZE 60,20 OF oDlg PIXEL
        @ 020,080 MSGET cProduto SIZE 80,10 OF oDlg PIXEL
        @ 040,045 BUTTON 'Buscar' SIZE 030,011 OF oDlg ACTION (nOpcao := 1,oDlg:END()) PIXEL 
        @ 040,085 BUTTON 'Cancelar' SIZE 030,011 OF oDlg ACTION (nOpcao := 2,oDlg:END()) PIXEL 
        
        ACTIVATE MSDIALOG oDlg CENTERED

        if nOpcao == 2
            lValido := .F.
        else

            cQuery := 'SELECT B1_COD, B1_DESC, B1_PRV1 FROM ' + RetSqlName('SB1') + CRLF
            cQuery += "WHERE B1_COD = '" + cProduto + "' AND D_E_L_E_T_ = ' '"

            TCQUERY cQuery ALIAS &(cAlias) NEW

            &(cAlias)->(DbGoTop())

            While &(cAlias)->(!EoF())
                nCont++
                DBSKIP()
            enddo

            if nCont > 0
                DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO nLinJan,500 PIXEL
                @ 010,040 SAY 'Resultado' SIZE 80,10 OF oDlg PIXEL
                @ 020,020 SAY 'Código' SIZE 80,10 OF oDlg PIXEL
                @ 020,050 SAY 'Descrição' SIZE 80,10 OF oDlg PIXEL
                @ 020,150 SAY 'Preço de Venda' SIZE 80,10 OF oDlg PIXEL

                &(cAlias)->(DbGoTop())

                nLinha := 20
                While &(cAlias)->(!EoF())
                    cCodigo   := Alltrim(&(cAlias)->(B1_COD))
                    cDesc     := &(cAlias)->(B1_DESC)
                    nPreco    := &(cAlias)->(B1_PRV1)
                    if UPPER(cProduto) = cCodigo
                        nLinha += 10
                        @ nLinha,020 SAY cCodigo SIZE 80,10 OF oDlg PIXEL
                        @ nLinha,050 SAY cDesc SIZE 80,10 OF oDlg PIXEL
                        @ nLinha,150 SAY CVALTOCHAR(nPreco) SIZE 80,10 OF oDlg PIXEL
                    endif
                    DBSKIP()
                enddo

                @ nLinha + 10,070 SAY 'Deseja fazer outra Consulta?' SIZE 80,10 OF oDlg PIXEL

                @ nLinha + 20,065 BUTTON 'Buscar' SIZE 030,011 OF oDlg ACTION (nOpcao := 1,oDlg:END()) PIXEL 
                @ nLinha + 20,105 BUTTON 'Cancelar' SIZE 030,011 OF oDlg ACTION (nOpcao := 2,oDlg:END()) PIXEL 

                ACTIVATE MSDIALOG oDlg CENTERED
            else

                DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO nLinJan,500 PIXEL
                @ 020,020 SAY 'Produto não Encontrado!' SIZE 80,10 OF oDlg PIXEL
                @ nLinha + 10,070 SAY 'Deseja fazer outra Consulta?' SIZE 80,10 OF oDlg PIXEL
                @ nLinha + 20,065 BUTTON 'Buscar' SIZE 030,011 OF oDlg ACTION (nOpcao := 1,oDlg:END()) PIXEL 
                @ nLinha + 20,105 BUTTON 'Cancelar' SIZE 030,011 OF oDlg ACTION (nOpcao := 2,oDlg:END()) PIXEL 

                ACTIVATE MSDIALOG oDlg CENTERED
            endif

            if nOpcao == 2
                lValido := .F.
            endif

            &(cAlias)->(DbCloseArea())

        endif
    enddo

    RestArea(aArea)
Return 
