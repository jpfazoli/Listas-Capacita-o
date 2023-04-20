#INCLUDE 'TOTVS.CH'


User Function ValForn()
    local aArea     := GetArea()
    local aAreaSA2  := SA2->(GetArea())
    local lRetorno  := .T.
    local cPais     := Alltrim(M->A2_PAIS)

    if cPais == ''
        lRetorno := .F.
        Help(,, "Código de País",, "País não informado", 1, 0,,,,,, {"Informe um valor de País"})
    else
        if cPais == '105' .AND. Alltrim(M->A2_CGC) == ''
            lRetorno := .F.
            Help(,, "CNPJ",, "CNPJ não informado", 1, 0,,,,,, {"Informe um valor de CNPJ válido"})
        endif
    endif
    RestArea(aArea)
    RestArea(aAreaSA2)
Return lRetorno
