set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

_sudo := if os_family() == "unix" { "sudo" } else { "" }

# Lists all available recipes
@default:
  just --list

# Formats all code files
format:
  just app format
  just server format

# Launches the local development environment
launch-dev-environment: (_compose-up 'compose/openems-dev')

# Stops the local development environment
stop-dev-environment: (_compose-down 'compose/openems-dev')

# Launches the dynamic DNS environment
launch-dyndns-environment: (_compose-up 'compose/openems-dyndns')

# Stops the dynamic DNS environment
stop-dyndns-environment: (_compose-down 'compose/openems-dyndns')

reset-database: stop-dev-environment
  {{_sudo}} docker volume rm openems-dev_backend_database_data || echo "volume already removed"
  {{_sudo}} docker volume rm openems-dev_keycloak_database_data || echo "volume already removed"
  {{_sudo}} docker volume rm openems-dev_lavinmq_data || echo "volume already removed"

[unix]
start-docker:
  {{_sudo}} systemctl start docker

[windows]
start-docker:
  echo "Please ensure Docker Desktop is running"

# Executes build pipeline for given target.
target *args="--help":
  dotnet run --project devops/OpenEMS.Pipeline -- {{args}}

# App commands
@app *args:
  cd 'app' && just {{ args }}

# Server commands
@server *args:
  cd 'server' && just {{ args }}

_compose-up project_dir: start-docker
  {{_sudo}} docker compose \
    --project-directory {{project_dir}} \
    up --build --detach --remove-orphans

_compose-down project_dir: start-docker
  {{_sudo}} docker compose \
    --project-directory {{project_dir}} \
    down --remove-orphans
