module StabilityKolmogorov

    #Dependencies on other packages
    using Flows
    using OpenKolmogorovFlow
    using DelimitedFiles
    using Statistics
    using Glob
    using Serialization
    using Random

    include("setup.jl")
    include("Perturbation.jl")
    include("MergingFiles.jl")
end
