clc;clear;close all

load("A.mat");
load("B.mat");
load("C.mat");

% Q = [100,0,0;0,100,0;0,0,100];
% R = [1,0;0,1];

Q = [1,0,0;0,12,0;0,0,10];
R = [1,0;0,1];

T = [A -B/R*B';
     -Q -A'];

[evec, eval] = eig(T);
eval = sum(eval);
evec_stable = evec(:,find(real(eval)<0));
V = evec_stable(1:3,:);
U = evec_stable(4:6,:);
P = U/V;

K = R\B'*P;

