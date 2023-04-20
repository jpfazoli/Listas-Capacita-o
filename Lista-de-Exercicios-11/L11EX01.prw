#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'FWPRINTSETUP.CH'
#INCLUDE 'RPTDEF.CH'

#DEFINE PRETO    RGB(000,000,000)
#DEFINE VERMELHO RGB(255,000,000)
#DEFINE MAX_LINE 770

/*/{Protheus.doc} User Function L11EX01
    Imprime Relatório de Produtos
    @type  Function
    @author user
    @since 14/04/2023
    /*/
User Function L11EX01()
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

    cQuery := 'SELECT B1_COD, B1_DESC, B1_UM, B1_PRV1, B1_LOCPAD FROM ' + RetSqlName('SB1') + CRLF
    cQuery += "WHERE D_E_L_E_T_ = ' '" + CRLF
    cQuery += "ORDER BY B1_COD"

    TCQUERY cQuery ALIAS (cAlias) NEW

    (cAlias)->(DbGoTop())

    if (cAlias)->(EOF())
        cAlias := ''
    endif

    RestArea(aArea)
Return cAlias

Static Function MontaRel(cAlias)
    local cCaminho := 'C:\Users\João Pedro Fazoli\Desktop\'
    local cArquivo := 'RelProdutos.pdf'

    Private nLinha := 80
    Private oPrint
    Private oFont10  := TFont():New('Arial',,10,, .F.,,,,,.F.,.F.)
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
    oPrint:Say(50,220, 'Relatório de Produtos', oFont14,,PRETO)

    //!Rótulo de Dados
    oPrint:Box(90,15,770,580,'-8')
    oPrint:Say(nLinha,25 , 'Código',oFont12B,,PRETO)
    oPrint:Say(nLinha,80 , 'Descrição',oFont12B,,PRETO)
    oPrint:Say(nLinha,350, 'Un. Medida',oFont12B,,PRETO)
    oPrint:Say(nLinha,420, 'Preço de Venda',oFont12B,,PRETO)
    oPrint:Say(nLinha,520 , 'Armazém',oFont12B,,PRETO)
    nLinha += 20
    //!Rodapé
    oPrint:Box(780,15,820,580,'-8')
    oPrint:SayBitmap( 785, 220, "D:\TOTVS\Capacitacao\ADVPL\Exercicios\Lista-de-Exercicios-11\logo-totvs.png", 120, 35) //!Logo Centralizado

Return

Static Function ImpDados(cAlias)
    local cPreco    := ''
    Private nCor    := PRETO

    DbSelectArea(cAlias)

    (cAlias)->(DbGoTop())

    while (cAlias)->(!EOF())
        QuebPag()

        cPreco := "R$ " + Alltrim(Str((cAlias)->(B1_PRV1),,2))

        oPrint:Say(nLinha,25 ,Alltrim((cAlias)->(B1_COD))   , oFont10,,nCor)
        oPrint:Say(nLinha,80 ,Alltrim((cAlias)->(B1_DESC))  , oFont10,,nCor)
        oPrint:Say(nLinha,370,Alltrim((cAlias)->(B1_UM))    , oFont10,,nCor)
        oPrint:Say(nLinha,420,cPreco  , oFont10,,nCor)
        oPrint:Say(nLinha,535,Alltrim((cAlias)->(B1_LOCPAD)), oFont10,,nCor)
        nLinha += 20

        IncProc()

        (cAlias)->(DbSkip())
    enddo

    (cAlias)->(DbCLoseArea())
Return

Static Function QuebPag()

    if nLinha > MAX_LINE
        oPrint:EndPage()
        oPrint:StartPage()
        nLinha := 80
        Estrutura()
    endif

Return
