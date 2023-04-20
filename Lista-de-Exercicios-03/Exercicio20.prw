#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'

USER FUNCTION L3Ex20()
    local aArea   := GetArea()
    local cTipo   := M->B1_TIPO
    local cRetorno

    DbSelectArea('SB1')
    DbSetOrder(1)
    DbGoTop()

    If cTipo = 'MP'
        cRetorno := 'Mat�ria Prima Produ��o'
    elseif cTipo = 'PA'
        cRetorno := 'Produto para Comercializa��o'
    else
        cRetorno := 'Outros Produtos'
    endif

    DbCloseArea()
    RestArea(aArea)
RETURN cRetorno
