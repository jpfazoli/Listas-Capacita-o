#INCLUDE 'TOTVS.CH'
#INCLUDE 'REPORT.CH'

/*/{Protheus.doc} User Function L10EX1
    Função para Criação de Relatório de Produtos
    @type  Function
    @author João Pedro Fazoli de Souza
    @since 05/04/2023
    /*/
User Function L10EX01()
    local oReport := GeraRelatorio()

    oReport:PrintDialog()
Return 


Static Function GeraRelatorio()
    local cAlias     := GetNextAlias()
    local oRelatorio := TReport():NEW('L10EX1', 'Relatório de Produtos',, {|oRelatorio| ImprimeDados(oRelatorio,cAlias)}, 'Relatório para Impressão de Produtos', .F.)
    local oSection   := TRSection():NEW(oRelatorio, 'Seção de Produtos')

    TRCELL():New(oSection, 'B1_COD'   , 'SB1', 'Código'          ,/*PICTURE*/      , 8 ,,, 'CENTER',.F., 'CENTER',,, .F.,,, .T.)
    TRCELL():New(oSection, 'B1_DESC'  , 'SB1', 'Descrição'       ,/*PICTURE*/      , 70,,, 'LEFT'  ,.T., 'LEFT'  ,,, .F.,,, .T.)
    TRCELL():New(oSection, 'B1_UM'    , 'SB1', 'Un. Medida'      ,/*PICTURE*/      , 30,,, 'CENTER',.F., 'CENTER',,, .F.,,, .T.)
    TRCELL():New(oSection, 'B1_PRV1'  , 'SB1', 'Preço de Venda'  ,'@E R$999,999.99', 26,,, 'LEFT'  ,.F., 'LEFT'  ,,, .F.,,, .T.)
    TRCELL():New(oSection, 'B1_LOCPAD', 'SB1', 'Armazém'         ,/*PICTURE*/      , 17,,, 'CENTER',.F., 'CENTER',,, .F.,,, .T.)
  
Return oRelatorio

Static Function ImprimeDados(oRelatorio,cAlias)
    local oSection  := oRelatorio:Section(1)
    local nTotalReg := 0
    local cQuery    := ConstroiQry()

    DbUseArea(.T., 'TOPCONN', TcGenQry(,,cQuery), cAlias, .T., .T.)

    COUNT TO nTotalReg

    oRelatorio:SetMeter(nTotalReg)
    oRelatorio:SetTitle('Relatorio de Produtos')
    oRelatorio:StartPage()

    oSection:Init()

    (cAlias)->(DbGoTop())

    while (cAlias)->(!EOF())
        if oRelatorio:Cancel()
            exit
        endif

        oSection:Cell('B1_COD'):SetValue((cAlias)->(B1_COD))
        oSection:Cell('B1_DESC'):SetValue((cAlias)->(B1_DESC))
        oSection:Cell('B1_UM'):SetValue((cAlias)->(B1_UM))
        oSection:Cell('B1_PRV1'):SetValue((cAlias)->(B1_PRV1))
        oSection:Cell('B1_LOCPAD'):SetValue((cAlias)->(B1_LOCPAD))

        oSection:PrintLine()

        oRelatorio:ThinLine()

        oRelatorio:IncMeter()

        (cAlias)->(DbSkip())
    enddo

    (cAlias)->(DbCloseArea())

    oRelatorio:EndPage()

Return

Static Function ConstroiQry()
    local cQuery := ''

    cQuery := 'SELECT B1_COD, B1_DESC, B1_UM, B1_PRV1, B1_LOCPAD FROM ' + RetSqlName('SB1') + CRLF
    cQuery += "WHERE D_E_L_E_T_ = ' '"
Return cQuery
