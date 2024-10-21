GOHOSTOS:=$(shell go env GOHOSTOS)

ifeq ($(GOHOSTOS), windows)
	#the `find.exe` is different from `find` in bash/shell.
	#to see https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/find.
	#changed to use git-bash.exe to run find cli or other cli friendly, caused of every developer has a Git.
	#Git_Bash= $(subst cmd\,bin\bash.exe,$(dir $(shell where git)))
	Git_Bash=$(subst \,/,$(subst cmd\,bin\bash.exe,$(dir $(shell where git))))
	ERRORS_PROTO_FILES=$(shell $(Git_Bash) -c "find errors -name *.proto")
	EXAMPLE_PROTO_FILES=$(shell $(Git_Bash) -c "find example -name *.proto")
else
	ERRORS_PROTO_FILES=$(shell find errors -name *.proto)
	EXAMPLE_PROTO_FILES=$(shell find example -name *.proto)
endif

.PHONY: install
# install
install:
	go install github.com/fzf-labs/protoc-gen-go-errors/v2

.PHONY: errors
# errors
errors:
	protoc -I. -I /usr/local/include \
	       --go_out=paths=source_relative:. \
	       $(ERRORS_PROTO_FILES)

.PHONY: example
# example
example:
	protoc -I. -I /usr/local/include \
		   --go_out=paths=source_relative:. \
		   --go-errors_out=paths=source_relative:. \
		   $(EXAMPLE_PROTO_FILES)