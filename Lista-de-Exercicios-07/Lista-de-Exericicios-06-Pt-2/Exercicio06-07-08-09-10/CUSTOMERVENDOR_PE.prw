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
            if nOperacao == 5 //Solicita confirmação para excluir cadastro
                xRetorno := MsgYesNo('Confirma a Exclusão do Cadastro?','Exclusão de Cadastro!')
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
        FWAlertInfo('Seja Bem Vindo(a) ao Cadastro de Fornecedores!','Inclusão')
    elseif nTipo == 4
        FWAlertInfo('Você está prestes a alterar o cadastro do Fornecedor ' + cNome,'Alteração')
    elseif nTipo == 5
        FWAlertInfo('Cuidado, você está prestes a excluir o cadastro do Fornecedor ' + cNome,'Exclusão')
    endif
Return NIL

