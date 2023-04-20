#INCLUDE 'TOTVS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function BLOCMVC
    Função para que permita cadastrar Blocos e seus respectivos apartamentos e proprietários
    @type  Function
    @author João Pedro Fazoli de Souza
    @since 31/03/2023
    /*/
User Function nomeFunction(param_name)
    
Return return_var

User Function BLOCMVC()
    local cAlias  := 'ZZ5'
    local cTitle  := 'Blocos de Apartamentos'
    local oBrowse := FWMBROWSE():NEW()

    oBrowse:SetAlias(cAlias)
    oBrowse:SetDescription(cTitle)
    oBrowse:DisableDetails()
    oBrowse:DisableReport()
    oBrowse:ACTIVATE()

Return 

Static Function MenuDef()
    local aRotina := {}

    ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'VIEWDEF.BLOCMVC' OPERATION 2 ACCESS 0
    ADD OPTION aRotina TITLE 'Cadastrar'    ACTION 'VIEWDEF.BLOCMVC' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'      ACTION 'VIEWDEF.BLOCMVC' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Deletar'      ACTION 'VIEWDEF.BLOCMVC' OPERATION 5 ACCESS 0

Return aRotina

Static Function ModelDef()
    //!Validação da Grid
    local bLinePre  := {|oGrid, nLine, cAction, cFieldId, xValue, xCurValue| ValidLine(oGrid, nLine, cAction, cFieldId, xValue, xCurValue) }

    local oModel    := MPFormModel():NEW('BLOCMVCM')
    local oStruZZ5  := FWFormStruct(1, 'ZZ5')
    local oStruZZ6  := FWFormStruct(1, 'ZZ6')


    oModel:AddFields('ZZ5MASTER',,oStruZZ5)

    oModel:AddGrid('ZZ6DETAIL','ZZ5MASTER',oStruZZ6,bLinePre)

    oModel:SetDescription('Bloco')
    oModel:GetModel('ZZ5MASTER'):SetDescription('Bloco')
    oModel:GetModel('ZZ6DETAIL'):SetDescription('Apartamento')

    oModel:SetRelation('ZZ6DETAIL', {{'ZZ6_FILIAL', 'xFilial("ZZ6")'}, {'ZZ6_BLOCO', 'ZZ5_COD'}}, ZZ6->(IndexKey(1)))

    oStruZZ5:SetProperty('ZZ5_COD', MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, Alltrim(GETSXENUM('ZZ5',"ZZ5_COD"))))
    oStruZZ6:SetProperty('ZZ6_COD', MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, Alltrim(GETSXENUM('ZZ6',"ZZ6_COD"))))

    oModel:GetModel('ZZ6DETAIL'):SetUniqueLine({'ZZ6_COD'})

    oModel:SetPrimaryKey({'ZZ5_COD', 'ZZ6_COD'})


Return oModel

Static Function ViewDef()
    local oModel    := FWLoadModel('BLOCMVC')
    local oStruZZ5  := FWFormStruct(2, 'ZZ5')
    local oStruZZ6  := FWFormStruct(2, 'ZZ6')
    local oView     := FWFormView():New()

    oView:SetModel(oModel)
    oView:AddField('VIEW_ZZ5', oStruZZ5, 'ZZ5MASTER')
    oView:AddGrid('VIEW_ZZ6', oStruZZ6, 'ZZ6DETAIL')
    
    oView:CreateHorizontalBox('BLOCO',       30)
    oView:CreateHorizontalBox('APARTAMENTO', 70)

    oView:SetOwnerView('VIEW_ZZ5', 'BLOCO')
    oView:SetOwnerView('VIEW_ZZ6', 'APARTAMENTO')

    oView:EnableTitleView('VIEW_ZZ5', 'Dados do Bloco')
    oView:EnableTitleView('VIEW_ZZ6', 'Apartamentos no Bloco')

Return oView

Static Function ValidLine(oGrid, nLine, cAction, cFieldId, xValue, xCurValue)
    local lValido := .T.

    //!Valida se os Campos Apartamento e Código se repetem e impede
    if cAction == 'SETVALUE' .AND. cFieldID == 'ZZ6_DESC' .AND. xValue == xCurValue
        lValido := .F.
        Help(,,"Não Pode ser feito!",,'Você selecionou o mesmo Apartamento!',1 ,0,,,,,,{'Selecione outro Apartamento.'})
    elseif cAction == 'SETVALUE' .AND. cFieldID == 'ZZ6_COD' .AND. xValue == xCurValue
        lValido := .F.
        Help(,,"Não Pode ser feito!",,'Você selecionou o mesmo código para o Apartamento!',1 ,0,,,,,,{'Selecione outro código Apartamento.'})
    endif 

Return lValido
