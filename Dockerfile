FROM alpine:3.9

RUN apk update && \
	apk add --no-cache \
		git python py-pip py-mysqldb alpine-sdk \
		python2-dev libffi-dev libjpeg jpeg-dev zlib-dev \
		openssl-dev libxml2-dev libxslt-dev py-cairo

RUN git clone https://github.com/concentricsky/badgr-server.git /badgr && \
	LIBRARY_PATH=/lib:/usr/lib /bin/sh -c "pip install -r /badgr/requirements.txt" 

COPY settings_local.py /badgr/apps/mainsite/settings_local.py

RUN	/badgr/manage.py migrate 


CMD /badgr/manage.py runserver
