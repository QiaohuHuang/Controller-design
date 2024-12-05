clc;clear;close all
load("A.mat");
load("B.mat");
load("C.mat");
W = [6,0,0;0,7,0;0,0,12];
X0=[1;100;200];
X_SP=[5;250;300];
% check
M = [A B;
    -C zeros(2,2)];
%rank(M)
Qc = M*[zeros(3,2) B A*B;
        eye(2)  zeros(2,2) zeros(2,2)];
%rank(Qc)
A_ba = [A zeros(3,2);-C zeros(2,2)];
B_ba = [B;zeros(2,2)];
Q_ba = [10000000	0	0	0	0;
        0	10	0	0	0;
        0	0	10	0	0;
        0	0	0	1	0;
        0	0	0	0	1];
R_ba = eye(2)*1;
T_ba = [A_ba -B_ba/R_ba*B_ba';-Q_ba -A_ba'];
[evec, eval] = eig(T_ba);
eval = sum(eval);
evec_stable = evec(:,find(real(eval)<0));
V = evec_stable(1:5,:);
%rank(V)
U = evec_stable(6:10,:);
%rank(U)
P = U/V;
K = R_ba\B_ba'*P;
K1 = K(:,1:3);
K2 = K(:,4:5);
[evec2, eval2] = eig(A-B*K1);
[evec3, eval3] = eig((A-B*K1)'*W);