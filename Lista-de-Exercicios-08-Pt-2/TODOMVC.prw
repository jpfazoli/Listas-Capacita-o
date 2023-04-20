#INCLUDE 'TOTVS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function TODOMVC
    Função para que mostre as tarefas e as etapas para que seja concluida
    @type  Function
    @author João Pedro Fazoli de Souza
    @since 31/03/2023
    /*/
User Function TODOMVC()
    local cAlias  := 'ZZ7'
    local cTitle  := 'Tarefas'
    local oBrowse := FWMBROWSE():NEW()

    oBrowse:SetAlias(cAlias)
    oBrowse:SetDescription(cTitle)
    oBrowse:DisableDetails()
    oBrowse:DisableReport()
    //!Legenda de Tarefa Concluida
    oBrowse:AddLegend( "ZZ7_CONC == 'Sim'", "GREEN")
    oBrowse:AddLegend( "ZZ7_CONC == 'Não'", "RED")
    
    oBrowse:ACTIVATE()

Return 

Static Function MenuDef()
    local aRotina := {}

    ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'VIEWDEF.TODOMVC' OPERATION 2 ACCESS 0
    ADD OPTION aRotina TITLE 'Cadastrar'    ACTION 'VIEWDEF.TODOMVC' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'      ACTION 'VIEWDEF.TODOMVC' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Deletar'      ACTION 'VIEWDEF.TODOMVC' OPERATION 5 ACCESS 0
    ADD OPTION aRotina TITLE 'Legenda'      ACTION 'U_LegMvc'        OPERATION 6 ACCESS 0

Return aRotina

Static Function ModelDef()
    local bModelPos         := {|oModel| ValModelPos(oModel)}
    local bGridLinePos      := {|oGrid, nLine, cAction, cFieldId, xValue, xCurValue| ValidLinePre(oGrid, nLine, cAction, cFieldId, xValue, xCurValue) }

    local oModel        := MPFormModel():NEW('TODOMVCM',,bModelPos)
    local oStruZZ7      := FWFormStruct(1, 'ZZ7')
    local oStruZZ8      := FWFormStruct(1, 'ZZ8')


    oModel:AddFields('ZZ7MASTER',,oStruZZ7)

    oModel:AddGrid('ZZ8DETAIL','ZZ7MASTER',oStruZZ8,,bGridLinePos)

    oModel:SetDescription('Bloco')
    oModel:GetModel('ZZ7MASTER'):SetDescription('Bloco')
    oModel:GetModel('ZZ8DETAIL'):SetDescription('Apartamento')

    oModel:SetRelation('ZZ8DETAIL', {{'ZZ8_FILIAL', 'xFilial("ZZ8")'}, {'ZZ8_TAREFA', 'ZZ7_COD'}}, ZZ8->(IndexKey(1)))

    oStruZZ7:SetProperty('ZZ7_COD', MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, Alltrim(GETSXENUM('ZZ7',"ZZ7_COD"))))

    oModel:GetModel('ZZ8DETAIL'):SetUniqueLine({'ZZ8_COD'})

    oModel:SetPrimaryKey({'ZZ7_COD', 'ZZ8_COD'})


Return oModel

Static Function ViewDef()
    local oModel    := FWLoadModel('TODOMVC')
    local oStruZZ7  := FWFormStruct(2, 'ZZ7')
    local oStruZZ8  := FWFormStruct(2, 'ZZ8')
    local oView     := FWFormView():New()

    oView:SetModel(oModel)
    oView:AddField('VIEW_ZZ7', oStruZZ7, 'ZZ7MASTER')
    oView:AddGrid('VIEW_ZZ8', oStruZZ8, 'ZZ8DETAIL')
    
    oView:CreateHorizontalBox('TAREFA', 30)
    oView:CreateHorizontalBox('ETAPAS', 70)

    oView:SetOwnerView('VIEW_ZZ7', 'TAREFA')
    oView:SetOwnerView('VIEW_ZZ8', 'ETAPAS')

    oView:EnableTitleView('VIEW_ZZ7', 'Dados do Tarefa')
    oView:EnableTitleView('VIEW_ZZ8', 'Etapas da Tarefa')

Return oView

Static Function ValidLinePre(oGrid, nLine, cAction, cFieldId, xValue, xCurValue)
    local lValido := .T.

    if cAction == 'SETVALUE' .AND. cFieldID == 'ZZ8_DESC' .AND. xValue == xCurValue
        lValido := .F.
        Help(,,"Não Pode ser feito!",,'Você selecionou o mesmo Apartamento!',1 ,0,,,,,,{'Selecione outro Apartamento.'})
    elseif cAction == 'SETVALUE' .AND. cFieldID == 'ZZ8_COD' .AND. xValue == xCurValue
        lValido := .F.
        Help(,,"Não Pode ser feito!",,'Você selecionou o mesmo código para o Apartamento!',1 ,0,,,,,,{'Selecione outro código Apartamento.'})
    endif 

Return lValido

Static Function ValModelPos(oModel)
    local oGridModel := oModel:GetModel('ZZ8DETAIL')
    local nLinha     := 1
    local nCont      := 0
    local lValido    := .T.

    for nLinha := 1 TO oGridModel:Length(.T.)
        oGridModel:GoLine(nLinha)
        if oGridModel:GetValue('ZZ8_BOX')
            nCont++
        endif
    next

    if nCont == oGridModel:Length(.T.) .AND. oModel:GetValue('ZZ7MASTER', 'ZZ7_CONC') == 'Não'
        lValido := .F.
        Help(,,"Todas as Etapas Feitas!",,'Todas as Etapas foram feitas marque a tarefa como Realizada!',1 ,0,,,,,,{'Marque a Tarefa como Realizada.'})
    elseif nCont <> oGridModel:Length(.T.) .AND. oModel:GetValue('ZZ7MASTER', 'ZZ7_CONC') == 'Sim'
        lValido := .F.
        Help(,,"Tarefa não finalizada!",,'As Etapas foram todas feitas para marcar a tarefa como Realizada!',1 ,0,,,,,,{'Finalize todas as etapas.'})
    endif

Return lValido

User Function LegMvc()
    local aLegenda := {}
    
    AADD(aLegenda,{'BR_VERDE', 'Tarefa Finalizada'})
    AADD(aLegenda,{'BR_VERMELHO', 'Tarefa Em Progresso'})

    BRWLEGENDA('Status das Tarefas', 'Status das Tarefas', aLegenda)

Return aLegenda


