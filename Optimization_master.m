% MAE 535 Design of Electromechanical Systems - Course Project
% Optimization for semi-haptic feedback device design
% Vinod Kumar Singla 4/20/2017
clear all;clc;close all; %JG;JG;WG
lb = [10;10.5;0;11;12;14;5;0;5]; % lower bounds on individual design variables
ub = [20;23;20;25;27;37;30;22.5;22.5]; % upper bounds on individual design variables
opts = gaoptimset('PlotFcn',{@gaplotbestf,@gaplotstopping},'Generations',2000,'TolFun',1e-8);
fitnessfcn = @objF;
nvars = 9;
nonlcon = []; 
Aeq = [];
beq = [];
A = [-1 1 0 0 0 0 0 0 0;1 -1 0 0 0 0 0 0 0;-1 0 1 0 0 0 0 0 0;...
    0 -1 0 1 0 0 0 0 0;0 1 0 -1 0 0 0 0 0;0 0 0 -1 1 0 0 0 0;...
    0 0 0 1 -1 0 0 0 0;0 0 0 0 -1 1 0 0 0;0 0 0 0 1 -1 0 0 0;...
    0 0 0 0 0 0 0 1 -1];
b = [3;-0.5;0;2;-1;3;-1.5;10;-2;0];
[x,fval,exitflag,output] = ga(fitnessfcn,nvars,A,b,Aeq,beq,lb,ub,nonlcon,opts)

