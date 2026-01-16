FROM apache/jena-fuseki:5.1.0

ENV FUSEKI_BASE=/fuseki-base

COPY docker/fuseki/ttf-config.ttl /opt/ttf/ttf-config.ttl
COPY docker/fuseki/start-fuseki.sh /opt/ttf/start-fuseki.sh
COPY ontology/ttf.ttl /opt/ttf/ttf.ttl

RUN chmod +x /opt/ttf/start-fuseki.sh

EXPOSE 3030

ENTRYPOINT ["/opt/ttf/start-fuseki.sh"]
