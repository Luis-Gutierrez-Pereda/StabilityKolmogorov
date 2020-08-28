export MergingFiles

function MergingFiles(SetupChoice::Int,
                      JWaveNumber::Int,
                      KWaveNumber::Int,
                      PertMag::Float64,
                      PertTime::Int)

     total = [];
     mean_std = [];

    for i in 1:size(glob("tmp_*"),1)         
        if i==1
            ind = deserialize(glob("tmp_*")[i]);
            total = ind;
        else
            ind = deserialize(glob("tmp_*")[i]);
            total = vcat(total,ind);
        end
    end

    mean_std = vcat(mean(total), std(total) ./ sqrt(size(glob("tmp_*")[1],3)))
 

    serialize("TransportTerm_Pert_$(PertMag)_Omega_$(KWaveNumber),$(JWaveNumber)_Time_$(PertTime)", mean_std)
end