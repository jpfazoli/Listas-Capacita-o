#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'

User Function L4Ex17()
    local cAlias        := 'ZZ1' 
    LOCAL aLegenda      := {{ 'ZZ1->ZZ1_IDADE >= 18' , 'BR_VERDE'  },;
                            { 'ZZ1->ZZ1_IDADE < 18' ,  'BR_VERMELHO' }}
    Private cCadastro   := 'Cadastro de Alunos'
    Private aRotina     := {}

    AADD(aRotina, {'Pesquisar' ,   'AxPesqui', 0, 1})
    AADD(aRotina, {'Visualizar',   'AxVisual', 0, 2})
    AADD(aRotina, {'Incluir'   ,   'AxInclui', 0, 3})
    AADD(aRotina, {'Alterar'   ,   'AxAltera', 0, 4})
    AADD(aRotina, {'Excluir'   ,   'AxDeleta', 0, 5})
    AADD(aRotina, {'Legenda'   ,   'U_ZZ1LEG', 0, 6})

    DbSelectArea(cAlias)
    DbSetOrder(1)

    MBrowse(,,,, cAlias,,,,,,aLegenda)

    DbCloseArea()
    
Return
