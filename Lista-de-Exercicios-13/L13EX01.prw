#INCLUDE 'TOTVS.CH'


/*/{Protheus.doc} User Function L13EX01
    Cria um diretório na pasta Temporária
    @type  Function
    @author user
    @since 24/04/2023
    /*/
User Function L13EX01()
    local cCaminho   := GetTempPath()
    local cNomePasta := 'Lista 13 - Ex1'

    if !ExistDir(cCaminho + cNomePasta)
        if MakeDir(cCaminho + cNomePasta) == 0
            FwAlertSuccess('Pasta Criada com Sucesso', 'Parabéns!')
        else    
            FwAlertError('Houve um Erro ao Criar a Pasta ' + cNomePasta, 'Erro!')
        endif
    endif
Return 
