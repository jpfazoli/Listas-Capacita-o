#INCLUDE 'TOTVS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function CNHMVC
    Função para Cadastro de Categorias de CNH
    @type  Function
    @author João Pedro Fazoli de Souza
    @since 28/03/2023
    /*/
User Function CNHMVC()
    local oBrowse
    local cAlias    := 'ZZ2'
    local cTitle    := 'Cadastro de Categorias de CNH'

    oBrowse := FwMBrowse():New()

    oBrowse:SetAlias(cAlias)

    oBrowse:SetDescription(cTitle)

    oBrowse:DisableDetails()
    oBrowse:DisableReport()
    oBrowse:Activate()
Return


Static Function MenuDef()
    local aRotina := {}

    ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.CNHMVC' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.CNHMVC' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.CNHMVC' OPERATION 5 ACCESS 0

Return aRotina

Static Function ModelDef()
    //!Validações do Model
    local bModelPos    := {|oModel| ValidPos(oModel)}
    
    local oModel     := MPFormModel():NEW('CNHMVCM',,bModelPos)
    local oStruZZ2   := FWFormStruct(1,'ZZ2')
    local aGatilho   := FwStruTrigger('ZZ2_VEIC','ZZ2_NOMVEI','ZZV->ZZV_NOME',.T.,'ZZV',1,'xFilial("ZZ2")+Alltrim(M->ZZ2_VEIC)')

    oStruZZ2:AddTrigger(aGatilho[1],aGatilho[2],aGatilho[3],aGatilho[4])

    oModel:AddFields('ZZ2MASTER',/*Pai*/,oStruZZ2)

    oModel:SetDescription('Modelo de Dados de Categoria de CNH')

    oModel:GetModel('ZZ2MASTER'):SetDescription('Formulario das Categorias de CNH')

    //! Seta o valor de Inicialização padrão
    oStruZZ2:SetProperty('ZZ2_COD', MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, Alltrim(GETSXENUM('ZZ2',"ZZ2_COD"))))

    oModel:SetPrimaryKey({'ZZ2_COD'})

Return oModel


Static Function ViewDef()
    local oModel    := FWLoadModel('CNHMVC') // Carrega o Modelo criado para o Fonte
    local oStruZZ2  := FWFormStruct(2,'ZZ2')// 
    local oView     := FwFormView():NEW()

    oView:SetModel(oModel)

    oView:AddField('VIEW_ZZ2',oStruZZ2,'ZZ2MASTER')

    oView:CreateHorizontalBox('CNH',100)

    oView:SetOwnerView('VIEW_ZZ2','CNH')

Return oView

Static Function ValidPos(oModel)
    local nOperacao := oModel:GetOperation()
    local lValido   := .T.
    local cSigla    := UPPER(alltrim(oModel:GetValue('ZZ2MASTER', 'ZZ2_SIGLA')))
    local cVeiculo  := UPPER(alltrim(oModel:GetValue('ZZ2MASTER', 'ZZ2_VEIC')))
    
    if nOperacao == 3 .OR. nOperacao == 4
        if len(cSigla) = 2
            lValido := .F.
            Help(,,"Valor Inválido",,'A Sigla de Categoria informado possui um tamanho inválido!',1 ,0,,,,,,{'Preencha a sigla com 1 ou 3 caracteres.'})
        elseif !ValVeiculo(cVeiculo)
            lValido := .F.
            Help(,,"Valor Inválido",,'O Veiculo Informado não existe na base de Dados!',1 ,0,,,,,,{'Preencha um veiculo válido ou cadastre um novo.'})
        endif
    endif
return lValido

Static Function ValVeiculo(cVeiculo)
    local lEncontrado := .F.

    DbSelectArea('ZZV')
    ZZV->(DbGoTop())

    while ZZV->(!EOF())
        if cVeiculo == Alltrim(ZZV->ZZV_COD)
            lEncontrado := .T.
        endif
        ZZV->(DbSkip())
    enddo

    ZZV->(DbCloseArea())
return lEncontrado
