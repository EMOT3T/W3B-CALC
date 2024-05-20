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

/*Estrutura em português*/

CREATE TABLE Aluno (
  idAluno INT AUTO_INCREMENT PRIMARY KEY,
  fullname VARCHAR(255) NOT NULL,
  email VARCHAR(127) NOT NULL UNIQUE,
  password_hash VARCHAR(60) NOT NULL,
  salt VARCHAR(128) NOT NULL UNIQUE,
  registerDay DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ContatoAluno (
  idContato INT AUTO_INCREMENT PRIMARY KEY,
  idaluno INT NOT NULL,
  phoneNumber VARCHAR(20),
  photo BLOB,
  FOREIGN KEY (idaluno) REFERENCES Aluno(idAluno)
);

CREATE TABLE Universidade (
  idUniversidade INT AUTO_INCREMENT PRIMARY KEY,
  nomeUniversidade VARCHAR(255) NOT NULL,
  endereco VARCHAR(255) NOT NULL,
  siteUniversidade VARCHAR(128),
  idNotaTipo INT,
  FOREIGN KEY (idNotaTipo) REFERENCES TipoNotaUniversidade(idTipoNotaUniversidade)
);

CREATE TABLE TipoNotaUniversidade (
  idTipoNotaUniversidade INT AUTO_INCREMENT PRIMARY KEY,
  idUniversidade INT NOT NULL,
  nomeTipoNota VARCHAR(128) NOT NULL,
  FOREIGN KEY (idUniversidade) REFERENCES Universidade(idUniversidade)
);

CREATE TABLE Curso (
  idCurso INT AUTO_INCREMENT PRIMARY KEY,
  nomeCurso TEXT NOT NULL,
  idUniversidade INT NOT NULL,
  quantSemestres INTEGER NOT NULL,
  informacoesCurso JSON NOT NULL,
  FOREIGN KEY (idUniversidade) REFERENCES Universidade(idUniversidade)
);

CREATE TABLE Semestre (
  idSemestre INTEGER AUTO_INCREMENT PRIMARY KEY,
  idCurso INTEGER NOT NULL,
  semestre INTEGER NOT NULL,
  FOREIGN KEY (idCurso) REFERENCES Curso(idCurso)
);

CREATE TABLE Materia (
  idMateria INTEGER AUTO_INCREMENT PRIMARY KEY,
  idSemestre INTEGER NOT NULL,
  nomeMateria TEXT NOT NULL,
  FOREIGN KEY (idSemestre) REFERENCES Semestre(idSemestre)
);

CREATE TABLE Matricula (
  idMatricula INT AUTO_INCREMENT PRIMARY KEY,
  idaluno INT NOT NULL,
  idCurso INT NOT NULL,
  semestreMatriculado INT NOT NULL,
  situacaoMatricula VARCHAR(255) NOT NULL,
  dataMatricula DATETIME NOT NULL,
  FOREIGN KEY (idaluno) REFERENCES Aluno(idAluno),
  FOREIGN KEY (idCurso) REFERENCES Curso(idCurso)
);

CREATE TABLE Nota (
  idNota INT AUTO_INCREMENT PRIMARY KEY,
  idmateria INT NOT NULL,
  idaluno INT NOT NULL,
  idTipoNotaUniversidade INT NOT NULL,
  nota REAL NOT NULL,
  FOREIGN KEY (idmateria) REFERENCES Materia(idMateria),
  FOREIGN KEY (idaluno) REFERENCES Aluno(idAluno),
  FOREIGN KEY (idTipoNotaUniversidade) REFERENCES TipoNotaUniversidade(idTipoNotaUniversidade)
);