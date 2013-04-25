#!pydsl

import random

shipper_hosts = __salt__['publish.publish']('role:logstash.shipper', 'grains.item', 'id', 'grain').keys()
shipper_host = random.choice(shipper_hosts)

state('rsyslog')\
    .service.running(
        enable=True,
        reload=True)\
    .watch(file='/etc/rsyslog.d/*')

config = '/etc/rsyslog.d/00-logstash.conf'
state(config)\
    .file.managed(
        source='salt://logstash/files{}'.format(config),
        user='root',
        group='root',
        mode='644',
        template='jinja',
        shipper_host=shipper_host)

state('/etc/rsyslog.d/50-default.conf').file.absent()
