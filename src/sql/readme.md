LÓGICA:

1. Aluno:

idAluno: Identificador único do aluno (chave primária auto-incrementada).
fullname: Nome completo do aluno.
email: Endereço de e-mail do aluno (único e não nulo).
password_hash: Hash da senha do aluno.
salt: Salt utilizado para gerar o hash da senha.
registerDay: Data e hora de registro do aluno (padrão atual).


2. ContatoAluno:

idContato: Identificador único do contato (chave primária auto-incrementada).
idaluno: Identificador do aluno associado ao contato (chave estrangeira).
phoneNumber: Número de telefone do aluno.
photo: Foto do aluno (blob).


3. Universidade:

idUniversidade: Identificador único da universidade (chave primária auto-incrementada).
nomeUniversidade: Nome da universidade.
endereco: Endereço da universidade.
siteUniversidade: Site da universidade.
idNotaTipo: Identificador do tipo de nota utilizado pela universidade (chave estrangeira).


4. TipoNotaUniversidade:

idTipoNotaUniversidade: Identificador único do tipo de nota (chave primária auto-incrementada).
idUniversidade: Identificador da universidade associada ao tipo de nota (chave estrangeira).
nomeTipoNota: Nome do tipo de nota (por exemplo, Prova 1, Prova 2, Média Final).


5. Curso:

idCurso: Identificador único do curso (chave primária auto-incrementada).
nomeCurso: Nome do curso.
idUniversidade: Identificador da universidade que oferece o curso (chave estrangeira).
quantSemestres: Quantidade de semestres do curso.
informacoesCurso: Informações adicionais sobre o curso em formato JSON.


6. Semestre:

idSemestre: Identificador único do semestre (chave primária auto-incrementada).
idCurso: Identificador do curso associado ao semestre (chave estrangeira).
semestre: Número do semestre.


7. Materia:

idMateria: Identificador único da matéria (chave primária auto-incrementada).
idSemestre: Identificador do semestre em que a matéria é oferecida (chave estrangeira).
nomeMateria: Nome da matéria.


8. Matricula:

idMatricula: Identificador único da matrícula (chave primária auto-incrementada).
idaluno: Identificador do aluno matriculado (chave estrangeira).
idCurso: Identificador do curso em que o aluno está matriculado (chave estrangeira).
semestreMatriculado: Semestre em que o aluno está matriculado.
situacaoMatricula: Situação da matrícula (por exemplo, Ativo, Trancado, Cancelado).
dataMatricula: Data da matrícula.


9. Nota:

idNota: Identificador único da nota (chave primária auto-incrementada).
idmateria: Identificador da matéria à qual a nota se refere (chave estrangeira).
idaluno: Identificador do aluno que recebeu a nota (chave estrangeira).
idTipoNotaUniversidade: Identificador do tipo de nota (chave estrangeira).
nota: Valor numérico da nota.

/*------------------------------------------------------------*/

-- Estrutura da Tabela Nota:

-- idNota: Identificador único da nota (chave primária auto-incrementada).
-- idmateria: Identificador da matéria à qual a nota se refere (chave estrangeira que referencia a tabela Materia).
-- idaluno: Identificador do aluno que recebeu a nota (chave estrangeira que referencia a tabela Aluno).
-- notaProva1: Valor numérico da nota da Prova 1.
-- notaSomaAtividades: Valor numérico da nota da Soma das Atividades.
-- notaAvaliacaoIntegrada: Valor numérico da nota da Avaliação Integrada (Prova Global).
-- notaRecuperacao: Valor numérico da nota da Recuperação (DP)

/*------------------------------------------------------------*/

-- Exemplo:

-- Prova 1: 8.5
-- Soma das Atividades: 7.2
-- Avaliação Integrada: 9.0
-- Recuperação (DP): 6.0 (opcional)
-- Cálculo da Média Final:

-- Média N1 e N2:

-- N1: Prova 1
-- N2: Média da Soma das Atividades e Avaliação Integrada
-- Cálculo da Média N2:

-- (notaSomaAtividades + notaAvaliacaoIntegrada) / 2

-- Cálculo da Média Final:

-- (notaProva1 + notaN2) / 2

/*------------------------------------------------------------*/

-- Problemas a serem resolvidos
-- Se a disciplina não possui recuperação (DP), o campo notaRecuperacao pode ser omitido ou armazenado como nulo.
-- As regras de cálculo da média final podem ser ajustadas de acordo com as necessidades da sua universidade.

/*------------------------------------------------------------*/

-- Consultar a média final de um aluno em uma matéria
-- SELECT
--   (notaProva1 + ((notaSomaAtividades + notaAvaliacaoIntegrada) / 2)) / 2 AS mediaFinal
-- FROM Nota
-- WHERE idaluno = 12345 -- ID do aluno
--   AND idmateria = 56789 -- ID da matéria
-- Use o código com cuidado.
-- content_copy

/*------------------------------------------------------------*/