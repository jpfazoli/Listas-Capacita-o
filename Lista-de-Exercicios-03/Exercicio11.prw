#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

USER FUNCTION L3Ex11()
    local aArea      := GetArea()
    local cAlias     := GetNextAlias()
    local cEstado    := ''
    local cCodigo    := ''
    local cNome      := ''
    local cMsg       := ''
    local nCont      := 0

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SA2' MODULO 'COM'

    cQuery := 'SELECT A2_COD, A2_NOME, A2_EST FROM ' + RetSqlName('SA2') + CRLF
    cQuery += "WHERE A2_EST = 'SP'"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())
        cCodigo  := &(cAlias)->(A2_COD)
        cNome    := &(cAlias)->(A2_NOME)
        cEstado  := &(cAlias)->(A2_EST)
        nCont++

        cMsg += 'Código: ' + cCodigo + CRLF + 'Nome Fornecedor: ' + cNome + CRLF + 'Estado: ' + cEstado + CRLF
        cMsg += '______________________________' + CRLF
        DBSKIP()
    ENDDO

    if nCont > 0
        FwAlertInfo(cMsg, 'Fornecedores do Estado de São Paulo-SP')
    else
        FwAlertError('Infelizmente o Produto Informado não foi Encontrado', 'Fornecedores do Estado de São Paulo-SP')
    endif

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)
RETURN
