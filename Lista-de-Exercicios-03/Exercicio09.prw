#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

USER FUNCTION L3Ex09()
    local aArea      := GetArea()
    local cAlias     := GetNextAlias()
    local cBusca     := ''
    local cCodigo    := ''
    local nRegistros := 0
    local cMsg       := 'Pedidos em que o Produto '
    local nCont      := 0

    cBusca := FwInputBox('Informe o Código do Produto: ', cBusca)
    cMsg   += cBusca + ' se Encontra: '

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC6' MODULO 'COM'

    cQuery := 'SELECT C6_NUM, C6_PRODUTO FROM ' + RetSqlName('SC6') + CRLF
    cQuery += "WHERE C6_PRODUTO = '" + cBusca +"'"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())
        nRegistros++
        DBSKIP()
    enddo

    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())
        cCodigo  := &(cAlias)->(C6_NUM)
        nCont++
        if nCont < nRegistros
            cMsg += cCodigo + ', '
        else
            cMsg += cCodigo + '.'
        endif
        DBSKIP()
    ENDDO
    
    if nCont > 0
        FwAlertInfo(cMsg, 'Pedidos em que o Produto ' + cBusca + ' se Encontra')
    else
        FwAlertError('Infelizmente o Produto Informado não foi Encontrado', 'Pedidos em que o Produto ' + cBusca + ' se Encontra')
    endif

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)
RETURN
