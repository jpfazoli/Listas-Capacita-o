#INCLUDE 'TOTVS.CH'

User Function vldExc()
    local cMsg := 'Confirma que deseja Excluir esse Registro?'
    local lRet := .F.

    lRet := MsgYesNo(cMsg, 'Confirmação')
Return lRet
