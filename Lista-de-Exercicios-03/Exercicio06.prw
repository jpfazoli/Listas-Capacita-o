#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

USER FUNCTION L3Ex06()
    local aArea   := GetArea()
    local cAlias  := GetNextAlias()
    local cBusca  := ''
    local cDesc   := ''
    local cCodigo := ''
    local nPreco  := 0
    local cMsg    := ''
    local nCont   := 0

    cBusca := FwInputBox('Informe um c�digo para Buscar: ', cBusca)

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    cQuery := 'SELECT B1_COD, B1_DESC,B1_PRV1 FROM ' + RetSqlName('SB1') + CRLF
    cQuery += "WHERE B1_COD = '" + cBusca + "'"
    cQuery += "ORDER BY B1_DESC DESC"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())
        cCodigo  := &(cAlias)->(B1_COD)
        cDesc    := &(cAlias)->(B1_DESC)
        nPreco   := &(cAlias)->(B1_PRV1)
        nCont++

        cMsg += 'C�digo: '+ cCodigo + CRLF + 'Descri��o: ' + cDesc + CRLF + 'Pre�o de Venda: R$' + CVALTOCHAR(nPreco)

        DBSKIP()
    ENDDO
    
    if nCont > 0
        FwAlertInfo(cMsg, 'Dados Tabela Produto em Ordem Decrescente pela Descri��o')
    else
        FwAlertError('Infelizmente o Produto Informado n�o foi Encontrado', 'Produto n�o Encontrado')
    endif

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)
RETURN
