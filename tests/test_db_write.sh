. "${FUNCTIONS}"
. "${ACTIVATE_SH}"

AUTOENV_AUTH_FILE="$(pwd)/db"
export AUTOENV_AUTH_FILE
wd="$(pwd)"

mkdir a
echo 'echo a' > a/.env

# Write nothing
echo n | cd a
builtin cd "${wd}"
patterntest 'cat db' '^$'

# Write allowed
echo y | cd a
\command -v chdir >/dev/null 2>&1 && \chdir "${wd}" || builtin cd "${wd}"
patterntest 'cat db' "^y:$(pwd)/a/.env:fe08476cb37197e892beb9d781aada5a340aefb0"

# Overwrite
echo 'echo b' > a/.env
echo "$(pwd)/a/.env:SOME-HASH
y:$(pwd)/a/.env:SOME-HASH
n:$(pwd)/a/.env:SOME-HASH" > db
echo y | cd a
\command -v chdir >/dev/null 2>&1 && \chdir "${wd}" || builtin cd "${wd}"
patterntest 'cat db' "^y:$(pwd)/a/.env:8e250c53c160f73e21783f0abd3603d1dc222615$"
