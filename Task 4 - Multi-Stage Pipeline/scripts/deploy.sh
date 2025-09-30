#!/bin/bash

PARAM_FILE=$1

echo "Using parameters file: $PARAM_FILE"

eval $(python3 -c "import yaml, sys; f = open('$PARAM_FILE'); y = yaml.safe_load(f); print('\n'.join([f'{k}={v}' for k,v in y['variables'].items()]))")

echo "Deploying application $app_name to $environment"
echo "Replica count: $replica_count"
echo "Image tag: $image_tag"
