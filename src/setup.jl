# setup
Res = Float64[40,    60,     80,   100];
ms  =        [49,    71,     79,    89];
Δts =        [ 0.010,   0.01,  0.0075,  0.005];
ns  = down_dealias_size.(ms);
setup = [(Res[i], Δts[i], ns[i], ms[i]) for i = 1:4];