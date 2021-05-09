# Ocean

A Helm chart to install Seafile on a cluster.

![Ocean](https://repository-images.githubusercontent.com/308657240/a6198d80-1e0e-11eb-9c69-8c5b9f77e096)

## Usage

After installation, the [Seafile clients](https://www.seafile.com/en/download/) or the web UI (available at the configured `location`) can be used to sync and manage files. Login as the `admin` user created during install and sync away!

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

When set that way, the `FILE_SERVER_ROOT` should be set accordingly from the web UI (note: once set from the UI, those settings will take priority over any config/environment changes).

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

### Example

For a working example check out [a working ArgoCD app](https://github.com/valerauko/sut/blob/4b3dd84/apps/71-seafile.yaml).

## Cover photo

<span>Photo by <a href="https://unsplash.com/@unstable_affliction?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Ivan Bandura</a> on <a href="https://unsplash.com/s/photos/ocean?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span>
