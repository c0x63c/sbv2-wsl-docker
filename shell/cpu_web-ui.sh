#!/bin/sh
export SBV2_START_CMD="python app.py"
docker compose --file docker-compose.cpu.yaml up service
