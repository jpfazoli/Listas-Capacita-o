#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

#DEFINE ESQUERDA  1
#DEFINE CENTRO    2
#DEFINE DIREITA   3

#DEFINE GERAL       1
#DEFINE NUMERICO    2
#DEFINE MONETARIO   3
#DEFINE DATETIME    4

/*/{Protheus.doc} User Function L12EX02
    Gerador de Planilhas com todos os Registros de Produtos
    @type  Function
    @author João Pedro Fazoli de Souza
    @since 19/04/2023
    /*/
User Function L12EX02()
    local cPath       := 'C:\Users\João Pedro Fazoli\Desktop\'
    local cArq        := 'L12EX02.xls'
    local cAlias      := GetNextAlias()
    local cQuery      := GeraQuery()
    Private cPasta    := 'Produtos'
    Private cTable    := 'Dados dos Produtos'
    Private oExcel    := FwMsExcelEx():New()

    

    TCQUERY cQuery ALIAS &(cAlias) NEW
    
    oExcel:AddWorkSheet(cPasta)

    oExcel:AddTable(cPasta, cTable)

    //! Colunas a serem usadas
    oExcel:AddColumn(cPasta, cTable, PADR('Código', 8)           , CENTRO    , 1)
    oExcel:AddColumn(cPasta, cTable, PADR('Descrição',40)        , ESQUERDA  , 1)
    oExcel:AddColumn(cPasta, cTable, PADR('Tipo',5)             , CENTRO    , 1)
    oExcel:AddColumn(cPasta, cTable, PADR('Unidade de Medida',5), CENTRO    , 1)
    oExcel:AddColumn(cPasta, cTable, PADR('Preço de Venda',15)   , ESQUERDA  , 3)

    //!Estilo Titulo
    oExcel:SetTitleFont('Arial')
    oExcel:SetTitleSizeFont(14)
    oExcel:SetTitleBold(.T.)
    oExcel:SetTitleBgColor('#2F4F4F')
    oExcel:SetTitleFrColor('#FFFFFF')

    //!Estilo Cabeçalho
    oExcel:SetHeaderFont('Arial')
    oExcel:SetHeaderSizeFont(12)
    oExcel:SetHeaderBold(.T.)
    oExcel:SetBgColorHeader('#228B22')
    oExcel:SetFrColorHeader('#FFFFFF')
    //!Estilo Linha 1
    oExcel:SetLineFont('Arial')
    oExcel:SetLineSizeFont(10)
    oExcel:SetLineBgColor('#98FB98')
    oExcel:SetLineFrColor('#000000')
    //!Estilo Linha 2
    oExcel:Set2LineFont('Arial')
    oExcel:Set2LineSizeFont(10)
    oExcel:Set2LineBgColor('#90EE90')
    oExcel:Set2LineFrColor('#000000')


    oExcel:SetCelBgColor("#FF0000")
    oExcel:SetCelFrColor("#ffffff")

    if !Empty(cAlias)
        ImpDados(cAlias)

        oExcel:ACTIVATE()
        oExcel:GetXMLFile(cPath + cArq)

        if ApOleClient('MsExcel')
            oExec := MsExcel():New()
            oExec:WorkBooks:Open(cPath + cArq)
            oExec:SetVisible(.T.)
        else
            FwAlertError('Excel não encontrado no Windows', 'Excel não Encontrado')
        endif

        FwAlertSuccess('Arquivo Gerado com Sucesso', 'Concluido')
        oExcel:DeActivate()
    else
        FwAlertError('Não foram encontrados Resultados')
    endif

Return 

Static Function GeraQuery()
    local cQuery := ''

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    cQuery := 'SELECT SB1.B1_COD, SB1.B1_DESC, SB1.B1_TIPO, SB1.B1_UM, SB1.B1_PRV1, SB1.D_E_L_E_T_ AS Deletado FROM ' + RetSqlName('SB1')+ ' SB1' + CRLF
    cQuery += 'ORDER BY SB1.B1_COD'

Return cQuery

Static Function ImpDados(cAlias)
    local cCodigo
    local cDesc
    local cTipo
    local cUnid
    local cPreco

    while (cAlias)->(!EOF())
        cCodigo   := Alltrim((cAlias)->(B1_COD))
        cDesc     := Alltrim((cAlias)->(B1_DESC))
        cTipo     := Alltrim((cAlias)->(B1_TIPO))
        cUnid     := Alltrim((cAlias)->(B1_UM))
        cPreco    := (cAlias)->(B1_PRV1)


        if (cAlias)->(Deletado) == '*'
            oExcel:AddRow(cPasta, cTable,{cCodigo,cDesc,cTipo,cUnid,cPreco},{1,2,3,4,5})
        else
            oExcel:AddRow(cPasta, cTable,{cCodigo,cDesc,cTipo,cUnid,cPreco})
        endif
        (cAlias)->(DbSkip())
    enddo
Return
