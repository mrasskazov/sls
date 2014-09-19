mysql-server:
  pkg:
    - installed
    - pkgs:
      - mysql-server
      - python-mysqldb
    - refresh: True
  service:
    - running
    - name: mysql
    - reload: True
    - require:
      - pkg: mysql-server
    - watch:
      - file: /etc/mysql/my.cnf
  mysql_user:
    - present
    - name: root
    - password: 'try_it'
    #- password_hash: '*C578C5DBE343282D6C2CCCD97897739FCB3DE0AB'
    #- host: '%'
    - require:
      - service: mysql
  file.sed:
    - name: /etc/mysql/my.cnf
    - before: '=.*'
    - after: '= 127.0.0.1'
    - limit: 'bind-address'
    - require:
      - pkg: mysql-server
/etc/mysql/my.cnf:
  file:
    - uncomment
    - char: '#'
    - regex: 'bind-address'
    - require:
      - pkg: mysql-server
