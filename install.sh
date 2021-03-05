#!/bin/bash
set -e # everything must succeed.

if [ -e requirements.lock ]; then
    # just delete the .lock file when you want to recreate it
    . mkvenv.sh
    source venv/bin/activate
    pip install -r requirements.lock
else
    rm -rf venv/
    . mkvenv.sh
    source venv/bin/activate
    pip install -r requirements.txt
    echo "locking..."
    pip freeze > requirements.lock
    echo "wrote 'requirements.lock'"
fi

# Clean and re-install node.js dependencies
rm -rf node_modules/
npm install

NEW_RELIC_EXTENSIONS=false pip install --no-binary :all: newrelic==2.82.0.62
