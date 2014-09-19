include:
  - mysql/server

gerrit_db:
  mysql_database.present:
    - name: reviewdb
    - connection_user: root
    - connection_pass: try_it
  require:
    - service: mysql

gerrit_db_user:
  mysql_user.present:
    - name: gerrit2
    - password: 'secret'
    #- password_hash: ''
    #- host: '%'
    - connection_user: root
    - connection_pass: try_it
  require:
    - service: mysql

gerrit_db_grants:
  mysql_grants.present:
    - grant: all privileges
    - user: gerrit2
    - database: 'reviewdb.*'
    - connection_user: root
    - connection_pass: try_it
    - require:
      - mysql_user: gerrit_db_user
      - mysql_database: gerrit_db



