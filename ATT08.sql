-- Q01. Ao realizar um curso o aluno ganha créditos. Ao eliminar um curso da lista do aluno, os seus créditos totais deverão ser reduzidos.
-- Construa uma Trigger chamada dbo.lost_credits que atualiza o valor de créditos de um aluno após a retirada de um curso da sua lista.

CREATE TRIGGER dbo.lost_credits
ON dbo.takes       -- tabela vigiada
AFTER DELETE       -- dispara quando o aluno retirar o curso da lista takes
AS
BEGIN
    SET NOCOUNT ON; -- elimina mensagens de linhas afetadas

    UPDATE s -- atualiza tabela students (s)
    SET s.tot_cred = s.tot_cred - c.credits -- valor atual - créditos do curso
    FROM dbo.student s -- altera os dados
    INNER JOIN deleted d ON s.ID = d.ID -- cruza os dados do aluno deletado (d) com o ID de students (s) pra verificar se o ID do aluno é homogêneo
    INNER JOIN dbo.course c ON d.course_id = c.course_id; -- '' o código da tabela course (c) com o c que foi deletado = descobre quantos créditos c valia.
END;