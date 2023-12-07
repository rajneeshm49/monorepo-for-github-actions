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
  kubectl apply -f clusterrole.yaml
  kubectl create clusterrolebinding continuous-deployment \
    --clusterrole=continuous-deployment \
    --serviceaccount=default:github-actions

  kubectl apply -f k8s/service-account-secret.yaml

  sed -i .bak "s/- host: .*/- host: $externalip/g" k8s/ingress-service-new.yaml

  secretyaml="$(kubectl get secret github-actions-secret -o yaml)";
  echo "paste below output in KUBERNETES_SECRET var in github secrets and also copy kubernetes server url in pull-request file";
  echo $secretyaml
else
  echo "The cluster is not ready yet";
fi



# #! /bin/sh

# # if [ "$text" =~ 'Ready' ]

#   # kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/aws/deploy.yaml;
#   # a="$(kubectl get service -n ingress-nginx)"
#   a="service/ingress-nginx-controller             LoadBalancer   10.100.71.119    abbb42cc9f1344282b9e286e1f561829-6862f115033f7dce.elb.us-east-1.amazonaws.com   80:32131/TCP,443:30394/TCP   7m9sservice/ingress-nginx-controller-admission   ClusterIP      10.100.219.235   <none>"
# https://8BCCC9F9CD39F640CE5E381FAA766120.sk1.us-east-1.eks.amazonaws.com
#   # echo $a | sed  's/^.* \(.*.com\).*$/\1/g';
#   externalip=$(sed  's/^.* \(.*.com\).*$/\1/g' <<<"$a")
#   sed -i .bak "s/- host: .*/- host: $externalip/g" k8s/ingress-service-new.yaml
  
#   # echo $a | sed -e 's/(.*elb.us-east-1.amazonaws.com).*/$1/g'

# # [[ "$text" =~ 'Ready' ]] && kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/aws/deploy.yaml;
# # kubectl get service -n ingress-nginx