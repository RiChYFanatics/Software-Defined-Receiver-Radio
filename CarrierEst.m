function EstCarrier = CarrierEst(r, f_if, fs)
    
Ts = 1/fs; 
t = 0:Ts:((length(r)*Ts)-(Ts)); 
n = round(f_if/fs);
f_nom = abs(f_if-n*fs);
f0 = f_nom;


fl = 20; ff = [0 .01 .02 1]; fa = [1 1 0 0 ];                               %LPF specifications
fh = firpm(fl,ff,fa);                                                       %LPF

mu = 0.055;                                                                 %algorithm stepsize
theta = zeros(1, length(t)); theta(1) = 0;                                   %zeros vector
zs = zeros(1,fl+1); zc = zeros(1,fl+1);                                     %initialize buffers for LPFs


EstCarrier = zeros(1, length(t));

for k=1:length(t)-1                                                         % z's contain past fl+1 inputs
  zs = [zs(2:fl+1), 2*r(k)*sin(2*pi*f0*t(k)+theta(k))];
  zc = [zc(2:fl+1), 2*r(k)*cos(2*pi*f0*t(k)+theta(k))];
  lpfs = fliplr(fh)*zs'; lpfc=fliplr(fh)*zc';                               % new output of filters
  theta(k+1) = theta(k)-mu*lpfs*lpfc;                                       % algorithm update
  
  EstCarrier(k) = cos(2*pi*f0*t(k)+theta(k));                               % vector for estimated carrier
end

figure(2),plot(t,theta);
title('Phase Tracking via the 1st Costas Loop')
xlabel('time'); ylabel('phase offset')