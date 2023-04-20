#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

USER FUNCTION L3Ex05()
    local aArea   := GetArea()
    local cAlias  := GetNextAlias()
    local cDesc   := ''
    local cCodigo := ''
    local cMsg    := ''
    local nCont   := 0

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    cQuery := 'SELECT B1_COD, B1_DESC FROM ' + RetSqlName('SB1') + CRLF
    cQuery += "ORDER BY B1_DESC DESC"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())
        cCodigo  := &(cAlias)->(B1_COD)
        cDesc    := &(cAlias)->(B1_DESC)
        nCont++

        cMsg += 'Código: '+ cCodigo + CRLF + 'Descrição: ' + cDesc + CRLF
        cMsg += '_______________________________________' + CRLF

        if nCont == 10
            FwAlertInfo(cMsg, 'Dados Tabela Produto em Ordem Decrescente pela Descrição')
            nCont := 0
            cMsg  := ''
        endif
        DBSKIP()
    ENDDO
    
    if nCont > 0
        FwAlertInfo(cMsg, 'Dados Tabela Produto em Ordem Decrescente pela Descrição')
    endif

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)
RETURN
