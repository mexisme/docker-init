FROM base:init

COPY --chown=app:app config/test/ /app/monit/
CMD /usr/bin/monit
