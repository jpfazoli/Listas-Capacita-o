#INCLUDE 'TOTVS.CH'


USER FUNCTION L2Ex09()
    local cMes := ''
    local aDias    := {'31', '28', '31','30','31','30','31','31','30','31','30','31'}
    local aMes    := {'Janeiro', 'Fevereiro', 'Mar�o','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'}
    local cTitulo  := 'Programa para Informar os dias de um m�s informado'

    while VAL(cMes) < 1 .OR. VAL(cMes) > 12
        cMes := FwInputBox('Informe um valor de 1 a 12: ', cMes)
    enddo

    FwAlertInfo('O m�s informado ' + aMes[VAL(cMes)] + ' tem ' + aDias[VAL(cMes)] + ' dias' , cTitulo)

RETURN
