clc;clear;close all

matrix_number = 'A0290537Y';

[A,B,C] = get_matrix(matrix_number);

save('A.mat', 'A');
save('B.mat', 'B');
save('C.mat', 'C');

function [MA,MB,MC] = get_matrix(s)
    a = str2num(s(5));
    b = str2num(s(6));
    c = str2num(s(7));
    d = str2num(s(8));

    MA = [-1.7, -0.25, 0; 23, -30, 20; 0, -200-a*100-b*10, -220-b*100-a*10];
    MB = [3+a, 0; -30-d*10-c, 0; 0, -420-c*100-d*10];
    MC = [0, 1, 0; 0, 0, 1];
end


