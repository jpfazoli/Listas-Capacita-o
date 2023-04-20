#INCLUDE 'TOTVS.CH'

User Function L4Ex07()
    local oDlg      := NIL
    local nCont     := 0
    local nI        := 0
    local nJ        := 0
    local lMaiusc   := .F.
    local lNumero   := .F.
    local lCaractere:= .F.
    local lValido   := .T.
    local cUsuario  := Space(50)
    local cSenha1   := Space(18)
    local cConfirma := Space(18)
    local nLinJan   := 250
    local nColJan   := 300
    local cTitulo   := 'Janela de Cadastro de Usuário'

    while lValido
        cUsuario  := Space(50)
        cSenha1   := Space(18)
        cConfirma := Space(18)
        DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO nLinJan,nColJan PIXEL
        @ 015,060 SAY 'USUÁRIO: ' SIZE 60,20 OF oDlg PIXEL
        @ 025,035 MSGET cUsuario SIZE 80,10 OF oDlg PIXEL
        @ 045,060 SAY 'SENHA:' SIZE 60,20 OF oDlg PIXEL
        @ 055,035 MSGET cSenha1 SIZE 80,10 PASSWORD OF oDlg PIXEL
        @ 075,045 SAY 'CONFIRME A SENHA:' SIZE 60,20 OF oDlg PIXEL
        @ 085,035 MSGET cConfirma SIZE 80,10 PASSWORD OF oDlg PIXEL
        @ 105,042 BUTTON 'Entrar' SIZE 030,011 OF oDlg ACTION (nOpcao := 1, oDlg:End()) PIXEL 
        DEFINE SBUTTON FROM 105,075 TYPE 2 ACTION (nOpcao := 2, oDlg:End()) ENABLE OF oDlg

        if lValido .AND. nCont > 0
            @ 125,035 SAY ('Usuário Deve Conter ao menos 6 Caracteres' + CRLF + 'A Senha deve conter: ' + CRLF + '1 Letra Maiuscula' + CRLF + '1 Número' + CRLF + '1 Símbolo') SIZE 80,40 OF oDlg PIXEL COLOR CLR_RED
        endif

        ACTIVATE MSDIALOG oDlg CENTERED

        cUsuario := Alltrim(cUsuario)
        cSenha1 := Alltrim(cSenha1)
        cConfirma := Alltrim(cConfirma)

        if nOpcao == 1
            lMaiusc := .F.
            lNumero := .F.
            lCaractere := .F.
            for nI := 1 TO LEN(cSenha1)
                if ISUPPER(SubStr(cSenha1,nI,1))
                    lMaiusc := .T.
                endif

                if ISDIGIT(SubStr(cSenha1,nI,1))
                    lNumero := .T.
                endif

                for nJ := 33 TO 47
                    if nJ == ASC(SUBSTR( cSenha1, nI, 1))
                        lCaractere := .T.
                    endif
                next

                for nJ := 58 TO 64
                    if nJ == ASC(SUBSTR( cSenha1, nI, 1))
                        lCaractere := .T.
                    endif
                next

                for nJ := 91 TO 94
                    if nJ == ASC(SUBSTR( cSenha1, nI, 1))
                        lCaractere := .T.
                    endif
                next

                for nJ := 123 TO 126
                    if nJ == ASC(SUBSTR( cSenha1, nI, 1))
                        lCaractere := .T.
                    endif
                next
            next

            if LEN(cUsuario) > 5 .AND. lMaiusc .AND. lNumero .AND. lCaractere .AND. LEN(cSenha1) >= 6 .AND. cConfirma == cSenha1
                lValido := .F.
                FwAlertSuccess('Seja Bem Vindo ' + cUsuario, 'Parábens')
            else
                nCont++
                nLinJan := 350
            endif

        else
            lValido := .F.
        endif

    enddo

Return 
