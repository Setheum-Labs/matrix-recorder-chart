#!/bin/bash

source /scripts/common.sh
source /scripts/bootstrap-helm.sh


run_tests() {
    echo Running tests...
    wait_pod_ready matrix-recorder-0 default 2/2
}

teardown() {
    helm delete matrix-recorder
}

main(){
    if [ -z "$KEEP_W3F_MATRIX_REC" ]; then
        trap teardown EXIT
    fi

    /scripts/build-helm.sh \
        --set baseUrl="${BASE_URL}" \
        --set accessToken="${W3F_BACKUPBOT_ACCESS_TOKEN}" \
        --set deviceId="${W3F_BACKUPBOT_DEVICE_ID}" \
        --set userId="${W3F_BACKUPBOT_USER_ID}" \
        matrix-recorder \
        ./charts/matrix-recorder

    run_tests
}

main
