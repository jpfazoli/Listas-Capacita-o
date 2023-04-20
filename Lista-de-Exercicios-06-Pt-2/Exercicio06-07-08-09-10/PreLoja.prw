#INCLUDE 'TOTVS.CH'


User Function PreLoja()
    local cRetorno  := ''
    if INCLUI
        cRetorno := ALLTRIM(STR(Randomize(1,9)))
    endif
Return cRetorno
