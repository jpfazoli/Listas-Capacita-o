#INCLUDE 'TOTVS.CH'


#DEFINE cUsername   'Joao-Pedro'
#DEFINE cPassword   'Jogos123'

USER FUNCTION L2Ex08()
    local cUsuario := ''
    local cSenha1   := ''
    local cTitulo  := 'Programa para Entrada de Usu�rio e Senha'

    FwAlertInfo('Para Continuar no Programa, Informe seu Usu�rio e Senha' , cTitulo)

    cUsuario := FwInputBox('Nome de Usu�rio: ', cUsuario)
    cSenha1   := FwInputBox('Senha: ', cSenha1)

    if  (cUsuario == cUsername) .AND. (cSenha1 == cPassword)
        FwAlertSuccess('Seja Bem-Vindo ' + cUsuario , 'Acesso Permitido!')
    else
        FwAlertError('Usu�rio e/ou Senha incorretos ' , 'Acesso Negado!')
    endif

RETURN
