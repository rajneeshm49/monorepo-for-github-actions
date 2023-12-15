#! /bin/sh
text="$(kubectl get nodes)"
s2="Ready"
if [[ $text == *"$s2"* ]]
then
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/aws/deploy.yaml;
  a="$(kubectl get service -n ingress-nginx)";
  externalip=$(sed  's/^.* \(.*.com\).*$/\1/g' <<<"$a")

  kubectl create secret docker-registry regcred  \
    --docker-server=682755029646.dkr.ecr.us-east-1.amazonaws.com \
    --docker-username=AWS  \
    --docker-password=$(aws ecr get-login-password)

  kubectl create serviceaccount github-actions
  kubectl apply -f k8s/clusterrole.yaml
  kubectl create clusterrolebinding continuous-deployment \
    --clusterrole=continuous-deployment \
    --serviceaccount=default:github-actions

  kubectl apply -f k8s/service-account-secret.yaml

  sed -i .bak "s/- host: .*/- host: $externalip/g" k8s/prod/ingress-service.yaml

  echo "STEP 1: PASTE OUTPUT OF `kubectl get secret github-actions-secret -o yaml` IN GITHUB SECRETS";
  echo "STEP 2: COPY KUBERNETES SERVER URL IN PULL-REQUEST FILE";
  echo "STEP 3: RUN `kubectl get service -n ingress-nginx`, GET THE LB URL AND COPY IT IN PROD/INGRESS-SERVICE.YAML "
  echo "STEP 4: COPY THE VALUE FROM STEP 3 TO PROD/FE-CONFIGMAP.YAML"
else
  echo "The cluster is not ready yet";
fi