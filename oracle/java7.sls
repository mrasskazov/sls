web8upd-repo-key-install:
    cmd.run:
        - name: 'apt-key adv --keyserver keys.gnupg.net --recv-keys EEA14886'
        - until: 'apt-key list | grep -q EEA14886'

web8upd-java-repo:
    pkgrepo.managed:
        - humanname: web8upd-java
        - name: deb http://ppa.launchpad.net/webupd8team/java/ubuntu {{ grains['oscodename'] }} main
        - require_in:
            - pkg: oracle-java7-installer
        - required:
            - cmd: web8upd-repo-key-install

oracle-license:
    cmd.run:
        - name: 'echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections'
        - until: 'debconf-get-selections | grep -qE "^oracle-jdk7-installer\s*shared/accepted-oracle-license-v1-1.*true$"'

java7-pkg:
    pkg.installed:
        - name: oracle-java7-installer
        - refresh: true
        - required:
            - pkgrepo: web8upd-java-repo
            - cmd: oracle-license
