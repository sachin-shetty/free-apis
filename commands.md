gcloud auth activate-service-account --key-file <key_file>
gcloud config set compute/zone asia-south1-a
gcloud config set project free-apis-199609 
gcloud compute addresses create free-apis-ingress --global # Needs login as admin

gcloud container --project free-apis-199609  clusters get-credentials  free-apis-infra  --zone asia-south1-a

kubectl create -f service_account.yaml
helm init --service-account helm
helm install --debug --dry-run ./free-apis-helm-chart/
helm upgrade --install geo-ip free-apis-helm-chart/ --values free-apis-helm-chart/values.yaml --namespace=default --debug
helm del --purge geo-ip
