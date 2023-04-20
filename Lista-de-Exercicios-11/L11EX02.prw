#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'FWPRINTSETUP.CH'
#INCLUDE 'RPTDEF.CH'

#DEFINE PRETO    RGB(000,000,000)
#DEFINE MAX_LINE 770

/*/{Protheus.doc} User Function L11EX02
    Imprime Relat�rio de Fornecedor Selecionado
    @type  Function
    @author user
    @since 14/04/2023
    /*/
User Function L11EX02()
    local cAlias := GeraCons()

    if !Empty(cAlias)
        Processa({|| MontaRel(cAlias)}, 'Aguarde...', 'Imprimindo Relat�rio')
    else
        FwAlertError('Nenhum Registro Encontrado!', 'Aten��o!')
    endif

Return 

Static Function GeraCons()
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ''

    cQuery := 'SELECT A2_COD, A2_NOME, A2_NREDUZ, A2_END, A2_BAIRRO, A2_MUN, A2_EST, A2_CEP, A2_EMAIL, A2_HPAGE FROM ' + RetSqlName('SA2') + CRLF
    cQuery += "WHERE D_E_L_E_T_ = ' ' AND A2_COD = '" + SA2->A2_COD + "'"

    TCQUERY cQuery ALIAS (cAlias) NEW

    (cAlias)->(DbGoTop())

    if (cAlias)->(EOF())
        cAlias := ''
    endif

    RestArea(aArea)
Return cAlias

Static Function MontaRel(cAlias)
    local cCaminho := 'C:\Users\Jo�o Pedro Fazoli\Desktop\'
    local cArquivo := 'RelFornecedor.pdf'

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
    //!Cabe�alho
    oPrint:Box(15,15,60,580,'-8')
    oPrint:Line(35,15,35,580,,'-6')
    oPrint:Say(30,20,  'Empresa/Filial: '+ Alltrim(SM0->M0_NOME) + ' / ' + Alltrim(SM0->M0_FILIAL), oFont14,,PRETO)
    oPrint:Say(50,230, 'Relat�rio de Fornecedor', oFont14,,PRETO)

    // //!R�tulo de Dados
    oPrint:Box(70,15,770,580,'-8')

    //!Rodap�
    oPrint:Box(780,15,820,580,'-8')
    oPrint:SayBitmap( 785, 220, "D:\TOTVS\Capacitacao\ADVPL\Exercicios\Lista-de-Exercicios-11\logo-totvs.png", 120, 35) //!Logo Centralizado

Return

Static Function ImpDados(cAlias)
    local incremento := 20
    Private nCor    := PRETO

    DbSelectArea(cAlias)

    (cAlias)->(DbGoTop())

    oPrint:Say(nLinha,210 ,'DADOS DO FORNECEDOR'   , oFont16,,nCor)
    
    //!Impress�o de Informa��es
    nLinha += incremento
    oPrint:Say(nLinha,20 ,'C�digo:'   , oFont12B,,nCor)
    oPrint:Say(nLinha,55 ,Alltrim((cAlias)->(A2_COD))   , oFont12,,nCor)
    nLinha += incremento
    oPrint:Say(nLinha,20 ,'Nome Fornecedor:'  , oFont12B,,nCor)
    oPrint:Say(nLinha,105 ,Alltrim((cAlias)->(A2_NOME))  , oFont12,,nCor)
    nLinha += incremento
    oPrint:Say(nLinha,20 ,'Nome Fantasia:'  , oFont12B,,nCor)
    oPrint:Say(nLinha,90 ,Alltrim((cAlias)->(A2_NREDUZ))  , oFont12,,nCor)
    nLinha += incremento
    oPrint:Say(nLinha,20 ,'Endere�o:'  , oFont12B,,nCor)
    oPrint:Say(nLinha,67 ,Alltrim((cAlias)->(A2_END))  , oFont12,,nCor)
    nLinha += incremento
    oPrint:Say(nLinha,20 ,'Bairro:'  , oFont12B,,nCor)
    oPrint:Say(nLinha,53 ,Alltrim((cAlias)->(A2_BAIRRO))  , oFont12,,nCor)
    oPrint:Say(nLinha,200,'Cidade:'  , oFont12B,,nCor)
    oPrint:Say(nLinha,235 ,Alltrim((cAlias)->(A2_MUN)) + ' - ' + Alltrim((cAlias)->(A2_EST))  , oFont12,,nCor)
    nLinha += incremento
    oPrint:Say(nLinha,20 ,'CEP:'  , oFont12B,,nCor)
    oPrint:Say(nLinha,45 ,Alltrim(TRANSFORM((cAlias)->(A2_CEP),'@R 99.999-999'))  , oFont12,,nCor)
    nLinha += incremento
    oPrint:Say(nLinha,20 ,'E-mail:'  , oFont12B,,nCor)
    oPrint:Say(nLinha,55 ,Alltrim((cAlias)->(A2_EMAIL))  , oFont12,,nCor)
    oPrint:Say(nLinha,200 ,'Site:'  , oFont12B,,nCor)
    oPrint:Say(nLinha,225 ,Alltrim((cAlias)->(A2_HPAGE))  , oFont12,,nCor)

    IncProc()

    (cAlias)->(DbCLoseArea())
Return
