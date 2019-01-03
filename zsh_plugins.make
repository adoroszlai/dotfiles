# vim: ft=make noet

%.zsh: %.list
	antibody bundle < $< > $@
