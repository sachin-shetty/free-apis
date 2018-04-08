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

# Setting up Certs
```Install Cert Manager chart```
git clone https://github.com/jetstack/cert-manager.git
helm install --name cert-manager  --namespace kube-system stable/cert-manager

```  Setup letsencrypt cert ```
https://github.com/ahmetb/gke-letsencrypt
export EMAIL=sachin.shetty@gmail.com
curl -sSL https://rawgit.com/ahmetb/gke-letsencrypt/master/yaml/letsencrypt-issuer.yaml |     sed -e "s/email: ''/email: $EMAIL/g" |     kubectl apply -f-

