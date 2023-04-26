#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function CopiaRel
    Copia os Relat�rios e Logs da Pasta Pedido de Venda no Root
    @type  Function
    @author Jo�o Pedro Fazoli de Souza
    @since 25/04/2023
    /*/
User Function CopiaRel()
    local cPastaOrig := 'C:\TOTVS12\Protheus\protheus_data\Pedidos de Venda\'
    local cPastaDest := GeraPasta()
    local aArquivos  := Directory(cPastaOrig + '*.pdf', 'D',,,1)
    local nCont      := 0

    if Len(aArquivos) > 0
        for nCont := 1 TO Len(aArquivos)
            __CopyFile(cPastaOrig + aArquivos[nCont][1], cPastaDest + aArquivos[nCont][1])
        next
        FwAlertSuccess('Arquivos Copiados com Sucesso', 'Parab�ns!')
    else
        FwAlertInfo('N�o Encontrado Arquivos na Pasta', 'Aten��o')
    endif


Return 

Static Function GeraPasta()
    Local cNomePasta := 'C:\Vendas Protheus\'
    
    if !ExistDir(cNomePasta)
        if MakeDir(cNomePasta) <> 0
            FwAlertError('Houve um Erro ao Criar a Pasta ' + cNomePasta, 'Erro!')
        endif
    endif
Return cNomePasta
