#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'


User Function L4Ex12()
    local oDlg      := NIL
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ''
    local cTitulo   := 'Busca de Pedido de Venda por Periodo'
    local cMsg      := ''
    local dInicio   := DATE()
    local dFim      := DATE()
    local cCodigo   := ''
    local cInicio   := ''
    local cFim      := ''
    local lValido   := .T.
    local nI        := 0
    local nCont     := 0
    local nLinha    := 20
    local nLinJan   := 150
    local nColJan   := 350

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC7' MODULO 'COM'

    while lValido
        DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO nLinJan,nColJan PIXEL
        @ 020,020 SAY 'Data de Inicio: ' SIZE 60,20 OF oDlg PIXEL
        @ 017,060 MSGET dInicio SIZE 40,10 OF oDlg PIXEL PICTURE '@D 99/99/9999'
        @ 040,020 SAY 'Data de Fim: ' SIZE 60,20 OF oDlg PIXEL
        @ 037,060 MSGET dFim SIZE 40,10 OF oDlg PIXEL PICTURE '@D 99/99/9999'
        @ 060,045 BUTTON 'Buscar' SIZE 030,011 OF oDlg ACTION (nOpcao := 1,oDlg:END()) PIXEL 
        @ 060,085 BUTTON 'Cancelar' SIZE 030,011 OF oDlg ACTION (nOpcao := 2,oDlg:END()) PIXEL 
        
        ACTIVATE MSDIALOG oDlg CENTERED

        cInicio := DtoS(dInicio)
        cFim := DtoS(dFim)

        if nOpcao == 2
            lValido := .F.
        else

            cQuery := 'SELECT C7_NUM FROM ' + RetSqlName('SC7') + CRLF
            cQuery += "WHERE (CONVERT(DATE,C7_EMISSAO) BETWEEN '" + cInicio + "' AND '" + cFim + "') AND D_E_L_E_T_ = ' '" + CRLF
            cQuery += 'GROUP BY C7_NUM'

            TCQUERY cQuery ALIAS &(cAlias) NEW

            &(cAlias)->(DbGoTop())

            While &(cAlias)->(!EoF())
                nLinJan += 5
                nCont++
                DBSKIP()
            enddo

            &(cAlias)->(DbGoTop())

            DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO nLinJan,500 PIXEL
            @ 010,110 SAY 'Resultado' SIZE 80,10 OF oDlg PIXEL
            @ 020,020 SAY ('Códigos do Produto dentro do Periodo informado') SIZE 150,10 OF oDlg PIXEL

            nLinha := 20
            While &(cAlias)->(!EoF())
                cCodigo := Alltrim(&(cAlias)->(C7_NUM))
                nI++
                IF nI < nCont
                    cMsg += cCodigo + ', '
                else
                    cMsg += cCodigo + ' '
                endif
                DBSKIP()
            enddo

            @ 035,020 SAY cMsg SIZE 200,50 OF oDlg PIXEL

            @ 100,085 SAY 'Deseja fazer outra Consulta?' SIZE 80,10 OF oDlg PIXEL

            @ 110,090 BUTTON 'Buscar' SIZE 030,011 OF oDlg ACTION (nOpcao := 1,oDlg:END()) PIXEL 
            @ 110,120 BUTTON 'Cancelar' SIZE 030,011 OF oDlg ACTION (nOpcao := 2,oDlg:END()) PIXEL 

            ACTIVATE MSDIALOG oDlg CENTERED

            if nOpcao == 2
                lValido := .F.
            endif

            &(cAlias)->(DbCloseArea())

        endif
    enddo

    RestArea(aArea)
Return 
