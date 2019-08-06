#!/bin/sh

echo "CREATE DATABASE IF NOT EXISTS \`rag_log_test\` ;" | "${mysql[@]}"
echo "GRANT ALL ON \`rag_log_test\`.* TO '"$MYSQL_USER"'@'%' ;" | "${mysql[@]}"
echo 'FLUSH PRIVILEGES ;' | "${mysql[@]}"
