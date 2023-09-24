FROM ghcr.io/bdklahn/jumambar:0.1.0

COPY epitainer.scif /
COPY config.json /
COPY install_common_julia_packages.jl /
COPY install_common_R_packages.R /

RUN Rscript /install_common_R_packages.R

RUN julia /install_common_julia_packages.jl --shared

RUN --mount=type=secret,id=github_token \
    micromamba run --name base scif install /epitainer.scif

ENTRYPOINT ["/usr/bin/micromamba", "run", "--name", "base", "scif"]

CMD ["shell"]