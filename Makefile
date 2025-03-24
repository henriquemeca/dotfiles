symbolics:
	./setup_symbolic_links.sh

up_lazyvim:
	docker run -w /root -it --rm alpine:edge sh -c ' \
  	apk add git lazygit neovim ripgrep alpine-sdk --no-cache && \
	git clone https://github.com/LazyVim/starter /root/.config/nvim && \
  	cd /root/.config/nvim && \
  	bash \
	'
up_astrovim:
	docker run -w /root -it --rm alpine:edge sh -c ' \
  	apk add git neovim alpine-sdk --no-cache && \
	git clone https://github.com/AstroNvim/AstroNvim /root/.config/nvim && \
  	cd /root/.config/nvim && \
  	sh \
	'
mac-init:
	export PATH=/opt/homebrew/bin:$PATH
	touch ~/.credentials.sh
	if [ ! -d ~/.config ]; then mkdir ~/.config; fi
	stow --dotfiles .
	brew install font-hack-nerd-font
	#gem install colorls

brew-install:
	brew bundle

brew-update:
	brew bundle dump --force

brew-fonts:

