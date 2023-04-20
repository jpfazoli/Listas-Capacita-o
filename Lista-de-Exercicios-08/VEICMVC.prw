#INCLUDE 'TOTVS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function VEICMVC
    Função para Cadastro de Veiculo dentro do Banco de Dados
    @type  Function
    @author João Pedro Fazoli de Souza
    @since 28/03/2023
    /*/
User Function VEICMVC()
    local oBrowse
    local cAlias    := 'ZZV'
    local cTitle    := 'Cadastro de Veiculos'

    oBrowse := FwMBrowse():New()

    oBrowse:SetAlias(cAlias)

    oBrowse:SetDescription(cTitle)

    oBrowse:DisableDetails()
    oBrowse:DisableReport()
    oBrowse:Activate()
Return


Static Function MenuDef()
    local aRotina := {}

    ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.VEICMVC' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.VEICMVC' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.VEICMVC' OPERATION 5 ACCESS 0

Return aRotina

Static Function ModelDef()
    local oModel    := MPFormModel():NEW('VEICMVCM')
    local oStruZZC  := FWFormStruct(1,'ZZV')

    oModel:AddFields('ZZVMASTER',/*Pai*/,oStruZZC)

    oModel:SetDescription('Modelo de Dados de Veiculos')

    oModel:GetModel('ZZVMASTER'):SetDescription('Formulario dos Veiculos')

    oModel:SetPrimaryKey({'ZZV_COD'})

Return oModel

Static Function ViewDef()
    local oModel    := FWLoadModel('VEICMVC') // Carrega o Modelo criado para o Fonte
    local oStruZZC  := FWFormStruct(2,'ZZV')// 
    local oView     := FwFormView():NEW()

    oView:SetModel(oModel)

    oView:AddField('VIEW_ZZV',oStruZZC,'ZZVMASTER')

    oView:CreateHorizontalBox('GERAL',100)

    oView:SetOwnerView('VIEW_ZZV','GERAL')

Return oView

