module StabilityKolmogorov

    #Dependencies on other packages
    import Flows
    import OpenKolmogorovFlow
    import DelimitedFiles
    import Statistics
    import Glob
    import Serialization
    import Random

    #including 
    include("setup.jl")
    #include("initial_iterations.jl")
    # include("no_perturbation.jl")
    include("Perturbation.jl")
    include("MergingFiles.jl")
end
