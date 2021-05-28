## Vagrant Microk8s
Local installation of kubernetes using vagrant & microk8s 

### Prerequisites
- Vagrant > 2.2.15
- Virtualbox > 6.1
- helm > 3.x

### Usage
- Vagrantfile L14, add the desired local IP. If you do not know your local desired IP then remove from L14 and add the type: "dhcp"
- `vagrant up`
- From /vagrant/config, copy cluster, context & users to ~/.kube/config
- `kubectl config use-context vag-microk8s`
- `kubectl get pods --sort-by={.metadata.name}`

### Test
- `helm repo add bitnami https://charts.bitnami.com/bitnami`
- `helm install nginx bitnami/nginx`
- Go to `http://${SERVICE_IP}`