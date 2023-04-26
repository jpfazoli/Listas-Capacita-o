#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function L13EX02
    Cria um Arquivo Txt dentro da Pasta do Exercicio Anterior
    @type  Function
    @author João Pedro Fazoli de Souza
    @since 24/04/2023
    /*/
User Function L13EX02()
    local cPasta := 'C:\Users\JOOPED~1\AppData\Local\Temp\lista 13 - ex1\'
    local cArquivo := 'L13EX02.txt'
    local oWriter := FwFileWriter():New(cPasta + cArquivo,.T.)

    if File(cPasta + cArquivo)
        FwAlertInfo('O Arquivo ' + cArquivo + ' já existe', 'Atenção!')
    else
        if oWriter:Create()
            oWriter:Write('As vezes tudo é uma questão de ponto e virgula igual no código')

            oWriter:Close()

            if MsgYesNo('Arquivo Gerado com Sucesso! (' + cPasta + cArquivo + ')' + CRLF + 'Abrir o Arquivo?', 'Executar?')
                ShellExecute('OPEN',cArquivo, '', cPasta, 1)
            endif
        else
            FwAlertError('Houve um erro ao gerar o arquivo!' + CRLF + oWriter:Error():Message, 'Erro!')
        endif
    endif

Return 
