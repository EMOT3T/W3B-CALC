-- Inserir dados na tabela Aluno
INSERT INTO Aluno (nome, email, hashSenha, salt, sessao)
VALUES 
('Alice Silva', 'alice@example.com', 'hash1', 'salt1', 1),
('Bruno Costa', 'bruno@example.com', 'hash2', 'salt2', 1),
('Carla Lima', 'carla@example.com', 'hash3', 'salt3', 1),
('Daniel Alves', 'daniel@example.com', 'hash4', 'salt4', 1),
('Eduarda Souza', 'eduarda@example.com', 'hash5', 'salt5', 1);

-- Inserir dados na tabela ContatoAluno
INSERT INTO ContatoAluno (idaluno, celular, foto)
VALUES
(1, '123456789', NULL),
(2, '987654321', NULL),
(3, '456789123', NULL),
(4, '789123456', NULL),
(5, '321654987', NULL);

-- Inserir dados na tabela Universidade
INSERT INTO Universidade (nomeUniversidade, endereco, siteUniversidade, idNotaTipo)
VALUES
('Universidade A', 'Endereço A', 'www.unia.com', 1),
('Universidade B', 'Endereço B', 'www.unib.com', 2),
('Universidade C', 'Endereço C', 'www.unic.com', 3),
('Universidade D', 'Endereço D', 'www.unid.com', 4),
('Universidade E', 'Endereço E', 'www.unie.com', 5);

-- Inserir dados na tabela TipoNotaUniversidade
INSERT INTO TipoNotaUniversidade (idUniversidade, nomeTipoNota)
VALUES
(1, 'Tipo A'),
(2, 'Tipo B'),
(3, 'Tipo C'),
(4, 'Tipo D'),
(5, 'Tipo E');

-- Inserir dados na tabela Curso
INSERT INTO Curso (nomeCurso, idUniversidade, quantSemestres, informacoesCurso)
VALUES
('Curso A', 1, 8, '{"info": "Curso A"}'),
('Curso B', 2, 8, '{"info": "Curso B"}'),
('Curso C', 3, 8, '{"info": "Curso C"}'),
('Curso D', 4, 8, '{"info": "Curso D"}'),
('Curso E', 5, 8, '{"info": "Curso E"}');

-- Inserir dados na tabela Semestre
INSERT INTO Semestre (idCurso, semestre)
VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1);

-- Inserir dados na tabela Materia
INSERT INTO Materia (idSemestre, nomeMateria)
VALUES
(1, 'Materia A1'),
(2, 'Materia B1'),
(3, 'Materia C1'),
(4, 'Materia D1'),
(5, 'Materia E1');

-- Inserir dados na tabela Matricula
INSERT INTO Matricula (idaluno, idCurso, semestreMatriculado, situacaoMatricula, dataMatricula)
VALUES
(1, 1, 1, 'Ativo', NOW()),
(2, 2, 1, 'Ativo', NOW()),
(3, 3, 1, 'Ativo', NOW()),
(4, 4, 1, 'Ativo', NOW()),
(5, 5, 1, 'Ativo', NOW());

-- Inserir dados na tabela Nota
INSERT INTO Nota (idmateria, idaluno, idTipoNotaUniversidade, nota)
VALUES
(1, 1, 1, 9.5),
(2, 2, 2, 8.0),
(3, 3, 3, 7.5),
(4, 4, 4, 6.0),
(5, 5, 5, 10.0);




/*---------------------------------*/

Lista dos alunos com suas respectivas universidades e cursos:
SELECT A.nome AS NomeAluno, U.nomeUniversidade, C.nomeCurso
FROM Aluno A
JOIN Matricula M ON A.idAluno = M.idaluno
JOIN Curso C ON M.idCurso = C.idCurso
JOIN Universidade U ON C.idUniversidade = U.idUniversidade;

Notas dos alunos por matéria, curso e universidade:
SELECT A.nome AS NomeAluno, M.nomeMateria, C.nomeCurso, U.nomeUniversidade, N.nota
FROM Nota N
JOIN Aluno A ON N.idaluno = A.idAluno
JOIN Materia M ON N.idmateria = M.idMateria
JOIN Semestre S ON M.idSemestre = S.idSemestre
JOIN Curso C ON S.idCurso = C.idCurso
JOIN Universidade U ON C.idUniversidade = U.idUniversidade;

Alunos matriculados com suas respectivas situações e data de matrícula:
SELECT A.nome AS NomeAluno, C.nomeCurso, M.situacaoMatricula, M.dataMatricula
FROM Aluno A
JOIN Matricula M ON A.idAluno = M.idaluno
JOIN Curso C ON M.idCurso = C.idCurso;
