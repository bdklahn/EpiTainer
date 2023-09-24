using Pkg

if "--shared" in ARGS && occursin(homedir(), DEPOT_PATH[1])
    println("popping: ", popfirst!(DEPOT_PATH))
end

"common packages which might be useful for many apps"
packages = [
    "Arrow",
    "DataFrames",
]

Pkg.add(packages)
Pkg.precompile()

using packages...
