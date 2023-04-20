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

/*/{Protheus.doc} User Function L12EX03
    Gerador de Planilhas com todos os Registros de Alunos e Cursos
    @type  Function
    @author João Pedro Fazoli de Souza
    @since 19/04/2023
    /*/
User Function L12EX03()
    local cPath       := 'C:\Users\João Pedro Fazoli\Desktop\'
    local cArq        := 'L12EX03.xls'
    local cAlias      := GetNextAlias()
    local cQuery      := GeraQuery()
    Private oExcel    := FwMsExcelEx():New()

    TCQUERY cQuery ALIAS &(cAlias) NEW
    
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
    oExcel:SetBgColorHeader('#F4A460')
    oExcel:SetFrColorHeader('#000000')
    //!Estilo Linha 1
    oExcel:SetLineFont('Arial')
    oExcel:SetLineSizeFont(10)
    oExcel:SetLineBgColor('#FFE4C4')
    oExcel:SetLineFrColor('#000000')
    //!Estilo Linha 2
    oExcel:Set2LineFont('Arial')
    oExcel:Set2LineSizeFont(10)
    oExcel:Set2LineBgColor('#FFFFE0')
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

    cQuery := 'SELECT ZZC.ZZC_COD, ZZC.ZZC_NOME, ZZB_COD,ZZB_NOME, ZZ1_IDADE FROM ' + RetSqlName('ZZC') + ' ZZC' + CRLF
    cQuery += "LEFT JOIN "+ RetSqlName('ZZB') + " ZZB ON ZZB.ZZB_CURSO = ZZC.ZZC_COD AND ZZB.D_E_L_E_T_ = ' '" + CRLF
    cQuery += "LEFT JOIN "+ RetSqlName('ZZ1') + " ZZ1 ON ZZ1.ZZ1_COD = ZZB.ZZB_COD AND ZZ1.D_E_L_E_T_ = ' '" + CRLF
    cQuery += "WHERE ZZC.D_E_L_E_T_ = ' '" + CRLF
    cQuery += "ORDER BY ZZC.ZZC_COD"

Return cQuery

Static Function ImpDados(cAlias)
    local aDados[3]
    local cCodCurso := ''
    local cPasta    := ''
    local cTable    := 'Dados do Aluno'


    while (cAlias)->(!EOF())
        
        aDados[1] := (cAlias)->(ZZB_COD)
        aDados[2] := (cAlias)->(ZZB_NOME)
        aDados[3] := (cAlias)->(ZZ1_IDADE)
        
        if cCodCurso <> Alltrim((cAlias)->(ZZC_COD))
                cPasta := Alltrim((cAlias)->(ZZC_NOME))
                oExcel:AddWorkSheet(cPasta)

                oExcel:AddTable(cPasta, cTable)
                cCodCurso := Alltrim((cAlias)->(ZZC_COD))
                //! Colunas a serem usadas
                oExcel:AddColumn(cPasta, cTable, 'Código'    , CENTRO    , GERAL)
                oExcel:AddColumn(cPasta, cTable, 'Nome Aluno', ESQUERDA  , GERAL)
                oExcel:AddColumn(cPasta, cTable, 'Idade'     , CENTRO    , NUMERICO)
        endif

        oExcel:AddRow(cPasta, cTable,aDados)
        (cAlias)->(DbSkip())
    enddo
Return
