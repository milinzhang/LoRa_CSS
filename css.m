function sig = css(bw,sf,symbol,fs,is_up)
    M = 2^sf;
    T = M/bw;
    if is_up
        k = bw/T;
        f_init = -bw/2;
        f_offset = bw*symbol/M;
    else
        k = -bw/T;
        f_init = bw/2;
        f_offset = -bw*symbol/M;
    end
    t1 = (0:(M-symbol)*(fs/bw))/fs;
    s1 = exp(1j*2*pi*(t1.*(0.5*k*t1+f_init+f_offset)));
    phi = angle(s1(-1));
    t2 = (0:symbol*(fs/bw)-1)/fs;
    s2 = exp(1j*(phi + 2*pi*(t2.*(0.5*k*t2+f_init))));

    sig = cat(2, s1(1:snum-1), s2).';

end