SHELL := /bin/bash
VERSION := 0.2.0
WEB_PORT = 4000

# ==============================================================================
# go

go-run-web:
	go run ./cmd/web -addr=":$(WEB_PORT)"

# ==============================================================================
# docker

docker-build-web:
	docker build \
		-f deploy/docker/dockerfile.snippetbox \
		-t snippetbox-amd64:$(VERSION) \
		--build-arg BUILD_REF=$(VERSION) \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		.

docker-run-web:
	docker run \
		-p $(WEB_PORT):$(WEB_PORT)\
		-e WEB_PORT=$(WEB_PORT)\
		snippetbox-amd64:$(VERSION)

# ==============================================================================
# run kind k8s cluster

KIND_CLUSTER := lab-go-snippetbox

kind-up:
	kind create cluster \
		--image kindest/node:v1.22.0@sha256:b8bda84bb3a190e6e028b1760d277454a72267a5454b57db34437c34a588d047 \
		--name $(KIND_CLUSTER) \
		--config deploy/k8s/kind/kind-config.yaml
	kubectl config set-context --current --namespace=web-snippetbox

kind-down:
	kind delete cluster --name $(KIND_CLUSTER)

kind-load:
	cd deploy/k8s/kind/web-snippetbox; kustomize edit set image web-snippetbox=snippetbox-amd64:$(VERSION)
	kind load docker-image snippetbox-amd64:$(VERSION) --name $(KIND_CLUSTER)

kind-apply-jenkins:
	kubectl apply -f deploy/k8s/base/devops-jenkins

kind-apply-snippetbox:
	kustomize build deploy/k8s/kind/web-snippetbox | kubectl apply -f -

kind-status:
	kubectl get nodes -o wide
	kubectl get svc -o wide
	kubectl get pods -o wide --watch --all-namespaces

kind-logs:
	kubectl logs -l app=sales --all-containers=true -f --tail=100

kind-restart:
	kubectl rollout restart deployment snippetbox-pod

kind-update: all kind-load kind-restart

kind-update-apply: snippetbox-api kind-load kind-apply

kind-describe:
	kubectl describe pod -l app=snippetbox

# ==============================================================================
# Modules support

tidy:
	go mod tidy
	go mod vendor
