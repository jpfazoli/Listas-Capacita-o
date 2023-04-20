#INCLUDE 'TOTVS.CH'

#DEFINE cUSER     'Joao_Pedro'
#DEFINE cPASSWORD 'Codigo123'

User Function L7Ex06()
    local aEntrada  := {}
    local nConfirma := 0
    local nCont     := 0
    local lValido   := .T.
    local cUsuario  := ''
    local cSenha1   := ''

    while lValido
        aEntrada  := TelaEntrada(nCont)//Recebe os Valores da Tela de Entrada de Usuario

        cUsuario  := aEntrada[1]
        cSenha1   := aEntrada[2]
        nConfirma := aEntrada[3]

        if nConfirma == 1
            lValido := ValUser(cUsuario,cSenha1)//Valida se os Dados conferem com o sistema
            nCont++
        else
            lValido := .F.
        endif

    enddo
Return 


STATIC FUNCTION TelaEntrada(nContador)
    local oDlg      := NIL
    local cUsuario  := Space(50)
    local cSenha1   := Space(18)
    local nConfirma := 0
    local cTitulo   := 'Janela de Entrada de Usuário'

    DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 300,300 PIXEL
    //Entrada de Dados
    @ 030,060 SAY 'USUÁRIO: '   SIZE 60,20 OF oDlg PIXEL
    @ 040,035 MSGET cUsuario    SIZE 80,10 OF oDlg PIXEL
    @ 060,060 SAY 'SENHA:'      SIZE 60,20 OF oDlg PIXEL
    @ 070,035 MSGET cSenha1     SIZE 80,10 PASSWORD OF oDlg PIXEL

    if nContador > 0 //Validação para a Mensagem de Erro
        @ 90,035 SAY 'Usuário e/ou Senha Inválidos' SIZE 80,20 OF oDlg PIXEL COLOR CLR_RED
    endif

    //Botões de Confirmação
    @ 110,042 BUTTON 'Entrar' SIZE 030,011 OF oDlg ACTION (nConfirma := 1, oDlg:End()) PIXEL 
    DEFINE SBUTTON FROM 110,075 TYPE 2 ACTION (nConfirma := 2, oDlg:End()) ENABLE OF oDlg

    ACTIVATE MSDIALOG oDlg CENTERED

Return {Alltrim(cUsuario),Alltrim(cSenha1),nConfirma}


STATIC FUNCTION ValUser(cUsuario,cSenha1)
    local lConfirmado := .T.

    if cUsuario == cUSER .OR. cSenha1 == cPASSWORD //Verifica se senha e Usuário estão corretos
        lConfirmado := .F.
        FwAlertSuccess('Seja Bem Vindo ' + cUsuario, 'Parábens') //Imprime a Mensagem de Bem Vindo
    endif

return lConfirmado
