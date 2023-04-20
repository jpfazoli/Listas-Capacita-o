#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function L09EX01
    Relat�rio de Produtos 
    @type  Function
    @author Jo�o Pedro Fazoli de Souza
    @since 04/04/2023
    /*/
User Function L09EX01()
    local cTitulo       := 'Cadastro de Produtos'
    Private cNomeRel    := 'L09EX01'
    Private cPrograma   := 'L09EX01'
    Private cDesc1      := 'Relat�rio '
    Private aReturn     := {'Zebrado', 1, 'Administra��o', 1, 2,,, 1}


    cNomeRel := SetPrint('SB1', cPrograma,,@cTitulo, cDesc1,,,.F.,, .T., 'M' ,,.F.)

    SetDefault(aReturn, 'SB1')

    RptStatus({|| Imprime()}, cTitulo, 'Gerando Relat�rio...')



Return 

Static Function Imprime()
    local nLinha := 2
    local nCont  := 0

    DbSelectArea('SB1')
    SB1->(DbSetOrder(1))
    SB1->(DbGoTop())

    @   nLinha, 00 PSAY Replicate('*', 50)
    @ ++nLinha, 00 PSAY 'Relat�rio de Produtos'
    @ ++nLinha, 00 PSAY Replicate('*', 50)

    While !EOF()
        if !Empty(SB1->B1_COD) //! Valida se o C�digo est� Vazio
            nCont++
            @ ++nLinha, 10 PSAY PADR('C�digo: ', 12)         + Alltrim(SB1->B1_COD)
            @ ++nLinha, 10 PSAY PADR('Descri��o: ', 12)      + Alltrim(SB1->B1_DESC)
            @ ++nLinha, 10 PSAY PADR('Un. Medida: ', 12)     + Alltrim(SB1->B1_UM)
            @ ++nLinha, 10 PSAY PADR('Pre�o: ', 12)  + 'R$ ' + Alltrim(STR(SB1->B1_PRV1,, 2))
            @ ++nLinha, 10 PSAY PADR('Armaz�m: ', 12)        + Alltrim(SB1->B1_LOCPAD)
            @ ++nLinha, 10 PSAY Replicate("*", 50)

            if nCont == 10 //! Limite os Registros por Folha
                nCont := 0
                nLinha := 2
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
