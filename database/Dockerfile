FROM mdillon/postgis:10

ADD dhis2-db.sql.gz /tmp/data/dhis2-db.sql.gz
RUN gunzip /tmp/data/dhis2-db.sql.gz
ADD init-dhis2-db.sh /docker-entrypoint-initdb.d/z_init-dhis2-db.sh
ADD create-target-db.sh /docker-entrypoint-initdb.d/y_create-target-db.sh

EXPOSE 5432
