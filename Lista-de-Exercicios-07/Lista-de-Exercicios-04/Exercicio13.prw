#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'


User Function L4Ex13()

    local aEntrada    := {}
    local aArea       := GetArea()
    local cAlias      := GetNextAlias()
    local cQuery      := ''
    local cProduto    := Space(15)
    local cMsg        := ''
    local cCodigo     := ''
    local nCont       := 0
    Private cTitulo   := 'Busca de Pedido de Venda por Produto'
    Private nLinJan   := 150
    Private nColJan   := 350

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC6' MODULO 'COM'

    aEntrada := TelaBusca()
    cProduto := aEntrada[1]
    nOpcao   := aEntrada[2]

    if nOpcao == 1
        cQuery := 'SELECT C6_PRODUTO, C6_NUM FROM ' + RetSqlName('SC6') + CRLF
        cQuery += "WHERE C6_PRODUTO = '" + ALLTRIM(cProduto) + "' AND D_E_L_E_T_ = ' '"

        TCQUERY cQuery ALIAS &(cAlias) NEW

        &(cAlias)->(DbGoTop())

        While &(cAlias)->(!EoF())
            cCodigo   := Alltrim(&(cAlias)->(C6_NUM))
            nCont++
            cMsg += cCodigo + CRLF
            DBSKIP()
        enddo

    TelaSaida(cMsg,nCont)
    
    endif

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)
Return 


STATIC FUNCTION TelaBusca()
    local oDlg  := NIL
    local cProduto := Space(15)
    local nOpcao

    DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO nLinJan,nColJan PIXEL
    @ 020,020 SAY 'Informe o Código do Produto: ' SIZE 60,20 OF oDlg PIXEL
    @ 020,080 MSGET cProduto    SIZE 80,10 OF oDlg PIXEL

    @ 040,045 BUTTON 'Buscar'   SIZE 030,011 OF oDlg ACTION (nOpcao := 1,oDlg:END()) PIXEL 
    @ 040,085 BUTTON 'Cancelar' SIZE 030,011 OF oDlg ACTION (nOpcao := 2,oDlg:END()) PIXEL 
        
    ACTIVATE MSDIALOG oDlg CENTERED


Return {cProduto,nOpcao}


STATIC FUNCTION TelaSaida(cMsg,nContador)
    local oDlg      := NIL
    local nLinha    := 20

    DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO (nLinJan+(10*nContador)),350 PIXEL
    @ 010,040 SAY 'Resultado'    SIZE 80,10 OF oDlg PIXEL
    @ 020,020 SAY 'Código'       SIZE 80,10 OF oDlg PIXEL
    nLinha := 30
    @ nLinha,020 SAY cMsg        SIZE 80,(10 * nContador) OF oDlg PIXEL
    nLinha += (10*nContador)
    @ nLinha,075 BUTTON 'Fechar' SIZE 030,011 OF oDlg ACTION (oDlg:END()) PIXEL 

    ACTIVATE MSDIALOG oDlg CENTERED

Return NIL
