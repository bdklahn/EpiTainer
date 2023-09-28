FROM ghcr.io/bdklahn/jumambar:0.4.0
ARG GITHUB_TOKEN

COPY epitainer.scif /
COPY config.json /
COPY install_common_julia_packages.jl /
COPY install_common_R_packages.R /

RUN Rscript /install_common_R_packages.R

RUN julia /install_common_julia_packages.jl --shared

RUN mkdir -p /run/secrets

RUN --mount=type=secret,id=github_token \
    [ -s /run/secrets/github_token ] || echo $GITHUB_TOKEN > /run/secrets/github_token && \
    micromamba run --name base scif install /epitainer.scif

RUN rm -rf /run/secrets || true

ENTRYPOINT ["/usr/bin/micromamba", "run", "--name", "base", "scif"]

CMD ["shell"]