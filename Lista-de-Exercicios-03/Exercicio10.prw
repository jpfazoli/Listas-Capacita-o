#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

USER FUNCTION L3Ex10()
    local aArea      := GetArea()
    local cAlias     := GetNextAlias()
    local cBusca     := ''
    local cCodigo    := ''
    local nSoma      := 0
    local nResultado := 0
    local cMsg       := 'Pedidos em que o Produto '
    local nCont      := 0

    cBusca := FwInputBox('Informe o Código do Produto: ', cBusca)
    cMsg   += cBusca + ' se Encontra: '

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC6' MODULO 'COM'

    cQuery := 'SELECT C6_NUM, C6_PRODUTO, C6_QTDVEN FROM ' + RetSqlName('SC6') + CRLF
    cQuery += "WHERE C6_PRODUTO = '" + cBusca +"'"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())
        cCodigo  := &(cAlias)->(C6_NUM)
        nSoma    += &(cAlias)->(C6_QTDVEN)
        nCont++

        DBSKIP()
    ENDDO

    nResultado := nSoma / nCont

    if nCont > 0
        FwAlertInfo('O Produto tem a Média de ' + CVALTOCHAR(nResultado) + ' Dentre os Pedidos' , 'Média de Aparição do Produto ' + cBusca + ' em Pedidos')
    else
        FwAlertError('Infelizmente o Produto Informado não foi Encontrado', 'Pedidos em que o Produto ' + cBusca + ' se Encontra')
    endif

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)
RETURN
