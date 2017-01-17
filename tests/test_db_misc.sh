. "${FUNCTIONS}"
. "${ACTIVATE_SH}"

# Hashing
echo 'echo a' > env
patterntest 'autoenv_hash env' '^fe08476cb37197e892beb9d781aada5a340aefb0$'

# Midnight commander
AUTOENV_ENV_FILE="$(pwd)/env"
MC_SID=99
mkdir a
echo 'echo a' > "$(pwd)/a/.env"
patterntest 'cd a' '^$'
