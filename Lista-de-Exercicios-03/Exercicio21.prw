#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

USER FUNCTION L3Ex21()
    local aArea    := GetArea()
    local cRetorno := ''
    local cTipo    := ''

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    DbSelectArea('SB1')
    DbSetOrder(1)
    DbGoTop()

    while !EOF()
        if SB1->B1_ZZGRP = ' '
            RecLock('SB1', .F.)
            cTipo := SB1->B1_Tipo
            If cTipo == 'MP'
                cRetorno := 'Matéria Prima Produção'
            elseif cTipo == 'PA'
                cRetorno := 'Produto para Comercialização'
            else
                cRetorno := 'Outros Produtos'
            endif
            SB1->B1_ZZGRP := cRetorno
            MsUnLock()
        endif
        DBSKIP()
    enddo

    
    DbCloseArea()
    RestArea(aArea)
RETURN 
