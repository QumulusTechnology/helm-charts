{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "awx.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "awx.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "awx.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "awx.postgresql.host" -}}
{{- if .Values.postgresql.enabled -}}
  {{- printf "%s-%s" (include "common.names.fullname" .) "postgresql" -}}
{{- else -}}
  {{- printf "%s" (tpl .Values.aws_db_host $) -}}
{{- end -}}
{{- end -}}

{{- define "awx.postgresql.secretName" -}}
{{- if .Values.postgresql.enabled -}}
  {{- if .Values.postgresql.auth.existingSecret -}}
      {{- printf "%s" (tpl .Values.postgresql.auth.existingSecret $) -}}
  {{- else -}}
      {{- printf "%s-%s" (include "common.names.fullname" .) "postgresql" -}}
  {{- end -}}
{{- else -}}
      {{- printf "%s" (tpl .Values.awx_db_secret $) -}}
{{- end -}}
{{- end -}}
