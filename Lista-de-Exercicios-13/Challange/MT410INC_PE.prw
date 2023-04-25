#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function M410AGRV
    Ponto de Entrada
    @type  Function
    @author user
    @since 24/04/2023
    /*/
User Function MT410INC()
    iF ExistBlock('GeraRel')
        ExecBlock('GeraRel',.F.,.F.,M->C5_NUM)
    endif
Return 
