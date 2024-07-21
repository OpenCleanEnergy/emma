
# Lists all available recipes
@default:
  just --list

# Formats all code files
format:
  just app format
  just server format

# Launches the local development environment
launch-dev-environment: (_compose-up 'compose/emma-dev')

# Stops the local development environment
stop-dev-environment: (_compose-down 'compose/emma-dev')

# Launches the dynamic DNS environment
launch-dyndns-environment: (_compose-up 'compose/emma-dyndns')

# Stops the dynamic DNS environment
stop-dyndns-environment: (_compose-down 'compose/emma-dyndns')

reset-database: stop-dev-environment
  sudo docker volume rm emma-dev_backend_database_data || echo "volume already removed"
  sudo docker volume rm emma-dev_keycloak_database_data || echo "volume already removed"
  sudo docker volume rm emma-dev_lavinmq_data || echo "volume already removed"

start-docker:
  sudo systemctl start docker

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
  sudo docker compose \
    --project-directory {{project_dir}} \
    up --build --detach --remove-orphans

_compose-down project_dir: start-docker
  sudo docker compose \
    --project-directory {{project_dir}} \
    down --remove-orphans
