#INCLUDE 'TOTVS.CH'
#Include "FWMVCDef.ch"

User Function CUSTOMERVENDOR()
    local aArea     := GetArea()
    local aAreaSA2  := SA2->(GetArea())
    local aParam    := PARAMIXB
    local oObj      := NIL
    local xRetorno  := .T.
    local nOperacao := ''
    local cIdPonto  := ''
    local cIdModel  := ''

    if aParam <> NIL
        oObj     := aParam[1]
        cIdPonto := aParam[2]
        cIdModel := aParam[3]
        nOperacao := oObj:GetOperation()

        if cIdPonto == 'FORMPOS' // Exercicio 06
            if ExistBlock('ValForn') //Valida o Pais e CNPJ do Fornecedor
                xRetorno := ExecBlock('ValForn',.T.,.T.)
            endif
        
        elseif cIdPonto == 'MODELPOS' // Exercicio 09
            if nOperacao == 5 //Solicita confirma��o para excluir cadastro
                xRetorno := MsgYesNo('Confirma a Exclus�o do Cadastro?','Exclus�o de Cadastro!')
            endif


        elseif cIdPonto == 'MODELVLDACTIVE' //Exercicio 08
            MsgAcoes(nOperacao,Alltrim(SA2->A2_NOME))
        
        elseif cIdPonto == 'BUTTONBAR' //Exercicio 07
            if INCLUI
                oObj:GetModel('SA2MASTER'):LoadValue('A2_LOJA', '0' + CValtoChar(Randomize(1,9)))
                oView := FwViewActive()
                oView:Refresh()

                xRetorno := {{"Cadastro de Produtos", "Cadastro de Produtos", {|| AxCadastro('SB1','Cadastro de Produtos','.F.','.F.')}}} //Exercicio 10
            endif
        endif
    endif    

    RestArea(aArea)
    RestArea(aAreaSA2)
Return xRetorno

Static Function MsgAcoes(nTipo,cNome)
    if nTipo == 3
        FWAlertInfo('Seja Bem Vindo(a) ao Cadastro de Fornecedores!','Inclus�o')
    elseif nTipo == 4
        FWAlertInfo('Voc� est� prestes a alterar o cadastro do Fornecedor ' + cNome,'Altera��o')
    elseif nTipo == 5
        FWAlertInfo('Cuidado, voc� est� prestes a excluir o cadastro do Fornecedor ' + cNome,'Exclus�o')
    endif
Return NIL

