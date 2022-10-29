#!/bin/bash
git config --global user.email "${GITLAB_USER_EMAIL}"
git config --global user.name "${GITLAB_USER_NAME}"
git clone git@${CI_SERVER_HOST}:${CI_PROJECT_PATH}.git /prod
cd /prod
git switch prod
sed -i "s|- name: .*$|- name: $CI_PROJECT_NAME${CI_PIPELINE_ID}|g" /prod/rancher/kubernetes_web.yml
sed -i "s|image: .*$|image: $CI_REGISTRY/$CI_REGISTRY_USER/$CI_PROJECT_NAME|g" /prod/rancher/kubernetes_web.yml
git add .
git commit -m "Publicação do Pipeline nº ${CI_PIPELINE_ID}"
git push