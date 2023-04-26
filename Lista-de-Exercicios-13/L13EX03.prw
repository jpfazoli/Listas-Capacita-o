#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function L13EX03
    Ler Arquivos Txt
    @type  Function
    @author João Pedro Fazoli de Souza
    @since 24/04/2023
    /*/
User Function L13EX03()
    local cPasta    := 'C:\Users\JOOPED~1\AppData\Local\Temp\lista 13 - ex1\'
    local cArquivo  := 'l13ex02.txt'
    local cTxtLin   := ''
    local oLeitor   := FwFileReader():New(cPasta + cArquivo)

    if oLeitor:Open()

        if !oLeitor:EOF()
            while oLeitor:HasLine()
                cTxtLin += oLeitor:GetLine(.T.)
            enddo
        endif

        oLeitor:Close()
    endif

    FwAlertInfo(cTxtLin, 'Conteudo do Arquivo')

Return 
