-- Procedure para registrar um novo aluno:

DELIMITER $$
CREATE PROCEDURE sp_RegistrarAluno(
    IN p_nome VARCHAR(255),
    IN p_email VARCHAR(127),
    IN p_senha VARCHAR(255),
    OUT p_idAluno INT,
    OUT p_mensagemErro VARCHAR(100)
)
BEGIN
    DECLARE v_salt VARCHAR(128);
    DECLARE v_hashSenha VARCHAR(60);
    DECLARE v_insertedRows INT DEFAULT 0;

    -- Validação de dados
    IF NOT EXISTS (SELECT 1 FROM Aluno WHERE email = p_email) THEN
        -- Verificar se o nome não contém caracteres inválidos
        IF p_nome REGEXP '^[a-zA-Z\s]+$' THEN
            -- Gerar um salt aleatório
            WHILE (1) DO
                SET v_salt = CONCAT(
                    CHAR(FLOOR(RAND() * 26) + 65),
                    CHAR(FLOOR(RAND() * 26) + 97),
                    CHAR(FLOOR(RAND() * 10) + 48),
                    SUBSTRING(UUID(), 1, 124)
                );

                -- Verificar se o salt já existe
                IF NOT EXISTS (SELECT 1 FROM Aluno WHERE salt = v_salt) THEN
                    BREAK;
                END IF;
            END WHILE;

            -- Gerar o hash da senha
            SET v_hashSenha = PASSWORD(CONCAT(v_salt, p_senha));

            -- Inserir o novo aluno
            INSERT INTO Aluno (nome, email, hashSenha, salt, sessao)
            VALUES (p_nome, p_email, v_hashSenha, v_salt, 1);

            -- Verificar se a inserção foi bem-sucedida
            IF ROW_COUNT() = 1 THEN
                SET p_idAluno = LAST_INSERT_ID();
                SET p_mensagemErro = 'OK';
            ELSE
                SET p_idAluno = 0;
                SET p_mensagemErro = 'Erro na inserção do aluno';
            END IF;
        ELSE
            SET p_idAluno = 0;
            SET p_mensagemErro = 'Erro: O nome contém caracteres inválidos';
        END IF;
    ELSE
        SET p_idAluno = 0;
        SET p_mensagemErro = 'Erro: O email já está cadastrado';
    END IF;
END$$
DELIMITER ;


-- Procedure para atualizar os dados de um aluno:

DELIMITER $$
CREATE PROCEDURE sp_AtualizarAluno(
    IN p_idAluno INT,
    IN p_nome VARCHAR(255),
    IN p_email VARCHAR(127),
    OUT p_mensagemErro VARCHAR(100)
)
BEGIN
    -- Validação de dados
    IF EXISTS (SELECT 1 FROM Aluno WHERE idAluno = p_idAluno) THEN
        -- Verificar se o nome não contém caracteres inválidos
        IF p_nome REGEXP '^[a-zA-Z\s]+$' THEN
            -- Atualizar os dados do aluno
            UPDATE Aluno
            SET nome = p_nome, email = p_email
            WHERE idAluno = p_idAluno;

            -- Verificar se a atualização foi bem-sucedida
            IF ROW_COUNT() = 1 THEN
                SET p_mensagemErro = 'OK';
            ELSE
                SET p_mensagemErro = 'Erro na atualização do aluno';
            END IF;
        ELSE
            SET p_mensagemErro = 'Erro: O nome contém caracteres inválidos';
        END IF;
    ELSE
        SET p_mensagemErro = 'Erro: Aluno não encontrado';
    END IF;
END$$
DELIMITER ;


-- Procedure para registrar uma nova nota:

DELIMITER $$
CREATE PROCEDURE sp_RegistrarNota(
    IN p_idMateria INT,
    IN p_idAluno INT,
    IN p_idTipoNotaUniversidade INT,
    IN p_nota REAL,
    OUT p_mensagemErro VARCHAR(100)
)
BEGIN
    -- Validação de dados
    IF EXISTS (SELECT 1 FROM Materia WHERE idMateria = p_idMateria) AND
       EXISTS (SELECT 1 FROM Aluno WHERE idAluno = p_idAluno) AND
       EXISTS (SELECT 1 FROM TipoNotaUniversidade WHERE idTipoNotaUniversidade = p_idTipoNotaUniversidade) THEN

        -- Inserir a nova nota
        INSERT INTO Nota (idmateria, idaluno, idTipoNotaUniversidade, nota)
        VALUES (p_idMateria, p_idAluno, p_idTipoNotaUniversidade, p_nota);

        -- Verificar se a inserção foi bem-sucedida
        IF ROW_COUNT() = 1 THEN
            SET p_mensagemErro = 'OK';
        ELSE
            SET p_mensagemErro = 'Erro na inserção da nota';
        END IF;
    ELSE
        SET p_mensagemErro = 'Erro: Dados inválidos';
    END IF;
END$$
DELIMITER ;
