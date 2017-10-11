#!/bin/bash

# local ip address
ipaddr=$(hostname -i | awk ' { print $1 } ')

cat > /etc/mysql/conf.d/group_replication.cnf << EOF
[mysqld]
server_id=${SERVER_ID}
gtid_mode=ON
enforce_gtid_consistency=ON
master_info_repository=TABLE
relay_log_info_repository=TABLE
binlog_checksum=NONE
log_slave_updates=ON
log_bin=binlog
binlog_format=ROW

transaction_write_set_extraction=XXHASH64
loose-group_replication_group_name="aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
loose-group_replication_start_on_boot=off
loose-group_replication_local_address=${ipaddr}:${GROUP_REPLICATION_PORT}
loose-group_replication_group_seeds=${GROUP_REPLICATION_SEEDS}
loose-group_replication_bootstrap_group= off
loose-group_replication_single_primary_mode=off
loose-group_replication_enforce_update_everywhere_checks=on
EOF

cat >/docker-entrypoint-initdb.d/init_group_replication.sh  <<'EOF'
#!/bin/bash
mysql_upgrade -uroot -p${MYSQL_ROOT_PASSWORD}
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "\
    SET SQL_LOG_BIN=0; \
    CREATE USER rpl_user@'%' IDENTIFIED BY 'rpl_pass'; \
    GRANT REPLICATION SLAVE ON *.* TO rpl_user@'%'; \
    FLUSH PRIVILEGES; \
    SET SQL_LOG_BIN=1; \
    CHANGE MASTER TO MASTER_USER='rpl_user', MASTER_PASSWORD='rpl_pass' FOR CHANNEL 'group_replication_recovery'; \
    INSTALL PLUGIN group_replication SONAME 'group_replication.so'; \
"
EOF

exec docker-entrypoint.sh "$@"