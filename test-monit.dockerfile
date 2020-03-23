ARG PARENT=alpine
FROM init:$PARENT

COPY --chown=app:app config/test/ /app/monit/
CMD /usr/bin/monit
