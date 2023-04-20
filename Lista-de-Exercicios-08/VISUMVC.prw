#INCLUDE 'TOTVS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function VISUMVC
    Função para Visualizar todos os Instrutores de Cada Categoria e os Alunos de Cada Instrutor
    @type  Function
    @author João Pedro Fazoli de Souza
    @since 28/03/2023
    /*/
User Function VISUMVC()
    local cAlias  := 'ZZ2'
    local cTitle  := 'Categoria/Instrutores/Alunos'
    local oBrowse := FWMBROWSE():NEW()

    oBrowse:SetAlias(cAlias)
    oBrowse:SetDescription(cTitle)
    oBrowse:DisableDetails()
    oBrowse:DisableReport()
    oBrowse:ACTIVATE()

Return 

Static Function MenuDef()
    local aRotina := {}

    ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.VISUMVC' OPERATION 2 ACCESS 0

Return aRotina

Static Function ModelDef()
    local oModel        := MPFormModel():NEW('VISUMVCM')
    local oStruZZ2      := FWFormStruct(1, 'ZZ2')
    local oStruZZ3      := FWFormStruct(1, 'ZZ3')
    local oStruZZ4      := FWFormStruct(1, 'ZZ4')

    oModel:AddFields('ZZ2MASTER',,oStruZZ2)

    oModel:AddGrid('ZZ3DETAIL','ZZ2MASTER',oStruZZ3)
    oModel:AddGrid('ZZ4DETAIL','ZZ3DETAIL',oStruZZ4)

    oModel:SetDescription('Categoria')
    oModel:GetModel('ZZ2MASTER'):SetDescription('Categoria')
    oModel:GetModel('ZZ3DETAIL'):SetDescription('Instrutor')
    oModel:GetModel('ZZ4DETAIL'):SetDescription('Alunos')

    //!Monta o Relacionamento entre as Tabelas de Dados
    oModel:SetRelation('ZZ3DETAIL', {{'ZZ3_FILIAL', 'xFilial("ZZ3")'}, {'ZZ3_CATEG', 'ZZ2_COD'}}, ZZ3->(IndexKey(1)))
    oModel:SetRelation('ZZ4DETAIL', {{'ZZ4_FILIAL', 'xFilial("ZZ4")'}, {'ZZ4_INST', 'ZZ3_COD'}}, ZZ4->(IndexKey(1)))

    oModel:SetPrimaryKey({'ZZ2_COD', 'ZZ3_COD', 'ZZ4_COD'})

    oModel:GetModel('ZZ3DETAIL'):SetUniqueLine({'ZZ3_COD'})

Return oModel

Static Function ViewDef()
    local oModel    := FWLoadModel('VISUMVC')
    local oStruZZ2  := FWFormStruct(2, 'ZZ2')
    local oStruZZ3  := FWFormStruct(2, 'ZZ3')
    local oStruZZ4  := FWFormStruct(2, 'ZZ4')
    local oView     := FWFormView():New()

    oView:SetModel(oModel)
    oView:AddField('VIEW_ZZ2', oStruZZ2, 'ZZ2MASTER')
    oView:AddGrid('VIEW_ZZ3', oStruZZ3, 'ZZ3DETAIL')
    oView:AddGrid('VIEW_ZZ4', oStruZZ4, 'ZZ4DETAIL')
    
    oView:CreateHorizontalBox('CATEGORIA', 20)
    oView:CreateHorizontalBox('INSTRUTOR', 40)
    oView:CreateHorizontalBox('ALUNOS', 40)

    oView:SetOwnerView('VIEW_ZZ2', 'CATEGORIA')
    oView:SetOwnerView('VIEW_ZZ3', 'INSTRUTOR')
    oView:SetOwnerView('VIEW_ZZ4', 'ALUNOS')

    oView:EnableTitleView('VIEW_ZZ2', 'Categoria')
    oView:EnableTitleView('VIEW_ZZ3', 'Instrutores')
    oView:EnableTitleView('VIEW_ZZ4', 'Alunos')

Return oView
