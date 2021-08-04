function [Kur, Skur] = New_Index(y, Fr, Fs)

HSig = abs(hilbert(y));
HSig = HSig;
Kur = kurtosis(HSig);


[ yf, ~] = Hilbert_envelope(y, Fs);
xlen = length(y);
NFFT = 2 ^ nextpow2(xlen);
N1 = round(Fr * 10 / (Fs / NFFT));
N_Interval1 = 5;
Skur = kurtosis(yf(1:N1+N_Interval1));