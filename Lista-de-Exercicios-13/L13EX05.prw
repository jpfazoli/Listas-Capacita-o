#INCLUDE 'TOTVS.CH'


/*/{Protheus.doc} User Function L13EX05
    Deleta a Pasta Criada no Exercicio 1
    @type  Function
    @author user
    @since 24/04/2023
    /*/
User Function L13EX05()
    local cPasta     := 'C:\Users\JOOPED~1\AppData\Local\Temp\lista 13 - ex1\'
    local aArquivos  := Directory(cPasta + '*.*', 'D',,,1)
    local nCont      := 0

    if ExistDir(cPasta)
        if MsgYesNo('Confirma Exclusão da Pasta?', 'Atenção!')
            if Len(aArquivos) > 0
                for nCont := 1 TO Len(aArquivos)
                    if FErase(cPasta + aArquivos[nCont][1]) == -1
                        MsgStop('Houve um erro ao apagar o arquivo' + aArquivos[nCont][1])
                    endif
                next
            endif

            if DirRemove(cPasta)
                FwAlertSuccess('Pasta Apagada com Sucesso!', 'Concluido')
            else
                FwAlertError('Houve um Erro ao Excluir a Pasta!', 'Erro')
            endif
        endif
    endif
Return 

