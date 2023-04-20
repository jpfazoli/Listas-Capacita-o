#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'


User Function L7Ex12()
    local aArea     := GetArea()
    local cQuery    := ''
    local aEntrada  := {}
    local cInicio   := ''
    local cFim      := ''
    local lValido   := .T.
    local nCont     := 0
    Private cTitulo   := 'Busca de Pedido de Venda por Periodo'
    Private cAlias    := GetNextAlias()
    Private nLinha    := 20
    Private nLinJan   := 150
    Private nColJan   := 350

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC7' MODULO 'COM'

    while lValido

        aEntrada := TelaBusca()//Chama a tela para Busca por datas e Recebe o Retorno
        cInicio  := aEntrada[1]
        cFim     := aEntrada[2]
        nOpcao   := aEntrada[3]

        if nOpcao == 2 //Valida se a Operação de Busca não foi cancelada
            lValido := .F.
        else

            cQuery := 'SELECT C7_NUM FROM ' + RetSqlName('SC7') + CRLF
            cQuery += "WHERE (CONVERT(DATE,C7_EMISSAO) BETWEEN '" + cInicio + "' AND '" + cFim + "') AND D_E_L_E_T_ = ' '" + CRLF
            cQuery += 'GROUP BY C7_NUM'

            TCQUERY cQuery ALIAS &(cAlias) NEW

            &(cAlias)->(DbGoTop())

            While &(cAlias)->(!EoF())
                nLinJan += 5
                nCont++
                DBSKIP()
            enddo

            if nCont > 0
                nOpcao := TelaEncon()//Chama a Função para caso encontre o produto
            else
                nOpcao := TelaVazia()//Chama a Função para caso não encontre
            endif
            if nOpcao == 2
                lValido := .F.
            endif

            &(cAlias)->(DbCloseArea())

        endif
    enddo

    RestArea(aArea)
Return 


STATIC FUNCTION TelaBusca()
    local oDlg    := NIL
    local nOpcao  := 0
    local dInicio := DATE()
    local dFim    := DATE()

    DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO nLinJan,nColJan PIXEL

    @ 020,020 SAY 'Data de Inicio: ' SIZE 60,20 OF oDlg PIXEL
    @ 017,060 MSGET dInicio          SIZE 40,10 OF oDlg PIXEL PICTURE '@D 99/99/9999'
    @ 040,020 SAY 'Data de Fim: '    SIZE 60,20 OF oDlg PIXEL
    @ 037,060 MSGET dFim             SIZE 40,10 OF oDlg PIXEL PICTURE '@D 99/99/9999'

    @ 060,045 BUTTON 'Buscar' SIZE 030,011 OF oDlg ACTION (nOpcao := 1,oDlg:END()) PIXEL 
    @ 060,085 BUTTON 'Cancelar' SIZE 030,011 OF oDlg ACTION (nOpcao := 2,oDlg:END()) PIXEL 
        
    ACTIVATE MSDIALOG oDlg CENTERED

return {DtoS(dInicio), DtoS(dFim), nOpcao}


STATIC FUNCTION TelaEncon(cInicio,cFim,nCont) 
    local oDlg      := NIL
    local cCodigo   := ''
    local cMsg   := ''
    local nRegAtual := 0
    local nLinha    := 0
    local nOpcao    := 0


    &(cAlias)->(DbGoTop())
    
    DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO nLinJan,500 PIXEL
    //Cabeçalho de Resultado
    @ 010,110 SAY 'Resultado' SIZE 80,10 OF oDlg PIXEL
    @ 020,020 SAY ('Códigos do Produto dentro do Periodo informado') SIZE 150,10 OF oDlg PIXEL
    
    nLinha := 20
    While &(cAlias)->(!EoF())
        cCodigo := Alltrim(&(cAlias)->(C7_NUM))
        nRegAtual++
        IF nRegAtual < nCont
            cMsg += cCodigo + ', '
        else
            cMsg += cCodigo + ' '
        endif
        DBSKIP()
    enddo
    //Imprime os Resultados
    @ 035,020 SAY cMsg SIZE 200,50 OF oDlg PIXEL
    
    @ 100,085 SAY 'Deseja fazer outra Consulta?' SIZE 80,10 OF oDlg PIXEL
    
    @ 110,090 BUTTON 'Buscar'   SIZE 030,011 OF oDlg ACTION (nOpcao := 1,oDlg:END()) PIXEL 
    @ 110,120 BUTTON 'Cancelar' SIZE 030,011 OF oDlg ACTION (nOpcao := 2,oDlg:END()) PIXEL 
    
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
