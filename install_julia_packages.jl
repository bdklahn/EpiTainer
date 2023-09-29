using Pkg

"common packages which might be useful for many apps"
const common_packages = [
    "Arrow",
    "CSV",
    "DataFrames",
]

isempty(ARGS) ? packages = common_packages : packages = ARGS

Pkg.add(packages)

Pkg.precompile()