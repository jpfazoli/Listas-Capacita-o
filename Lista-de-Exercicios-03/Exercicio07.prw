#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

USER FUNCTION L3Ex07()
    local aArea    := GetArea()
    local cAlias   := GetNextAlias()
    local cInicio  := ''
    local cFim     := ''
    local cCodigo  := ''
    local cCliente := ''
    local cMsg     := ''
    local nCont    := 0
    local nRes     := .F.

    cInicio := DtoS(CtoD(FwInputBox('Informe a Data de Inicio (DD/MM/AAAA): ', '')))
    cFim    := DtoS(CtoD(FwInputBox('Informe a Data de Fim (DD/MM/AAAA): ', '')))

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC5' MODULO 'COM'

    cQuery := 'SELECT C5_NUM,C5_CLIENT FROM ' + RetSqlName('SC5') + CRLF
    cQuery += "WHERE CONVERT(DATE,C5_EMISSAO) BETWEEN '" + cInicio + "' AND '" + cFim + "' AND D_E_L_E_T_ = ' '"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    While &(cAlias)->(!EOF())
        cCodigo  := &(cAlias)->(C5_NUM)
        cCliente := &(cAlias)->(C5_CLIENT)
        nCont++
        cMsg += 'Código: '+ cCodigo + CRLF  + 'Código Cliente: ' + cCliente + CRLF + CRLF

        if nCont = 10
            FwAlertInfo(cMsg, 'Pedidos de Vendas no Periodo de ' + cInicio + ' a ' + cFim)
            nRes  := .T.
            nCont := 0
            cMsg  := ''
        endif
        DBSKIP()
    ENDDO
    
    if nCont > 0
        FwAlertInfo(cMsg, 'Pedidos de Vendas no Periodo de ' + cInicio + ' a ' + cFim)
    elseif nRes == .F.
        FwAlertError('Infelizmente o Produto Informado não foi Encontrado', 'Pedidos de Vendas no Periodo de ' + cInicio + ' a ' + cFim)
    endif

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)
RETURN
