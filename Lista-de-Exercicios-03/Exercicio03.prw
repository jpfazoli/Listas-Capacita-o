#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

USER FUNCTION L3Ex03()
    local aArea   := GetArea()
    local cAlias  := GetNextAlias()
    local cCodigo := ''
    local cDesc   := ''
    local nQtd    := ''
    local nVlUnit := ''
    local nVlTotal:= ''
    local cMsg    := ''
    local nCont   := 0

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC6' MODULO 'COM'

    cQuery := 'SELECT C6_PRODUTO, C6_DESCRI, C6_QTDVEN,C6_PRCVEN, C6_VALOR FROM ' + RetSqlName('SC6') + CRLF
    cQuery += "WHERE C6_NUM = 'PV0008'"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())
        cCodigo  := &(cAlias)->(C6_PRODUTO)
        cDesc    := &(cAlias)->(C6_DESCRI)
        nQtd     := &(cAlias)->(C6_QTDVEN)
        nVlUnit  := &(cAlias)->(C6_PRCVEN)
        nVlTotal := &(cAlias)->(C6_VALOR)
        nCont++

        MontaCons(cCodigo,cDesc,nQtd,nVlUnit,nVlTotal,cMsg)
        DBSKIP()
    ENDDO
    
    ExibeCons(cMsg,nCont)

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)
RETURN

Static Function MontaCons(cCodigo,cDesc,nQtd,nVlUnit,nVlTotal,cMsg)
    cMsg += 'Código: ' + cCodigo + CRLF +'Descrição: ' + cDesc + CRLF + 'Quantidade: ' + CVALTOCHAR(nQtd) + CRLF + 'Valor Unitário: R$' + CVALTOCHAR(nVlUnit) + CRLF + 'Valor Total: R$'+ CVALTOCHAR(nVlTotal) + CRLF
    cMsg += '____________________________________________' + CRLF
return cMsg

Static Function ExibeCons(cMsg,nCont)
    if nCont > 0
        FwAlertInfo(cMsg, 'Itens Pedido PV0008')
    else
        FwAlertInfo('Nenhum Item Encontrado', 'Itens Pedido PV0008')
    endif
return
