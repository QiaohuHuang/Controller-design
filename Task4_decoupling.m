clc;clear;close all

load("A.mat");
load("B.mat");
load("C.mat");

for i=1:2
    if C(1,:)*A^(i-1)*B==0
       continue
    end
    sigma1=i;
    break
end

for j=1:2
    if C(2,:)*A^(j-1)*B==0
       continue
    end
    sigma2=j;
    break
end

A(1,1) = A(1,1)+2;

B_star = [C(1,:)*A^(sigma1-1)*B;C(2,:)*A^(sigma2-1)*B];
F = B_star^-1;
% C_star = [C(1,:)*A^sigma1;C(2,:)*A^sigma2];
% K = F*C_star;
y11 = 1;
y21 = 2;
K = F*[C(1,:)*(A+y11*eye(3));C(2,:)*(A+y21*eye(3))];

[evec, eval] = eig(A-B*K);
