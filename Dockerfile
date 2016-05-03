FROM jolokia/alpine-jre-8
MAINTAINER Jesue Junior <jesuesousa@gmail.com>

# Set environment variables
ENV LOGSTASH_NAME logstash
ENV LOGSTASH_VERSION 2.3.1
ENV LOGSTASH_URL https://download.elastic.co/$LOGSTASH_NAME/$LOGSTASH_NAME/$LOGSTASH_NAME-$LOGSTASH_VERSION.tar.gz
ENV LOGSTASH_CONFIG /opt/$LOGSTASH_NAME/logstash.conf

ADD $LOGSTASH_URL /tmp

RUN apk update \
    && apk add bash openssl \
    && mkdir -p /opt \
    && tar xzf /tmp/$LOGSTASH_NAME-$LOGSTASH_VERSION.tar.gz -C /opt/ \
    && ln -sf /opt/$LOGSTASH_NAME-$LOGSTASH_VERSION /opt/$LOGSTASH_NAME \
    && rm -rf /tmp/*.tar.gz /var/cache/apk/* \
    && mkdir -p /opt/$LOGSTASH_NAME/patterns \
    && /opt/$LOGSTASH_NAME/bin/logstash-plugin install logstash-input-log4j logstash-input-lumberjack \
	 logstash-input-tcp logstash-input-udp logstash-output-elasticsearch logstash-codec-rubydebug logstash-input-beats \
	 logstash-filter-grok

# Add logstash config file
COPY conf/logstash.conf /opt/$LOGSTASH_NAME/logstash.conf
COPY patterns/* /opt/$LOGSTASH_NAME/patterns/

EXPOSE 28776 28777 28778 28779

WORKDIR /opt/$LOGSTASH_NAME

CMD /opt/$LOGSTASH_NAME/bin/logstash -f $LOGSTASH_CONFIG