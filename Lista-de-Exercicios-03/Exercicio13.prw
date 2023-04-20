#INCLUDE 'TOTVS.CH'

USER FUNCTION L3Ex13()
    local aSemana  := {'Domingo', 'Segunda-Feira', 'Terça-Feira', 'Quarta-Feira', 'Quinta-Feira','Sexta-Feira', 'Sábado'}
    local nEntrada := 0

    while nEntrada < 1 .OR. nEntrada > 7
       nEntrada :=  VAL(FwInputBox('Informe um valor entre 1 e 7 para saber o dia da semana: ', ''))
       if nEntrada < 1 .OR. nEntrada > 7
            FwAlertError('Aceito apenas valores entre 1 e 7', 'Informe um valor válido!')
       endif
    enddo

    FwAlertInfo('O valor informado corresponde a ' + aSemana[nEntrada], 'Programa para Retornar o dia da semana de um valor informado')

RETURN
