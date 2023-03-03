clc;

select = input('Select signal A, B or C:\n','s');                           %select one of the signals
signal = selectSignal(select);                                              %function to load signal into workspace
figure(1), plotspec(signal.r, signal.Ts);

EstCarrier = CarrierEst(signal.r, signal.f_if, signal.fs);                  %perform carrier estimation
demodsig = signal.r.*EstCarrier;                                            %demodulation done by multiplying the signal with the est car
figure(3), plotspec(demodsig,signal.Ts);

srrcfilt = srrc(signal.SRRCLength,signal.SRRCrolloff,signal.OR);            %Sqrt raised cosine filter
sigshaped = filter(fliplr(srrcfilt),1,demodsig);                            %convolve time reversed srrc filter with the demod signal
figure(4), plotspec(sigshaped,signal.Ts), title('Signal after matched filter');

timerecsig = tRecovery(signal, sigshaped); 
equalizedsig = DDEqualizer(timerecsig);

figure(6), 
subplot(2, 1, 1), plot(timerecsig, 'b.') 
title('Time Recovery Constellation Diagram');
subplot(2, 1, 2), plot(equalizedsig, 'b.') 
title('Equalizer Constellation Diagram');


preamble = letters2pam('A0Oh well whatever Nevermind');
framesyncsig = startFrame(preamble, equalizedsig);


mprime=quantalph(equalizedsig,[-3,-1,1,3])';                                % quantize to +/-1 and +/-3 alphabet

% decode decision device output to text string
reconstructed_message=pam2letters(mprime);                                  % reconstruct message
disp(reconstructed_message);

