#INCLUDE 'TOTVS.CH'


User Function ValForn()
    local aArea     := GetArea()
    local aAreaSA2  := SA2->(GetArea())
    local lRetorno  := .T.
    local cPais     := Alltrim(M->A2_PAIS)

    if cPais == ''
        lRetorno := .F.
        Help(,, "C�digo de Pa�s",, "Pa�s n�o informado", 1, 0,,,,,, {"Informe um valor de Pa�s"})
    else
        if cPais == '105' .AND. Alltrim(M->A2_CGC) == ''
            lRetorno := .F.
            Help(,, "CNPJ",, "CNPJ n�o informado", 1, 0,,,,,, {"Informe um valor de CNPJ v�lido"})
        endif
    endif
    RestArea(aArea)
    RestArea(aAreaSA2)
Return lRetorno
