
{{ range .Errors }}

{{ if .HasComment }}{{ .Comment }}{{ end -}}
func Error{{ .CamelValue }}() *Error {
	return &Error{
		code:    {{ .HTTPCode }},
		reason:  {{ .Name }}_{{ .Value }}.String(),
		message: "{{ .Message }}",
		i18n:    map[string]string{
			"en_US": {{ .I18N.EnUS }},
			"zh_CN": {{ .I18N.ZhCN }},
			"zh_TW": {{ .I18N.ZhTW }},
			"es_ES": {{ .I18N.EsES }},
			"fr_FR": {{ .I18N.FrFR }},
			"de_DE": {{ .I18N.DeDE }},
			"it_IT": {{ .I18N.ItIT }},
			"ja_JP": {{ .I18N.JaJP }},
			"ko_KR": {{ .I18N.KoKR }},
			"pt_BR": {{ .I18N.PtBR }},
			"ru_RU": {{ .I18N.RuRU }},
			"ar_SA": {{ .I18N.ArSA }},
			"hi_IN": {{ .I18N.HiIN }},
			"nl_NL": {{ .I18N.NlNL }},
			"pl_PL": {{ .I18N.PlPL }},
			"sv_SE": {{ .I18N.SvSE }},
			"tr_TR": {{ .I18N.TrTR }},
			"vi_VN": {{ .I18N.ViVN }},
			"th_TH": {{ .I18N.ThTH }},
			"id_ID": {{ .I18N.IdID }},
			"ms_MY": {{ .I18N.MsMY }},
		},
	}
}

{{- end }}
