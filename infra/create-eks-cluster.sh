#! /bin/sh
eksctl create cluster --name Kubernetes-demo --region us-east-1 --node-type t3.micro --nodes-min 2 --nodes-max 2