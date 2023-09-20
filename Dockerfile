FROM ghcr.io/bdklahn/jumambar:0.1.0

COPY epitainer.scif /

RUN micromamba run --name base scif install /epitainer.scif

ENTRYPOINT ["/usr/bin/micromamba", "run", "--name", "base", "scif"]

CMD ["shell"]