#INCLUDE 'TOTVS.CH'


USER FUNCTION L2Ex17()
    local nAleatorio  := RANDOMIZE( 0, 100 )
    local cPalpite    := '-1'
    local cTitulo     := 'I wanna Play a Game'



    FwAlertINfo('Regras do Jogo!' + CRLF + 'O computador Sortear� um n�mero entre 0 e 100, seu objetivo � adivinhar!' + CRLF + 'Seu Resultado Ser� informado depois do palpite, se errar receber� uma dica' + CRLF+ CRLF + 'BOA SORTE! VAI PRECISAR!', cTitulo)

    while nAleatorio <> VAL(cPalpite)
        cPalpite := '-1'
        while VAL(cPalpite) < 0 .OR. VAL(cPalpite) > 100
            cPalpite := ''
            cPalpite := FwInputBox('De seu palpite com um N�mero de 0 a 100: ', cPalpite)
            if VAL(cPalpite) < 0 .OR. VAL(cPalpite) > 100
                FwAlertError('n�o leu as regras?', '� um valor entre 0 e 100!')
            endif
        enddo
        if VAL(cPalpite) < nAleatorio
            FwAlertError('Um pouco mais Alto', 'Errado')
        elseif VAL(cPalpite) > nAleatorio
            FwAlertError('Um pouco mais Baixo', 'Errado')
        endif
    enddo

    FwAlertSuccess('Voc� Acertou!', 'Parab�ns')

Return
