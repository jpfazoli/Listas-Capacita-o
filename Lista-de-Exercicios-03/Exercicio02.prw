#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'

USER FUNCTION L3Ex02()
    local aArea   := GetArea()
    local cPedido := ''
    local cNome   := ''
    local cMsg    := ''
    local nCont   := 0

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC5,SA1' MODULO 'COM'

    DbSelectArea('SC5')
    DbSetOrder(1)
    DbGoTop()

    DbSelectArea('SA1')
    DbSetOrder(1)
    DbGoTop()



    While SC5->(!EOF())

        if SC5->C5_NOTA = ' '
            cPedido := SC5->C5_NUM
            while SA1->(!EOF())
                if SA1->A1_COD == SC5->C5_CLIENT
                    cNome := SA1->A1_NOME
                endif
            SA1->(DBSKIP())
            enddo
            cMsg += 'Pedido: ' + cPedido + CRLF +'Nome Cliente: ' + cNome + CRLF
            cMsg += '-----------------------------------------------' + CRLF
            nCont++
        endif
        SC5->(DBSKIP())
    ENDDO
    
    if nCont > 0
        FwAlertInfo(cMsg, 'Pedidos de Venda sem Nota Fiscal Informada')
    else
        FwAlertInfo('Nenhum Pedido Encontrado', 'Pedidos de Venda sem Nota Fiscal Informada')
    endif

    DbCloseArea()
    RestArea(aArea)
RETURN
