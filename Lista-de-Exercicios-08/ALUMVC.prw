#INCLUDE 'TOTVS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function ALUMVC
    Fun��o para Cadastro de Alunos da Auto Escola
    @type  Function
    @author Jo�o Pedro Fazoli de Souza
    @since 28/03/2023
    /*/
User Function ALUMVC()
    local cAlias    := 'ZZ4'
    local cTitle    := 'Cadastro de Alunos para CNH'
    local oMark   := FwMarkBrowse():New()

    oMark:SetAlias(cAlias)
    oMark:SetDescription(cTitle)
    oMark:SetFieldMark('ZZ4_MARC')
    
    oMark:AddButton('Excluir Marcados', 'U_DelTodos',5, 1)

    oMark:DisableDetails()
    oMark:DisableReport()
    oMark:Activate()

Return


Static Function MenuDef()
    local aRotina := {}

    ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.ALUMVC' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.ALUMVC' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.ALUMVC' OPERATION 5 ACCESS 0

Return aRotina

Static Function ModelDef()
    //!Valida��es do Modelo
    local bModelPos      := {|oModel| ValidPos(oModel)}
    local bModelCommit   := {|oModel| CommitZZ3(oModel)}

    local oModel         := MPFormModel():NEW('ALUMVCM',/*bModelPre*/,bModelPos,bModelCommit)
    local oStruZZ4       := FWFormStruct(1,'ZZ4')
    local aGatilho       := FwStruTrigger('ZZ4_INST','ZZ4_NOMEIN','ZZ3->ZZ3_NOME',.T.,'ZZ3',1,'xFilial("ZZ4")+Alltrim(M->ZZ4_INST)')
    //local cInstAntigo  := oModel:GetValue('ZZ4MASTER', 'ZZ4_INST')

    oStruZZ4:AddTrigger(aGatilho[1],aGatilho[2],aGatilho[3],aGatilho[4])

    oModel:AddFields('ZZ4MASTER',/*Pai*/,oStruZZ4)

    oModel:SetDescription('Modelo de Dados de Alunos da Auto Escola')

    //!Inicializa��o Padr�o
    oStruZZ4:SetProperty('ZZ4_COD', MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, GETSXENUM('ZZ4',"ZZ4_COD")))

    oModel:GetModel('ZZ4MASTER'):SetDescription('Formulario dos Alunos')

    oModel:SetPrimaryKey({'ZZ4_COD'})

Return oModel

Static Function ViewDef()
    local oModel    := FWLoadModel('ALUMVC') // Carrega o Modelo criado para o Fonte
    local oStruZZ4  := FWFormStruct(2,'ZZ4')// 
    local oView     := FwFormView():NEW()

    oView:SetModel(oModel)

    oView:AddField('VIEW_ZZ4',oStruZZ4,'ZZ4MASTER')

    oView:CreateHorizontalBox('GERAL',100)

    oView:SetFieldAction('ZZ4_AULA', {|oView| ValAula(oView)})
    oView:SetFieldAction('ZZ4_INST', {|oView| ValAula(oView)})

    oView:SetOwnerView('VIEW_ZZ4','GERAL')

Return oView


Static Function ValidPos(oModel)
  local lValido       := .T.
  local nOperacao     := oModel:GetOperation()
  local cRealizando   := UPPER(oModel:GetValue('ZZ4MASTER', 'ZZ4_AULA'))
  local cInstrutor    := UPPER(Alltrim(oModel:GetValue('ZZ4MASTER','ZZ4_INST')))
  local nAlunos       := BuscaAlunos(cInstrutor) //! Fun��o que verifica o n�mero de alunos do Instrutor dentro de ZZ3
  local cInsAntigo  := EncAntigo(oModel:GetValue('ZZ4MASTER', 'ZZ4_COD'))

  if nOperacao == 5
    if cRealizando == 'SIM'
        lValido := .F.
        Help(,,"Exclus�o Inv�lida",,'N�o � poss�vel excluir Alunos Realizando Aulas!',1 ,0,,,,,,{'Reveja os Alunos.'})
    endif
  elseif nOperacao == 3 .OR. nOperacao == 4
        if nAlunos >= 5 //!Verifica se o Instrutor j� tem 5 Alunos
            lValido := .F.
            Help(,,"Instrutor Inv�lida",,'Cada Instrutor pode ter no m�ximo 5 Alunos!',1 ,0,,,,,,{'Preencha com um Instrutor v�lido.'})
        elseif cRealizando == 'SIM' .AND. nAlunos >= 5 //!Verifica se o Instrutor tem 5 Alunos e se est� realizando as Aulas
            lValido := .F.
            Help(,,"Instrutor Inv�lida",,'O Aluno s� pode ser considerado realizando a Aula se o Instrutor tiver no m�ximo 5 Alunos!',1 ,0,,,,,,{'Preencha com um Instrutor v�lido ou mude o Status de Realizando do Aluno.'})
        elseif cInstrutor == '' .AND. cRealizando == 'SIM' //!Verifica se o Instrutor foi preenchido e se est� realizando as Aulas
            lValido := .F.
            Help(,,"Instrutor Inv�lida",,'O Aluno s� pode ser considerado realizando a Aula se tiver um Instrutor!',1 ,0,,,,,,{'Preencha com um Instrutor v�lido ou mude o Status de Realizando do Aluno.'})
        endif
  endif
  
  //!Altera��o do N�mero de Alunos do Instrutor caso seja alterado
  DbSelectArea('ZZ3')
  ZZ3->(DbGoTop())
  if nOperacao == 4 .AND. lValido == .T.
        if cInstrutor <> cInsAntigo
          if ZZ3->(DbSeek(xFilial('ZZ3') + cInsAntigo))
            Reclock('ZZ3',.F.)
            ZZ3->ZZ3_ALUNOS -= 1
            MsUnlock()
          endif
          if ZZ3->(DbSeek(xFilial('ZZ3') + cInstrutor))
            Reclock('ZZ3',.F.)
            ZZ3->ZZ3_ALUNOS += 1
            MsUnlock()
          endif
        endif
  endif
  ZZ3->(DbCloseArea())

Return lValido


User Function DelTodos()
  local nCont := 0

  DbSelectArea( 'ZZ4' )
  ZZ4->(DbGoTop())

  DbSelectArea('ZZ3')
  ZZ3->(DbGoTop())

  if MSGYESNO('Confirma a Exclus�o dos Alunos Marcados?')
    while ZZ4->(!EOF())
      if oMark:IsMark() .AND. ZZ4->ZZ4_AULA == 'N�o'
        if DbSeek(xFilial('ZZ3') + ZZ4->ZZ4_INST)
          Reclock('ZZ3', .F.)
          ZZ3->ZZ3_ALUNOS -= 1
          ZZ3->(MsUnlock())
        endif

        Reclock('ZZ4', .F.)
        ZZ4->(DbDelete())
        ZZ4->(MsUnlock())
        
      elseif oMark:IsMark() .AND. ZZ4->ZZ4_AULA == 'Sim'
        nCont++ 
      endif
      ZZ4->(DbSkip())
    enddo
  endif

  if nCont++
    Help(,,"Exclus�o Inv�lida",,'N�o � poss�vel excluir Alunos Realizando Aulas!',1 ,0,,,,,,{'Reveja os Alunos.'})
  endif

  oMark:Refresh(.T.)
Return

Static Function BuscaAlunos(cInstrutor)
    local nAlunos := 0

    DbSelectArea('ZZ3')
    ZZ3->(DbGoTop())

    While ZZ3->(!EOF())
        if cInstrutor == Alltrim(Upper(ZZ3->ZZ3_COD))
            nAlunos := ZZ3->ZZ3_ALUNOS
        endif
        ZZ3->(DbSkip())
    enddo

    ZZ3->(DbCloseArea())
Return nAlunos

Static Function CommitZZ3(oModel)
    local nOperacao   := oModel:GetOperation()
    Local lGravo      := FWFormCommit(oModel)
    local cInstrutor  := oModel:GetValue('ZZ4MASTER', 'ZZ4_INST')

    DbSelectArea('ZZ3')
    ZZ3->(DbGoTop())

    If lGravo
        while ZZ3->(!EOF())
          if ZZ3->ZZ3_COD == cInstrutor
            Reclock('ZZ3',.F.)
            if nOperacao == 3
              ZZ3->ZZ3_ALUNOS += 1 //!Incrementa o N�mero de Alunos do Instrutor
            elseif nOperacao == 5
              ZZ3->ZZ3_ALUNOS -= 1 //!Incrementa o N�mero de Alunos do Instrutor
            endif
            MsUnlock()
          endif
          ZZ3->(DbSkip())
        enddo
    endif
    ZZ3->(DbCloseArea())
Return lGravo


Static Function ValAula(oView)
  local lValido       := .T.
  local oModel        := oView:GetModel('ZZ4MASTER')
  local nOperacao     := oModel:GetOperation()
  local cRealizando   := UPPER(oModel:GetValue( 'ZZ4_AULA'))
  local cInstrutor    := UPPER(Alltrim(oModel:GetValue('ZZ4_INST')))
  local nAlunos       := BuscaAlunos(cInstrutor) //! Fun��o que verifica o n�mero de alunos do Instrutor dentro de ZZ3

  if nOperacao == 3 .OR. nOperacao == 4
    if cRealizando == 'SIM' .AND. nAlunos >= 5 //!Verifica se o Instrutor tem 5 Alunos e se est� realizando as Aulas
            lValido := .F.
            oModel:SetValue('ZZ4_AULA', 'N�o')
            Help(,,"Instrutor Inv�lida",,'O Aluno s� pode ser considerado realizando a Aula se o Instrutor tiver no m�ximo 5 Alunos!',1 ,0,,,,,,{'Preencha com um Instrutor v�lido ou mude o Status de Realizando do Aluno.'})
    elseif cInstrutor == '' .AND. cRealizando == 'SIM' //!Verifica se o Instrutor foi preenchido e se est� realizando as Aulas
            lValido := .F.
            oModel:SetValue('ZZ4_AULA', 'N�o')
            Help(,,"Instrutor Inv�lida",,'O Aluno s� pode ser considerado realizando a Aula se tiver um Instrutor!',1 ,0,,,,,,{'Preencha com um Instrutor v�lido ou mude o Status de Realizando do Aluno.'})
    endif
  endif

  oView:Refresh()
Return lValido

Static Function EncAntigo(cAluno)
  local cInstrutor := ''


  DbSelectArea('ZZ4')
  ZZ4->(DbGoTop())
  if DbSeek(xFilial('ZZ4') + cAluno)
    cInstrutor := ZZ4->ZZ4_INST
  endif

  ZZ4->(DbCloseArea())
Return cInstrutor
