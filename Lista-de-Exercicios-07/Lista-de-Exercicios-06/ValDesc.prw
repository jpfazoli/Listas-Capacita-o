#INCLUDE 'TOTVS.CH'


User Function ValDesc()
    local cRetorno  := ''
    local cDesc     := UPPER(Alltrim(PARAMIXB))
    local cTexto    := 'CAD. MANUAL - '

    if cDesc = cTexto
        cRetorno := cDesc
    else
        cRetorno := cTexto + cDesc
    endif

Return cRetorno
