# Firebird Dockerfile

[![Docker Pulls](https://img.shields.io/docker/pulls/almeida/firebird.svg)](https://hub.docker.com/r/almeida/firebird/)
[![Docker Stars](https://img.shields.io/docker/stars/almeida/firebird.svg)](https://hub.docker.com/r/almeida/firebird/)

## Description

Firebird 1.5.6 SuperServer

### Provides

  Firebird SQL relational database (http://www.firebirdsql.org/).

### Volumes

 * /backup
 * /data

### Exposed Ports

 * 3050

### Firebird credentials

 * Username: SYSDBA
 * Password: masterkey

## Run

	$ docker run -d \
		--name firebird \	
		-p 3050:3050 \
		-v /somehostdir/firebird/backup/:/backup/ \
		-v /somehostdir/firebird/data/:/data/ \
		almeida/firebird

## Misc

### Restore backup

	//enter container console
	$ docker exec -i -t firebird /bin/bash

    //backup
    $ gbak -c -v -user SYSDBA -password masterkey localhost:/data/dbname.fdb /backup/dbname.fbk 

	//restore 
	$ gbak -c -v -user SYSDBA -password masterkey /backup/dbname.fbk localhost:/data/dbname.fdb