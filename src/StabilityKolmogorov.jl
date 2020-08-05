module StabilityKolmogorov

    #Dependencies on other packages
    import Flows
    import OpenKolmogorovFlow
    import DelimitedFiles
    import Statistics
    import Glob
    import Serialization
    import Random

    include("setup.jl")
    include("Perturbation.jl")
    include("MergingFiles.jl")
end
