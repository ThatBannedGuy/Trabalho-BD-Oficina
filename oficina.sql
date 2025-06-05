CREATE DATABASE mecanica;

USE mecanica;

CREATE TABLE cliente(
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome_cliente VARCHAR(50),
    carro TEXT,
    telefone VARCHAR(9),
    endereco VARCHAR(50),
    email VARCHAR(50),
    sexo TEXT(10),
	id_cadastro TEXT
);

INSERT INTO cliente (nome_cliente, carro, telefone, endereco, email, sexo, id_cadastro) VALUES
('João Silva', 'Civic 2020', '999999999', 'Rua A, 123', 'joao@email.com', 'Masculino', 'CAD001'),
('Maria Souza', 'HB20 2018', '988888888', 'Av B, 456', 'maria@email.com', 'Feminino', 'CAD002'),
('Carlos Lima', 'Onix 2019', '977777777', 'Rua C, 789', 'carlos@email.com', 'Masculino', 'CAD003'),
('Ana Paula', 'EcoSport 2017', '966666666', 'Rua D, 321', 'ana@email.com', 'Feminino', 'CAD004'),
('Bruno Rocha', 'Fiesta 2015', '955555555', 'Av E, 654', 'bruno@email.com', 'Masculino', 'CAD005');


CREATE TABLE garagem(
	cnpj_dono INT PRIMARY KEY AUTO_INCREMENT,
    estacionamento TEXT,
    maquinas_garagem  LONGTEXT,
    ferramentas_garagem TEXT,
    horario_funcionamento TIME,
    limite_clientes INT,
	endereco VARCHAR(50)
);

INSERT INTO garagem (estacionamento, maquinas_garagem, ferramentas_garagem, horario_funcionamento, limite_clientes, endereco) VALUES
('Sim', 'Elevador hidráulico', 'Chave de impacto', '08:00:00', 10, 'Rua F, 101'),
('Sim', 'Alinhador 3D', 'Compressor de ar', '09:00:00', 8, 'Rua G, 102'),
('Não', 'Balanceadora', 'Chave estrela', '07:30:00', 12, 'Rua H, 103'),
('Sim', 'Scanner automotivo', 'Multímetro', '08:30:00', 15, 'Rua I, 104'),
('Sim', 'Prensa hidráulica', 'Kit de ferramentas', '09:15:00', 9, 'Rua J, 105');

CREATE TABLE problema(
	 id_problema INT PRIMARY KEY AUTO_INCREMENT,
	 id_cliente INT,
	 FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
     problema TEXT,
     tipo_veiculo VARCHAR(10)
);

INSERT INTO problema (id_cliente, problema, tipo_veiculo) VALUES
(1, 'Problema no motor', 'Carro'),
(2, 'Freio com barulho', 'Carro'),
(3, 'Pane elétrica', 'Carro'),
(4, 'Suspensão danificada', 'Carro'),
(5, 'Problema no ar-condicionado', 'Carro');

CREATE TABLE mecanico(
	id_mecanico INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    cnpj VARCHAR(14),
    telefone VARCHAR(9),
    email VARCHAR (50),
    disponibilidade TEXT,
    horario_trabalho TIME
);

INSERT INTO mecanico (nome, cnpj, telefone, email, disponibilidade, horario_trabalho) VALUES
('José Mecânico', '12345678000101', '944444444', 'jose@mecanico.com', 'Disponível', '08:00:00'),
('Carlos Técnico', '23456789000102', '933333333', 'carlos@mecanico.com', 'Em serviço', '09:00:00'),
('Marcos Silva', '34567890000103', '922222222', 'marcos@mecanico.com', 'Disponível', '07:30:00'),
('Luiz Santos', '45678901000104', '911111111', 'luiz@mecanico.com', 'Indisponível', '10:00:00'),
('Paulo Almeida', '56789012000105', '900000000', 'paulo@mecanico.com', 'Disponível', '08:30:00');


CREATE TABLE peca(
	id_peca INT PRIMARY KEY AUTO_INCREMENT,
    nome_peca VARCHAR(50),
    id_fornecedora VARCHAR(10),
    quantidade_disponivel INT,
    dimensoes_peca VARCHAR(20),
    preco_peca INT,
    prazo_de_entrega DATE
);	

INSERT INTO peca (nome_peca, id_fornecedora, quantidade_disponivel, dimensoes_peca, preco_peca, prazo_de_entrega) VALUES
('Filtro de óleo', 'F001', 20, '10x10x5', 50, '2025-06-10'),
('Pastilha de freio', 'F002', 15, '12x6x4', 80, '2025-06-12'),
('Correia dentada', 'F003', 10, '15x2x2', 120, '2025-06-15'),
('Amortecedor', 'F004', 8, '40x5x5', 300, '2025-06-20'),
('Velas de ignição', 'F005', 30, '5x2x2', 25, '2025-06-18');

CREATE TABLE compra_peca(
	id_empresa_terceira INT PRIMARY KEY AUTO_INCREMENT,
    nome_peca TEXT,
    prazo_de_entrega INT,
    quantidade_disponivel INT,
    FOREIGN KEY (prazo_de_entrega) REFERENCES peca(id_peca),
    FOREIGN KEY (quantidade_disponivel) REFERENCES peca(id_peca),
    selo_autenticidade TEXT,
    nome_transportadora VARCHAR(30),
    aviso_chegada TEXT
);

INSERT INTO compra_peca (nome_peca, prazo_de_entrega, quantidade_disponivel, selo_autenticidade, nome_transportadora, aviso_chegada) VALUES
('Filtro de óleo', 1, 1, 'Sim', 'Correios', 'Entrega amanhã'),
('Pastilha de freio', 2, 2, 'Sim', 'Sedex', 'Chegada prevista hoje'),
('Correia dentada', 3, 3, 'Não', 'Jadlog', 'Atrasado'),
('Amortecedor', 4, 4, 'Sim', 'Transportadora X', 'Saiu para entrega'),
('Velas de ignição', 5, 5, 'Não', 'Transportadora Y', 'Chegando');


CREATE TABLE pagamento(
	id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    forma_pagamento TEXT,
    parcela_maxima INT,
    prazo_pagamento DATE,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    dados_concerto LONGTEXT,
    sistema_anti_fraude BOOLEAN
);

INSERT INTO pagamento (forma_pagamento, parcela_maxima, prazo_pagamento, id_cliente, dados_concerto, sistema_anti_fraude) VALUES
('Cartão', 3, '2025-06-15', 1, 'Troca de óleo e filtros', TRUE),
('Dinheiro', 1, '2025-06-10', 2, 'Reparo de freios', FALSE),
('Pix', 2, '2025-06-12', 3, 'Revisão completa', TRUE),
('Boleto', 4, '2025-06-18', 4, 'Correia dentada trocada', FALSE),
('Cartão', 2, '2025-06-20', 5, 'Alinhamento e balanceamento', TRUE);


CREATE TABLE recibo(
	id_recibo INT PRIMARY KEY AUTO_INCREMENT,
    dados_servico VARCHAR(50),
    custo_servico FLOAT,
    peca_trocada TEXT,
    mao_de_obra FLOAT,
    forma_pagamento TEXT,
    valor_total VARCHAR(10)
);

INSERT INTO recibo (dados_servico, custo_servico, peca_trocada, mao_de_obra, forma_pagamento, valor_total) VALUES
('Troca de óleo', 100.00, 'Filtro de óleo', 50.00, 'Cartão', '150.00'),
('Reparo de freio', 200.00, 'Pastilha de freio', 80.00, 'Dinheiro', '280.00'),
('Revisão completa', 300.00, 'Várias peças', 150.00, 'Pix', '450.00'),
('Correia dentada', 250.00, 'Correia dentada', 100.00, 'Boleto', '350.00'),
('Alinhamento', 120.00, 'Nenhuma', 80.00, 'Cartão', '200.00');

