#INCLUDE 'TOTVS.CH'
#INCLUDE 'REPORT.CH'


/*/{Protheus.doc} User Function L10EX05
    Função para Criação de Relatório de Pedidos de Compra
    @type  Function
    @author João Pedro Fazoli de Souza
    @since 05/04/2023
    /*/
User Function L10EX05()
    local oReport := GeraRelatorio()

    oReport:PrintDialog()
Return 


Static Function GeraRelatorio()
    local cAlias     := GetNextAlias()
    local oRelatorio := TReport():NEW('L10EX05', 'Relatório do Pedido de Compra',, {|oRelatorio| ImprimeDados(oRelatorio,cAlias)}, 'Relatório para Impressão do Pedido de Compra', .F.)
    local oSection1   := TRSection():NEW(oRelatorio, 'Pedido')
    local oSection2   := TRSection():NEW(oRelatorio, 'Itens')
    

    TRCELL():New(oSection1, 'C7_NUM'     , 'SC7', 'Num Pedido'       ,/*PICTURE*/      , 100  ,,, 'LEFT',.F., 'LEFT',,, .F.,,, .T.)
    TRCELL():New(oSection1, 'C7_EMISSAO' , 'SC7', 'Data de Emissao'  ,'@R 9999/99/99'  , 100  ,,, 'LEFT',.F., 'LEFT',,, .F.,,, .T.)
    TRCELL():New(oSection1, 'C7_FORNECE' , 'SC7', 'Código Fornecedor',/*PICTURE*/      , 100  ,,, 'LEFT',.F., 'LEFT',,, .F.,,, .T.)
    TRCELL():New(oSection1, 'C7_LOJA'    , 'SC7', 'Loja'             ,/*PICTURE*/      , 100  ,,, 'LEFT',.F., 'LEFT',,, .F.,,, .T.)
    TRCELL():New(oSection1, 'C7_COND'    , 'SC7', 'Cond. Pagamento'  ,/*PICTURE*/      , 100  ,,, 'LEFT',.F., 'LEFT',,, .F.,,, .T.)

    TRCELL():New(oSection2, 'C7_PRODUTO' , 'SC7', 'Produto'          ,/*PICTURE*/      , 8    ,,, 'CENTER',.F., 'CENTER',,, .T.,,, .T.)
    TRCELL():New(oSection2, 'C7_DESCRI'  , 'SC7', 'Descrição'        ,/*PICTURE*/      , 50   ,,, 'LEFT'  ,.T., 'LEFT'  ,,, .T.,,, .T.)
    TRCELL():New(oSection2, 'C7_QUANT'   , 'SC7', 'Quantidade'       ,/*PICTURE*/      , 10   ,,, 'CENTER',.F., 'CENTER',,, .T.,,, .T.)
    TRCELL():New(oSection2, 'C7_PRECO'   , 'SC7', 'Preço'            ,'@R R$999999.99' , 10   ,,, 'LEFT'  ,.F., 'LEFT'  ,,, .T.,,, .T.)
    TRCELL():New(oSection2, 'C7_TOTAL'   , 'SC7', 'Total'            ,'@R R$999999.99' , 10   ,,, 'LEFT'  ,.F., 'LEFT'  ,,, .T.,,, .T.)
    

Return oRelatorio

Static Function ImprimeDados(oRelatorio,cAlias)
    local oSection1  := oRelatorio:Section(1)
    local oSection2  := oRelatorio:Section(2)
    local cPedido    := ''
    local nCont      := 0
    local nTotalReg  := 0
    local cQuery     := ConstroiQry()

    DbUseArea(.T., 'TOPCONN', TcGenQry(,,cQuery), cAlias, .T., .T.)

    COUNT TO nTotalReg

    oRelatorio:SetMeter(nTotalReg)
    oRelatorio:SetTitle('Relatorio de Produtos')
    oRelatorio:StartPage()

    oSection1:ForceLineStyle()

    oRelatorio:PageTotalInLine(.F.)
    (cAlias)->(DbGoTop())


    while (cAlias)->(!EOF())
        if oRelatorio:Cancel()
            exit
        endif

        if cPedido <> Alltrim((cAlias)->(C7_NUM)) //! Verifica se o Código foi trocado no sistema
            if nCont > 0 
                //! Se não for a primeira execução Finaliza a Seção de Itens anterior
                oSection2:Finish()
            endif
            oSection1:Init()

            oSection1:Cell('C7_NUM'):SetValue((cAlias)->(C7_NUM))
            oSection1:Cell('C7_EMISSAO'):SetValue((cAlias)->(C7_EMISSAO))
            oSection1:Cell('C7_FORNECE'):SetValue((cAlias)->(C7_FORNECE))
            oSection1:Cell('C7_LOJA'):SetValue((cAlias)->(C7_LOJA))
            oSection1:Cell('C7_COND'):SetValue((cAlias)->(C7_COND))

            nCont++
            cPedido := Alltrim((cAlias)->(C7_NUM))
            oSection1:PrintLine()
            oSection1:Finish()
            oSection2:Init()
        endif

        //! Imprime os Itens do Pedido
        oSection2:Cell('C7_PRODUTO'):SetValue((cAlias)->(C7_PRODUTO))
        oSection2:Cell('C7_DESCRI'):SetValue((cAlias)->(C7_DESCRI))
        oSection2:Cell('C7_QUANT'):SetValue((cAlias)->(C7_QUANT))
        oSection2:Cell('C7_PRECO'):SetValue((cAlias)->(C7_PRECO))
        oSection2:Cell('C7_TOTAL'):SetValue((cAlias)->(C7_TOTAL))
            

        oSection2:PrintLine()

        oRelatorio:ThinLine()

        oRelatorio:IncMeter()

        (cAlias)->(DbSkip())
    enddo
    
    (cAlias)->(DbCloseArea())

    oRelatorio:EndPage()
Return

Static Function ConstroiQry()
    local cQuery := ''

    cQuery := 'SELECT C7_NUM, C7_EMISSAO, C7_FORNECE, C7_LOJA, C7_COND, C7_PRODUTO, C7_DESCRI, C7_QUANT, C7_PRECO, C7_TOTAL FROM ' + RetSqlName('SC7') + CRLF
    cQuery += "WHERE D_E_L_E_T_ = ' '" + CRLF
    cQuery += "ORDER BY C7_NUM"
Return cQuery
