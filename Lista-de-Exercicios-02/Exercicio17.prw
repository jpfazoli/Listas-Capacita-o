#INCLUDE 'TOTVS.CH'


USER FUNCTION L2Ex17()
    local nAleatorio  := RANDOMIZE( 0, 100 )
    local cPalpite    := '-1'
    local cTitulo     := 'I wanna Play a Game'



    FwAlertINfo('Regras do Jogo!' + CRLF + 'O computador Sorteará um número entre 0 e 100, seu objetivo é adivinhar!' + CRLF + 'Seu Resultado Será informado depois do palpite, se errar receberá uma dica' + CRLF+ CRLF + 'BOA SORTE! VAI PRECISAR!', cTitulo)

    while nAleatorio <> VAL(cPalpite)
        cPalpite := '-1'
        while VAL(cPalpite) < 0 .OR. VAL(cPalpite) > 100
            cPalpite := ''
            cPalpite := FwInputBox('De seu palpite com um Número de 0 a 100: ', cPalpite)
            if VAL(cPalpite) < 0 .OR. VAL(cPalpite) > 100
                FwAlertError('não leu as regras?', 'É um valor entre 0 e 100!')
            endif
        enddo
        if VAL(cPalpite) < nAleatorio
            FwAlertError('Um pouco mais Alto', 'Errado')
        elseif VAL(cPalpite) > nAleatorio
            FwAlertError('Um pouco mais Baixo', 'Errado')
        endif
    enddo

    FwAlertSuccess('Você Acertou!', 'Parabéns')

Return
