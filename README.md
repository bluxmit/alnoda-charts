# Helm chart for Alnoda workspace 

Helm chart to install [Alnoda workspaces](docs.alnoda.org) in Kubernnetes clusters.  

## Usage

Add Helm repository:

```
helm repo add alnoda https://bluxmit.github.io/alnoda-charts/
```

Update your Helm chart list:

```
helm repo update
```

Create Helm values file, for example file values.yaml:

```
ingress:
  enabled: true
  className: nginx
  host: example.com
```

Install the workspace:

```
helm install my-workspace alnoda/alnoda-workspace -f values.yaml
```

## Values

| Parameter             | Description                    | Default        |
|-----------------------|--------------------------------|----------------|
| `replicaCount`       | Number of replicas             | `1`            |
| `image.repository`   | Image repository               | `alnoda/alnoda-workspace` |
| `image.pullPolicy`   | Image pull policy              | `IfNotPresent` |
| `image.tag`          | Image tag                      | `latest`       |
| `imagePullSecrets`   | Image pull secrets             | `[]`           |
| `nameOverride`       | Name override                  | `""`           |
| `fullnameOverride`   | Full name override             | `""`           |
| `podAnnotations`     | Pod annotations                | `{}`           |
| `podSecurityContext` | Pod security context           | `{}`           |
| `securityContext`    | Security context               | `{}`           |
| `service.type`       | Service type                   | `ClusterIP`    |
| `ingress.enabled`    | Enable ingress                 | `true`         |
| `ingress.className`  | Ingress class name             | `""`           |
| `ingress.annotations`| Ingress annotations            | `{}`           |
| `ingress.host`       | Ingress host                   | `example.local`|
| `resources`          | CPU/Memory resource requests/limits | `{}`   |
| `nodeSelector`       | Node selector                  | `{}`           |
| `tolerations`        | Tolerations                    | `[]`           |
| `affinity`           | Affinity                       | `{}`           |
| `customLabels`       | Custom labels                  | `{}`           |

