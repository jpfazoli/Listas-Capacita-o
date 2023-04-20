#INCLUDE 'TOTVS.CH'


USER FUNCTION L2Ex18()
    local nAleatorio  := RANDOMIZE( 0, 100 )
    local cPalpite    := '-1'
    local nTentativas := 0
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
            FwAlertError('A Reposta é um pouco mais Alto', 'Errado')
        elseif VAL(cPalpite) > nAleatorio
            FwAlertError('A Reposta é um pouco mais Baixo', 'Errado')
        endif
        nTentativas++
    enddo

    if nTentativas == 1
        FwAlertSuccess('Você é Excelente, Quem precisa de mais de uma tentativa!', 'Parabéns')
    elseif nTentativas > 1 .AND. nTentativas < 5
        FwAlertSuccess('Você é Muito Bom, Acertou em ' + cVALTOCHAR(nTentativas) +' Tentativas!', 'Parabéns')
    elseif nTentativas >= 5 .AND. nTentativas < 9
        FwAlertSuccess('Você é Mediano, Acertou em ' + cVALTOCHAR(nTentativas) +' Tentativas!', 'Parabéns')
    else 
        FwAlertSuccess('Você é muito Fraco, Acertou em ' + cVALTOCHAR(nTentativas) +' Tentativas!', 'Parabéns')
    endif

RETURN
