DESCRIPTION=$2
ENVIRONMENT=$3


function ok() {
    if [[ $3 = 'external' ]]; then
      mongo --quiet --port 27018 monitoring --eval 'db.checks.update({name: "'"$2"'"}, {name: "'"$2"'", status: 0}, { upsert: true })'
    fi
    echo -n "OK - "$1
    exit 0
}

function warning() {
    if [[ $3 = 'external' ]]; then
      mongo --quiet --port 27018 monitoring --eval 'db.checks.update({name: "'"$2"'"}, {name: "'"$2"'", status: 1}, { upsert: true })'
    fi
    echo -n "WARNING - "$1
    exit 1
}

function fail() {
    if [[ $3 = 'external' ]]; then
      mongo --quiet --port 27018 monitoring --eval 'db.checks.update({name: "'"$2"'"}, {name: "'"$2"'", status: 2}, { upsert: true })'
    fi
    echo -n "CRITICAL - "$1
    exit 2
}
