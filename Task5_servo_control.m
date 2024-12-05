clc;clear;close all
load("A.mat");
load("B.mat");
load("C.mat");
syms x11 x12 x13 x21 x22 x23;
% M = [A B;-C [0,0;0,0]];
% rank(M)
% Qc = M*[zeros(3,2) B A*B;eye(2)  zeros(2,2) zeros(2,2)];
% rank(Qc)
A_ba = [A zeros(3,2);-C zeros(2,2)];
B_ba = [B;zeros(2,2)];
Bw_ba = [B;zeros(2,2)];
Br_ba = [zeros(3,2);eye(2,2)];
Q_ba = [1	0	0	0	0;
        0	12	0	0	0;
        0	0	10	0	0;
        0	0	0	1	0;
        0	0	0	0	1];
R_ba = eye(2)*1;
T_ba = [A_ba -B_ba/R_ba*B_ba';-Q_ba -A_ba'];
[evec, eval] = eig(T_ba);
eval = sum(eval);
evec_stable = evec(:,find(real(eval)<0));
V = evec_stable(1:5,:);
U = evec_stable(6:10,:);
P = U/V;
K = R_ba\B_ba'*P;
K1 = K(:,1:3);
K2 = K(:,4:5);
Wc = [C', A'*C', A'*A'*C'];
X = [Wc(:,1), Wc(:,2), Wc(:,3)];
X_1 = inv(X);
d1 = 2;
d2 = 1;
T = [X_1(d1,:).', X_1(d1+d2,:).',(X_1(d1+d2,:)*A).'].';
A_bar = T*A'/T;
B_bar = T*C';
Ad = [-10	2962	1840;0	-158.1	-92;0	233.60	135.1];
A_bar(abs(A_bar) < 1e-5) = 0;
B_bar(abs(B_bar) < 1e-5) = 0;
x = [x11,x12,x13;x21,x22,x23];
L_num = solve(Ad==(A_bar-B_bar*x));
L_ans = double(struct2array(L_num));
L_bar = [L_ans(1:3);L_ans(4:6)];
L = L_bar*T;


