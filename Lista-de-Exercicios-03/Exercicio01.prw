#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

USER FUNCTION L3Ex01()
    local aArea   := GetArea()
    local cAlias  := GetNextAlias()
    local cQuery  := ''
    local cPedido := ''
    local cMsg    := ''
    local nCont   := 0

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC7' MODULO 'COM'

    cQuery := 'SELECT C7_NUM FROM ' + RetSqlName('SC7') + CRLF
    cQuery += "WHERE C7_FORNECE = 'F00004'"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())
        cPedido := &(cAlias)->(C7_NUM)
        
        nCont++
        cMsg += 'Pedido ' + CVALTOCHAR(nCont) + ' : ' + cPedido + CRLF

        DBSKIP()
    ENDDO
    
    if nCont > 0
        FwAlertInfo(cMsg, 'Pedidos de Compras Fornecedor: Super Cabos')
    else
    FwAlertInfo('Nenhum Pedido Encontrado', 'Pedidos de Compras Fornecedor: Super Cabos')
    endif

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)
RETURN
