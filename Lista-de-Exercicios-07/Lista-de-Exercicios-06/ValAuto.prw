#INCLUDE 'TOTVS.CH'


User Function ValAuto()
    local lRetorno  := .T.
    local cInclusao := UPPER(Alltrim(PARAMIXB))

    if cInclusao == 'AUTOMATICO'
        lRetorno := .F.
        FwAlertError('Esse Pedido tem Tipo de Inclus�o = Autom�tico', 'Exclus�o Bloqueada')
    endif

Return lRetorno
