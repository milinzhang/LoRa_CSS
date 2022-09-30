% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% created by milin
%
% a implementation for Chirp Spread Spectrum modulation
%
% credit to: 
%   https://github.com/tapparelj/gr-lora_sdr
%   https://github.com/rpp0/gr-lora
%   https://github.com/jkadbear/LoRaPHY
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function sig = css(bw,sf,symbol,fs,is_up)
    % LoRa CSS modulator
    %
    % input:
    %
    %   bw: bandwidth [125khz, 250khz, 500khz]
    %   sf: spreading factor [7, 8, 9, 10, 11, 12]
    %   symbol: symbol that need to be modulated
    %   fs: sampling frequency
    %   is_up: boolean flag to determine up-chirp or not
    %
    % output:
    %
    %   sig: Generated chirp
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