FROM mdillon/postgis:10

ADD dhis2-db.sql.gz /tmp/data/dhis2-db.sql.gz

ADD create-target-db.sh /docker-entrypoint-initdb.d/
ADD stage-dhis2-db.sh /docker-entrypoint-initdb.d/
RUN gunzip /tmp/data/dhis2-db.sql.gz

EXPOSE 5432
