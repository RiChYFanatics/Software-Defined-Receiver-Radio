function signal = selectSignal(select)
if(select=='A'||select=='a')
        SRRCLength=     5;
        SRRCrolloff=    0.3;
        T_t=            7.5e-6;
        f_if=           2.3e6;
        f_s=            840000;
        sig=load("mysteryA.mat");
elseif(select=='B'||select=='b')
        SRRCLength=     4;
        SRRCrolloff=    0.37;
        T_t=            9.7e-6;
        f_if=           1.68e6;
        f_s=            740000;
        sig=load("mysteryB.mat");
elseif(select=='C'||select=='c')
        SRRCLength=     6;
        SRRCrolloff=    0.2;
        T_t=            6.25e-6;
        f_if=           2.1e6;
        f_s=            920000;
        sig=load("mysteryC.mat");
end

signal.r = sig.r';
signal.fs = f_s;
signal.Ts = 1/f_s;
signal.SRRCLength = SRRCLength;
signal.SRRCrolloff = SRRCrolloff;
signal.T_t = T_t;
signal.f_if = f_if;
signal.t = 0:signal.Ts:((length(signal.r)*signal.Ts)-(signal.Ts)); 
signal.OR = signal.fs*signal.T_t;
signal.Ndata = length(signal.r); 
%signal.headerstart = 0;