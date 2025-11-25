CREATE DATABASE IF NOT EXISTS PetLar;
USE PetLar;

CREATE TABLE IF NOT EXISTS Endereco (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    rua VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(50),
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado CHAR(2) NOT NULL
);

CREATE TABLE IF NOT EXISTS Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    id_endereco INT NOT NULL,
    FOREIGN KEY (id_endereco) REFERENCES Endereco(id_endereco)
);

CREATE TABLE IF NOT EXISTS Formulario (
    id_formulario INT AUTO_INCREMENT PRIMARY KEY,
    respostas TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Usuario_Formulario (
    id_usuario INT NOT NULL,
    id_formulario INT NOT NULL,
    PRIMARY KEY (id_usuario, id_formulario),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_formulario) REFERENCES Formulario(id_formulario)
);

CREATE TABLE IF NOT EXISTS ONG (
    id_ong INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    id_endereco INT NOT NULL,
    FOREIGN KEY (id_endereco) REFERENCES Endereco(id_endereco)
);

CREATE TABLE IF NOT EXISTS Pet (
    id_pet INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    especie VARCHAR(30) NOT NULL,
    raca VARCHAR(50),
    data_nascimento DATE NOT NULL,
    sexo ENUM('Macho', 'Fêmea') NOT NULL,
    origem ENUM('Resgatado', 'Nascido na ONG', 'Doado') NOT NULL,
    id_ong INT NOT NULL,
    FOREIGN KEY (id_ong) REFERENCES ONG(id_ong)
);

CREATE TABLE IF NOT EXISTS Carteira_Vacinacao (
    id_carteira INT AUTO_INCREMENT PRIMARY KEY,
    id_pet INT UNIQUE NOT NULL,
    FOREIGN KEY (id_pet) REFERENCES Pet(id_pet)
);

CREATE TABLE IF NOT EXISTS Vacina (
    id_vacina INT AUTO_INCREMENT PRIMARY KEY,
    id_carteira INT NOT NULL,
    nome_vacina VARCHAR(100) NOT NULL,
    data_aplicacao DATE NOT NULL,
    FOREIGN KEY (id_carteira) REFERENCES Carteira_Vacinacao(id_carteira)
);

CREATE TABLE IF NOT EXISTS Solicitacao_Adocao (
    id_solicitacao INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_pet INT NOT NULL,
    id_ong INT NOT NULL,
    data_solicitacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pendente', 'Aprovado', 'Recusado') DEFAULT 'Pendente',
    observacao TEXT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_pet) REFERENCES Pet(id_pet),
    FOREIGN KEY (id_ong) REFERENCES ONG(id_ong)
);

CREATE TABLE IF NOT EXISTS Adocao (
    id_adocao INT AUTO_INCREMENT PRIMARY KEY,
    id_solicitacao INT NOT NULL UNIQUE,
    data_adocao DATE NOT NULL,
    FOREIGN KEY (id_solicitacao) REFERENCES Solicitacao_Adocao(id_solicitacao)
);

-- OS INSERTS SÃO DEPOIS DOS PROCEDURES E DAS TABELAS!

INSERT INTO Endereco (rua, numero, complemento, bairro, cidade, estado) VALUES
('Rua A', '100', NULL, 'Centro', 'São Paulo', 'SP'),
('Rua B', '200', 'Apto 12', 'Jardim', 'Rio de Janeiro', 'RJ'),
('Rua C', '300', NULL, 'Savassi', 'Belo Horizonte', 'MG'),
('Rua D', '400', NULL, 'Batel', 'Curitiba', 'PR'),
('Rua E', '500', 'Casa', 'Moinhos', 'Porto Alegre', 'RS'),
('Rua F', '600', NULL, 'Vila Nova', 'Florianópolis', 'SC'),
('Rua G', '700', 'Apto 21', 'Centro', 'Fortaleza', 'CE'),
('Rua H', '800', NULL, 'Bairro Alto', 'Porto Seguro', 'BA'),
('Rua I', '900', NULL, 'Jardim América', 'Campinas', 'SP'),
('Rua J', '1000', 'Casa', 'Centro', 'Belo Horizonte', 'MG');

INSERT INTO Usuario (nome_completo, cpf, data_nascimento, email, id_endereco) VALUES
('Ana Silva','12345678901','1990-05-10','ana@email.com',1),
('João Pereira','23456789012','1985-09-23','joao@email.com',2),
('Maria Souza','34567890123','1992-03-14','maria@email.com',3),
('Carlos Lima','45678901234','1988-12-30','carlos@email.com',4),
('Fernanda Costa','56789012345','1995-07-07','fernanda@email.com',5),
('Bruno Santos','56789012346','1987-04-12','bruno@email.com',6),
('Patrícia Almeida','67890123457','1993-11-05','patricia@email.com',7),
('Ricardo Fernandes','78901234568','1982-08-19','ricardo@email.com',8),
('Juliana Ribeiro','89012345679','1994-02-28','juliana@email.com',9),
('Lucas Oliveira','90123456780','1991-06-15','lucas@email.com',10);

INSERT INTO Formulario (respostas) VALUES
('Respostas 1'),('Respostas 2'),('Respostas 3'),('Respostas 4'),('Respostas 5'),
('Respostas 6'),('Respostas 7'),('Respostas 8'),('Respostas 9'),('Respostas 10');

INSERT INTO Usuario_Formulario (id_usuario, id_formulario) VALUES
(1,1),(1,2),(2,3),(3,4),(4,5),
(5,6),(6,7),(7,8),(8,9),(9,10);

INSERT INTO ONG (nome, id_endereco) VALUES
('PetLar SP',1),
('Amigos dos Animais RJ',2),
('Cão Feliz BH',3),
('Vida Animal Curitiba',4),
('Lar dos Pets RS',5),
('SOS Animais SC',6),
('Adoção Feliz CE',7),
('Bicho Amigo BA',8),
('Pet Amigo Campinas',9),
('Lar Animal BH',10);

INSERT INTO Pet (nome, especie, raca, data_nascimento, sexo, origem, id_ong) VALUES
('Rex','Cachorro','Vira-lata','2021-03-10','Macho','Resgatado',1),
('Bob','Cachorro','Labrador','2020-11-20','Macho','Doado',2),
('Thor','Cachorro','Beagle','2019-05-22','Macho','Resgatado',3),
('Max','Cachorro','Bulldog','2021-06-10','Macho','Doado',4),
('Spike','Cachorro','Pastor Alemão','2022-01-15','Macho','Resgatado',5),
('Toby','Cachorro','Poodle','2020-09-09','Macho','Doado',6),
('Loki','Cachorro','Shih Tzu','2021-12-01','Macho','Resgatado',7),
('Simba','Cachorro','Golden Retriever','2019-04-18','Macho','Doado',8),
('Zeus','Cachorro','Boxer','2022-03-22','Macho','Resgatado',9),
('Oliver','Cachorro','Husky Siberiano','2021-08-30','Macho','Doado',10);

INSERT INTO Carteira_Vacinacao (id_pet) VALUES
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10);

INSERT INTO Vacina (id_carteira, nome_vacina, data_aplicacao) VALUES
(1,'Antirrábica','2023-01-15'),
(1,'V8','2023-02-20'),
(2,'V10','2023-03-12'),
(2,'Antirrábica','2023-04-18'),
(3,'V8','2023-05-05'),
(3,'V10','2023-06-10'),
(4,'Antirrábica','2023-07-12'),
(5,'V8','2023-08-18'),
(5,'V10','2023-09-20'),
(6,'Antirrábica','2023-03-15'),
(6,'V10','2023-04-10'),
(7,'V8','2023-05-25'),
(7,'Antirrábica','2023-06-30'),
(8,'V10','2023-07-05'),
(8,'V8','2023-08-01'),
(9,'Antirrábica','2023-09-12'),
(10,'V8','2023-10-10');

INSERT INTO Solicitacao_Adocao (id_usuario, id_pet, id_ong, status, observacao) VALUES
(1,1,1,'Pendente','Interesse no Rex'),
(2,2,2,'Aprovado','Usuário aprovado'),
(3,3,3,'Recusado','Residência não aprovada'),
(4,4,4,'Pendente','Aguardando resposta'),
(5,5,5,'Aprovado','Histórico positivo'),
(6,6,6,'Pendente','Interesse no Toby'),
(7,7,7,'Aprovado','Usuário apto'),
(8,8,8,'Recusado','Condições não atendidas'),
(9,9,9,'Pendente','Interesse no Zeus'),
(10,10,10,'Aprovado','Histórico confirmado');


DELIMITER $$

CREATE PROCEDURE IF NOT EXISTS CadastrarONG(
    IN nome_ong VARCHAR(100),
    IN id_endereco INT
)
BEGIN
    INSERT INTO ONG (nome, id_endereco) VALUES (nome_ong, id_endereco);
END $$

CREATE PROCEDURE IF NOT EXISTS CadastrarPet(
    IN nome VARCHAR(50),
    IN especie VARCHAR(30),
    IN raca VARCHAR(50),
    IN data_nascimento DATE,
    IN sexo VARCHAR(10),
    IN origem VARCHAR(30),
    IN id_ong INT
)
BEGIN
    INSERT INTO Pet (nome, especie, raca, data_nascimento, sexo, origem, id_ong)
    VALUES (nome, especie, raca, data_nascimento, sexo, origem, id_ong);
END $$

CREATE PROCEDURE IF NOT EXISTS CadastrarUsuario(
    IN nome VARCHAR(100),
    IN cpf CHAR(11),
    IN data_nasc DATE,
    IN email VARCHAR(100),
    IN id_endereco INT
)
BEGIN
    INSERT INTO Usuario (nome_completo, cpf, data_nascimento, email, id_endereco)
    VALUES (nome, cpf, data_nasc, email, id_endereco);
END $$

CREATE PROCEDURE IF NOT EXISTS CadastrarVacina(
    IN id_carteira INT,
    IN nome_vacina VARCHAR(100),
    IN data_aplicacao DATE
)
BEGIN
    INSERT INTO Vacina (id_carteira, nome_vacina, data_aplicacao)
    VALUES (id_carteira, nome_vacina, data_aplicacao);
END $$

CREATE PROCEDURE IF NOT EXISTS ListarPetsPorONG(IN id INT)
BEGIN
    SELECT * FROM Pet WHERE id_ong = id;
END $$

CREATE PROCEDURE IF NOT EXISTS ConsultarVacinasPet(IN id_pet INT)
BEGIN
    SELECT v.nome_vacina, v.data_aplicacao
    FROM Vacina v
    JOIN Carteira_Vacinacao c ON v.id_carteira = c.id_carteira
    WHERE c.id_pet = id_pet;
END $$

CREATE PROCEDURE IF NOT EXISTS RegistrarSolicitacao(
    IN id_usuario INT,
    IN id_pet INT,
    IN id_ong INT,
    IN observacao TEXT
)
BEGIN
    INSERT INTO Solicitacao_Adocao (id_usuario, id_pet, id_ong, observacao)
    VALUES (id_usuario, id_pet, id_ong, observacao);
END $$

CREATE PROCEDURE IF NOT EXISTS AtualizarStatusSolicitacao(
    IN pid_solicitacao INT,
    IN novo_status VARCHAR(10)
)
BEGIN
    UPDATE Solicitacao_Adocao
    SET status = novo_status
    WHERE id_solicitacao = pid_solicitacao;
END $$

CREATE PROCEDURE IF NOT EXISTS ContarPendentes(OUT total INT)
BEGIN
    SELECT COUNT(*) INTO total FROM Solicitacao_Adocao WHERE status = 'Pendente';
END $$

CREATE PROCEDURE IF NOT EXISTS ContarAdocoesConcluidas(OUT total INT)
BEGIN
    SELECT COUNT(*) INTO total FROM Adocao;
END $$

CREATE PROCEDURE IF NOT EXISTS BuscarUsuarioPorCPF(IN cpfBusca CHAR(11))
BEGIN
    SELECT * FROM Usuario WHERE cpf = cpfBusca;
END $$

CREATE PROCEDURE IF NOT EXISTS ListarPetsDisponiveis()
BEGIN
    SELECT p.*
    FROM Pet p
    WHERE p.id_pet NOT IN (
        SELECT id_pet
        FROM Solicitacao_Adocao
        WHERE status = 'Aprovado'
    );
END $$

CREATE PROCEDURE IF NOT EXISTS HistoricoAdocoesUsuario(IN uid INT)
BEGIN
    SELECT a.id_adocao, p.nome AS nome_pet, a.data_adocao, o.nome AS nome_ong
    FROM Adocao a
    JOIN Solicitacao_Adocao s ON a.id_solicitacao = s.id_solicitacao
    JOIN Pet p ON s.id_pet = p.id_pet
    JOIN ONG o ON s.id_ong = o.id_ong
    WHERE s.id_usuario = uid;
END $$

CREATE PROCEDURE IF NOT EXISTS ExcluirSolicitacao(IN id INT)
BEGIN
    DELETE FROM Solicitacao_Adocao WHERE id_solicitacao = id;
END $$

CREATE PROCEDURE IF NOT EXISTS AtualizarPet(
    IN id INT,
    IN novo_nome VARCHAR(50),
    IN nova_raca VARCHAR(50),
    IN nova_origem VARCHAR(30)
)
BEGIN
    UPDATE Pet
    SET nome = novo_nome, raca = nova_raca, origem = nova_origem
    WHERE id_pet = id;
END $$

DELIMITER ;

