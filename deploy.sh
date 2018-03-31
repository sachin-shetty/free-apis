#!/bin/bash -xe
echo $K8S_SERVICE_ACCOUNT_KEY | base64 --decode -i > ${HOME}/k8s-service-key.json
gcloud auth activate-service-account --key-file ${HOME}/k8s-service-key.json
gcloud container --project free-apis-199609  clusters get-credentials  free-apis-infra  --zone asia-south1-a
helm upgrade --install geo-ip free-apis-helm-chart/ --values free-apis-helm-chart/values.yaml --namespace=default --debug
rm ${HOME}/k8s-service-key.json
