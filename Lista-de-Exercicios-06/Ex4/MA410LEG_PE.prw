#INCLUDE 'TOTVS.CH'

USER FUNCTION MA410LEG()
    local aLeg := PARAMIXB

    aLeg := { {'CHECKOK'   ,"Pedido de Venda em aberto"},;
              {'BR_CANCEL' ,"Pedido de Venda encerrado"},;
              {'GCTPIMSE'  ,"Pedido de Venda liberado" },;
              {'BR_AZUL'   ,"Pedido de Venda com Bloqueio de Regra"},;
              {'BR_LARANJA',"Pedido de Venda com Bloqueio de Verba" }}

Return aLeg
