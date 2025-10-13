FROM aandree5/gui-web-base:latest

USER root

RUN apt-get update && apt-get install -y \
    picard  \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER guiwebuser

CMD ["start", "picard"]
