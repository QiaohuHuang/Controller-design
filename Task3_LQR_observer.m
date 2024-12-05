clc;clear;close all

load("A.mat");
load("B.mat");
load("C.mat");
syms x11 x12 x13 x21 x22 x23;
% O = [C;C*A;C*A*A];
% k = rank(O');

Wc = [C', A'*C', A'*A'*C'];
X = [Wc(:,1), Wc(:,2), Wc(:,3)];
X_1 = inv(X);

d1 = 2;
d2 = 1;

T = [X_1(d1,:).', X_1(d1+d2,:).',(X_1(d1+d2,:)*A).'].';

A_bar = T*A'/T;
B_bar = T*C';

Ad = [-10	2962	1840
0	-158.1	-92
0	233.60	135.1];

A_bar(abs(A_bar) < 1e-5) = 0;
B_bar(abs(B_bar) < 1e-5) = 0;

x = [x11,x12,x13;x21,x22,x23];
L_num = solve(Ad==(A_bar-B_bar*x));
L_ans = double(struct2array(L_num));
L_bar = [L_ans(1:3);L_ans(4:6)];
L = L_bar*T;

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

