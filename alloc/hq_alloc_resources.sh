#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <number_of_workers> <sleep_time_in_seconds> <alloc_file>"
    exit 1
fi

N=$1
sleep_time=$2
command_to_run="sbatch $3"

echo "Desired number of workers: $N"
echo "Sleep time: $sleep_time seconds"

while true; do
    hq_worker_info=$(hq worker list)

    # Count the number of workers (non-header rows) from the table
    worker_count=$(echo "$hq_worker_info" | grep -E '^\| +[0-9]+ +\|' | wc -l)

    empty_slots=$((N - worker_count))

    if [ "$empty_slots" -gt 0 ]; then
        echo "Number of workers ($worker_count) is less than $N. Starting $empty_slots command(s)."
        # Run the specified command for each empty slot
        for ((i = 0; i < empty_slots; i++)); do
            echo "Running command $((i + 1)) of $empty_slots."
            $command_to_run
	    sleep 2
        done
	sleep $sleep_time
    else
        echo "Number of workers ($worker_count) has reached $N. Sleeping for $sleep_time seconds."
        sleep $sleep_time
    fi
done

