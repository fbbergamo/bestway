# README #

O aplicativo deve prover a melhor rota entre dois pontos. Esse problema é conhecido como "Problema do caminho mínimo"

Foi escolhido utilizar o Neo4J pois ele é classificado como banco de dados de grafos sendo um banco otimizado para se trabalhar com essa estrutura de dados, assim a aplicação não fica responsável pela implementação dos algorítimos ligados a grafos, estando mais preparado para se trabalhar com sistemas mais escaláveis.

A ferramenta Chef e Vagrant foram escolhidas para fazer o provisionamento da maquina de desenvolvimento, mantendo uma VM padrão para o desenvolvimento.

O manual da API foi descrito utilizando a GEM Apipie. é acessível por meio do link http://localhost:3000/apipie Ou nos PDFs da pasta doc


### Quais tecnologia esse aplicativa utiliza? ###

* Ruby on Rails 4.2
* Neo4j
* Chef

### Como configurar? ###

* Instalar o Vagrant com os plugins
* ** vagrant plugin install vagrant-librarian-chef-nochef
* ** vagrant plugin install vagrant-omnibus
* logar na maquina virtual "vagrant up; vagrant ssh"
* bundle
* configurar as senhas do Neo4J no secret.yml
* rake db:seed

### Como configurar o ambiente de teste com neoj4 ###

* https://github.com/neo4jrb/neo4j/wiki/How-To-Test
* rake neo4j:install[community-2.1.3,test]
* rake neo4j:config[test,7475]
* copie no config/environments/test
* ** config.neo4j.session_type = :server_db
* ** config.neo4j.session_path = 'http://localhost:7475'
* Por motivos de VM temos que fazer um link com o banco de teste, ref: https://github.com/neo4jrb/neo4j/issues/729
* rodar comando 1) "mv db/neo4j /home/vagrant"
* rodar comando 2) "ln -s /home/vagrant/neo4j db"
* rspec
