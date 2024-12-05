clc;clear;close all

syms x11 x12 x13 x21 x22 x23 s;

load("A.mat");
load("B.mat");
load("C.mat");

Wc = [B, A*B, A*A*B];
%k = rank(Wc);

X = [Wc(:,1), Wc(:,2), Wc(:,4)];
X_1 = inv(X);

d1 = 1;
d2 = 2;

T = [X_1(d1,:).', X_1(d1+d2,:).',(X_1(d1+d2,:)*A).'].';

A_bar = T*A/T;
B_bar = T*B;

a1 = 1.02;
a2 = 1.44;
a3 = 10*a1;
alpha = sym2poly((s^2+2*a1*s+a2)*(s+a3));
Ad = [-10.20, -1593.21466995252, -182.608707728754; 0, 0, 1; 0, -1.44, -2.04];


A_bar(abs(A_bar) < 1e-5) = 0;
B_bar(abs(B_bar) < 1e-5) = 0;

x = [x11,x12,x13;x21,x22,x23];
K_num = solve(Ad==(A_bar-B_bar*x));
K_ans = double(struct2array(K_num));
K_bar = [K_ans(1:3);K_ans(4:6)];
K = K_bar*T;