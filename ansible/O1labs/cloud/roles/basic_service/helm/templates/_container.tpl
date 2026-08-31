{{/*
Container environment variables from env.config, secrets, and extraEnv.
*/}}
{{- define "basic-service.containerEnv" -}}
- name: POD_IP
  valueFrom:
    fieldRef:
      fieldPath: status.podIP
{{- range $key, $value := ((.Values.env | default dict).config | default dict) }}
- name: {{ $key }}
  value: {{ tpl ($value | toString) $ | quote }}
{{- end }}
{{- range $key, $value := .Values.secretEnv }}
- name: {{ $key }}
  valueFrom:
    secretKeyRef:
      name: {{ include "basic-service.name" $ }}-env
      key: {{ $key }}
{{- end }}
{{- if .Values.extraEnv }}
{{ tpl (toYaml .Values.extraEnv) . | nindent 0 }}
{{- end }}
{{- end -}}

{{/*
Primary application container specification.
*/}}
{{- define "basic-service.mainContainer" -}}
- name: {{ template "basic-service.name" . }}
  image: {{ required "A valid .Values.image is required" .Values.image }}
  {{- with .Values.command }}
  command: {{ toYaml . | nindent 2 }}
  {{- end }}
  {{- with .Values.args }}
  args: {{ toYaml . | nindent 2 }}
  {{- end }}
  {{- with .Values.containerSecurityContext }}
  securityContext:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.resources }}
  resources:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- if or .Values.livenessProbe .Values.livenessProbeRPCDaemon }}
  livenessProbe:
    {{- toYaml (.Values.livenessProbe | default .Values.livenessProbeRPCDaemon) | nindent 4 }}
  {{- end }}
  {{- if or .Values.readinessProbe .Values.readinessProbeRPCDaemon }}
  readinessProbe:
    {{- toYaml (.Values.readinessProbe | default .Values.readinessProbeRPCDaemon) | nindent 4 }}
  {{- end }}
  {{- with .Values.startupProbe }}
  startupProbe:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- if or .Values.extraVolumeMounts .Values.deployStatefulSet }}
  volumeMounts:
    {{- if .Values.deployStatefulSet }}
    - mountPath: {{ .Values.statefulSetOptions.mountPath }}
      name: {{ tpl .Values.statefulSetOptions.name . }}
    {{- end }}
    {{- range $mountName, $mountValue := .Values.extraVolumeMounts }}
      {{- toYaml $mountValue | nindent 4 }}
    {{- end }}
  {{- end }}
  env:
    {{- include "basic-service.containerEnv" . | nindent 4 }}
{{- end -}}

{{/*
Shared pod specification for Deployments and StatefulSets.
*/}}
{{- define "basic-service.podSpec" -}}
{{- if or .Values.dockercfg .Values.dockercfgOverride }}
imagePullSecrets:
  - name: {{ default (include "basic-service.name" .) .Values.dockercfgOverride }}-dockercfg
{{- end }}
{{- with .Values.imagePullSecrets }}
imagePullSecrets:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- if or .Values.extraVolumes .Values.volumesFromConfigMaps }}
volumes:
{{- range $volumeName, $volumeValue := .Values.extraVolumes }}
  {{- toYaml $volumeValue | nindent 2 }}
{{- end }}
{{- range $volumeName, $volumeValue := .Values.volumesFromConfigMaps }}
  - name: {{ $volumeName }}
    configMap:
      name: {{ template "basic-service.name" $ }}-{{ $volumeValue.configMapName }}
{{- end }}
{{- end }}
{{- if .Values.serviceAccountName }}
serviceAccountName: {{ .Values.serviceAccountName }}
{{- end }}
{{- with .Values.initContainers }}
initContainers:
  {{- range $containerName, $containerValue := . }}
    {{- toYaml $containerValue | nindent 2 }}
  {{- end }}
{{- end }}
containers:
  {{- include "basic-service.mainContainer" . | nindent 2 }}
{{- with .Values.extraContainers }}
  {{- range $key, $value := . }}
    {{- tpl (toYaml $value) $ | nindent 2 }}
  {{- end }}
{{- end }}
{{- with .Values.nodeSelector }}
nodeSelector:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.affinity }}
affinity:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.tolerations }}
tolerations:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.terminationGracePeriodSeconds }}
terminationGracePeriodSeconds: {{ . }}
{{- end }}
{{- end -}}
