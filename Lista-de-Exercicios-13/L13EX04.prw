#INCLUDE 'TOTVS.CH'


/*/{Protheus.doc} User Function L13EX04
    Copia o Arquivo do Exercicio Anterior para uma pasta no Rootpath
    @type  Function
    @author user
    @since 24/04/2023
    /*/
User Function L13EX04()
    local cPastaOrig := 'C:\Users\JOOPED~1\AppData\Local\Temp\lista 13 - ex1\'
    local cPastaDest := CriaPasta()
    local aArquivos  := Directory(cPastaOrig + 'L13EX02.txt','D',,,1)

    if Len(aArquivos) > 0
        if !CpyT2S(cPastaOrig + aArquivos[1][1],cPastaDest)
            MsgStop('Houve um erro ao copiar o arquivo' + aArquivos[1][1])
        endif
        FwAlertSuccess('Arquivos Copiados com Sucesso', 'Parabéns!')
    else
        FwAlertInfo('Arquivo não encontrado!', 'Atenção')
    endif
Return 

Static Function CriaPasta()
    local cNomePasta := '\Lista 13\'

    if !ExistDir(cNomePasta)
        if MakeDir(cNomePasta) <> 0    
            FwAlertError('Houve um Erro ao Criar a Pasta ' + cNomePasta, 'Erro!')
        endif
    endif
Return cNomePasta
