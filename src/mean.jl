export mean

function mean()
    Re, Δt, n, m = setup[1]
    ω = Field(m, (x, y)->rand()); 
    Ω = FFT(ω, n);

    f = ForwardEquation(n, m, Re)
    N, L = splitexim(f)
    stepping = TimeStepConstant(Δt)
    ϕ = flow(N, L, CB3R2R3e(Ω), stepping)
    mon = Monitor(Ω, (t,Ω)->Ω.data[1:5,1:5]; oneevery=10)

    ϕ(Ω, (0, 50000),reset!(mon))
    
    Ω_mean = mean(samples(mon))
    Ω_unc = std(samples(mon)) ./ sqrt(5000000)

    data = []

    push!(data,Ω_mean)
    push!(data,Ω_unc)

    serialize("mean_turbulent_flow",data)
end
