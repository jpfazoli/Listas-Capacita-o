#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'

User Function L4Ex18()
    local cAlias    := 'ZZC'
    local cTitulo   := 'Cadastro de Alunos'
    local lBloqueio := 'U_BlqExc()'
    local lVldAlt   := 'U_VldAlt()'


    DBSELECTAREA(cAlias)
    DbSetOrder(1)
    AxCadastro(cAlias, cTitulo, lBLoqueio, lVldAlt)

Return
