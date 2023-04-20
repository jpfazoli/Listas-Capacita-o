#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'


User Function L7Ex14()
    local aEntrada  := {}
    local cQuery    := ''    
    local cProduto  := ''
    local cMsg      := ''
    local cCodigo   := ''
    local aCodigos  := {}
    local nCont     := 0
    Private aArea     := GetArea()
    Private cAlias    := GetNextAlias()
    Private cTitulo   := 'Busca de Pedido de Venda por Produto'
    Private nLinJan   := 150
    Private nColJan   := 350

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1,SC6' MODULO 'COM'

    aEntrada := TelaBusca() //Chama a Função e Recebe o Retorno da Tela de Busca
    cProduto := aEntrada[1]
    aCodigos := aEntrada[2]
    nOpcao   := aEntrada[3]

    cQuery := 'SELECT C6_NUM FROM ' + RetSqlName('SC6') + CRLF
    cQuery += "WHERE C6_PRODUTO = '" + aCodigos[VAL(cProduto)] + "' AND D_E_L_E_T_ = ' '"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    nCont := 0
    While &(cAlias)->(!EoF())
        cCodigo   := Alltrim(&(cAlias)->(C6_NUM))
        nCont++
        cMsg += cCodigo + CRLF
        DBSKIP()
    enddo

    TelaSaida(cMsg,nCont)

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)
Return 

STATIC FUNCTION TelaBusca()
    local oDlg      := NIL
    local nOpcao    := 0
    local aOpcoes   := {}
    local aCodigos  := {}
    local cProduto  := ''
    local cCodigo   := ''
    local cQuery    := ''
    local nCont     := 0

    //Busca todos os Produtos para colocar nas Opções
    cQuery := 'SELECT SB1.B1_COD FROM ' + RetSqlName('SB1') + ' SB1' + CRLF
    cQuery += "WHERE SB1.D_E_L_E_T_ = ' '"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EoF())
        //Popula o Array com as Opções e com os códigos
        cCodigo := Alltrim(&(cAlias)->(B1_COD))
        nCont++
        AADD(aOpcoes, CVALTOCHAR(nCont) + '=' + cCodigo)
        AADD(aCodigos, cCodigo)
        DBSKIP()
    enddo

    &(cAlias)->(DbCloseArea())
    //Cria a Tela com as Opções dos Produtos existentes
    DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO nLinJan,nColJan PIXEL
    @ 020,020 SAY 'Informe o Código do Produto: '          SIZE 60,20 OF oDlg PIXEL
    @ 020,080 MSCOMBOBOX oCombo VAR cProduto ITEMS aOpcoes SIZE 60,15 OF oDlg PIXEL 

    @ 040,045 BUTTON 'Buscar'   SIZE 030,011 OF oDlg ACTION (nOpcao := 1,oDlg:END()) PIXEL 
    @ 040,085 BUTTON 'Cancelar' SIZE 030,011 OF oDlg ACTION (nOpcao := 2,oDlg:END()) PIXEL 
        
    ACTIVATE MSDIALOG oDlg CENTERED
Return {cProduto,aCodigos,nOpcao}


STATIC FUNCTION TelaSaida(cMsg,nCont)
    local oDlg      := NIL
    local nLinha    := 30

    DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO (nLinJan+(10*nCont)),350 PIXEL
    //Cabeçalho de dados
    @ 010,040 SAY 'Resultado' SIZE 80,10 OF oDlg PIXEL
    @ 020,020 SAY 'Código'    SIZE 80,10 OF oDlg PIXEL
    //Impressão dos dados
    @ nLinha,020 SAY cMsg     SIZE 80,(10 * nCont) OF oDlg PIXEL
    nLinha += (10*nCont)

    @ nLinha,075 BUTTON 'Fechar' SIZE 030,011 OF oDlg ACTION (oDlg:END()) PIXEL 

    ACTIVATE MSDIALOG oDlg CENTERED
Return NIL
