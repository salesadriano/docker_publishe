# Docker Publisher

Esta imagem permite realizar o build de uma imagem Docker e a publicação dela em um Registry, permite também a integração com repositório Git.

Variáveis de ambiente
```
GITLAB_USER_NAME - Nome do Usuário logado no Git
GITLAB_USER_EMAIL - E-Mail do Usuário logado no Git

CI_SERVER_HOST - URL do Repositório. Ex.: https://gitlab.com
CI_PROJECT_PATH - Caminho do projeto no servidor. Ex.: /minhaEmpresa/meusProjetos
CI_PROJECT_NAME - Refenrência do projeto para clonagem. Ex.: meuProjeto
CI_PIPELINE_ID - Identificador único do Pipeline (gerado pelo repositório).

CI_REGISTRY - URL do Docker Registry. Ex.: docker.io
CI_REGISTRY_USER - Username de acesso ao Registry.
CI_REGISTRY_PASSWORD  - Senha de acesso ao Registry.
```

Exemplo de Pipeline
```
publish:
  image: salesadriano/docker_publisher
  stage: build
  services:
    - docker:dind
  before_script: 
      - service docker start
      - sleep 5
  script:
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
    - docker build . -t $CI_REGISTRY/$CI_REGISTRY_USER/$CI_PROJECT_NAME --pull
    - docker push $CI_REGISTRY/$CI_REGISTRY_USER/$CI_PROJECT_NAME
    - /publicar.sh
  only:
    - master
```