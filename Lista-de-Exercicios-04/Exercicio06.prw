#INCLUDE 'TOTVS.CH'

#DEFINE cUser 'Joao_Pedro'
#DEFINE cPassword 'Codigo123'

User Function L4Ex06()
    local oDlg      := NIL
    local nCont     := 0
    local lValido   := .T.
    local cUsuario  := Space(50)
    local cSenha1   := Space(18)
    local cTitulo   := 'Janela de Entrada de Usuário'

    while lValido
        DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 300,300 PIXEL
        @ 030,060 SAY 'USUÁRIO: ' SIZE 60,20 OF oDlg PIXEL
        @ 040,035 MSGET cUsuario SIZE 80,10 OF oDlg PIXEL
        @ 060,060 SAY 'SENHA:' SIZE 60,20 OF oDlg PIXEL
        @ 070,035 MSGET cSenha1 SIZE 80,10 PASSWORD OF oDlg PIXEL

        if lValido .AND. nCont > 0
            @ 90,035 SAY 'Usuário e/ou Senha Inválidos' SIZE 80,20 OF oDlg PIXEL COLOR CLR_RED
        endif

        @ 110,042 BUTTON 'Entrar' SIZE 030,011 OF oDlg ACTION (nOpcao := 1, oDlg:End()) PIXEL 
        DEFINE SBUTTON FROM 110,075 TYPE 2 ACTION (nOpcao := 2, oDlg:End()) ENABLE OF oDlg

        ACTIVATE MSDIALOG oDlg CENTERED

        cUsuario := Alltrim(cUsuario)
        cSenha1 := Alltrim(cSenha1)

        if nOpcao == 1
            if cUsuario == cUser .OR. cSenha1 == cPassword
                lValido := .F.
                FwAlertSuccess('Seja Bem Vindo ' + cUsuario, 'Parábens')
            else
                nCont++
            endif
        else
            lValido := .F.
        endif

    enddo
Return 
