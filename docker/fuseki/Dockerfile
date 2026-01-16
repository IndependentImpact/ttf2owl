FROM stain/jena-fuseki:5.1.0

ENV FUSEKI_BASE=/fuseki

# Your config files
COPY docker/fuseki/ttf-config.ttl     /opt/ttf/ttf-config.ttl
COPY docker/fuseki/shiro.ini          /fuseki/shiro.ini
COPY ontology/ttf.ttl                 /opt/ttf/ttf.ttl

# Custom startup (only if really needed)
COPY docker/fuseki/start-fuseki.sh    /opt/ttf/start-fuseki.sh

USER root

RUN chmod +x /opt/ttf/start-fuseki.sh \
    && chown -R fuseki:fuseki /opt/ttf/ \
    && chown fuseki:fuseki /fuseki/shiro.ini

USER fuseki

EXPOSE 3030

# If your script just wraps the original entrypoint:
ENTRYPOINT ["/opt/ttf/start-fuseki.sh"]
