#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'FWPRINTSETUP.CH'
#INCLUDE 'RPTDEF.CH'

#DEFINE PRETO      RGB(000,000,000)
#DEFINE MAX_LINE   760
#DEFINE incremento 15

/*/{Protheus.doc} User Function GeraRel
    Imprime Relatório referente ao Pedido de Venda Feito
    @type  Function
    @author João Pedro Fazoli de Souza
    @since 14/04/2023
/*/
User Function GeraRel()
    local cAlias
    Private cPedido := PARAMIXB
    Private cLog    := 'Relatório de Eventos - Log Eventos Pedido ' + cPedido + CRLF + CRLF

    cAlias := GeraCons()

    if !Empty(cAlias)
        cLog += '[' + Time() + '] Iniciado o Processo de Construção do Relatório' + CRLF
        Processa({|| MontaRel(cAlias)}, 'Aguarde...', 'Imprimindo Relatório')
    else
        FwAlertError('Nenhum Registro Encontrado!', 'Atenção!')
    endif

Return 

Static Function GeraCons()
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ''


    cQuery := 'SELECT SC5.C5_NUM, SC5.C5_EMISSAO, SE4.E4_DESCRI, SC6.C6_ITEM, SC6.C6_PRODUTO, SC6.C6_DESCRI, SC6.C6_QTDVEN, SC6.C6_PRCVEN, SC6.C6_VALOR ,' + CRLF
    cQuery += 'SC6.C6_ITEM, SC6.C6_PRODUTO, SC6.C6_DESCRI, SC6.C6_UM, SC6.C6_QTDVEN, SC6.C6_PRCVEN, SC6.C6_VALOR, SC6.C6_IPITRF, SC6.C6_ENTREG, SC6.C6_DTVALID,' + CRLF
    cQuery += 'SE4.E4_DESCRI,' + CRLF
    cQuery += 'SA1.A1_NOME, SA1.A1_HPAGE,SA1.A1_EMAIL, SA1.A1_CONTATO, SA1.A1_END, SA1.A1_BAIRRO, SA1.A1_MUN, SA1.A1_CEP, SA1.A1_DDD, SA1.A1_TEL, SA1.A1_FAX, SA1.A1_CGC, SA1.A1_INSCR FROM '  + RetSqlName('SC5') + ' SC5' + CRLF
    cQuery += 'INNER JOIN '  + RetSqlName('SA1') + ' SA1 ON SC5.C5_CLIENTE = SA1.A1_COD' + CRLF
    cQuery += 'INNER JOIN '  + RetSqlName('SE4') + ' SE4 ON SC5.C5_CONDPAG = SE4.E4_CODIGO' + CRLF
    cQuery += 'INNER JOIN '  + RetSqlName('SC6') + ' SC6 ON SC5.C5_NUM = SC6.C6_NUM' + CRLF
    cQuery += "WHERE SC5.D_E_L_E_T_ = ' ' AND SC6.D_E_L_E_T_ = ' ' AND SE4.D_E_L_E_T_ = ' ' AND SA1.D_E_L_E_T_ = ' ' AND SC5.C5_NUM = '" + cPedido + "' " + CRLF
    cQuery += 'ORDER BY SC5.C5_NUM'

    TCQUERY cQuery ALIAS (cAlias) NEW

    cLog += '[' + Time() + '] Feita a Consulta no Banco de Dados' + CRLF

    (cAlias)->(DbGoTop())

    if (cAlias)->(EOF())
        cAlias := ''
    endif

    RestArea(aArea)
Return cAlias

Static Function MontaRel(cAlias)
    local cCaminho := GeraPasta()
    local cArquivo := Alltrim((cAlias)->(C5_NUM))

    Private nLinha := 155
    Private oPrint
    Private oFont10  := TFont():New('Arial',,10,, .F.,,,,,.F.,.F.)
    Private oFont10B := TFont():New('Arial',,10,, .T.,,,,,.F.,.F.)
    Private oFont12  := TFont():New('Arial',,12,, .F.,,,,,.F.,.F.)
    Private oFont12B := TFont():New('Arial',,12,, .T.,,,,,.F.,.F.)
    Private oFont14  := TFont():New('Arial',,14,, .F.,,,,,.F.,.F.)
    Private oFont14B := TFont():New('Arial',,14,, .T.,,,,,.F.,.F.)
    Private oFont16  := TFont():New('Arial',,16,, .T.,,,,,.F.,.F.)

    cLog += '[' + Time() + '] Abertura do Relatório com a Função FwMsPrinter():New()' + CRLF
    oPrint := FwMsPrinter():New(cArquivo,IMP_PDF, .F., '', .T.,, @oPrint, '',,,,.T.)
    oPrint:cPathPDF := 'C:\TOTVS12\Protheus\protheus_data' + cCaminho

    cLog += '[' + Time() + '] Configuração do Tipo de Folha' + CRLF
    oPrint:SetPortrait()
    oPrint:SetPaperSize(9)

    cLog += '[' + Time() + '] Inicia a Página' + CRLF
    oPrint:StartPage()
    Estrutura()
    DadosPed(cAlias)
    DadosItens(cAlias)

    oPrint:EndPage()
    oPrint:Preview()
    GeraLog()
Return

Static Function Estrutura()
    //!Cabeçalho
    oPrint:SayBitmap( 15, 15, "D:\TOTVS\Capacitacao\ADVPL\Exercicios\Lista-de-Exercicios-11\logo-totvs.png", 200, 75)
    cLog += '[' + Time() + '] Imprime o Logotipo da Empresa' + CRLF
    // FwMsPrinter:SayAlign(nLinha, nColunaIni, cTexto, oFont, nTamanho,,, nTipoAlign[0=Esquerda, 1=Direita,2=Centro])
    oPrint:SayAlign(15, 10, 'TOTVS IP/TM'                                    , oFont16 ,  570 ,,, 1)
    oPrint:SayAlign(30, 10, 'Av. Dr. Antônio Carlos Couto de Barros, 937'    , oFont14 ,  570 ,,, 1)
    oPrint:SayAlign(45, 10, 'Sousas, Campinas - SP, 13105-000'               , oFont14 ,  570 ,,, 1)
    oPrint:SayAlign(60, 10, 'E-mail: rh@totvs.com.br'                        , oFont14B,  570 ,,, 1)
    oPrint:SayAlign(75, 10, 'Fone: (19) 3027-6600 FAX: (19) 3027-6600'       , oFont14 ,  570 ,,, 1)
    oPrint:SayAlign(90, 10, 'CNPJ: 53.113.791/0001-22 - IE: 111.010.945.111' , oFont14 ,  570 ,,, 1)
    cLog += '[' + Time() + '] Imprime o Cabeçalho de dados da Empresa' + CRLF
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

    cLog += '[' + Time() + '] Imprime os Dados do Cliente do Pedido' + CRLF

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

    cLog += '[' + Time() + '] Imprime o Cabeçalho de Itens do Pedido' + CRLF

Return nLinAntes


Static Function DadosItens(cAlias)
    local nLinAntes   := 0
    local nTotalVenda := 0
    local cPreco      := ''
    local nCont       := 1
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
        cLog += '[' + Time() + '] Imprime os Dados do Item ' + cValToChar(nCont) + ' do Pedido' + CRLF
        nCont++
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

    oPrint:Box(nLinha,360  ,nLinha +14,440,'-6')
    oPrint:SayAlign(nLinha, 370, 'Valor Total', oFont14B ,  80 ,,, 0)
    oPrint:Box(nLinha,440  ,nLinha +14,520,'-6')
    cPreco := 'R$ ' + Alltrim(Str((nTotalVenda),,2))
    oPrint:SayAlign(nLinha, 440, cPreco, oFont14B ,  70 ,,, 1)
    cLog += '[' + Time() + '] Imprime o Totalizador do Pedido' + CRLF
    nLinha += 14

    oPrint:Box(750,15,790,580,'-6')
    oPrint:SayAlign(760, 25, 'Mensagem:' , oFont14B ,  70 ,,, 0)
    oPrint:SayAlign(760, 95, Alltrim( (cAlias)->(C5_MENNOTA)) , oFont14 ,  505 ,,, 0)
    cLog += '[' + Time() + '] Imprime a Mensagem para a Nota do Pedido' + CRLF
    nLinha += 14

    (cAlias)->(DbCLoseArea())
Return


Static Function QuebPag(nLinAntes)

    if nLinha > (770)
        oPrint:EndPage()
        cLog += '[' + Time() + '] Feita uma Quebra de Pagina do Pedido do Pedido' + CRLF
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
        cLog += '[' + Time() + '] Inicia a Página do Pedido' + CRLF
        nLinha := 90
        Estrutura()
        CabecItens()
        oPrint:Say(30,525,CValToChar(nPagina),oFont12B,,nCor)
        nPagina++
        
    endif

Return


Static Function GeraPasta()
    local cNomePasta := '\Pedidos de Venda\'

    if !ExistDir(cNomePasta)
        MakeDir(cNomePasta)
    endif
    cLog += '[' + Time() + '] Verificação da Pasta que será salvo o Relatório' + CRLF
Return cNomePasta


Static Function GeraLog()
    local cPasta := 'C:\TOTVS12\Protheus\protheus_data\Pedidos de Venda\'
    local cArquivo := cPedido + '.txt'
    local oWriter := FwFileWriter():New(cPasta + cArquivo,.T.)

    if oWriter:Create()
        oWriter:Write(cLog)
        oWriter:Close()
    else
        FwAlertError('Houve um erro ao gerar o arquivo!' + CRLF + oWriter:Error():Message, 'Erro!')
    endif
Return 
