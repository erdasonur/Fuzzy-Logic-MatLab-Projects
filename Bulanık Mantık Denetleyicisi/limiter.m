function E=limiter(EMIN,EMAX,ee)
    if ee>=EMAX
        E=EMAX;
    elseif ee<=EMIN
        E=EMIN;
    else
        E=ee;
    end
end