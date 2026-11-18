# Read by every zsh (login, interactive, scripts). Keep fast and silent.
export DOTNET_ROOT=$HOME/.dotnet
export PGGMNugetPackageSource="https://proget.p.pggm-cloud.nl/nuget/PGGMNugetGallery/v3/index.json"
export SSL_CERT_DIR=$HOME/.aspnet/dev-certs/trust:/usr/lib/ssl/certs
export ASPNETCORE_ENVIRONMENT=Development
export ASPIRE_CLI_TELEMETRY_OPTOUT=1
export FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT=1
export EDITOR=nvim
unset LC_ALL
export LANG=C.UTF-8

typeset -U PATH path
path=(
  $HOME/.local/bin
  $DOTNET_ROOT
  $DOTNET_ROOT/tools
  $HOME/.aspire/bin
  $HOME/.cargo/bin
  /home/linuxbrew/.linuxbrew/bin
  /usr/local/go/bin
  $path
)

# Secrets live in an untracked file, never in ~/dotfiles.
[[ -f ~/.secrets.zsh ]] && source ~/.secrets.zsh
