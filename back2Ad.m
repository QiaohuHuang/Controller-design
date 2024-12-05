clc;clear;close all

load("A.mat");
load("B.mat");
load("C.mat");

syms a11 a12 a13 a21 a22 a23 a31 a32 a33;

ad = [a11 a12 a13; a21 a22 a23; a31 a32 a33];

K = [3.91478260869565	0
-8.70000000000001	20
-250	-710];

K = K';

T = [-0.869565217391304	0	1
0.0434782608695652	0	0
-0.0739130434782609	-0.0108695652173913	0];

A_bar = T*A'*inv(T);
B_bar = T*C';

K_bar = K*inv(T);

Ad_num = solve(ad==(A_bar-B_bar*K_bar));
Ad_ans = double(struct2array(Ad_num));

Ad = [Ad_ans(1:3);Ad_ans(4:6);Ad_ans(7:9)];

