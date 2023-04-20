#INCLUDE 'TOTVS.CH'


User Function L5EX16()
    local nCont    := 0
    local oDlg     := NIL
    local cNome    := ''
    local cMsg     := ''
    local nNota1   := 0
    local nNota2   := 0
    local nNota3   := 0
    local nMedia   := 0
    local aValores := {}
    local nLinJan  := 300
    local nColJan  := 300
    
    for nCont := 1 TO 4
        cNome    := SPACE(50)
        DEFINE MSDIALOG oDlg TITLE 'Notas Alunos' FROM 000,000 TO nLinJan,nColJan PIXEL
        @ 010,059 SAY 'NOME:' SIZE 50,10 OF oDlg PIXEL
        @ 020,033 MSGET cNome SIZE 80,10 OF oDlg PIXEL
        @ 040,057 SAY 'NOTA P1:' SIZE 50,10 OF oDlg PIXEL
        @ 050,033 MSGET nNota1 SIZE 80,10 OF oDlg PIXEL PICTURE '@R 99.99'
        @ 070,057 SAY 'NOTA P2:' SIZE 50,10 OF oDlg PIXEL
        @ 080,033 MSGET nNota2 SIZE 80,10 OF oDlg PIXEL PICTURE '@R 99.99'
        @ 100,057 SAY 'NOTA P3:' SIZE 50,10 OF oDlg PIXEL
        @ 110,033 MSGET nNota3 SIZE 80,10 OF oDlg PIXEL PICTURE '@R 99.99'

        @ 130,042 BUTTON 'Próximo' SIZE 030,011 OF oDlg ACTION (nOpcao := 1,oDlg:END()) PIXEL 
        @ 130,075 BUTTON 'Cancelar' SIZE 030,011 OF oDlg ACTION (nOpcao := 2,oDlg:END()) PIXEL 

        ACTIVATE MSDIALOG oDlg CENTERED
        
        nMedia := (nNota1 + nNota2 + nNota3) / 3
        
        AADD(aValores, {cNome, nNota1, nNota2, nNota3, nMedia})
    next

    for nCont := 1 TO 4
        cMsg += 'Nome Aluno: ' + aValores[nCont][1] + CRLF
        cMsg += 'Notas: ' + CVALTOCHAR(aValores[nCont][2]) + '..| ' + CVALTOCHAR(aValores[nCont][3]) + '..| ' + CVALTOCHAR(aValores[nCont][4]) + CRLF
        cMsg += 'Média do Aluno: ' + Alltrim(STR(aValores[nCont][5], 2)) + CRLF

        if nCont < 4
            cMsg += '_____________________________' + CRLF+ CRLF
        endif
    next

    FwAlertInfo('MÉDIA DOS ALUNOS' + CRLF + cMsg, 'Array Estruturado para Média de Alunos')
Return 
