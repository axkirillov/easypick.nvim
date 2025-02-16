.PHONY: test-no-deps test-telescope test
test-no-deps:
	@nvim --headless -c "PlenaryBustedDirectory tests/no_deps/ {minimal_init = 'tests/no_deps/init.lua'}"

test-telescope:
	@nvim --headless -c "PlenaryBustedDirectory tests/telescope/ {minimal_init = 'tests/telescope/init.lua'}"

test-fzf-lua:
	@nvim --headless -c "PlenaryBustedDirectory tests/fzf-lua/ {minimal_init = 'tests/fzf-lua/init.lua'}"

test:
	@make test-no-deps 
	@make test-telescope
	@make test-fzf-lua
