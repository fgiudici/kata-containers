{{- if not (eq .Values.kubernetes.distribution "k3s" "rke2" "k0s" "vanilla") -}}
  {{- required "Allowed kubernetes.distribution are: 'k3s', 'rke2', 'k0s' or 'vanilla'." "" -}}
{{- end -}}
