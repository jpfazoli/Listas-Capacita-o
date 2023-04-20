#INCLUDE 'TOTVS.CH'


User Function L5EX17()
    local oDlg  := nil
    local aValor  := ACLONE(PopArray(8))
    local nOpcao  := 0
    local nLinJan := 570
    local nColJan := 380

    while nOpcao <> 12
        DEFINE MSDIALOG oDlg TITLE 'Notas Alunos'   FROM 000,000 TO nLinJan,nColJan PIXEL
        @ 010,040 SAY    'Trabalhando com Vetores Clique nos Botões'  SIZE 150,10 OF oDlg COLOR CLR_BLUE PIXEL
        @ 020,020 BUTTON 'Preencher Aleatoriamente' SIZE 150,020 OF oDlg ACTION (nOpcao := 1,aValor := ACLONE(PopArray(8))) PIXEL
        @ 040,020 BUTTON 'Preencher Manualmente'    SIZE 150,020 OF oDlg ACTION (nOpcao := 2,aValor := ACLONE(PreencheArray())) PIXEL
        @ 060,020 BUTTON 'Exibir Array'             SIZE 150,020 OF oDlg ACTION (nOpcao := 3,ImprimeArray(aValor))  PIXEL
        @ 080,020 BUTTON 'Ordem Crescente'          SIZE 150,020 OF oDlg ACTION (nOpcao := 4,OrdCresc(aValor))      PIXEL
        @ 100,020 BUTTON 'Ordem Decrescente'        SIZE 150,020 OF oDlg ACTION (nOpcao := 5,OrdDecr(aValor))       PIXEL
        @ 120,020 BUTTON 'Pesquisar Valor'          SIZE 150,020 OF oDlg ACTION (nOpcao := 6,BuscaArray(aValor))    PIXEL
        @ 140,020 BUTTON 'Somatória'                SIZE 150,020 OF oDlg ACTION (nOpcao := 7,SomaArray(aValor))     PIXEL
        @ 160,020 BUTTON 'Média'                    SIZE 150,020 OF oDlg ACTION (nOpcao := 8,MediaArray(aValor))   PIXEL
        @ 180,020 BUTTON 'Maior e Menor'            SIZE 150,020 OF oDlg ACTION (nOpcao := 9,MaiorMenor(aValor))    PIXEL
        @ 200,020 BUTTON 'Embaralhar'               SIZE 150,020 OF oDlg ACTION (nOpcao := 10,EmbaralhaArray(aValor))PIXEL
        @ 220,020 BUTTON 'Valores Repetidos'        SIZE 150,020 OF oDlg ACTION (nOpcao := 11,RepeteArray(aValor)) PIXEL

        @ 250,020 BUTTON 'FECHAR' SIZE 150,020 OF oDlg ACTION (nOpcao := 12,oDlg:END()) PIXEL

        ACTIVATE MSDIALOG oDlg CENTERED


    enddo

Return 

STATIC FUNCTION PopArray(nTam)
    local nCont := 0
    local aArray[nTam]

    for nCont := 1 TO nTam
        aArray[nCont] := RANDOMIZE( 1, 100)
    next

Return aArray

STATIC Function PreencheArray()
    local nCont  := 1
    local aArray[8]


    For nCont := 1 TO 8
        aArray[nCont] := VAL(FwInputBox('Informe um valor: ', ''))
    next

return aArray

STATIC Function OrdCresc(aArray)
    local nAux      := 0
    local nI        := 0
    local nJ        := 0

    for nJ := 1 TO LEN(aArray)-1 
        for nI := 1 TO LEN(aArray)-1
            if aArray[nI] > aArray[nI+1]
                nAux        := aArray[nI]
                aArray[nI]   := aArray[nI+1]
                aArray[nI+1] := nAux
            endif
        next
    next 
    
    FwAlertSuccess( 'Vetor Ordenado com Sucesso!', 'Programa para Ordem Crescente')
Return aArray

STATIC Function OrdDecr(aArray)
    local nAux      := 0
    local nI        := 0
    local nJ        := 0

    for nJ := 1 TO LEN(aArray)-1 
        for nI := 1 TO LEN(aArray)-1
            if aArray[nI] < aArray[nI+1]
                nAux        := aArray[nI]
                aArray[nI]   := aArray[nI+1]
                aArray[nI+1] := nAux
            endif
        next
    next 

    FwAlertSuccess( 'Vetor Ordenado com Sucesso!', 'Programa para Ordem Decrescente')
Return aArray

STATIC FUNCTION ImprimeArray(aArray)
    local cMsg  := ''
    local nCont := 0

    for nCont := 1 TO LEN(aArray)
        if nCont < LEN(aArray)
            cMsg += CVALTOCHAR(aArray[nCont])  + ', '
        else
            cMsg += CVALTOCHAR(aArray[nCont])
        endif
    next

    FwAlertSuccess( 'Os valores do Array: ' + CRLF + cMsg, 'Apresentção de Array')
Return

STATIC FUNCTION BuscaArray(aArray)
    local cMsg     := ''
    local nCont    := 0
    local nValor   := VAL(FwInputBox('Informe o Valor a Buscar: ',''))
    local lAchei   := .F.
    local lVazio   := .T.
    local aPosicao := {}

    if LEN(aArray) == 0
        lVazio := .T.
    endif

    For nCont := 1 TO LEN(aArray)
        if nValor == aArray[nCont]
            lAchei := .T.
            AADD(aPosicao, nCont)
        endif 

        if aArray[nCont] != 0 .OR. aArray[nCont] != NIL
            lVazio := .F.
        endif
    next

    if lAchei
        if LEN(aPosicao) > 1
            cMsg += 'O valor foi encontrado nas Posicoes '
            for nCont := 1 TO LEN(aPosicao)
                if nCont < LEN(aPosicao)
                    cMsg += CVALTOCHAR(aPosicao[nCont]) + ', '
                else
                    cMsg += CVALTOCHAR(aPosicao[nCont])
                endif
            next
        else
            cMsg += 'O valor foi encontrado na Posicão ' + CVALTOCHAR(aPosicao[1])
        endif
    else
        If lVazio
            cMsg := 'O Array está vazio!'
        else
            cmsg := 'O valor Informado não foi encontrado!'
        endif
    endif

    FwAlertInfo(cMsg, 'Busca de Valor no Array')

Return

STATIC FUNCTION SomaArray(aArray)
    local nCont := 0
    local nSoma := 0

    for nCont := 1 TO LEN(aArray)
        nSoma += aArray[nCont]
    next

    FwAlertInfo('O valor total da Soma: ' + CVALTOCHAR(nSoma), 'Soma de Array')
Return 

STATIC FUNCTION MediaArray(aArray)
    local nCont  := 0
    local nSoma  := 0
    local nMedia := 0

    for nCont := 1 TO LEN(aArray)
        nSoma += aArray[nCont]
    next
    
    nMedia := nSoma / LEN(aArray)

    FwAlertInfo('O valor total da Média: ' + CVALTOCHAR(nMedia), 'Média de Array')
Return 

STATIC FUNCTION MaiorMenor(aArray)
    local nMaior := aArray[1]
    local nMenor := aArray[1]
    local nCont  := 0

    for nCont := 1 to LEN(aArray)
        if aArray[nCont] > nMaior
            nMaior := aArray[nCont]
        endif

        if aArray[nCont] < nMenor
            nMenor := aArray[nCont]
        endif
    next

    FwAlertInfo('O Maior Valor do Array: ' + CVALTOCHAR(nMaior) + CRLF +;
                'O Menor Valor do Array: ' + CVALTOCHAR(nMenor), 'Maior e Menor de um Array')

return

STATIC FUNCTION EmbaralhaArray(aArray)
    local nRepete    := 0
    local nCont      := 0
    local nAleatorio := 0
    local nAux       := 0
    For nRepete := 1 TO 100
        For nCont := 1 TO LEN(aArray)
            nAleatorio := RANDOMIZE(1, LEN(aArray))
            nAux                := aArray[nCont]
            aArray[nCont]       := aArray[nAleatorio]
            aArray[nAleatorio]  := nAux
        next
    next

    FwAlertSuccess( 'Array Embaralhado com Sucesso', 'Programa para Embaralhar Vetor')
    
Return

STATIC FUNCTION RepeteArray(aArray)
    local nI      := 0
    local nJ      := 0
    local nRepete := 0
    local aRepete := {}
    local aQtd    := {}
    local cMsg    := ''

    for nI := 1 TO LEN(aArray)
        nRepete := 1
        for nJ := 1 TO nI-1
            if aArray[nI] == aArray[nJ]
                nRepete++
            endif
        next
        
        if nRepete > 1
            AADD(aRepete, aArray[nI])
            AADD(aQtd, nRepete)
        endif 
    next

    For nI := 1 TO LEN(aRepete)
        for nJ := 1 TO nI-1
            if aRepete[nJ] == aRepete[nI]
                ADEL(aRepete,nJ)
                ADEL(aQtd,nJ)
            endif
        next
    next
    
    for nI := 1 TO LEN(aRepete)
        if aRepete[nI] > 0
            cMsg += CVALTOCHAR(aRepete[nI]) + ': ' + CVALTOCHAR(aQtd[nI]) + CRLF
        endif
    next

    FwAlertInfo('Os valores que se Repetiram foram: ' + CRLF + cMsg)

Return
