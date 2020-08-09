export MergingHighMem

function MergingHighMem(JWaveNumber::Int,
                        KWaveNumber::Int,
                        PertMag::Float64,
                        PertTime::Int)

    total = []

    for i in 1:size(glob("tmp_*"),1)
        ave = mean(deserialize(glob("tmp_*")[i]))
        total = vcat(total,ave)
    end
    serialize("Averaged_Pert_$(PertMag)_Omega_$(KWaveNumber),$(JWaveNumber)_Time_$(PertTime)", mean(total))
end