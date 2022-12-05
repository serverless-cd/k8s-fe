{{/*
Expand the name of the chart.
*/}}
{{- define "simple-gitlab-redis.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "simple-gitlab-redis.fullname" }}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- default .Chart.Name .Values.nameOverride }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "simple-gitlab-redis.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "simple-gitlab-redis.labels" -}}
helm.sh/chart: {{ include "simple-gitlab-redis.chart" . }}
{{ include "simple-gitlab-redis.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "simple-gitlab-redis.selectorLabels" -}}
app.kubernetes.io/name: {{ include "simple-gitlab-redis.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create redis servicePort
*/}}
{{- define "simple-gitlab-redis.servicePort" -}}
{{- if .Values.service.port }}
  {{- printf .Values.service.port }}
{{- else }}
  {{- default "6379" .Values.global.redis.servicePort -}}
{{- end }}
{{- end }}