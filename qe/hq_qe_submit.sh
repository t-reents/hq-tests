#!/bin/bash
#HQ --name="test-qe"
#HQ --stdout=_scheduler-stdout.txt
#HQ --stderr=_scheduler-stderr.txt
#HQ --time-limit=3600s
#HQ --cpus=288


echo '{}' | jq '.control = {verbosity: 1}' > sirius.json

_wp=/capstor/scratch/cscs/simonpi/uenv-images/wrapper.sh

"srun" -u "-n" "4" "--mem" "250000" "--cpu-bind=socket" ${_wp} '/user-environment/env/default/bin/pw.x' '-sirius_cfg' 'sirius.json' '-npool' '4' '-in' 'aiida.in'  > "aiida.out"
