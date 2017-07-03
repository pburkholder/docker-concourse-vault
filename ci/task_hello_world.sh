#!/bin/sh

echo TASK: ${TASK:-value not provided by task.yml}
echo PIPE: ${PIPE:-value not provided by pipeline.yml}
echo CRED: ${CRED:-value not provided by credentials.yaml}
echo VAULT: ${VAULT:-value not provided by vault}