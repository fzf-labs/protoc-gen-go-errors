{{ range .Errors }}

{{ if .HasComment }}{{ .Comment }}{{ end -}}
func Is{{.CamelValue}}(err error) bool {
	if err == nil {
		return false
	}
	e := errors.FromError(err)
	return e.Reason == {{ .Name }}_{{ .Value }}.String() && e.Code == {{ .HTTPCode }}
}

{{ if .HasComment }}{{ .Comment }}{{ end -}}
func Error{{ .CamelValue }}(format string, args ...interface{}) *errors.Error {
	 return errors.New({{ .HTTPCode }}, {{ .Name }}_{{ .Value }}.String(), fmt.Sprintf(format, args...))
}

{{ if .HasComment }}{{ .Comment }}{{ end -}}
func ErrorReason{{ .CamelValue }}(opts ...Option) *errors.Error {
	e := &ErrorReasonErrors{
		code:    {{ .HTTPCode }},
		reason:  {{ .Name }}_{{ .Value }}.String(),
		message: "{{ .Message }}",
		i18n:    map[string]string{
			{{- if .I18N.En_US }}
			"en_US": "{{ .I18N.En_US }}",
			{{- end }}
			{{- if .I18N.Zh_CN }}
			"zh_CN": "{{ .I18N.Zh_CN }}",
			{{- end }}
			{{- if .I18N.Zh_TW }}
			"zh_TW": "{{ .I18N.Zh_TW }}",
			{{- end }}
			{{- if .I18N.Es_ES }}
			"es_ES": "{{ .I18N.Es_ES }}",
			{{- end }}
			{{- if .I18N.Fr_FR }}
			"fr_FR": "{{ .I18N.Fr_FR }}",
			{{- end }}
			{{- if .I18N.De_DE }}
			"de_DE": "{{ .I18N.De_DE }}",
			{{- end }}
			{{- if .I18N.It_IT }}
			"it_IT": "{{ .I18N.It_IT }}",
			{{- end }}
			{{- if .I18N.Ja_JP }}
			"ja_JP": "{{ .I18N.Ja_JP }}",
			{{- end }}
			{{- if .I18N.Ko_KR }}
			"ko_KR": "{{ .I18N.Ko_KR }}",
			{{- end }}
			{{- if .I18N.Pt_BR }}
			"pt_BR": "{{ .I18N.Pt_BR }}",
			{{- end }}
			{{- if .I18N.Ru_RU }}
			"ru_RU": "{{ .I18N.Ru_RU }}",
			{{- end }}
			{{- if .I18N.Ar_SA }}
			"ar_SA": "{{ .I18N.Ar_SA }}",
			{{- end }}
			{{- if .I18N.Hi_IN }}
			"hi_IN": "{{ .I18N.Hi_IN }}",
			{{- end }}
			{{- if .I18N.Nl_NL }}
			"nl_NL": "{{ .I18N.Nl_NL }}",
			{{- end }}
			{{- if .I18N.Pl_PL }}
			"pl_PL": "{{ .I18N.Pl_PL }}",
			{{- end }}
			{{- if .I18N.Tr_TR }}
			"tr_TR": "{{ .I18N.Tr_TR }}",
			{{- end }}
			{{- if .I18N.Vi_VN }}
			"vi_VN": "{{ .I18N.Vi_VN }}",
			{{- end }}
			{{- if .I18N.Th_TH }}
			"th_TH": "{{ .I18N.Th_TH }}",
			{{- end }}
			{{- if .I18N.Id_ID }}
			"id_ID": "{{ .I18N.Id_ID }}",
			{{- end }}
			{{- if .I18N.Ms_MY }}
			"ms_MY": "{{ .I18N.Ms_MY }}",
			{{- end }}
		},
	}
	for _, o := range opts {
		o(e)
	}
	return e.Error()
}

{{- end }}
