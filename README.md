# Ocean

A Helm chart to install Seafile on a cluster.

## Installation

Configure using `values`.

### Won't work without

The below should be configured correctly for it to work as expected.

* database
* admin
* location

### Databases

Create the following databases and grant sensible (table creating) privileges to the user configured in `database.existingSecret/USERNAME` or `database.username`.

* ccnet_db
* seafile_db
* seahub_db

### Ingress

If using an ingress, some path (the official example uses `seafhttp`, but anything works really) should be set to route to port 8082 (where the file server is listening).

When set that way, the `FILE_SERVER_ROOT` should be set accordingly.

## Configuration

| Parameter                                 | Description                                   | Default                                                 |
|-------------------------------------------|-----------------------------------------------|---------------------------------------------------------|
| `location`                                | URL for the server                                   | Default                                                 |
| `timeZone`                                | Timezone for the server                               | `Etc/UTC`                                                     |
| `image.repository`                        | Image repository                              | `valerauko/ocean`                                       |
| `image.tag`                               | Image tag                | `0.4.3`                                                 |
| `image.pullPolicy`                        | Image pull policy                             | `IfNotPresent`                                          |
| `database.existingSecret` | Name of existing secret with MySQL credentials. `USERNAME`, `PASSWORD`, `HOSTNAME` must be present. | `nil` |
| `database.username` | User to access database | `seafile` |
| `database.password` | Above user's password | `""` |
| `database.hostname` | MySQL database host | `mariadb.default.svc.cluster.local` |
| `admin.existingSecret` | Name of existing secret with admin user's credentials. `EMAIL`, `PASSWORD` must be present. | `nil` |
| `admin.email` | Email address of admin | `me@example.com` |
| `admin.password` | Password of admin account | `""` |
| `service.type`                            | Kubernetes service type                       | `ClusterIP`                                             |
| `service.port`                            | Kubernetes port where service is exposed      | `80`                                                    |
| `ingress.enabled`                         | Enables Ingress                               | `false`                                                 |
| `ingress.annotations`                     | Ingress annotations (values are templated)    | `{}`                                                    |
| `ingress.hosts`                           | Ingress accepted hostnames                    | `["chart-example.local"]`                                                    |
| `ingress.extraPaths`                      | Ingress extra paths to prepend to every host configuration. Useful when configuring [custom actions with AWS ALB Ingress Controller](https://kubernetes-sigs.github.io/aws-alb-ingress-controller/guide/ingress/annotation/#actions). | `[]`                                                    |
| `ingress.tls`                             | Ingress TLS configuration                     | `[]`                                                    |
| `persistence.size`                        | Size of persistent volume claim               | `10Gi`                                                  |
| `persistence.existingClaim`               | Use an existing PVC to persist data           | `nil`                                                   |
| `persistence.storageClassName`            | Type of persistent volume claim               | `nil`                                                   |
| `persistence.accessModes`                 | Persistence access modes                      | `[ReadWriteOnce]`                                       |
| `resources`                               | CPU/Memory resource requests/limits           | `{}`                                                    |
| `nodeSelector`                            | Node labels for pod assignment                | `{}`                                                    |
| `tolerations`                             | Toleration labels for pod assignment          | `[]`                                                    |
| `affinity`                                | Affinity settings for pod assignment          | `{}`                                                    |
| `podAnnotations`                          | Pod annotations                               | `{}`                                                    |
| `podSecurityContext` | Pod security context | `{}` |
| `securityContext` | Security context | `{}` |
