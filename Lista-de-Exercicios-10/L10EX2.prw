#INCLUDE 'TOTVS.CH'
#INCLUDE 'REPORT.CH'

/*/{Protheus.doc} User Function L10EX2
    Função para Criação de Relatório do Fornecedor Selecionado
    @type  Function
    @author João Pedro Fazoli de Souza
    @since 05/04/2023
    /*/
User Function L10EX2()
    local oReport := GeraRelatorio()

    oReport:PrintDialog()
Return 


Static Function GeraRelatorio()
    local cAlias     := GetNextAlias()
    local oRelatorio := TReport():NEW('L10EX02', 'Relatório do Fornecedor',, {|oRelatorio| ImprimeDados(oRelatorio,cAlias)}, 'Relatório para Impressão do Fornecedor', .F.)
    local oSection   := TRSection():NEW(oRelatorio, 'Seção do Fornecedor')

    TRCELL():New(oSection, 'A2_COD'     , 'SA2', 'Código'         ,/*PICTURE*/ , 100  ,,, 'LEFT',.F., 'LEFT',,, .F.,,, .T.)
    TRCELL():New(oSection, 'A2_NOME'    , 'SA2', 'Nome Empresa'   ,/*PICTURE*/ , 100  ,,, 'LEFT',.F., 'LEFT',,, .F.,,, .T.)
    TRCELL():New(oSection, 'A2_NREDUZ'  , 'SA2', 'Nome Fantasia'  ,/*PICTURE*/ , 100  ,,, 'LEFT',.F., 'LEFT',,, .F.,,, .T.)
    TRCELL():New(oSection, 'A2_END'     , 'SA2', 'Endereço'       ,/*PICTURE*/ , 100  ,,, 'LEFT',.F., 'LEFT',,, .F.,,, .T.)
    TRCELL():New(oSection, 'A2_BAIRRO'  , 'SA2', 'Bairro'         ,/*PICTURE*/ , 100  ,,, 'LEFT',.F., 'LEFT',,, .F.,,, .T.)
    TRCELL():New(oSection, 'A2_MUN'     , 'SA2', 'Cidade'         ,/*PICTURE*/ , 100  ,,, 'LEFT',.F., 'LEFT',,, .F.,,, .T.)
    TRCELL():New(oSection, 'A2_EST'     , 'SA2', 'UF'             ,/*PICTURE*/ , 100  ,,, 'LEFT',.F., 'LEFT',,, .F.,,, .T.)
    TRCELL():New(oSection, 'A2_CEP'     , 'SA2', 'CEP'            ,/*PICTURE*/ , 100  ,,, 'LEFT',.F., 'LEFT',,, .F.,,, .T.)
    TRCELL():New(oSection, 'A2_EMAIL'   , 'SA2', 'Email'          ,/*PICTURE*/ , 100  ,,, 'LEFT',.F., 'LEFT',,, .F.,,, .T.)
    TRCELL():New(oSection, 'A2_HPAGE'   , 'SA2', 'Site'           ,/*PICTURE*/ , 100  ,,, 'LEFT',.F., 'LEFT',,, .F.,,, .T.)
  
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

    //! Imprime os Dados em Linhas
    oSection:ForceLineStyle()

    oSection:Init()

    oRelatorio:PageTotalInLine(.F.)
    (cAlias)->(DbGoTop())

    while (cAlias)->(!EOF())
        if oRelatorio:Cancel()
            exit
        endif

        oSection:Cell('A2_COD'   ):SetValue((cAlias)->(A2_COD))
        oSection:Cell('A2_NOME'  ):SetValue((cAlias)->(A2_NOME))
        oSection:Cell('A2_NREDUZ'):SetValue((cAlias)->(A2_NREDUZ))
        oSection:Cell('A2_END'   ):SetValue((cAlias)->(A2_END))
        oSection:Cell('A2_BAIRRO'):SetValue((cAlias)->(A2_BAIRRO))
        oSection:Cell('A2_MUN'   ):SetValue((cAlias)->(A2_MUN))
        oSection:Cell('A2_EST'   ):SetValue((cAlias)->(A2_EST))
        oSection:Cell('A2_CEP'   ):SetValue((cAlias)->(A2_CEP))
        oSection:Cell('A2_EMAIL' ):SetValue((cAlias)->(A2_EMAIL))
        oSection:Cell('A2_HPAGE' ):SetValue((cAlias)->(A2_HPAGE))

        oSection:PrintLine()

        oRelatorio:IncMeter()
        (cAlias)->(DbSkip())
    enddo

    (cAlias)->(DbCloseArea())

    oRelatorio:EndPage()
Return

Static Function ConstroiQry()
    local cQuery := ''

    cQuery := 'SELECT A2_COD, A2_NOME, A2_NREDUZ, A2_END, A2_BAIRRO, A2_MUN, A2_EST, A2_CEP, A2_EMAIL, A2_HPAGE FROM ' + RetSqlName('SA2') + CRLF
    cQuery += "WHERE D_E_L_E_T_ = ' ' AND A2_COD = '" + SA2->A2_COD + "'"
Return cQuery


                