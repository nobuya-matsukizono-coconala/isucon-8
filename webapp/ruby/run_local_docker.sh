#!/bin/bash
set -ue

export DB_DATABASE=torb
export DB_HOST=mysql
export DB_PORT=3306
export DB_USER=isucon
export DB_PASS=isucon

exec puma -p 8080 -v
