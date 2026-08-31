{{/*
Expand service names containing embedded templates.
*/}}
{{- define "basic-service.name" -}}
{{- tpl .Values.name . -}}
{{- end -}}

{{/*
Expand service common names/FQDN containing embedded templates.
*/}}
{{- define "basic-service.commonName" -}}
{{- tpl .Values.commonName . -}}
{{- end -}}

{{/*
Expand service labels containing embedded templates.
*/}}
{{- define "basic-service.labels" -}}
{{- range  $key, $value := .Values.labels }}
{{ tpl $key $ }}: {{ tpl $value $ | quote}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "basic-service.fullname" -}}
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
{{- define "basic-service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "basic-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "basic-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "basic-service.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "basic-service.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
