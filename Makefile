release:
	cd charts; helm package kata-containers; helm repo index . --url=https://katacharts.kubepod.cloud/assets --merge ../index.yaml
	mv charts/index.yaml ./
	mv charts/kata-containers-* assets/

