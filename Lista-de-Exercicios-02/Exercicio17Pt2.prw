#INCLUDE 'TOTVS.CH'


USER FUNCTION L2Ex18()
    local nAleatorio  := RANDOMIZE( 0, 100 )
    local cPalpite    := '-1'
    local nTentativas := 0
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
            FwAlertError('A Reposta � um pouco mais Alto', 'Errado')
        elseif VAL(cPalpite) > nAleatorio
            FwAlertError('A Reposta � um pouco mais Baixo', 'Errado')
        endif
        nTentativas++
    enddo

    if nTentativas == 1
        FwAlertSuccess('Voc� � Excelente, Quem precisa de mais de uma tentativa!', 'Parab�ns')
    elseif nTentativas > 1 .AND. nTentativas < 5
        FwAlertSuccess('Voc� � Muito Bom, Acertou em ' + cVALTOCHAR(nTentativas) +' Tentativas!', 'Parab�ns')
    elseif nTentativas >= 5 .AND. nTentativas < 9
        FwAlertSuccess('Voc� � Mediano, Acertou em ' + cVALTOCHAR(nTentativas) +' Tentativas!', 'Parab�ns')
    else 
        FwAlertSuccess('Voc� � muito Fraco, Acertou em ' + cVALTOCHAR(nTentativas) +' Tentativas!', 'Parab�ns')
    endif

RETURN
