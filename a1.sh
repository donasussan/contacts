hi() {
for ((l=1; l<=3000000; l++)); do
    flag=1
done
echo "Helllo"
}

 

start_time=$(date +%s%3N)
declare -a arrays
source ./new1.sh
count=4
batch_size=1
nested_array=()
j=0
sql_query=''
activity_string=''
for ((i=1; i<=$count; i++)); do
    k=0
    flag=1
    return=$(end_result) 
    name="Name$i"
    email="name$i@example.com"
    dob=$(date -d "$((RANDOM % 36525)) days ago" +%Y-%m-%d)
    country="Country$i"
    city="City$i"
    json="{\"dob\":\"$dob\",\"country\":\"$country\",\"city\":\"$city\"}" 
    sql_query+="CALL InsertContactAndActivity ('$name','$email',$flag,'$json','$return');"
    j=$((j+1))

 

    if [[ $j -eq $batch_size || $i -eq $count ]]; then
        # mysql --defaults-file=~/.my.cnf -D Task_mysql <<EOF
        # START TRANSACTION;
        # $sql_query
        # COMMIT;
        # EOF
       # echo $sql_query
        arrays+=("$sql_query")
        j=0
        sql_query=''
        end_time=$(date +%s%3N)
    execution_time=$((end_time - start_time))
    echo "execution time: $execution_time milliseconds"
    if [[ $i%2 -eq 0 ]]; then
        wait
        hi &
    fi
    fi
done
end_time=$(date +%s%3N)
execution_time=$((end_time - start_time))
echo "Script execution time: $execution_time milliseconds"
wait