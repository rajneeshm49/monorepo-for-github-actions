#! /bin/sh
text="$(kubectl get nodes)"
s2="Ready"
if [[ $text == *"$s2"* ]]
then
  a="$(kubectl get service -n ingress-nginx)";
  externalip=$(sed  's/^.* \(.*.com\).*$/\1/g' <<<"$a")

  sed -i .bak "s/- host: .*/- host: $externalip/g" k8s/prod/ingress-service.yaml
else
  echo "The cluster is not ready yet";
fi