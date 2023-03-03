function framesyncsig = startFrame(preamble, signal)



y = xcorr(preamble, signal);                                           %create corralation vector
%y = abs(y);
[m,ind]=max(abs(y));
headstart=length(y)-ind+1;          % place where header starts
headstart = mod(headstart, (112+400));
framesyncsig =y(headstart+112:end);

figure(7),
subplot(3,1,1), stem(preamble)             % plot header
title('Header')
subplot(3,1,2), stem(signal)               % plot data sequence
title('Data with embedded header')
subplot(3,1,3), stem(y)                % plot correlation
title('Correlation of header with data')