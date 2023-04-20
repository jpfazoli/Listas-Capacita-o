#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

USER FUNCTION L3Ex04()
    local aArea   := GetArea()
    local cAlias  := GetNextAlias()
    local cDesc   := ''
    local cMsg    := ''
    local nCont   := 0

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    cQuery := 'SELECT B1_DESC FROM ' + RetSqlName('SB1') + CRLF
    cQuery += "WHERE B1_GRUPO = 'G002'"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())
        cDesc    := &(cAlias)->(B1_DESC)
        nCont++

        cMsg += 'Descrição: ' + cDesc+ CRLF + CRLF
        DBSKIP()
    ENDDO
    
    if nCont > 0
        FwAlertInfo(cMsg, 'Itens do Grupo Películas')
    else
        FwAlertInfo('Nenhum Item Encontrado', 'Itens do Grupo Películas')
    endif

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)
RETURN
