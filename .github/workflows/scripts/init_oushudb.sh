#!/bin/bash
set -e



# Install
brew tap chiyang10000/homebrew-tap
brew search chiyang10000
brew install oushudb

# Configure
tee /usr/local/opt/oushudb/etc/hawq-site.xml << EOF
<configuration>
    <property>
        <name>hawq_dfs_url</name>
        <value>localhost:8020/hawq_default</value>
        <description>URL for accessing HDFS.</description>
    </property>
    <property>
        <name>hawq_master_address_host</name>
        <value>localhost</value>
    </property>
    <property>
        <name>hawq_master_address_port</name>
        <value>5432</value>
    </property>
    <property>
        <name>hawq_segment_address_port</name>
        <value>40000</value>
    </property>
    <property>
        <name>hawq_master_directory</name>
        <value>/tmp/db_data/hawq-data-directory/masterdd</value>
    </property>
    <property>
        <name>hawq_segment_directory</name>
        <value>/tmp/db_data/hawq-data-directory/segmentdd</value>
    </property>
    <property>
        <name>hawq_master_temp_directory</name>
        <value>/tmp</value>
    </property>
    <property>
        <name>hawq_segment_temp_directory</name>
        <value>/tmp</value>
    </property>
    <property>
        <name>hawq_magma_port_master</name>
        <value>50000</value>
    </property>
    <property>
        <name>hawq_magma_port_segment</name>
        <value>50005</value>
    </property>
    <property>
        <name>hawq_magma_locations_master</name>
        <value>file:///tmp/db_data/hawq-data-directory/magma_master</value>
    </property>
    <property>
        <name>hawq_magma_locations_segment</name>
        <value>file:///tmp/db_data/hawq-data-directory/magma_segment</value>
    </property>
    <property>
        <name>hawq_init_with_hdfs</name>
        <value>true</value>
        <description>choose whether initing hawq cluster with hdfs</description>
    </property>
    <property>
        <name>default_table_format</name>
        <value>appendonly</value>
        <description>default table format when creating table </description>
    </property>
</configuration>
EOF

# Initialize
rm -rf /opt/dependency*
rm -rf /tmp/db_data/hawq-data-directory
install -d /tmp/db_data/hawq-data-directory/masterdd
install -d /tmp/db_data/hawq-data-directory/segmentdd
install -d /tmp/db_data/hawq-data-directory/magma_master
install -d /tmp/db_data/hawq-data-directory/magma_segment
source /usr/local/opt/oushudb/greenplum_path.sh
hawq init cluster -a
