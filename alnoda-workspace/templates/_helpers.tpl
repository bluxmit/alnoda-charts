{{/*
Expand the name of the chart.
*/}}
{{- define "alnoda-workspace.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "alnoda-workspace.fullname" -}}
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
{{- define "alnoda-workspace.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "alnoda-workspace.labels" -}}
helm.sh/chart: {{ include "alnoda-workspace.chart" . }}
{{ include "alnoda-workspace.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.customLabels }}
{{- range $key, $value := .Values.customLabels }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "alnoda-workspace.selectorLabels" -}}
app.kubernetes.io/name: {{ include "alnoda-workspace.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create Service ports
*/}}
{{- define "alnoda-workspace.service-ports" }}
{{- range $i := until 20 }}
- port: {{ add $i 8020 }}
  targetPort: {{ add $i 8020 }}
  protocol: TCP
  name: http-{{ add $i 8020 | toString }}
{{- end }}
{{- end }}

{{/*
Create Ingress hosts
*/}}
{{- define "alnoda-workspace.ingress-hosts" }}
{{- $root := . -}}  {{- /* store the original context in $root */ -}}
{{- range $i := until 20 }}
- host: https-{{ add $i 8020 | toString }}.{{ $root.Values.ingress.host }}
  http:
    paths:
    - pathType: Prefix
      path: "/"
      backend:
        service:
          name: {{ (include "alnoda-workspace.fullname" $root) }}
          port:
            number: {{ add $i 8020 }}
{{- end }}
{{- end }}
