#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'


User Function L7Ex11()
    local aProduto    := {}
    local cQuery      := ''
    local cProduto    := Space(15)
    local lValido     := .T.
    local nCont       := 0
    Private aArea     := GetArea()
    Private cAlias    := GetNextAlias()
    Private cTitulo   := 'Busca de Produto'
    Private nLinha    := 20
    Private nLinJan   := 150
    Private nColJan   := 350

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    while lValido
        nCont := 0
        aProduto := TelaBusca()//Chama a Tela de Busca e Atribui para a variavel o retorno
        cProduto := aProduto[1]
        nOpcao   := aProduto[2]

        if nOpcao == 2//Verifica se a Operação de Busca não foi cancelada
            lValido := .F.
        else
            // Query para fazer a busca do produto 
            cQuery := 'SELECT B1_COD, B1_DESC, B1_PRV1 FROM ' + RetSqlName('SB1') + CRLF
            cQuery += "WHERE B1_COD = '" + cProduto + "' AND D_E_L_E_T_ = ' '"

            TCQUERY cQuery ALIAS &(cAlias) NEW

            &(cAlias)->(DbGoTop())

            While &(cAlias)->(!EoF())
                nCont++//Verifica se existem registros para a Busca do Produto
                DBSKIP()
            enddo

            if nCont > 0
                nOpcao := TelaEncon()//Chama a Função para caso encontre o produto
            else
                nOpcao := TelaVazia()//Chama a Função para caso não encontre
            endif

            if nOpcao == 2//Verifica se será feita nova consulta
                lValido := .F.
            endif

            &(cAlias)->(DbCloseArea())

        endif
    enddo

    RestArea(aArea)
Return 


STATIC FUNCTION TelaBusca()
    local oDlg
    local cProduto := Space(15)
    local nOpcao   := 0
    
    DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO nLinJan,nColJan PIXEL
    //Entrada do Produto a ser buscado
    @ 020,020 SAY 'Informe o Código do Produto: ' SIZE 60,20 OF oDlg PIXEL
    @ 020,080 MSGET cProduto                      SIZE 80,10 OF oDlg PIXEL

    @ 040,045 BUTTON 'Buscar' SIZE 030,011 OF oDlg ACTION (nOpcao := 1,oDlg:END()) PIXEL 
    @ 040,085 BUTTON 'Cancelar' SIZE 030,011 OF oDlg ACTION (nOpcao := 2,oDlg:END()) PIXEL 
        
    ACTIVATE MSDIALOG oDlg CENTERED
return {cProduto, nOpcao}


STATIC FUNCTION TelaEncon() 
    local oDlg      := NIL
    local cCodigo   := ''
    local cDesc     := ''
    local nPreco    := 0
    local nLinha    := 0
    local nOpcao    := 0


    DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO nLinJan,500 PIXEL    
    //Cabeçalho do resultado
    @ 010,040 SAY 'Resultado'      SIZE 80,10 OF oDlg PIXEL
    @ 020,020 SAY 'Código'         SIZE 80,10 OF oDlg PIXEL
    @ 020,050 SAY 'Descrição'      SIZE 80,10 OF oDlg PIXEL
    @ 020,150 SAY 'Preço de Venda' SIZE 80,10 OF oDlg PIXEL

    &(cAlias)->(DbGoTop())

    nLinha := 20
    While &(cAlias)->(!EoF())
        //Atribui para variáveis os valores do Banco de Dados
        cCodigo   := Alltrim(&(cAlias)->(B1_COD))
        cDesc     := &(cAlias)->(B1_DESC)
        nPreco    := &(cAlias)->(B1_PRV1)
        nLinha += 10
        //Imprime os valores encontrados
        @ nLinha,020 SAY cCodigo SIZE 80,10 OF oDlg PIXEL
        @ nLinha,050 SAY cDesc SIZE 80,10 OF oDlg PIXEL
        @ nLinha,150 SAY CVALTOCHAR(nPreco) SIZE 80,10 OF oDlg PIXEL
        DBSKIP()
    enddo

    //Verifica se será feita nova consulta
    @ nLinha + 10,070 SAY 'Deseja fazer outra Consulta?' SIZE 80,10 OF oDlg PIXEL

    @ nLinha + 20,065 BUTTON 'Buscar'   SIZE 030,011 OF oDlg ACTION (nOpcao := 1,oDlg:END()) PIXEL 
    @ nLinha + 20,105 BUTTON 'Cancelar' SIZE 030,011 OF oDlg ACTION (nOpcao := 2,oDlg:END()) PIXEL 

    ACTIVATE MSDIALOG oDlg CENTERED

return nOpcao


STATIC FUNCTION TelaVazia()
    local oDlg   := NIL
    local nOpcao := 0
    local nLinha := 20

    DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO nLinJan,500 PIXEL
    @ 020,020 SAY 'Produto não Encontrado!' SIZE 80,10 OF oDlg PIXEL
    //Verifica se será feita nova consulta
    @ nLinha + 10,070 SAY 'Deseja fazer outra Consulta?' SIZE 80,10 OF oDlg PIXEL
    @ nLinha + 20,065 BUTTON 'Buscar' SIZE 030,011 OF oDlg ACTION (nOpcao := 1,oDlg:END()) PIXEL 
    @ nLinha + 20,105 BUTTON 'Cancelar' SIZE 030,011 OF oDlg ACTION (nOpcao := 2,oDlg:END()) PIXEL 

    ACTIVATE MSDIALOG oDlg CENTERED

Return nOpcao
