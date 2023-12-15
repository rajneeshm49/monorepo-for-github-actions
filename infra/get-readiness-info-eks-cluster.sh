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

  secretyaml="$(kubectl get secret github-actions-secret -o yaml)";
  echo "paste below output in KUBERNETES_SECRET var in github secrets and also copy kubernetes server url in pull-request file";
  echo $secretyaml
else
  echo "The cluster is not ready yet";
fi