gerrit_war:
  file.managed:
    - name: /tmp/gerrit.war
    - source: https://gerrit-releases.storage.googleapis.com/gerrit-2.9.1.war
    - source_hash: md5=4b5250945957237a795aa4265ba3bc4a

gerrit2:
  user.present:
    - name: gerrit2
    #- home: /home/gerrit2
    #- createhome: True
    #- shell: /bin/bash

site_init:
    cmd.run:
        - name: 'sudo -i -u gerrit2 java -jar /tmp/gerrit.war init
--batch --no-auto-start -d /home/gerrit2/gerrit
--install-plugin commit-message-length-validator
--install-plugin download-commands
--install-plugin replication
--install-plugin reviewnotes
--install-plugin singleusergroup'

    require:
      - user: gerrit2
      - file: gerrit_war
      - pkg: oracle-java7-installer
