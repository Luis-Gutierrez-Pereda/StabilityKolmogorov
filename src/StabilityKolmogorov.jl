module StabilityKolmogorov

    #Dependencies on other packages
    import Flows
    import OpenKolmogorovFlow
    import DelimitedFiles
    import Statistics
    import Glob
    import Serialization
    import Random


    
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
    include("MergingHighMem.jl")
    include("PerturbationTransport.jl")
    include("mean.jl")
end
