#INCLUDE 'TOTVS.CH'


USER FUNCTION L2Ex16()
    local nI        := 1
    local nJ        := 1
    local cUsername := ''
    local cSenha1   := ''
    local cConfirma := ''
    local lMaiusc   := .F.
    local lNumero   := .F.
    local lSimbolo  := .F.
    local lIguais   := .F.
    local cTitulo   := 'Cadastro Concluido'

    while LEN(cUsername) <= 5
        cUsername   := FwInputBox('Informe o Nome de Usu�rio: ', cUsername)
    enddo

    while LEN(cSenha1) < 6 .OR. lMaiusc == .F. .OR. lNumero == .F. .OR. lSimbolo == .F.
        lMaiusc   := .F.
        lNumero   := .F.
        lSimbolo  := .F.
        cSenha1   := ''
        cSenha1   := FwInputBox('Informe a Senha: ', cSenha1)
        for nI := 1 to LEN(cSenha1)
            
            if ISUPPER(SUBSTR( cSenha1, nI, 1))
                lMaiusc := .T.
            endif

            if ISDIGIT(SUBSTR( cSenha1, nI, 1))
                lNumero := .T.
            endif

            for nJ := 33 TO 47
                if nJ == ASC(SUBSTR( cSenha1, nI, 1))
                    lSimbolo := .T.
                endif
            next
            
            for nJ := 58 TO 64
                if nJ == ASC(SUBSTR( cSenha1, nI, 1))
                    lSimbolo := .T.
                endif
            next
            
            for nJ := 91 TO 94
                if nJ == ASC(SUBSTR( cSenha1, nI, 1))
                    lSimbolo := .T.
                endif
            next

            for nJ := 123 TO 126
                if nJ == ASC(SUBSTR( cSenha1, nI, 1))
                    lSimbolo := .T.
                endif
            next
        next

        if LEN(cSenha1) < 6 .OR. lMaiusc == .F. .OR. lNumero == .F. .OR. lSimbolo == .F.
            FwAlertError('A senha deve conter no m�nimo 6 caracteres, um Caractere Especial, um Digito e uma Letra Maiuscula','Senha Inv�lida!')
        endif

    enddo

    while lIguais ==.F.
        cConfirma := ''
        cConfirma := FwInputBox('Confirme sua Senha: ', cConfirma)
        if cConfirma <> cSenha1
            FwAlertError('As Senhas devem ser Iguais','Senha Inv�lida!')
        else
            lIguais := .T.
        endif
    enddo

    FwAlertSuccess('Cadastro Concluido com Sucesso' , cTitulo)


RETURN
