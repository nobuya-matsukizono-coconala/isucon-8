#!/bin/bash
cd /isucon/bench
./bin/gen-initial-dataset

cd /isucon
./db/init_local.sh

