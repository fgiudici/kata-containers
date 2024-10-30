# kata-containers

The [Kata Containers project](https://katacontainers.io/) provides the [kata-deploy installation method](https://github.com/kata-containers/kata-containers/blob/main/tools/packaging/kata-deploy/README.md) which consists of:

* a container image packed with all the required binaries compiled statically and all the other artifacts from the release
* a kata-deploy script, included in the same container image, that should be run on each cluster node
* kubernetes resources to be installed through kustomize

During the hackweek the kata-deploy resources have been adapted in an helm chart.

**The resulting chart has been released in an Helm Repo at https://fgiudici.github.io/kata-containers/**.

Add it to Rancher as an App HTTP Repository or add to your helm repositories with:

$> helm repo add kata-containers https://fgiudici.github.io/kata-containers/

Install it via the Rancher Marketplace or via the helm command line, but **be sure to set the right kind of kubernetes cluster you are using** (chart value *kubernetes.distribution*).
Allowed options are vanilla, **k3s**, **rke2** or k0s.

The default is _vanilla_ so you need to change it to _k3s_ or _rke2_ if you are using one of the two Rancher distro. This is required because the kata deployment needs to change the containerd config file on the cluster nodes to enable the kata low level runtimes and containerd config location changes depending on the kubernetes distribution used.

On the Rancher Marketplace UI you will need to change the kubernetes.distribution value editing the chart yaml before deployment (sorry, no UI for that yet).
For the helm command line, you will need something like (k3s scenario):

$> helm install kata-containers kata-containers/kata-containers --namespace kube-system --set kubernetes.distribution=k3s

After installing Kata Containers, in order to start a kata workload, you have to specify a _runtimeClassName_ in your kubernetes resource: 
[here a sample kata ngnix  Deployment](https://github.com/fgiudici/kata-containers/blob/charts/example-workloads/nginx-kata-deployment.yaml).

The available runtime classes can be retrieved with:

$> kubectl get runtimeclasses.node.k8s.io
