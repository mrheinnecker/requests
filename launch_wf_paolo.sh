#!/usr/bin/env bash
set -euo pipefail

WF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

nextflow run "${WF_DIR}/main.nf" \
    -c "${WF_DIR}/nextflow.config" \
    -resume \
    -with-report "${WF_DIR}/nextflow_report.html" \
    -with-trace "${WF_DIR}/nextflow_trace.txt" \
    -with-timeline "${WF_DIR}/nextflow_timeline.html" \
    "$@"
