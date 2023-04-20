#INCLUDE 'TOTVS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function MyMVC_4
  Exemplo MVC
  @type  Function
  @author Jo�o Pedro Fazoli de Souza
  @since 24/03/2023
/*/
User Function MVC_4()
  Local cAlias  := 'ZZC'
  Local cTitle  := 'Cursos'
  local oMark   := FwMarkBrowse():New()

  oMark:SetAlias(cAlias)
  oMark:SetDescription(cTitle)
  oMark:SetFieldMark('ZZC_MARC')
  
  oMark:AddButton('Marcar Todos', 'U_Marcar'      ,, 1)
  oMark:AddButton('Desmarcar Todos', 'U_Desmarcar',, 1)
  oMark:AddButton('Inverter Todos', 'U_Inverter'  ,, 1)
  oMark:AddButton('Deletar Marcados', 'U_Deletar' ,5, 1)
  oMark:AddButton('Exportar Relatorio', 'U_L12EX03' ,6, 1)

  oMark:DisableDetails()
  oMark:DisableReport()
  oMark:Activate()
Return


Static Function ModelDef()
  Local oModel    := MPFormModel():New('MVC_4M')
  Local oStruZZC  := FWFormStruct(1, 'ZZC')
  Local oStruZZB  := FWFormStruct(1, 'ZZB')
  Local aGatilho  := FwStruTrigger('ZZB_COD', 'ZZB_NOME', 'ZZA->ZZA_NOME', .T., 'ZZA', 1, 'xFilial("ZZA")+AllTrim(M->ZZB_COD)')

  oStruZZB:AddTrigger(aGatilho[1], aGatilho[2], aGatilho[3], aGatilho[4])
  
  oModel:SetDescription('Cursos')

  oModel:AddFields('ZZCMASTER', /*COMPONENTE PAI*/, oStruZZC)
  oModel:GetModel('ZZCMASTER'):SetDescription('Cursos')

  oModel:AddGrid('ZZBDETAIL', 'ZZCMASTER', oStruZZB)
  oModel:GetModel('ZZBDETAIL'):SetDescription('Alunos')
  
  oModel:SetRelation('ZZBDETAIL', {{'ZZB_FILIAL', 'xFilial("ZZB")'}, {'ZZB_CURSO', 'ZZC_COD'}}, ZZB->(IndexKey(1)))
  oModel:GetModel('ZZBDETAIL'):SetUniqueLine({'ZZB_COD'})
  oModel:SetPrimaryKey({'ZZC_COD', 'ZZB_COD'})
Return oModel

Static Function ViewDef()
  Local oModel   := FWLoadModel('MVC_4')
  Local oStruZZC := FWFormStruct(2, 'ZZC')
  Local oStruZZB := FWFormStruct(2, 'ZZB')
  Local oView    := FWFormView():New()

  oView:SetModel(oModel)
  oView:AddField('VIEW_ZZC', oStruZZC, 'ZZCMASTER')
  oView:AddGrid('VIEW_ZZB', oStruZZB, 'ZZBDETAIL')

  oView:CreateHorizontalBox('SUPERIOR', 30)
  oView:CreateHorizontalBox('INFERIOR', 70)

  oView:SetOwnerView('VIEW_ZZC', 'SUPERIOR')
  oView:SetOwnerView('VIEW_ZZB', 'INFERIOR')

  oView:EnableTitleView('VIEW_ZZC', 'Dados do Curso')
  oView:EnableTitleView('VIEW_ZZB', 'Alunos Matriculados')

  oView:SetCloseOnOK({|| .T.}) //!True ele fecha a tela e False ele retorna para a tela de cadastro 

  oView:SetAfterOkButton({|| FwAlertSuccess('Tudo certo', 'SetAfterOkButton')})

//  oView:SetViewCanActivate({|| MSGYESNO('Ativar Tela?','SetViewCanActivate')})

//  oView:SetAfterViewActivate({|| FwAlertError('SetAfterViewActivate', 'Tela Ativa')})

Return oView


User Function Marcar()
  DbSelectArea( 'ZZC' )
  ZZC->(DbGoTop())

  while ZZC->(!EOF())
    if !oMark:IsMark()
      oMark:MarkRec()
    endif
    ZZC->(DbSkip())
  enddo

  oMark:Refresh(.T.)

Return


User Function Desmarcar()
  DbSelectArea( 'ZZC' )
  ZZC->(DbGoTop())

  while ZZC->(!EOF())
    if oMark:IsMark()
      oMark:MarkRec()
    endif
    ZZC->(DbSkip())
  enddo

  oMark:Refresh(.T.)
Return

User Function Inverter()
  DbSelectArea( 'ZZC' )
  ZZC->(DbGoTop())

  while ZZC->(!EOF())
    oMark:MarkRec()
    ZZC->(DbSkip())
  enddo

  oMark:Refresh(.T.)
Return

User Function Deletar()
  DbSelectArea( 'ZZC' )
  ZZC->(DbGoTop())
  if MSGYESNO('Confirma a Exclus�o dos Cursos Marcados?')
    while ZZC->(!EOF())
      if oMark:IsMark()
        Reclock('ZZC', .F.)
          ZZC->(DbDelete())
        ZZC->(MsUnlock())
      endif
      ZZC->(DbSkip())
    enddo
  endif

  oMark:Refresh(.T.)
Return
