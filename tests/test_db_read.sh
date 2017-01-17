. "${FUNCTIONS}"
. "${ACTIVATE_SH}"

# Create database
echo "
# Comment

# Old syntax
$(pwd)/a/.env:fe08476cb37197e892beb9d781aada5a340aefb0
$(pwd)/b/.env:INVALID

# New syntax
y:$(pwd)/c/.env:fe08476cb37197e892beb9d781aada5a340aefb0
n:$(pwd)/d/.env:fe08476cb37197e892beb9d781aada5a340aefb0
y:$(pwd)/e/.env:SKIP
n:$(pwd)/f/.env:SKIP
y:$(pwd)/g/.env:INVALID
n:$(pwd)/h/.env:INVALID
" > db
AUTOENV_AUTH_FILE="$(pwd)/db"
export AUTOENV_AUTH_FILE

# Create directories
mkdir -pv a b c d e f g h
# Create env files
echo 'echo a' | tee a/.env | tee b/.env | tee c/.env | tee d/.env | tee e/.env | tee f/.env | tee g/.env > h/.env

# Old syntax
patterntest 'cd a' '^a$'
patterntest 'echo n | cd b' 'autoenv:'

# New syntax

# Exact hash
patterntest 'cd c' '^a$'
patterntest 'cd d' '^$'
# No hash
patterntest 'cd e' '^a$'
patterntest 'cd f' '^$'
# Invalid hash
patterntest 'echo | cd g' 'autoenv:'
patterntest 'echo | cd h' 'autoenv:'
