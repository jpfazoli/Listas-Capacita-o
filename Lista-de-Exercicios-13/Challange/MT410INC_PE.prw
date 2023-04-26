#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MT410INC
    Ponto de Entrada para a Inclusão
    @type  Function
    @author João Pedro Fazoli de Souza
    @since 24/04/2023
    /*/
User Function MT410INC()
    iF ExistBlock('GeraRel')
        ExecBlock('GeraRel',.F.,.F.,M->C5_NUM)
    endif
Return 
