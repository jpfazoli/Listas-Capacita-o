#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function ValMunici()
    local lRet     := .T.
    local aArea    := GetArea()
    local cAlias   := GetNextAlias()
    local cQuery   := ''
    local aEntrada := PARAMIXB

    cQuery := 'SELECT CC2_MUN, CC2_EST FROM ' + RetSqlName('CC2') + CRLF
    cQuery += "WHERE D_E_L_E_T_ = ' ' AND CC2_MUN = '" + aEntrada[1] + "' AND CC2_EST = '" + aEntrada[2] + "'"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())
        lRet := .F.
        FwAlertError('Este Municipio já existe nessa UF, cheque os cadastros no sistema.', 'Cadastro Inválido!')
        DBSKIP()
    ENDDO

    RestArea(aArea)
Return lRet
