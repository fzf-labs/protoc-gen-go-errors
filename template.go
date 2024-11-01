package main

import (
	"bytes"
	_ "embed"
	"github.com/fzf-labs/protoc-gen-go-errors/v2/errors"
	"text/template"
)

//go:embed errorsTemplate.tpl
var errorsTemplate string

type errorInfo struct {
	Name       string
	Value      string
	HTTPCode   int
	Message    string
	CamelValue string
	Comment    string
	HasComment bool
	I18N       *errors.I18N
}

type errorWrapper struct {
	Errors []*errorInfo
}

func (e *errorWrapper) execute() string {
	buf := new(bytes.Buffer)
	tmpl, err := template.New("errors").Parse(errorsTemplate)
	if err != nil {
		panic(err)
	}
	if err := tmpl.Execute(buf, e); err != nil {
		panic(err)
	}
	return buf.String()
}
