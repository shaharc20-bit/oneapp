{{- define "k8s-exam.labels" -}}
app.kubernetes.io/name: k8s-exam
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
exam: workshop
{{- end }}
