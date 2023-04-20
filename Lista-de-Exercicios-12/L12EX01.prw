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

/*/{Protheus.doc} User Function L12EX01
    Gerador de Planilhas com todos os Registros de Fornecedores
    @type  Function
    @author João Pedro Fazoli de Souza
    @since 19/04/2023
    /*/
User Function L12EX01()
    local cPath       := 'C:\Users\João Pedro Fazoli\Desktop\'
    local cArq        := 'L12EX01.xls'
    local cAlias      := GetNextAlias()
    local cQuery      := GeraQuery()
    Private cPasta    := 'Fornecedores'
    Private cTable    := 'Dados Fornecedores'
    Private oExcel    := FwMsExcelEx():New()

    

    TCQUERY cQuery ALIAS &(cAlias) NEW
    
    oExcel:AddWorkSheet(cPasta)

    oExcel:AddTable(cPasta, cTable)

    //! Colunas a serem usadas
    oExcel:AddColumn(cPasta, cTable, PADR('Código',8)   , ESQUERDA  , 1)
    oExcel:AddColumn(cPasta, cTable, PADR('Nome',50)     , ESQUERDA  , 1)
    oExcel:AddColumn(cPasta, cTable, PADR('Loja',5)     , CENTRO    , 1)
    oExcel:AddColumn(cPasta, cTable, PADR('CNPJ',15)     , CENTRO    , 1)
    oExcel:AddColumn(cPasta, cTable, PADR('Endereço',30) , ESQUERDA  , 1)
    oExcel:AddColumn(cPasta, cTable, PADR('Bairro',30)   , ESQUERDA  , 1)
    oExcel:AddColumn(cPasta, cTable, PADR('Cidade',20)   , ESQUERDA  , 1)
    oExcel:AddColumn(cPasta, cTable, PADR('UF',4)       , CENTRO    , 1)

    //!Estilo Titulo
    oExcel:SetTitleFont('Arial')
    oExcel:SetTitleSizeFont(14)
    oExcel:SetTitleBold(.T.)
    oExcel:SetTitleBgColor('#8B4513')
    oExcel:SetTitleFrColor('#FFFFFF')

    //!Estilo Cabeçalho
    oExcel:SetHeaderFont('Arial')
    oExcel:SetHeaderSizeFont(12)
    oExcel:SetHeaderBold(.T.)
    oExcel:SetBgColorHeader('#D2691E')
    oExcel:SetFrColorHeader('#FFFFFF')
    //!Estilo Linha 1
    oExcel:SetLineFont('Arial')
    oExcel:SetLineSizeFont(10)
    oExcel:SetLineBgColor('#F4A460')
    oExcel:SetLineFrColor('#000000')
    //!Estilo Linha 2
    oExcel:Set2LineFont('Arial')
    oExcel:Set2LineSizeFont(10)
    oExcel:Set2LineBgColor('#FFDEAD')
    oExcel:Set2LineFrColor('#000000')


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

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SA2' MODULO 'COM'

    cQuery := 'SELECT SA2.A2_COD, SA2.A2_NOME, SA2.A2_LOJA, SA2.A2_CGC, SA2.A2_END, SA2.A2_NR_END, SA2.A2_BAIRRO, SA2.A2_MUN, SA2.A2_EST FROM ' + RetSqlName('SA2')+ ' SA2' + CRLF
    cQuery += "WHERE SA2.D_E_L_E_T_ = ' ' AND SA2.A2_COD != '      '" + CRLF
    cQuery += 'ORDER BY SA2.A2_COD'

Return cQuery

Static Function ImpDados(cAlias)
    local cCodigo
    local cNome
    local cLoja
    local cCNPJ
    local cEnd
    local cBairro
    local cCidade
    local cUF

    while (cAlias)->(!EOF())
        cCodigo := Alltrim((cAlias)->(A2_COD))
        cNome   := Alltrim((cAlias)->(A2_NOME))
        cLoja   := Alltrim((cAlias)->(A2_LOJA))
        cCNPJ   := Alltrim((cAlias)->(A2_CGC))
        cEnd    := Alltrim((cAlias)->(A2_END))
        cBairro := Alltrim((cAlias)->(A2_NR_END))
        cCidade := Alltrim((cAlias)->(A2_MUN))
        cUF     := Alltrim((cAlias)->(A2_EST))
        oExcel:AddRow(cPasta, cTable,{cCodigo,cNome,cLoja,cCNPJ,cEnd,cBairro,cCidade,cUF} )
        (cAlias)->(DbSkip())
    enddo
Return
