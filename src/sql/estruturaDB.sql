CREATE TABLE Aluno (
  idAluno INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  email VARCHAR(127) NOT NULL UNIQUE,
  hashSenha VARCHAR(60) NOT NULL,
  salt VARCHAR(128) NOT NULL UNIQUE,
  diaRegistro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  sessao BIT NOT NULL
);

CREATE TABLE ContatoAluno (
  idContato INT AUTO_INCREMENT PRIMARY KEY,
  idaluno INT NOT NULL,
  celular VARCHAR(20),
  foto BLOB,
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
  quantSemestres INT NOT NULL,
  informacoesCurso JSON NOT NULL,
  FOREIGN KEY (idUniversidade) REFERENCES Universidade(idUniversidade)
);

CREATE TABLE Semestre (
  idSemestre INT AUTO_INCREMENT PRIMARY KEY,
  idCurso INT NOT NULL,
  semestre INT NOT NULL,
  FOREIGN KEY (idCurso) REFERENCES Curso(idCurso)
);

CREATE TABLE Materia (
  idMateria INT AUTO_INCREMENT PRIMARY KEY,
  idSemestre INT NOT NULL,
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