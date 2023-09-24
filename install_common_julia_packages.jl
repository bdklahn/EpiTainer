using Pkg

if occursin("--shared", ARGS) && occursin(homedir(), DEPOT_PATH[1])
    popfirst!(DEPOT_PATH)
end

"common packages which might be useful for many apps"
packages = [
    "Arrow",
    "DataFrames",
]

Pkg.add(packages)