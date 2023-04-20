#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'FWPRINTSETUP.CH'
#INCLUDE 'RPTDEF.CH'

#DEFINE PRETO      RGB(000,000,000)
#DEFINE MAX_LINE   760
#DEFINE incremento 15
/*/{Protheus.doc} User Function L11EX06
    Imprime Relatório de Pedido de Venda - Challange
    @type  Function
    @author user
    @since 14/04/2023
    /*/
User Function L11EX06()
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

    cQuery := 'SELECT SC5.C5_NUM, SC5.C5_FRETE,SC5.C5_CLIENTE, SC5.C5_DESPESA, SC5.C5_CONDPAG,SC5.C5_TRANSP, SC5.C5_TPFRETE,SC5.C5_ESPECI1, SC5.C5_VOLUME1, SC5.C5_DESC1, SC5.C5_DESC2, SC5.C5_DESC3, SC5.C5_DESC4, SC5.C5_MENNOTA, SC5.C5_VEND1,' + CRLF
    cQuery += 'SA1.A1_NOME, SA1.A1_HPAGE,SA1.A1_EMAIL, SA1.A1_CONTATO,SA1.A1_END, SA1.A1_BAIRRO, SA1.A1_MUN, SA1.A1_CEP, SA1.A1_DDD, SA1.A1_TEL, SA1.A1_FAX, SA1.A1_CGC, SA1.A1_INSCR,' + CRLF
    cQuery += 'SE4.E4_DESCRI,' + CRLF
    cQuery += 'SC6.C6_ITEM, SC6.C6_PRODUTO, SC6.C6_DESCRI, SC6.C6_UM, SC6.C6_QTDVEN, SC6.C6_PRCVEN, SC6.C6_VALOR, SC6.C6_IPITRF, SC6.C6_ENTREG, SC6.C6_DTVALID,' + CRLF
    cQuery += 'SA4.A4_NOME,' + CRLF
    cQuery += 'SA3.A3_NOME FROM ' +  RetSqlName('SC5') + ' SC5' + CRLF
    cQuery += 'INNER JOIN ' + RetSqlName('SA1') + ' SA1 ON SA1.A1_COD = SC5.C5_CLIENTE' + CRLF
    cQuery += 'INNER JOIN ' + RetSqlName('SE4') + ' SE4 ON SE4.E4_CODIGO = SC5.C5_CONDPAG' + CRLF
    cQuery += 'INNER JOIN ' + RetSqlName('SC6') + ' SC6 ON SC6.C6_NUM = SC5.C5_NUM' + CRLF
    cQuery += 'LEFT JOIN '  + RetSqlName('SA4') + ' SA4 ON SA4.A4_COD = SC5.C5_TRANSP' + CRLF
    cQuery += 'LEFT JOIN '  + RetSqlName('SA3') + ' SA3 ON SA3.A3_COD = SC5.C5_VEND1' + CRLF
    cQuery += "WHERE SC5.D_E_L_E_T_ = ' ' AND SC5.C5_NUM = '" + SC5->C5_NUM + "'"

    TCQUERY cQuery ALIAS (cAlias) NEW

    (cAlias)->(DbGoTop())

    if (cAlias)->(EOF())
        cAlias := ''
    endif

    RestArea(aArea)
Return cAlias

Static Function MontaRel(cAlias)
    local cCaminho := 'C:\Users\João Pedro Fazoli\Desktop\'
    local cArquivo := 'Challenge.pdf'

    Private nLinha := 155
    Private oPrint
    Private oFont10  := TFont():New('Arial',,10,, .F.,,,,,.F.,.F.)
    Private oFont10B := TFont():New('Arial',,10,, .T.,,,,,.F.,.F.)
    Private oFont12  := TFont():New('Arial',,12,, .F.,,,,,.F.,.F.)
    Private oFont12B := TFont():New('Arial',,12,, .T.,,,,,.F.,.F.)
    Private oFont14  := TFont():New('Arial',,14,, .F.,,,,,.F.,.F.)
    Private oFont14B := TFont():New('Arial',,14,, .T.,,,,,.F.,.F.)
    Private oFont16  := TFont():New('Arial',,16,, .T.,,,,,.F.,.F.)

    oPrint := FwMsPrinter():New(cArquivo,IMP_PDF, .F., '', .T.,, @oPrint, '',,,,.T.)
    oPrint:cPathPDF := cCaminho

    oPrint:SetPortrait()
    oPrint:SetPaperSize(9)

    oPrint:StartPage()
    Estrutura()
    DadosPed(cAlias)
    DadosItens(cAlias)

    oPrint:EndPage()
    oPrint:Preview()
Return

Static Function Estrutura()
    //!Cabeçalho
    oPrint:SayBitmap( 15, 15, "D:\TOTVS\Capacitacao\ADVPL\Exercicios\Lista-de-Exercicios-11\logo-totvs.png", 200, 75)

    // FwMsPrinter:SayAlign(nLinha, nColunaIni, cTexto, oFont, nTamanho,,, nTipoAlign[0=Esquerda, 1=Direita,2=Centro])
    oPrint:SayAlign(15, 10, 'TOTVS IP/TM'                                    , oFont16 ,  570 ,,, 1)
    oPrint:SayAlign(30, 10, 'Av. Dr. Antônio Carlos Couto de Barros, 937'    , oFont14 ,  570 ,,, 1)
    oPrint:SayAlign(45, 10, 'Sousas, Campinas - SP, 13105-000'               , oFont14 ,  570 ,,, 1)
    oPrint:SayAlign(60, 10, 'E-mail: rh@totvs.com.br'                        , oFont14B,  570 ,,, 1)
    oPrint:SayAlign(75, 10, 'Fone: (19) 3027-6600 FAX: (19) 3027-6600'       , oFont14 ,  570 ,,, 1)
    oPrint:SayAlign(90, 10, 'CNPJ: 53.113.791/0001-22 - IE: 111.010.945.111' , oFont14 ,  570 ,,, 1)

    oPrint:Line(105,15,105,580,,'-8')
    
    oPrint:Say(125,15,'Pedido de Venda N° ' + Alltrim(SC5->C5_NUM),oFont16,,PRETO)

    oPrint:Line(135,15,135,580,,'-8')

    oPrint:Say(125,519,TRANSFORM(Date(), '@R 99/99/9999'),oFont16,,PRETO)
    
Return

Static Function DadosPed(cAlias)
    local nColCabec1 := 15
    local nColCabec2 := 60
    local nColCabec3 := 330
    local nColCabec4 := 385

    //! Impressão Dados do Pedido
    oPrint:Say(nLinha,nColCabec1, 'Cliente' ,oFont12B,,PRETO)
    oPrint:Say(nLinha,nColCabec2, Alltrim((cAlias)->(C5_CLIENTE)) + ' - ' +Alltrim((cAlias)->(A1_NOME)),oFont12,,PRETO)
    oPrint:Say(nLinha,nColCabec3, 'Site' ,oFont12B,,PRETO)
    oPrint:Say(nLinha,nColCabec4, Alltrim((cAlias)->(A1_HPAGE)),oFont12,,PRETO)
    nLinha += incremento
    oPrint:Say(nLinha,nColCabec1, 'E-mail' ,oFont12B,,PRETO)
    oPrint:Say(nLinha,nColCabec2, Alltrim((cAlias)->(A1_EMAIL)),oFont12,,PRETO)
    oPrint:Say(nLinha,nColCabec3, 'Contato' ,oFont12B,,PRETO)
    oPrint:Say(nLinha,nColCabec4, Alltrim((cAlias)->(A1_CONTATO)),oFont12,,PRETO)
    nLinha += incremento
    oPrint:Say(nLinha,nColCabec1, 'Endereço' ,oFont12B,,PRETO)
    oPrint:Say(nLinha,nColCabec2, Alltrim((cAlias)->(A1_END)),oFont12,,PRETO)
    oPrint:Say(nLinha,nColCabec3, 'Bairro' ,oFont12B,,PRETO)
    oPrint:Say(nLinha,nColCabec4, Alltrim((cAlias)->(A1_BAIRRO)),oFont12,,PRETO)
    nLinha += incremento
    oPrint:Say(nLinha,nColCabec1, 'Cidade' ,oFont12B,,PRETO)
    oPrint:Say(nLinha,nColCabec2, Alltrim((cAlias)->(A1_MUN)),oFont12,,PRETO)
    oPrint:Say(nLinha,nColCabec3, 'CEP' ,oFont12B,,PRETO)
    oPrint:Say(nLinha,nColCabec4, TRANSFORM(Alltrim((cAlias)->(A1_CEP)), '@R 99.999-999'),oFont12,,PRETO)
    nLinha += incremento
    oPrint:Say(nLinha,nColCabec1, 'TEL' ,oFont12B,,PRETO)
    oPrint:Say(nLinha,nColCabec2, '(' + Alltrim((cAlias)->(A1_DDD)) + ') ' + Alltrim((cAlias)->(A1_TEL)),oFont12,,PRETO)
    oPrint:Say(nLinha,nColCabec3, 'CEP' ,oFont12B,,PRETO)
    oPrint:Say(nLinha,nColCabec4, TRANSFORM(Alltrim((cAlias)->(A1_CEP)), '@R 99.999-999'),oFont12,,PRETO)
    nLinha += incremento
    oPrint:Say(nLinha,nColCabec1, 'CNPJ' ,oFont12B,,PRETO)
    oPrint:Say(nLinha,nColCabec2, TRANSFORM(Alltrim((cAlias)->(A1_CGC)),'@R 99.999.999/9999-99'),oFont12,,PRETO)
    oPrint:Say(nLinha,nColCabec3, 'IE' ,oFont12B,,PRETO)
    oPrint:Say(nLinha,nColCabec4, TRANSFORM(Alltrim((cAlias)->(A1_INSCR)), '@R 999.999.999.999'),oFont12,,PRETO)
    nLinha += 10

return

Static Function CabecItens()
    local nLinAntes

    oPrint:Box(nLinha,15  ,nLinha+12,580,'-6')
    nLinAntes := nLinha
    oPrint:SayAlign(nLinha, 15 , 'Item'                   , oFont12B ,  35  ,,, 2)
    oPrint:SayAlign(nLinha, 50 , 'Produto'                , oFont12B ,  70  ,,, 2)
    oPrint:SayAlign(nLinha, 125, 'Descrição do Produto'   , oFont12B ,  170 ,,, 0)
    oPrint:SayAlign(nLinha, 300, 'UM'                     , oFont12B ,  30  ,,, 2)
    oPrint:SayAlign(nLinha, 330, 'QTD'                    , oFont12B ,  30  ,,, 2)
    oPrint:SayAlign(nLinha, 360, 'Prç Unit.'              , oFont12B ,  60  ,,, 2)
    oPrint:SayAlign(nLinha, 420, 'Prç Total'              , oFont12B ,  60  ,,, 2)
    oPrint:SayAlign(nLinha, 480, 'IPI'                    , oFont12B ,  40  ,,, 2)
    oPrint:SayAlign(nLinha, 520, 'Dt. Entrega'            , oFont12B ,  60  ,,, 2)
    nLinha += 15 

Return nLinAntes


Static Function DadosItens(cAlias)
    local nLinAntes   := 0
    local nTotalVenda := 0
    local cPreco      := ''
    Private nPagina   := 1
    Private nCor      := PRETO

    DbSelectArea(cAlias)

    //!Imprime Cabeçalho dos Itens 
    nLinAntes := Cabecitens()

    (cAlias)->(DbGoTop())
    //!Imprime os Dados dos Itens
    while (cAlias)->(!EOF())
        QuebPag(nLinAntes)
        oPrint:SayAlign(nLinha, 15 , Alltrim((cAlias)->(C6_ITEM))    , oFont10 ,  35 ,,, 2)
        oPrint:SayAlign(nLinha, 50 , Alltrim((cAlias)->(C6_PRODUTO)) , oFont10 ,  70 ,,, 2)
        oPrint:SayAlign(nLinha, 125, Alltrim((cAlias)->(C6_DESCRI))  , oFont10 ,  170 ,,, 0)
        oPrint:SayAlign(nLinha, 300, Alltrim((cAlias)->(C6_UM))      , oFont10 ,  30 ,,, 2)
        oPrint:SayAlign(nLinha, 330, Alltrim(CValtochar((cAlias)->(C6_QTDVEN))), oFont10 ,  30 ,,, 2)
        cPreco := 'R$ ' + Alltrim(Str((cAlias)->(C6_PRCVEN),,2))
        oPrint:SayAlign(nLinha, 360, cPreco, oFont10 ,  60 ,,, 2)
        cPreco := 'R$ ' + Alltrim(Str((cAlias)->(C6_VALOR),,2))
        oPrint:SayAlign(nLinha, 420, cPreco, oFont10 ,  60 ,,, 2)
        oPrint:SayAlign(nLinha, 480, Alltrim(Str((cAlias)->(C6_IPITRF),,2)) + ' %', oFont10 ,  40 ,,, 2)
        oPrint:SayAlign(nLinha, 520, TRANSFORM(DTOC(STOD((cAlias)->(C6_ENTREG))), '@R 99/99/9999'), oFont10 ,  60 ,,, 2)
        nLinha += 15
        nTotalVenda += (cAlias)->(C6_VALOR)
        (cAlias)->(DbSkip())
    enddo
    (cAlias)->(DbGoTop())
    //!Imprime as Linhas Verticais
    oPrint:Line(nLinAntes, 15 , nLinha ,15 ,,'-6')
    oPrint:Line(nLinAntes, 50 , nLinha ,50 ,,'-6')
    oPrint:Line(nLinAntes, 120, nLinha ,120,,'-6')
    oPrint:Line(nLinAntes, 300, nLinha ,300,,'-6')
    oPrint:Line(nLinAntes, 330, nLinha ,330,,'-6')
    oPrint:Line(nLinAntes, 360, nLinha ,360,,'-6')
    oPrint:Line(nLinAntes, 420, nLinha ,420,,'-6')
    oPrint:Line(nLinAntes, 480, nLinha ,480,,'-6')
    oPrint:Line(nLinAntes, 520, nLinha ,520,,'-6')
    oPrint:Line(nLinAntes, 580, nLinha ,580,,'-6')

    oPrint:Line(nLinha, 15, nLinha ,580,,'-6')

    nLinha += 10
    //!Imprime Totalizadores
    QuebPag(nLinAntes)
    oPrint:Box(nLinha,120  ,nLinha +14,210,'-6')
    oPrint:SayAlign(nLinha, 130, 'Valor Frete', oFont14B ,  80 ,,, 0)
    oPrint:Box(nLinha,210  ,nLinha +14,330,'-6')
    cPreco := 'R$ ' + Alltrim(Str((cAlias)->(C5_FRETE),,2))
    oPrint:SayAlign(nLinha, 210, cPreco, oFont14B ,  110 ,,, 1)

    oPrint:Box(nLinha,360  ,nLinha +14,440,'-6')
    oPrint:SayAlign(nLinha, 370, 'Valor Total', oFont14B ,  80 ,,, 0)
    oPrint:Box(nLinha,440  ,nLinha +14,520,'-6')
    cPreco := 'R$ ' + Alltrim(Str((nTotalVenda + (cAlias)->(C5_FRETE) + (cAlias)->(C5_DESPESA)),,2))
    oPrint:SayAlign(nLinha, 440, cPreco, oFont14B ,  70 ,,, 1)

    nLinha += 14

    oPrint:Box(nLinha,120  ,nLinha +14,210,'-6')
    oPrint:SayAlign(nLinha, 130, 'Valor Despesa', oFont14B ,  80 ,,, 0)
    oPrint:Box(nLinha,210  ,nLinha +14,330,'-6')
    cPreco := 'R$ ' + Alltrim(Str((cAlias)->(C5_DESPESA),,2))
    oPrint:SayAlign(nLinha, 210, cPreco, oFont14B ,  110 ,,, 1)

    //! Impresssão Informações Gerais
    (cAlias)->(DbGoTop())
    oPrint:Box(650,15,750,580,'-6')
    oPrint:SayAlign(660, 20, 'Informações Gerais:', oFont16 ,  565 ,,, 2)
    oPrint:SayAlign(675, 20, 'Forma de Pagamento:', oFont12B ,  90 ,,, 0)
    oPrint:SayAlign(675, 105, Alltrim((cAlias)->(C5_CONDPAG)) + ' - ' + Alltrim((cAlias)->(E4_DESCRI)), oFont12 ,  120 ,,, 0)

    oPrint:SayAlign(690, 20, 'Transportadora:', oFont12B ,  90 ,,, 0)
    if Alltrim((cAlias)->(C5_TRANSP)) <> NIL
        oPrint:SayAlign(690, 105, Alltrim((cAlias)->(C5_TRANSP)) + ' - ' + Alltrim((cAlias)->(A4_NOME)), oFont12 ,  120 ,,, 0)
    endif

    oPrint:SayAlign(705, 20 , 'Espécie:', oFont12B ,  90 ,,, 0)
    oPrint:SayAlign(705, 105 , Alltrim((cAlias)->(C5_ESPECI1)), oFont12 ,  120 ,,, 0)

    oPrint:SayAlign(705, 330, 'Tipo de Frete:', oFont12B ,  90 ,,, 0)
    oPrint:SayAlign(705, 390, Alltrim((cAlias)->(C5_TPFRETE)), oFont12 ,  120 ,,, 0)

    oPrint:SayAlign(720, 20 , 'Volume:', oFont12B ,  90 ,,, 0)
    oPrint:SayAlign(720, 105 , Alltrim((cAlias)->(C5_VOLUME1)), oFont12 ,  120 ,,, 0)

    oPrint:SayAlign(720, 330, 'Vendedor:', oFont12B ,  90 ,,, 0)
    if Alltrim((cAlias)->(C5_VEND1)) <> NIL
        oPrint:SayAlign(720, 390, Alltrim((cAlias)->(C5_VEND1)) + ' - ' + Alltrim((cAlias)->(A3_NOME)), oFont12 ,  120 ,,, 0)
    endif

    oPrint:SayAlign(735, 20 , 'Descontos %:', oFont12B ,  90 ,,, 0)
    oPrint:SayAlign(735, 105 , cValToChar((cAlias)->(C5_DESC1)) + ' + ' + cValToChar((cAlias)->(C5_DESC2)) + ' + ' + cValToChar((cAlias)->(C5_DESC3)) + ' + ' + cValToChar((cAlias)->(C5_DESC4)), oFont12 ,  120 ,,, 0)

    oPrint:SayAlign(735, 330, 'Validade: ', oFont12B ,  90 ,,, 0)
    oPrint:SayAlign(735, 390, Alltrim((cAlias)->(C6_DTVALID)), oFont12 ,  120 ,,, 0)


    oPrint:Box(750,15,790,580,'-6')
    oPrint:SayAlign(760, 25, 'Mensagem:' , oFont14B ,  70 ,,, 0)
    oPrint:SayAlign(760, 95, Alltrim( (cAlias)->(C5_MENNOTA)) , oFont14 ,  505 ,,, 0)

    nLinha += 14

    (cAlias)->(DbCLoseArea())
Return


Static Function QuebPag(nLinAntes)

    if nLinha > (770)
        oPrint:EndPage()
        oPrint:Line(nLinAntes, 15 , nLinha ,15 ,,'-6')
        oPrint:Line(nLinAntes, 50 , nLinha ,50 ,,'-6')
        oPrint:Line(nLinAntes, 120, nLinha ,120,,'-6')
        oPrint:Line(nLinAntes, 300, nLinha ,300,,'-6')
        oPrint:Line(nLinAntes, 330, nLinha ,330,,'-6')
        oPrint:Line(nLinAntes, 360, nLinha ,360,,'-6')
        oPrint:Line(nLinAntes, 420, nLinha ,420,,'-6')
        oPrint:Line(nLinAntes, 480, nLinha ,480,,'-6')
        oPrint:Line(nLinAntes, 520, nLinha ,520,,'-6')
        oPrint:Line(nLinAntes, 580, nLinha ,580,,'-6')
        oPrint:StartPage()
        nLinha := 90
        Estrutura()
        CabecItens()
        oPrint:Say(30,525,CValToChar(nPagina),oFont12B,,nCor)
        nPagina++
    endif

Return
