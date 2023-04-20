#INCLUDE 'TOTVS.CH'

User Function ZZ1LEG()
    local aLegenda := {}

    AADD(aLegenda, {'BR_VERMELHO',      'Aluno com Menos de 18 anos'})
    AADD(aLegenda, {'BR_VERDE',    'Aluno com Mais de 18 anos'})

    BrwLegenda('Legenda de Idade dos Alunos', 'Idade dos Alunos', aLegenda)
Return 
