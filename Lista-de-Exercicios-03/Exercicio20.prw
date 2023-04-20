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
        cRetorno := 'Matéria Prima Produção'
    elseif cTipo = 'PA'
        cRetorno := 'Produto para Comercialização'
    else
        cRetorno := 'Outros Produtos'
    endif

    DbCloseArea()
    RestArea(aArea)
RETURN cRetorno
