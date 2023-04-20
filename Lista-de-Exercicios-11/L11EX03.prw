#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'FWPRINTSETUP.CH'
#INCLUDE 'RPTDEF.CH'

#DEFINE PRETO    RGB(000,000,000)
#DEFINE MAX_LINE 760

/*/{Protheus.doc} User Function L11EX03
    Imprime Relatório de Pedido de Compra 
    @type  Function
    @author user
    @since 14/04/2023
    /*/
User Function L11EX03()
    local cAlias := GeraCons()

    if !Empty(cAlias)
        Processa({|| MontaRel(cAlias)}, 'Aguarde...', 'Imprimindo Relatório')
    else
        FwAlertError('Nenhum Registro Encontrado!', 'Atenção!')
    endif

Return 

Static Function GeraCons()
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ''

    cQuery := 'SELECT SC7.C7_NUM, SC7.C7_EMISSAO, SC7.C7_FORNECE, SC7.C7_LOJA, SC7.C7_COND, SC7.C7_PRODUTO, SC7.C7_DESCRI, SC7.C7_QUANT, SC7.C7_PRECO, SC7.C7_TOTAL, SE4.E4_DESCRI, SA2.A2_NOME FROM ' + RetSqlName('SC7') + ' SC7'+ CRLF
    cQuery += 'INNER JOIN ' + RetSQLName('SE4') +' SE4 ON SC7.C7_COND = SE4.E4_CODIGO' + CRLF
    cQuery += 'INNER JOIN ' + RetSQLName('SA2') +' SA2 ON SC7.C7_FORNECE = SA2.A2_COD' + CRLF
    cQuery += "WHERE SC7.D_E_L_E_T_ = ' ' AND C7_NUM = '" + SC7->C7_NUM + "'" + CRLF

    TCQUERY cQuery ALIAS (cAlias) NEW

    (cAlias)->(DbGoTop())

    if (cAlias)->(EOF())
        cAlias := ''
    endif

    RestArea(aArea)
Return cAlias

Static Function MontaRel(cAlias)
    local cCaminho := 'C:\Users\João Pedro Fazoli\Desktop\'
    local cArquivo := 'RelPedCompra.pdf'

    Private nLinha := 90
    Private oPrint
    Private oFont10  := TFont():New('Arial',,10,, .F.,,,,,.F.,.F.)
    Private oFont10B := TFont():New('Arial',,10,, .T.,,,,,.F.,.F.)
    Private oFont12  := TFont():New('Arial',,12,, .F.,,,,,.F.,.F.)
    Private oFont12B := TFont():New('Arial',,12,, .T.,,,,,.F.,.F.)
    Private oFont14  := TFont():New('Arial',,14,, .F.,,,,,.F.,.F.)
    Private oFont16  := TFont():New('Arial',,16,, .T.,,,,,.T.,.F.)

    oPrint := FwMsPrinter():New(cArquivo,IMP_PDF, .F., '', .T.,, @oPrint, '',,,,.T.)
    oPrint:cPathPDF := cCaminho

    oPrint:SetPortrait()
    oPrint:SetPaperSize(9)

    oPrint:StartPage()
    Estrutura()
    ImpDados(cAlias)

    oPrint:EndPage()
    oPrint:Preview()
Return

Static Function Estrutura()
    //!Cabeçalho
    oPrint:Box(15,15,60,580,'-8')
    oPrint:Line(35,15,35,580,,'-6')
    oPrint:Say(30,20,  'Empresa/Filial: '+ Alltrim(SM0->M0_NOME) + ' / ' + Alltrim(SM0->M0_FILIAL), oFont14,,PRETO)
    oPrint:Say(50,230, 'Relatório de Fornecedor', oFont14,,PRETO)

    // //!Rótulo de Dados
    oPrint:Box(70,15,770,580,'-8')

    //!Rodapé
    oPrint:Box(780,15,820,580,'-8')
    oPrint:SayBitmap( 785, 220, "D:\TOTVS\Capacitacao\ADVPL\Exercicios\Lista-de-Exercicios-11\logo-totvs.png", 120, 35) //!Logo Centralizado
    // oPrint:SayBitmap( 785, 450, "D:\TOTVS\Capacitacao\ADVPL\Exercicios\Lista-de-Exercicios-11\logo-totvs.png", 120, 35) //!Logo a Direita

Return

Static Function ImpDados(cAlias)
    local incremento := 20
    local cPreco     := ''
    Private nCor    := PRETO

    DbSelectArea(cAlias)

    (cAlias)->(DbGoTop())
    
    //!Impressão de Informações de Cabecalho
    oPrint:Say(nLinha,20  ,'Número do Pedido:'   , oFont12B,,nCor)
    oPrint:Say(nLinha,110 ,Alltrim((cAlias)->(C7_NUM))   , oFont12,,nCor)
    oPrint:Say(nLinha,260 ,'Cód. Fornecedor:'  , oFont12B,,nCor)
    oPrint:Say(nLinha,340 ,Alltrim((cAlias)->(C7_FORNECE))  , oFont12,,nCor)
    oPrint:Say(nLinha,380 ,'Loja:'  , oFont12B,,nCor)
    oPrint:Say(nLinha,405 ,Alltrim((cAlias)->(C7_LOJA))  , oFont12,,nCor)
    nLinha += incremento
    oPrint:Say(nLinha,20 ,'Fornecedor:'  , oFont12B,,nCor)
    oPrint:Say(nLinha,85 ,Alltrim((cAlias)->(A2_NOME))  , oFont12,,nCor)
    oPrint:Say(nLinha,260 ,'Data Emissão:'  , oFont12B,,nCor)
    oPrint:Say(nLinha,330 ,TRANSFORM(DTOC(STOD((cAlias)->(C7_EMISSAO))), '@R 99/99/9999')  , oFont12,,nCor)
    nLinha += incremento
    oPrint:Say(nLinha,20 ,'Cond. Pagamento:'  , oFont12B,,nCor)
    oPrint:Say(nLinha,105 ,Alltrim((cAlias)->(C7_COND)) + ' - ' + Alltrim((cAlias)->(E4_DESCRI)), oFont12,,nCor)
    nLinha += incremento

    CabecItem()

    //!Imprime os Dados do Fornecedor
    while (cAlias)->(!EOF())
        QuebPag()

        oPrint:Say(nLinha,30 , (cAlias)->(C7_PRODUTO) ,oFont10,,PRETO)
        oPrint:Say(nLinha,80 , (cAlias)->(C7_DESCRI)  ,oFont10,,PRETO)
        oPrint:Say(nLinha,360, CValToChar((cAlias)->(C7_QUANT))   ,oFont10,,PRETO)
        cPreco := 'R$' + Alltrim(Str((cAlias)->(C7_PRECO),,2))
        oPrint:Say(nLinha,415, cPreco                 ,oFont10,,PRETO)
        cPreco := 'R$' + Alltrim(Str((cAlias)->(C7_TOTAL),,2))
        oPrint:Say(nLinha,500, cPreco                 ,oFont10,,PRETO)
        nLinha += 20
        IncProc()
        (cAlias)->(DbSkip())
    enddo



    (cAlias)->(DbCLoseArea())
Return

Static Function CabecItem()
    oPrint:Say(nLinha,280, 'ITENS', oFont12B,,nCor)
    nLinha += 10
    oPrint:Box(nLinha,20,MAX_LINE,575,'-8')
    nLinha += 20
    oPrint:Say(nLinha,30 , 'Código'         ,oFont12B,,PRETO)
    oPrint:Say(nLinha,80 , 'Descrição'      ,oFont12B,,PRETO)
    oPrint:Say(nLinha,340, 'Quantidade'     ,oFont12B,,PRETO)
    oPrint:Say(nLinha,415, 'Valor Unitário' ,oFont12B,,PRETO)
    oPrint:Say(nLinha,500, 'Valor Total'    ,oFont12B,,PRETO)
    nLinha += 5
    oPrint:Line(nLinha,30,nLinha,555,,'-6')
    nLinha += 20
Return

Static Function QuebPag()

    if nLinha > MAX_LINE
        oPrint:EndPage()
        oPrint:StartPage()
        nLinha := 90
        Estrutura()
        CabecItem()
    endif

Return
