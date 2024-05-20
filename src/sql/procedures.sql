/*INSERT NOVO Aluno*/

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

    # Iniciar a transação
    START TRANSACTION;

    # Validação de dados
    IF NOT EXISTS (SELECT 1 FROM Aluno WHERE email = p_email) THEN
        # Verificar se o nome não contém caracteres inválidos
        IF p_nome REGEXP '^[a-zA-Z\s]+$' THEN
            # Gerar um salt aleatório
            WHILE (1) DO
                SET v_salt = CONCAT(
                    CHAR(FLOOR(RAND() * 26) + 65),
                    CHAR(FLOOR(RAND() * 26) + 97),
                    CHAR(FLOOR(RAND() * 10) + 48),
                    SUBSTRING(UUID(), 1, 124)
                );

                # Verificar se o salt já existe
                IF NOT EXISTS (SELECT 1 FROM Aluno WHERE salt = v_salt) THEN
                    BREAK;
                END IF;
            END WHILE;

            # Gerar o hash da senha
            SET v_hashSenha = PASSWORD_HASH(CONCAT(v_salt, p_senha), PASSWORD_DEFAULT);

            # Inserir o novo aluno
            INSERT INTO Aluno (nome, email, hashSenha, salt, sessao)
            VALUES (p_nome, p_email, v_hashSenha, v_salt, 1);

            # Verificar se a inserção foi bem-sucedida
            IF ROW_COUNT() = 1 THEN
                SET p_idAluno = LAST_INSERT_ID();
                SET p_mensagemErro = 'OK';

                # Confirmar a transação
                COMMIT;
            ELSE
                SET p_idAluno = 0;
                SET p_mensagemErro = 'Erro na inserção do aluno';

                # Reverter a transação
                ROLLBACK;
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