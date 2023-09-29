FROM ghcr.io/bdklahn/jumambar:0.4.0
ARG GITHUB_TOKEN

COPY epitainer.scif /
COPY config.json /
COPY install_common_julia_packages.jl /
COPY install_common_R_packages.R /

RUN Rscript /install_common_R_packages.R

ENV JULIA_DEPOT_PATH="/usr/local/julia/local/share/julia:$JULIA_DEPOT_PATH"
ENV JULIA_CPU_TARGET="generic;skylake-avx512,clone_all;znver2,clone_all"
RUN julia /install_julia_packages.jl

ENV JULIA_SCRATCH_TRACK_ACCESS=0

RUN mkdir -p /run/secrets

RUN --mount=type=secret,id=github_token \
    [ -s /run/secrets/github_token ] || echo $GITHUB_TOKEN > /run/secrets/github_token && \
    micromamba run --name base scif install /epitainer.scif

RUN rm -rf /run/secrets || true

ENTRYPOINT ["/usr/bin/micromamba", "run", "--name", "base", "scif"]

CMD ["shell"]