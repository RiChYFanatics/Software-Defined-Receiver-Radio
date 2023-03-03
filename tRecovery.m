% Time recovering performed using Dual Decision directed algorithm (clockrecDD.m)

function xs = tRecovery(signal, x)

vec = signal.SRRCLength*signal.OR;
tnow = vec +1; 
tau = 0; 
xs = zeros(1, signal.Ndata);                                                % initialize variables
tausave = zeros(1, signal.Ndata); 
tausave(1) = tau; 
i = 0;
mu = 0.05;                                                                  % algorithm stepsize
delta = 0.1;                                                                % time for derivative

while tnow < (length(x) - signal.SRRCLength * signal.OR)               % run iteration
  i = i + 1;
  xs(i) = interpsinc(x, tnow+tau, signal.SRRCLength);                       % interpolated value at tnow+tau
  x_deltap = interpsinc(x, tnow+tau+delta, signal.SRRCLength);              % get value to the right
  x_deltam = interpsinc(x, tnow+tau-delta, signal.SRRCLength);              % get value to the left
  dx = x_deltap - x_deltam;                                                 % calculate numerical derivative
  qx = quantalph(xs(i),[-3,-1,1,3]);                                        % quantize xs to nearest 4-PAM symbol
  tau = tau + mu * dx * (qx - xs(i));                                       % alg update: DD
  tnow = tnow + signal.OR; 
  tausave(i) = tau;                                                         % save for plotting
end

xs = xs(1:i);

figure(5)
subplot(2,1,1), plot(xs(1:i-2),'.')                                        % plot constellation diagram
title('constellation diagram');
ylabel('estimated symbol values')
subplot(2,1,2), plot(tausave(1:i-2))                                        % plot trajectory of tau
ylabel('offset estimates'), xlabel('iterations');
