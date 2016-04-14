#!/bin/bash
envtpl /etc/telegraf/telegraf.conf.tpl
/opt/go/bin/telegraf -config /etc/telegraf/telegraf.conf
