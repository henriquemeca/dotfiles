symbolics:
	./setup_symbolic_links.sh

up_lazyvim:
	docker run -w /root -it --rm alpine:edge sh -c ' \
  	apk add git lazygit neovim ripgrep alpine-sdk --no-cache && \
	git clone https://github.com/LazyVim/starter /root/.config/nvim && \
  	cd /root/.config/nvim && \
  	bash \
	'
