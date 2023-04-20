#INCLUDE 'TOTVS.CH'

User Function L7Ex07()
    local aEntrada  := {}
    local nCont     := 0
    local lValido   := .T.
    local cUsuario  := Space(50)
    local cSenha1   := Space(18)
    local cConfirma := Space(18)
    Private nLinJan   := 250
    Private nColJan   := 300
    Private cTitulo   := 'Janela de Cadastro de Usuário'

    while lValido
        aEntrada    := TelaEntrada(nCont)
        cUsuario    := aEntrada[1]
        cSenha1     := aEntrada[2]
        cConfirma   := aEntrada[3]
        nCancela    := aEntrada[4]

        if nCancela == 1
            if LEN(cUsuario) > 5 .AND. ValSenha(cSenha1) .AND. cConfirma == cSenha1 //Valida o Usuário, Senha e Confirma Senha
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

STATIC FUNCTION TelaEntrada(nContador)
    local oDlg      := NIL
    local cUsuario  := Space(50)
    local cSenha1   := Space(18)
    local cConfirma := Space(18)
    local nCancela  := 0

        DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO nLinJan,nColJan PIXEL
        //Entrada de Dados
        @ 015,060 SAY 'USUÁRIO: '         SIZE 60,20 OF oDlg PIXEL
        @ 025,035 MSGET cUsuario          SIZE 80,10 OF oDlg PIXEL
        @ 045,060 SAY 'SENHA:'            SIZE 60,20 OF oDlg PIXEL
        @ 055,035 MSGET cSenha1           SIZE 80,10 PASSWORD OF oDlg PIXEL
        @ 075,045 SAY 'CONFIRME A SENHA:' SIZE 60,20 OF oDlg PIXEL
        @ 085,035 MSGET cConfirma         SIZE 80,10 PASSWORD OF oDlg PIXEL
        //Botões de Confirmação
        @ 105,042 BUTTON 'Entrar' SIZE 030,011 OF oDlg ACTION (nCancela := 1, oDlg:End()) PIXEL 
        DEFINE SBUTTON FROM 105,075 TYPE 2 ACTION (nCancela := 2, oDlg:End()) ENABLE OF oDlg

        if nContador > 0 // Validação para Imprimir os Requisitos após valores incorretos
            @ 125,035 SAY ('Usuário Deve Conter ao menos 6 Caracteres' + CRLF + 'A Senha deve conter: ' + CRLF + '1 Letra Maiuscula' + CRLF + '1 Número' + CRLF + '1 Símbolo') SIZE 80,40 OF oDlg PIXEL COLOR CLR_RED
        endif

        ACTIVATE MSDIALOG oDlg CENTERED

Return {Alltrim(cUsuario),Alltrim(cSenha1),Alltrim(cConfirma),nCancela}


STATIC FUNCTION ValSenha(cSenha1)
    local lRetorno   := .F.
    local nASC       := 1
    local nLetra     := 1
    local lMaiusc    := .F.
    local lNumero    := .F.
    local lCaractere := .F.
    local lTamanho   := .F.

    if LEN(cSenha1) >= 6 //Verifica o Tamanho da Senha
        lTamanho := .T.
    endif

    for nLetra := 1 TO LEN(cSenha1) //Verifica se a Senha tem Maiuscula
        if ISUPPER(SubStr(cSenha1,nLetra,1))
            lMaiusc := .T.
        endif

        if ISDIGIT(SubStr(cSenha1,nLetra,1)) //Verifica se a senha tem Digito
            lNumero := .T.
        endif

        //Verificam se existe simbolo
        for nASC := 33 TO 47
            if nASC == ASC(SUBSTR( cSenha1, nLetra, 1))
                lCaractere := .T.
            endif
        next

        for nASC := 58 TO 64
            if nASC == ASC(SUBSTR( cSenha1, nLetra, 1))
                lCaractere := .T.
            endif
        next

        for nASC := 91 TO 94
            if nASC == ASC(SUBSTR( cSenha1, nLetra, 1))
                lCaractere := .T.
            endif
        next

        for nASC := 123 TO 126
            if nASC == ASC(SUBSTR( cSenha1, nLetra, 1))
                lCaractere := .T.
            endif
        next
    next

    if lTamanho .AND. lNumero .AND. lCaractere .AND. lMaiusc //Valida se todos os requisitos foram atendidos
        lRetorno := .T.
    endif

Return lRetorno
