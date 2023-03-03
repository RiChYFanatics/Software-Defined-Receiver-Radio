%DDEqualizer doesn't require training
function equalizedSignal = DDEqualizer(timerecsignal) 

f = [0 1 0 0 0 0 0 0 0 0 0 0 0 0]';
n = length(f);
m = length(timerecsignal);
mu = .0105;                                                               %stepsize

equalizedSignal = timerecsignal;
ind = 1;

for i = n+1 : m
    vecrs = timerecsignal(i:-1:i-n+1)';                                 %vector of received signal
    error = quantalph(f' * vecrs, [-3 -1 1 3]) - f' * vecrs;            %error
    f = f + mu * error * vecrs;                                         %update equalizer coefficients
    equalizedSignal(ind) = vecrs' * f;
    ind = ind + 1;
end
