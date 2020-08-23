export PerturbationTransport

function PerturbationTransport(SetupChoice::Int,
                      JWaveNumber::Int,
                      KWaveNumber::Int,
                      PertTime::Int,
                      PertSamples::Int,
                      PertMag::Float64,
                      OneEvery::Int)

    Re, Δt, n, m = setup[SetupChoice];

     #initialize random field
     ω = Field(m, (x, y)->rand()); 
     Ω = FFT(ω, n);

    # right hand side
    f = ForwardEquation(n, m, Re)

    # and split
    N, L = splitexim(f);
    
    #stepping
    stepping = TimeStepConstant(Δt)

    # forward map
    ϕ = flow(N, L, CB3R2R3e(Ω), stepping);

    function fun(Ω)

      Φ = invlaplacian!(similar(Ω),Ω)
      v̂ = ddx!(similar(Φ), Φ)
      û = ddy!(similar(Φ), Φ)
      û = -1.0 .* û 
      u = IFFT(û)
      v = IFFT(v̂)

      dxΩ = ddx!(similar(Ω),Ω)
      dyΩ = ddy!(similar(Ω),Ω)
      dxω = IFFT(dxΩ)
      dyω = IFFT(dyΩ)
      uω .= u .* dxω
      vω .= v .* dyω

      tr .= uω .+ vω

      tr = FFT(tr,n)
    
      return tr
    end

    # Monitor definition
    mon = Monitor(Ω,(t,Ω)->fun(Ω), oneevery = OneEvery);


    #initial 50 time units to settle the turbulent flow
    ϕ(Ω, (0, 50), reset!(mon));

    #mag_pert set to 0.8 for all of the cases to ensure uniform response when averaging (magnitude to be determined)


    data =[];

    for i in 1:PertSamples
        Ω[KWaveNumber,JWaveNumber]+= PertMag;
        Ω[end-KWaveNumber+1,JWaveNumber]+= PertMag;
        ϕ(Ω, (0, PertTime), reset!(mon));
        SamplePert = copy(samples(mon));
        push!(data,cat(SamplePert...,dims=3));
    end
  
   serialize("tmp_$(rand())",data)
    
end