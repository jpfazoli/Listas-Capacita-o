#INCLUDE 'TOTVS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function INSTMVC
    Função para Cadastro de Instrutores da Auto Escola
    @type  Function
    @author João Pedro Fazoli de Souza
    @since 28/03/2023
    /*/
User Function INSTMVC()
    local cAlias  := 'ZZ3'
    local cTitle  := 'Cadastro de Instrutores'
    local oMark   := FwMarkBrowse():New()

    oMark:SetAlias(cAlias)
    oMark:SetDescription(cTitle)
    oMark:SetFieldMark('ZZ3_MARC')
    
    oMark:AddButton('Excluir Marcados', 'U_DelMarc',5, 1)

    oMark:DisableDetails()
    oMark:DisableReport()
    oMark:Activate()

Return


Static Function MenuDef()
    local aRotina := {}

    ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.INSTMVC' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.INSTMVC' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.INSTMVC' OPERATION 5 ACCESS 0

Return aRotina

Static Function ModelDef()
    local bModelPos := {|oModel| ValidPos(oModel)}
    local oModel    := MPFormModel():NEW('INSTMVCM',,bModelPos)
    local oStruZZ3  := FWFormStruct(1,'ZZ3')

    oModel:AddFields('ZZ3MASTER',/*Pai*/,oStruZZ3)

    oModel:SetDescription('Modelo de Dados de Instrutores')

    oModel:GetModel('ZZ3MASTER'):SetDescription('Formulario dos Instrutores')

    oModel:SetPrimaryKey({'ZZ3_COD'})

Return oModel

Static Function ViewDef()
    local oModel    := FWLoadModel('INSTMVC') // Carrega o Modelo criado para o Fonte
    local oStruZZ3  := FWFormStruct(2,'ZZ3')// 
    local oView     := FwFormView():NEW()

    oView:SetModel(oModel)

    oView:AddField('VIEW_ZZ3',oStruZZ3,'ZZ3MASTER')

    oView:CreateHorizontalBox('INSTRUTORES',100)

    oView:SetOwnerView('VIEW_ZZ3','INSTRUTORES')

Return oView

Static Function ValidPos(oModel)
    local nOperacao     := oModel:GetOperation()
    local lValido       := .T.
    local nAlunos       := oModel:GetValue('ZZ3MASTER','ZZ3_ALUNOS')
    local cEscolaridade := Alltrim(oModel:GetValue('ZZ3MASTER','ZZ3_ESCOLA'))
    local dHabilitacao  := oModel:GetValue('ZZ3MASTER','ZZ3_DTCNH')
    local dNascimento   := oModel:GetValue('ZZ3MASTER','ZZ3_NASC')
    local nDiffHab      := DateDiffYear(dHabilitacao, Date())
    local nDiffNasc     := DateDiffYear(dNascimento, Date())

    if nOperacao == 5
        if nAlunos > 0
            lValido := .F.
            Help(,,"Exclusão Negada!",,'Não é possível excluir Instrutor com Alunos vinculados!',1 ,0,,,,,,{'Verifique os Cadastros.'})
        endif
    else
        if nDiffHab < 2 //!Verifica o tempo de Habilitação do Instrutor
            lValido := .F.
            Help(,,"Data de Habilitação Inválida",,'A data da Habilitação do Instrutor não pode ser inferior a <b> 2 anos</b>!',1 ,0,,,,,,{'Preencha com uma data válido.'})
        elseif nDiffNasc < 21 //!Verifica a Idade do Instrutor
            lValido := .F.
            Help(,,"Data de Nascimento Inválida",,'O Instrutor não pode ter menos de <b> 21 anos</b>!',1 ,0,,,,,,{'Preencha com uma data válido.'})
        elseif cEscolaridade == 'Ensino Fundamental' //!Verifica a Escolaridade do Instrutor
            lValido := .F.
            Help(,,"Escolaridade Inválida",,'O Instrutor deve ser formado ao menos no <b> Ensino Médio</b>!',1 ,0,,,,,,{'Preencha com um valor válido.'})
        endif                                                                            
    endif

Return lValido

User Function DelMarc()
    local nCont := 0

    DbSelectArea( 'ZZ3' )
    ZZ3->(DbGoTop())
    if MSGYESNO('Confirma a Exclusão dos Instrutores Marcados?')
      while ZZ3->(!EOF())
          if oMark:IsMark() .AND. ZZ3->ZZ3_ALUNOS == 0 //!Verifica se está marcado e se possui aluno
              Reclock('ZZ3', .F.)
              ZZ3->(DbDelete())
              ZZ3->(MsUnlock())
          elseif oMark:IsMark() .AND. ZZ3->ZZ3_ALUNOS > 0
              nCont++
          endif
          ZZ3->(DbSkip())
      enddo
    endif

    if nCont > 0
        Help(,,"Exclusão Negada!",,'Não é possível excluir Instrutor com Alunos vinculados!',1 ,0,,,,,,{'Verifique os Cadastros.'})
    endif
    oMark:Refresh(.T.)
Return
