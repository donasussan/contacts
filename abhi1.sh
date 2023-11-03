#!/bin/bash

start_time=$(date +%s%3N)
count=30000
batch_size=3
nested_array=()
j=0
NAME=''
EMAILS=''
sql_query=''
activity_string=''

for ((i=1; i<=$count; i++)); do
    k=0
    flag=1
    echo $i
    name="Name$i"
    email="name$i@example.com"
    dob=$(date -d "$((RANDOM % 36525)) days ago" +%Y-%m-%d)
    country="Country$i"
    city="City$i"
    json="{\"dob\":\"$dob\",\"country\":\"$country\",\"city\":\"$city\"}"

    # sql_query+="CALL InsContacts('$name','$email','$flag','$json', @pid);"
    j=$((j+1))
    NAME+="$name,"
    EMAILS+="$email,"

    if [[ $j -gt $batch_size || $i -eq $count ]]; then
        # Remove trailing commas from NAME and EMAILS variables
        
        NAME=${NAME%,}
        EMAILS=${EMAILS%,}

        # Call the stored procedure and capture the output
      # mysql --defaults-file=~/.my.cnf -D campaign -e "CALL BatchInsertAndGetLastIDs('$NAME', '$EMAILS', '$flag');"
      sql_query+="CALL BatchInsertAndGetLastIDs('$NAME', '$EMAILS', '$flag');"
        j=0

        NAME=''
        EMAILS=''
    fi
done
mysql --defaults-file=~/.my.cnf -D campaign <<EOF
    START TRANSACTION;
    $sql_query
    COMMIT;
EOF
end_time=$(date +%s%3N)
execution_time=$((end_time - start_time))
echo "Script execution time: $execution_time milliseconds"
