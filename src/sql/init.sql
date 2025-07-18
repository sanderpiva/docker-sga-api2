CREATE DATABASE IF NOT EXISTS `gerenciamento_academico_completo` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `gerenciamento_academico_completo`;

CREATE TABLE IF NOT EXISTS `turma` (
  `id_turma` int(11) NOT NULL AUTO_INCREMENT,
  `codigoTurma` varchar(45) NOT NULL,
  `nomeTurma` varchar(45) NOT NULL,
  PRIMARY KEY (`id_turma`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `professor` (
  `id_professor` int(11) NOT NULL AUTO_INCREMENT,
  `registroProfessor` varchar(100) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `endereco` varchar(100) NOT NULL,
  `telefone` varchar(45) NOT NULL,
  `senha` varchar(255) NOT NULL,
  PRIMARY KEY (`id_professor`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `disciplina` (
  `id_disciplina` int(11) NOT NULL AUTO_INCREMENT,
  `codigoDisciplina` varchar(100) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `carga_horaria` varchar(700) NOT NULL,
  `professor` varchar(100) NOT NULL,
  `descricao` varchar(700) NOT NULL,
  `semestre_periodo` varchar(150) NOT NULL,
  `Professor_id_professor` int(11) NOT NULL,
  `Turma_id_turma` int(11) NOT NULL,
  PRIMARY KEY (`id_disciplina`,`Professor_id_professor`),
  KEY `fk_Disciplina_Professor1_idx` (`Professor_id_professor`),
  KEY `fk_Turma1_idx` (`Turma_id_turma`),
  CONSTRAINT `fk_Disciplina_Professor1` FOREIGN KEY (`Professor_id_professor`) REFERENCES `professor` (`id_professor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turma1` FOREIGN KEY (`Turma_id_turma`) REFERENCES `turma` (`id_turma`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `aluno` (
  `id_aluno` int(11) NOT NULL AUTO_INCREMENT,
  `matricula` varchar(100) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cpf` varchar(700) NOT NULL,
  `email` varchar(100) NOT NULL,
  `data_nascimento` date NOT NULL,
  `endereco` varchar(150) NOT NULL,
  `cidade` varchar(45) NOT NULL,
  `telefone` varchar(45) NOT NULL,
  `Turma_id_turma` int(11) NOT NULL,
  `senha` varchar(255) NOT NULL,
  PRIMARY KEY (`id_aluno`,`Turma_id_turma`),
  KEY `fk_Aluno_Turma1_idx` (`Turma_id_turma`),
  CONSTRAINT `fk_Aluno_Turma1` FOREIGN KEY (`Turma_id_turma`) REFERENCES `turma` (`id_turma`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `conteudo` (
  `id_conteudo` int(11) NOT NULL AUTO_INCREMENT,
  `codigoConteudo` varchar(100) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descricao` varchar(700) NOT NULL,
  `data_postagem` date NOT NULL,
  `professor` varchar(100) NOT NULL,
  `disciplina` varchar(45) NOT NULL,
  `tipo_conteudo` varchar(45) NOT NULL,
  `Disciplina_id_disciplina` int(11) NOT NULL,
  PRIMARY KEY (`id_conteudo`,`Disciplina_id_disciplina`),
  KEY `fk_Conteudo_Disciplina1_idx` (`Disciplina_id_disciplina`),
  CONSTRAINT `fk_Conteudo_Disciplina1` FOREIGN KEY (`Disciplina_id_disciplina`) REFERENCES `disciplina` (`id_disciplina`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `prova` (
  `id_prova` int(11) NOT NULL AUTO_INCREMENT,
  `codigoProva` varchar(100) NOT NULL,
  `tipo_prova` varchar(100) NOT NULL,
  `disciplina` varchar(700) NOT NULL,
  `conteudo` varchar(100) NOT NULL,
  `data_prova` date NOT NULL,
  `professor` varchar(100) NOT NULL,
  `Disciplina_id_disciplina` int(11) NOT NULL,
  `Disciplina_Professor_id_professor` int(11) NOT NULL,
  PRIMARY KEY (`id_prova`,`Disciplina_id_disciplina`,`Disciplina_Professor_id_professor`),
  KEY `fk_Prova_Disciplina1_idx` (`Disciplina_id_disciplina`,`Disciplina_Professor_id_professor`),
  CONSTRAINT `fk_Prova_Disciplina1` FOREIGN KEY (`Disciplina_id_disciplina`, `Disciplina_Professor_id_professor`) REFERENCES `disciplina` (`id_disciplina`, `Professor_id_professor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `questoes` (
  `id_questao` int(11) NOT NULL AUTO_INCREMENT,
  `codigoQuestao` varchar(100) NOT NULL,
  `descricao` varchar(700) NOT NULL,
  `tipo_prova` varchar(100) NOT NULL,
  `Prova_id_prova` int(11) NOT NULL,
  `Prova_Disciplina_id_disciplina` int(11) NOT NULL,
  `Prova_Disciplina_Professor_id_professor` int(11) NOT NULL,
  PRIMARY KEY (`id_questao`,`Prova_id_prova`,`Prova_Disciplina_id_disciplina`,`Prova_Disciplina_Professor_id_professor`),
  KEY `fk_Questoes_Prova1_idx` (`Prova_id_prova`,`Prova_Disciplina_id_disciplina`,`Prova_Disciplina_Professor_id_professor`),
  CONSTRAINT `fk_Questoes_Prova1` FOREIGN KEY (`Prova_id_prova`, `Prova_Disciplina_id_disciplina`, `Prova_Disciplina_Professor_id_professor`) REFERENCES `prova` (`id_prova`, `Disciplina_id_disciplina`, `Disciplina_Professor_id_professor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `respostas` (
  `id_respostas` int(11) NOT NULL AUTO_INCREMENT,
  `codigoRespostas` varchar(100) NOT NULL,
  `respostaDada` varchar(45) NOT NULL,
  `acertou` varchar(45) NOT NULL,
  `nota` float NOT NULL,
  `Questoes_id_questao` int(11) NOT NULL,
  `Questoes_Prova_id_prova` int(11) NOT NULL,
  `Questoes_Prova_Disciplina_id_disciplina` int(11) NOT NULL,
  `Questoes_Prova_Disciplina_Professor_id_professor` int(11) NOT NULL,
  `Aluno_id_aluno` int(11) NOT NULL,
  PRIMARY KEY (`id_respostas`,`Questoes_id_questao`,`Questoes_Prova_id_prova`,`Questoes_Prova_Disciplina_id_disciplina`,`Questoes_Prova_Disciplina_Professor_id_professor`),
  KEY `fk_Respostas_Questoes1_idx` (`Questoes_id_questao`,`Questoes_Prova_id_prova`,`Questoes_Prova_Disciplina_id_disciplina`,`Questoes_Prova_Disciplina_Professor_id_professor`),
  KEY `Aluno_id_aluno` (`Aluno_id_aluno`),
  CONSTRAINT `fk_Respostas_Questoes1` FOREIGN KEY (`Questoes_id_questao`, `Questoes_Prova_id_prova`, `Questoes_Prova_Disciplina_id_disciplina`, `Questoes_Prova_Disciplina_Professor_id_professor`) REFERENCES `questoes` (`id_questao`, `Prova_id_prova`, `Prova_Disciplina_id_disciplina`, `Prova_Disciplina_Professor_id_professor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `respostas_ibfk_1` FOREIGN KEY (`Aluno_id_aluno`) REFERENCES `aluno` (`id_aluno`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `matricula` (
  `Aluno_id_aluno` int(11) NOT NULL,
  `Disciplina_id_disciplina` int(11) NOT NULL,
  PRIMARY KEY (`Aluno_id_aluno`,`Disciplina_id_disciplina`),
  KEY `fk_Aluno_has_Disciplina_Disciplina1_idx` (`Disciplina_id_disciplina`),
  KEY `fk_Aluno_has_Disciplina_Aluno_idx` (`Aluno_id_aluno`),
  CONSTRAINT `fk_Aluno_has_Disciplina_Aluno` FOREIGN KEY (`Aluno_id_aluno`) REFERENCES `aluno` (`id_aluno`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Aluno_has_Disciplina_Disciplina1` FOREIGN KEY (`Disciplina_id_disciplina`) REFERENCES `disciplina` (`id_disciplina`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `tabeladados` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `q1` varchar(1) NOT NULL,
  `q2` varchar(1) NOT NULL,
  `q3` varchar(1) NOT NULL,
  `q4` varchar(1) NOT NULL,
  `nota` double NOT NULL,
  `turma` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;



