#INCLUDE 'TOTVS.CH'

User Function MA410COR(aCores)
    Default aCores := {}

    aCores := { {"Empty(C5_LIBEROK).And.Empty(C5_NOTA)" ,"CHECKOK"   ,"Pedido em Aberto"},;  //Pedido em Aberto           
                {"!Empty(C5_NOTA).Or.C5_LIBEROK=='E'"   ,"BR_CANCEL" ,"Pedido Encerrado"},;  //Pedido Encerrado          
                {"!Empty(C5_LIBEROK).And.Empty(C5_NOTA)","GCTPIMSE"  ,"Pedido Liberado"} }  //Pedido Liberado

Return ( aCores )   
