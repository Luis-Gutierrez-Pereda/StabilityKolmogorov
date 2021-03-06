export Perturbation

function Perturbation(SetupChoice::Int,
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

    # Monitor definition
    mon = Monitor(Ω,(t,Ω)->copy(Ω.data), oneevery = OneEvery);


    #initial 50 time units to settle the turbulent flow
    ϕ(Ω, (0, 50), reset!(mon));

    #mag_pert set to 0.8 for all of the cases to ensure uniform response when averaging (magnitude to be determined)


    data =[];

    for i in 1:PertSamples

        #Ω[KWaveNumber,JWaveNumber]+= PertMag;
        #Ω[end-KWaveNumber+1,JWaveNumber]+= PertMag;

        Ω[0,1] += 0.8
        Ω[0,2] += 0.6
        Ω[0,3] += 0.9
        Ω[1,0] += 0.7
        Ω[end,0] += 0.7
        Ω[2,0] += 0.8
        Ω[end-1,0] += 0.8
        Ω[3,0] += 1
        Ω[end-2,0] += 1

        ϕ(Ω, (0, PertTime), reset!(mon));
        SamplePert = copy(samples(mon));
        push!(data,cat(SamplePert...,dims=3));
    end
  
   serialize("tmp_$(rand())",data)
    
end