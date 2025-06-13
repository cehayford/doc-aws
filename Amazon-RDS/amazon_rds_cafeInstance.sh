# create a backup for the rds instance
mysqldump --user=root --password='Re:Start!9' \
--databases cafe_db --add-drop-database > cafedb-backup.sql


# review the backup file
less cafedb-backup.sql

# creates a MySQL connection to the Amazon RDS instance
mysql --user=root --password='Re:Start!9' \
--host="cafedbinstance.c0aqnonbhq7h.us-west-2.rds.amazonaws.com" \
< cafedb-backup.sql


mysql --user=root --password='Re:Start!9' \
--host="cafedbinstance.c0aqnonbhq7h.us-west-2.rds.amazonaws.com" \
cafe_db


