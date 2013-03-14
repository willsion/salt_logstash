include:
  - logstash.logstash

extend:
  logstash:
    file.managed:
      - name: /etc/logstash/conf.d/indexer.conf
      - source: salt://logstash/etc/logstash/conf.d/indexer.conf.jinja
      - user: root
      - group: adm
      - mode: 644
      - template: jinja
      - require:
        - pkg: logstash
