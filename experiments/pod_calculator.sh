#!/bin/bash -e

WORKER_LABEL="node-role.kubernetes.io/worker"
PODS_PER_CORE=25
PODS_PER_ITERATION=5

log() {
  echo -e "\033[1m$(date "+%d-%m-%YT%H:%M:%S") ${@}\033[0m"
}

ncores() {
for c in $(oc get node -l ${WORKER_LABEL} -o go-template --template='{{ range .items}}{{ .status.capacity.cpu }}{{"\n"}}{{ end }}'); do 
  let n_cpus=c+n_cpus
 done
}

ncores
log "Number of cores: ${n_cpus}"
PODS_TOTAL=$((n_cpus*PODS_PER_CORE))
log "Total number of pods: ${PODS_TOTAL}"
iterations=$((PODS_TOTAL/PODS_PER_ITERATION))
log "Total number of iterations: ${iterations}"

