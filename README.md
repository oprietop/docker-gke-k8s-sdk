# docker-gke-k8s-sdk
Extending google/cloud-sdk:alpine with kubectl and a wrapper to easily authenticate using service account keys in '.json' format.

**How to use:**  
Export your service accounts to json files into a dir and mount it into /root/keys inside the container.   
Example: `docker run -it --rm -v $(PWD)/keys:/root/keys oprietop/gke-k8s-sdk`.  
Service accounts can be created at https://console.cloud.google.com/iam-admin/serviceaccounts.  
If you only need to deploy to GKE, _Container Engine Developer_ is enough for the role.  

**Links:**  
https://hub.docker.com/r/oprietop/gke-k8s-sdk/  
https://hub.docker.com/r/google/cloud-sdk/
