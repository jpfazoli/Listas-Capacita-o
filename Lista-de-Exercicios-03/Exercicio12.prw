#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

USER FUNCTION L3Ex12()
    local aArea   := GetArea()
    local cAlias  := GetNextAlias()
    local aCodigo[2]
    local aDesc  [2]
    local aVlUnit[2]
    local cMsg    := ''
    local nCont   := 0

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    cQuery := 'SELECT B1_COD, B1_DESC, B1_PRV1 FROM ' + RetSqlName('SB1') + CRLF
    cQuery += "WHERE B1_PRV1 = (SELECT MAX(B1_PRV1) FROM " + RetSqlName('SB1') + ") OR B1_PRV1 = (SELECT MIN(B1_PRV1) FROM " + RetSqlName('SB1') + " WHERE B1_PRV1 > 0)"
    cQuery += 'ORDER BY B1_PRV1 ASC'

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())
        nCont++
        aCodigo[nCont]  := &(cAlias)->(B1_COD)
        aDesc[nCont]    := &(cAlias)->(B1_DESC)
        aVlUnit[nCont]   := &(cAlias)->(B1_PRV1)

        DBSKIP()
    ENDDO
    cMsg := 'O Produto com Menor Valor: ' + CRLF + 'Código: ' + aCodigo[1] + CRLF + 'Descrição: ' + aDesc[1] + CRLF + 'Valor Unitário: R$' + CVALTOCHAR(aVlUnit[1]) + CRLF
    cMsg += '_________________________________' + CRLF
    cMsg += 'O Produto com Maior Valor: ' + CRLF + 'Código: ' + aCodigo[2] + CRLF + 'Descrição: ' + aDesc[2] + CRLF + 'Valor Unitário: R$' + CVALTOCHAR(aVlUnit[2]) + CRLF

    if nCont > 0
        FwAlertInfo(cMsg, 'Item com Maior Valor Total entre todos os Pedidos')
    else
        FwAlertInfo('Nenhum Item Encontrado', 'Itens Pedido PV0008')
    endif

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)
RETURN
