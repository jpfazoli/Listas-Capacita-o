#INCLUDE 'TOTVS.CH'

User Function MT010INC()
    local aArea     := GetArea()
    local aAreaSB1  := SB1->(GetArea())

    if ExistBlock('ValDesc')
        SB1->B1_DESC := ExecBlock('ValDesc', .F., .F.,SB1->B1_DESC)
    endif

    RestArea(aArea)
    RestArea(aAreaSB1)
Return NIL

