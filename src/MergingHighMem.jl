export MergingHighMem

function MergingHighMem(JWaveNumber::Int,
                        KWaveNumber::Int,
                        PertMag::Float64,
                        PertTime::Int)

    total = []

    for i in 1:size(glob("tmp_*"),1)
        ave = mean(deserialize(glob("tmp_*")[i]))
        total = push!(total,ave)
    end
    total = mean(total)
    serialize("Averaged_Pert_$(PertMag)_Omega_$(KWaveNumber),$(JWaveNumber)_Time_$(PertTime)", total)
    #serialize("TransportTerm_Pert_$(PertMag)_Omega_$(KWaveNumber),$(JWaveNumber)_Time_$(PertTime)", total)
    #serialize("Diss_Pert_$(PertMag)_Omega_$(KWaveNumber),$(JWaveNumber)_Time_$(PertTime)", total)
end