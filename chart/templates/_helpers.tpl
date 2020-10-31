{{/*
Expand the name of the chart.
*/}}
{{- define "ocean.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ocean.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ocean.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ocean.labels" -}}
helm.sh/chart: {{ include "ocean.chart" . }}
{{ include "ocean.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ocean.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ocean.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the secrets to use
*/}}
{{- define "ocean.databaseSecret" -}}
{{- default (printf "%s-database" (include "ocean.fullname" .)) .Values.database.existingSecret }}
{{- end }}
{{- define "ocean.adminSecret" -}}
{{- default (printf "%s-database" (include "ocean.fullname" .)) .Values.database.existingSecret }}
{{- end }}

{{/*
Storage class
*/}}
{{- define "ocean.storageClass" -}}
{{- if .Values.ocean.storageClass -}}
    {{- if (eq "-" .Values.persistence.storageClass) -}}
        {{- printf "storageClassName: \"\"" -}}
    {{- else }}
        {{- printf "storageClassName: %s" .Values.persistence.storageClass -}}
    {{- end -}}
{{- end -}}
{{- end -}}
