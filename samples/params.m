clear
clc
load("222m.mat");
 
% Timing Parameters
V1 = zeros(100000, 1);  % Increased the size to match the loop length
Fs = 100;
L = length(val(1, :))*100;
t = linspace(0, L-1, L) / Fs;
 
% Plotting ecg signal
ECG = val(1, :);
figure;
plot(ECG, 'DisplayName', 'Unfiltered');
title('ECG Signal');
xlim([0 3600]);
 
% Parameters for the leaky integrate-and-fire model
C = 104 / 10^12;
gL = 4.3 / 10^12;
EL = -65 / 1000;
Vt = -52 / 1000;
delta_T = 0.8 / 1000;
Tw = 88 / 1000;
a = -0.8 / 10^9;
b = 65/ 10^9;
dt = 1 / 10000;
t1 = 1:1001;
 
% Initial conditions
K1 = 1000;
I = (ECG*100);
V1(1) = EL;
W1(1) = K1 * b;
spikes(1) = 1;
dv1 = 0;
E = 0;
e = exp((EL - Vt) / delta_T);
pos_spikes(1) = 0;
neg_spikes(1) = 0;
% Leaky integrate-and-fire model
for i = 1:length(t)-1
    if V1(i) > Vt
        V1(i + 1) = EL;
        W1(i + 1) = W1(i) + K1 * b;
        V1(i) = 0;
        dv1 = 0;
        e = exp((EL - Vt) / delta_T);
        spikes(i + 1) = 1;
        if(I(floor(i/100)+1)>0)%Shd this be zero or Vt?
            pos_spikes(i+1) = 1;
            neg_spikes(i+1) = 0;
        else
            pos_spikes(i+1) = 0;
            neg_spikes(i+1) = 1;
        end
    else
        E = (e / 2^21) + (e * dv1 / 2^12) + (e * dv1 * dv1 * 2^3);
        VP = V1(i);
        if i + 1 <= length(t)
            V1(i + 1) = V1(i) - ((V1(i) - EL) / 2^12) + E + I(floor(i/100)+1) - W1(i);
            dv1 = V1(i + 1) - V1(i);
        end
        W1(i + 1) = W1(i) - (W1(i) / 2^14);
        e = E * 2^21;
        spikes(i + 1) = 0;
        pos_spikes(i+1) = 0;
        neg_spikes(i+1) = 0;
    end
    cur(i) = I(floor(i/100)+1);
end
 
% Spike detection
spike1 = abs(spikes);
  
figure;
yyaxis left;
stairs(pos_spikes, 'r');
hold on;
%stairs(neg_spikes, 'b');
yyaxis right;
plot(cur, 'k');


a1 = round(abs(log2((dt/C)*gL)))
a2 = round(abs(log2((dt/C)*gL*delta_T)))
b1 = round(abs(log2((dt/Tw)*a*K1)))
b2 = round(abs(log2(dt/Tw)))
c = round(abs(log2(1/delta_T)))
d = round(abs(log2(dt/(C*K1))))