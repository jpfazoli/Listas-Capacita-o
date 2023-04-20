#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function L10EX06
    Imprime Relatório de Pedido de Vendas
    @type  Function
    @author João Pedro Fazoli de Souza
    @since 11/04/2023
    /*/
User Function L10EX06()
    local oReport := GeraRelatorio()

    oReport:PrintDialog()
Return 

Static Function GeraRelatorio()
    local cAlias     := GetNextAlias()
    local oRelatorio := TReport():NEW('L10EX06', 'Relatório do Pedido de Venda',, {|oRelatorio| ImprimeDados(oRelatorio,cAlias)}, 'Relatório para Impressão do Pedido de Venda', .F.)
    local oSection1   := TRSection():NEW(oRelatorio, 'Pedido')
    local oSection2   := TRSection():NEW(oSection1, 'Itens')

    TRCELL():New(oSection1, 'C5_NUM'     , 'SC5', 'Num Pedido de Venda' ,/*PICTURE*/      , 100  ,,, 'LEFT',.F., 'LEFT',,, .F.,,, .T.)
    TRCELL():New(oSection1, 'A1_NOME'    , 'SA1', 'Nome Cliente'        ,/*PICTURE*/      , 100  ,,, 'LEFT',.F., 'LEFT',,, .F.,,, .T.)
    TRCELL():New(oSection1, 'C5_EMISSAO' , 'SC5', 'Emissão do Pedido'   ,/*PICTURE*/      , 100  ,,, 'LEFT',.F., 'LEFT',,, .F.,,, .T.)
    TRCELL():New(oSection1, 'E4_DESCRI'  , 'SE4', 'Cond. Pagamento'     ,/*PICTURE*/      , 100  ,,, 'LEFT',.F., 'LEFT',,, .F.,,, .T.)

    TRCELL():New(oSection2, 'C6_ITEM'    , 'SC6', 'N° Item'             ,/*PICTURE*/      , 8    ,,, 'CENTER',.F., 'CENTER',,, .T.,,, .T.)
    TRCELL():New(oSection2, 'C6_PRODUTO' , 'SC6', 'Código'              ,/*PICTURE*/      , 8    ,,, 'CENTER',.T., 'CENTER',,, .T.,,, .T.)
    TRCELL():New(oSection2, 'C6_DESCRI'  , 'SC6', 'Descrição'           ,/*PICTURE*/      , 50   ,,, 'LEFT'  ,.F., 'LEFT'  ,,, .T.,,, .T.)
    TRCELL():New(oSection2, 'C6_QTDVEN'  , 'SC6', 'Quantidade'          ,/*PICTURE*/      , 10   ,,, 'CENTER',.F., 'CENTER',,, .T.,,, .T.)
    TRCELL():New(oSection2, 'C6_PRCVEN'  , 'SC6', 'Valor Unitário'      ,'@R R$999999.99' , 10   ,,, 'LEFT'  ,.F., 'LEFT'  ,,, .T.,,, .T.)
    TRCELL():New(oSection2, 'C6_VALOR'   , 'SC6', 'Valor Total'         ,'@R R$999999.99' , 10   ,,, 'LEFT'  ,.F., 'LEFT'  ,,, .T.,,, .T.)

    oBreak := TRBreak():New(oSection1, oSection1:Cell('C5_NUM'), '', .T.)
    TRFunction():New(oSection2:Cell('C6_VALOR'), 'VALTOT', 'SUM', oBreak, 'VALOR TOTAL',"@R R$999999.99",, .F., .F., .F.) 
Return oRelatorio

Static Function ImprimeDados(oRelatorio,cAlias)
    local oSection1  := oRelatorio:Section(1)
    local oSection2  := oSection1:Section(1)
    local nTotalReg  := 0
    local cQuery     := ConstroiQry()

    DbUseArea(.T., 'TOPCONN', TcGenQry(,,cQuery), cAlias, .T., .T.)

    COUNT TO nTotalReg

    oRelatorio:SetMeter(nTotalReg)
    oRelatorio:SetTitle('Relatorio de Pedido de Venda')
    oRelatorio:StartPage()

    oSection1:ForceLineStyle()

    oRelatorio:PageTotalInLine(.F.)
    (cAlias)->(DbGoTop())

    //!Impressão de Cabeçalho
    oSection1:Init()
    oSection1:Cell('C5_NUM'):SetValue((cAlias)->(C5_NUM))
    oSection1:Cell('A1_NOME'):SetValue((cAlias)->(A1_NOME))
    oSection1:Cell('C5_EMISSAO'):SetValue(STOD((cAlias)->(C5_EMISSAO)))
    oSection1:Cell('E4_DESCRI'):SetValue((cAlias)->(E4_DESCRI))
    oSection1:PrintLine()


    //!Impressão de Itens
    while (cAlias)->(!EOF())
        if oRelatorio:Cancel()
            exit
        endif
        oSection2:Init()
        oSection2:Cell('C6_ITEM'):SetValue((cAlias)->(C6_ITEM))
        oSection2:Cell('C6_PRODUTO'):SetValue((cAlias)->(C6_PRODUTO))
        oSection2:Cell('C6_DESCRI'):SetValue((cAlias)->(C6_DESCRI))
        oSection2:Cell('C6_QTDVEN'):SetValue((cAlias)->(C6_QTDVEN))
        oSection2:Cell('C6_PRCVEN'):SetValue((cAlias)->(C6_PRCVEN))
        oSection2:Cell('C6_VALOR'):SetValue((cAlias)->(C6_VALOR))

        oSection2:PrintLine()

        oRelatorio:IncMeter()

        (cAlias)->(DbSkip())
    enddo
    oSection1:Finish()
    oSection2:Finish()
    (cAlias)->(DbCloseArea())

    oRelatorio:EndPage()
Return

Static Function ConstroiQry()
    local cQuery := ''

    cQuery := 'SELECT SC5.C5_NUM, SA1.A1_NOME, SC5.C5_EMISSAO, SE4.E4_DESCRI, SC6.C6_ITEM, SC6.C6_PRODUTO, SC6.C6_DESCRI, SC6.C6_QTDVEN, SC6.C6_PRCVEN, SC6.C6_VALOR  FROM '  + RetSqlName('SC5') + ' SC5' + CRLF
    cQuery += 'INNER JOIN '  + RetSqlName('SA1') + ' SA1 ON SC5.C5_CLIENTE = SA1.A1_COD' + CRLF
    cQuery += 'INNER JOIN '  + RetSqlName('SE4') + ' SE4 ON SC5.C5_CONDPAG = SE4.E4_CODIGO' + CRLF
    cQuery += 'INNER JOIN '  + RetSqlName('SC6') + ' SC6 ON SC5.C5_NUM = SC6.C6_NUM' + CRLF
    cQuery += "WHERE SC5.D_E_L_E_T_ = ' ' AND SC6.D_E_L_E_T_ = ' ' AND SE4.D_E_L_E_T_ = ' ' AND SA1.D_E_L_E_T_ = ' ' AND SC5.C5_NUM = '" + SC5->C5_NUM + "' " + CRLF
    cQuery += 'ORDER BY SC5.C5_NUM'
Return cQuery
