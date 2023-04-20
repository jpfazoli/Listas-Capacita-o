#INCLUDE 'TOTVS.CH'

User Function MT010INC()
    local aArea     := GetArea()
    local aAreaSB1  := SB1->(GetArea())

    SB1->B1_MSBLQL := '1'

    RestArea(aArea)
    RestArea(aAreaSB1)
Return NIL

