#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

USER FUNCTION L3Ex08()
    local aArea   := GetArea()
    local cAlias  := GetNextAlias()
    local cCodigo := ''
    local cDesc   := ''
    local nVlUnit := ''
    local nVlTotal:= ''
    local cMsg    := ''
    local nCont   := 0

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC6' MODULO 'COM'

    cQuery := 'SELECT C6_PRODUTO, C6_DESCRI, C6_PRCVEN, C6_VALOR FROM ' + RetSqlName('SC6') + CRLF
    cQuery += "WHERE C6_VALOR = (SELECT MAX(C6_VALOR) FROM " + RetSqlName('SC6') + ")"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())
        cCodigo  := &(cAlias)->(C6_PRODUTO)
        cDesc    := &(cAlias)->(C6_DESCRI)
        nVlUnit  := &(cAlias)->(C6_PRCVEN)
        nVlTotal := &(cAlias)->(C6_VALOR)
        nCont++

        cMsg += 'Código: ' + cCodigo + CRLF +'Descrição: ' + cDesc + CRLF + 'Quantidade: ' + CVALTOCHAR(nQtd) + CRLF + 'Valor Unitário: R$' + CVALTOCHAR(nVlUnit) + CRLF + 'Valor Total: R$'+ CVALTOCHAR(nVlTotal) + CRLF
        DBSKIP()
    ENDDO
    
    if nCont > 0
        FwAlertInfo(cMsg, 'Item com Maior Valor Total entre todos os Pedidos')
    else
        FwAlertInfo('Nenhum Item Encontrado', 'Itens Pedido PV0008')
    endif

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)
RETURN
