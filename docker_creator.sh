instalar_docker(){
    sudo apt-get update && \
    sudo apt-get install ca-certificates curl gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get install docker-ce docker-ce-cli containerd.io
    start_function
}

container_arch_criador(){
    echo "Escolha o nome do container"
    read nome
    echo "Escolha a distribuição"
    read distribuicao
    xhost +
    docker run --name $nome -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/docker_local:/exports -it $distribuicao /bin/bash
    exit
}

executar_aplicacao(){
    xhost +
    echo "Qual o nome do container?"
    read nome_container
    echo "Qual o nome da aplicação que deseja executar?"
    read nome_aplicacao  
    docker exec $nome_container $nome_aplicacao
    funcao_principal
}

executar_container_novamente(){
    echo "Qual container você deseja executar?"
    read nome_container
    sudo docker start $nome_container
    funcao_principal
}

parar_container(){
    echo "Qual container você deseja parar?"
    read nome_container
    sudo docker stop $nome_container
    funcao_principal
}

remover_container(){
    echo "Qual container você deseja remover?"
    read nome_container
    sudo docker stop $nome_container
    sudo docker rm $nome_container
    funcao_principal
}

remover_imagem(){
    echo "Qual docker image você deseja remover?"
    read nome_imagem
    sudo docker rmi $nome_imagem
    funcao_principal
}

executar_sem_sudo(){
    sudo groupadd docker && sudo usermod -aG docker $USER
    exit
}

executar_container_shell(){
    echo "Qual o nome do container você deseja gerenciar?"
    read nome_container
    docker exec -it $nome_container /bin/bash
    exit
}

funcao_principal(){
echo
echo "Selecione uma opção"
echo
echo "1  - Instalar docker"
echo "2  - Criar um novo container com uma imagem docker"
echo "3  - Executar um container previamente criado"
echo "4  - Parar um container"
echo "5  - Executar uma aplicação especifica dentro de um container"
echo "6  - Executar os comandos do docker sem a utilização do sudo"
echo "7  - Acessar o container para gerenciar ou instalar mais aplicações"
echo "8  - Remover containers"
echo "9  - Remover imagens docker"
echo "10  - Sair do Script"
echo

while :
do
  read opcao_selecionada
  case $opcao_selecionada in

	1) instalar_docker;;
	
    2) container_arch_criador;;
    
    3) executar_container_novamente;;

    4) parar_container;;

    5) executar_aplicacao;;

    6) executar_sem_sudo;;
	
    7) executar_container_shell;; 

    8) remover_container;;

    9) remover_imagem;;
    
    10) exit

  esac
done
}

funcao_principal