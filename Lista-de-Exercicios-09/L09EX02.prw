#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function L09EX2
    Relatório de Produtos com Cabeçalho
    @type  Function
    @author João Pedro Fazoli de Souza
    @since 04/04/2023
    /*/
User Function L09EX2()
    local cTitulo       := 'Cadastro de Produtos'
    Private cNomeRel    := 'L09EX02'
    Private cPrograma   := 'L09EX02'
    Private cDesc1      := 'Relatório '
    Private cSize       := 'M'
    Private nLastKey    := 0
    Private aReturn     := {'Zebrado', 1, 'Administração', 1, 2,,, 1}
    Private m_Pag       := 1


    cNomeRel := SetPrint('SB1', cPrograma,,@cTitulo, cDesc1,,,.F.,, .T., cSize ,,.F.)

    SetDefault(aReturn, 'SB1')

    RptStatus({|| Imprime()}, cTitulo, 'Gerando Relatório...')

Return 

Static Function Imprime()
    local nLinha := 8
    local cCabecalho := 'Código' + Space(4) + 'Descrição' + Space(26) + 'Un. Medida' + Space(5) + 'Preço' + Space(10) + 'Armazém'
    local nCont  := 0

    DbSelectArea('SB1')
    SB1->(DbSetOrder(1)) 
    SB1->(DbGoTop())

    //!Impressão de Cabeçalho
    Cabec('Cadastro de Produtos', cCabecalho, '',cPrograma, cSize,15)

    While !EOF()

        if !Empty(SB1->B1_COD) //! Valida se Código esta Vazio
            nLinha++
            @ nLinha, 00 PSAY PADR(SB1->B1_COD,  10)
            @ nLinha, 10 PSAY PADR(SB1->B1_DESC, 35)
            @ nLinha, 45 PSAY PADR(SB1->B1_UM, 15)
            @ nLinha, 60 PSAY 'R$ ' + Alltrim(STR(SB1->B1_PRV1,, 2))
            @ nLinha, 75 PSAY PADR(SB1->B1_LOCPAD, 10)
            @ ++nLinha, 00 PSAY Replicate('_', 80)
            nCont++

            if nCont == 30 //! Limite os Registros por Folha
                nCont  := 0
                nLinha := 8
            endif
        endif
        SB1->(DbSkip())
    enddo

    SET DEVICE TO SCREEN

    if aReturn[5] == 1
        SET PRINTER TO DbCommitAll()
        OurSpool(cNomeRel)
    endif
    
    MS_FLUSH()
Return

