% MAE 535 Design of Electromechanical Systems - Course Project
% Optimization for semi-haptic feedback device design
% Vinod Kumar Singla 4/20/2017

function f = objF(x)
%Note: x = [r1, r2, r3, r4, r5, r6, h0, h1, h2] 
r1 = 1e-3*x(1);  r2 = 1e-3*x(2);  r3 = 1e-3*x(3);  
r4 = 1e-3*x(4);  r5 = 1e-3*x(5);  r6 = 1e-3*x(6);
h0 = 1e-3*x(7);  h1 = 1e-3*x(8);  h2 = 1e-3*x(9);

% Data needed
r0 = 1e-3; % inner bore dia, m
rho_i = 7.87*10^3; % iron density, Kg/m^3
rho_c = 8.96*10^3; % copper density, Kg/m^3
dw = 25*1e-5; % copper wire dia, m
mu_0 = 1.25663706*1e-6; % Permeability of free space , m*kg*s^-2*A^-2
mu_ri = 5000; % Relative Permeability of iron, dimensionless 
mu_rf = 4; % Relative Permeability of mrf, dimensionless
Nc = h0*(r2-r1)/dw^2; % Number of wire turns, dimensionless
Lw = 2*pi*Nc*(r1+r2)/2; % Wire length, m
Aw = pi*dw^2/4; % cross sectional area of wire, m^2
rhoe = 1.68*10^-8; % electrical resistivity of copper (ohm-m)
%yeta = 250; % dynamic viscosity of mrf, Pa-s, for v = 1 m/s
Rw = rhoe*Lw/Aw; % total wire resistance, ohms
Vs = 12; % Supply voltage, volts
Is = Vs/Rw; % current in the coil, amps
As = pi*(r4+r5)*h2*2; % area b/w lands of piston & cylinder wall, m^2
penalty = 0; % Will be increased for exceeding a certain preset # of turns
% mass calculation
mc = 3*pi*(r6^2-r5^2)*(h0+2*h2)*rho_i; % Cylinder mass, Kg, assuming cylinder length to be 3 times to that of spool
ms = pi*((2*h2+h0)*(r4^2- r0^2)-2*h1*(r3^2-r0^2)-h0*(r4^2-r1^2))*rho_i; % Spool mass, Kg
mw = (pi/4)*dw^2*Lw*rho_c; % coil mass, Kg
M = mc+ms+mw; % Total mass of spool, cylinder and coil, Kg

% Magnetic circuit analysis (MCA) for calculating B in mrf
Aa = 2*pi*(r1^2-r0^2); La = h0;
Ab = pi*(r1^2-r0^2+(r1+r0)*sqrt(h1^2+(r1-r0)^2)); Lb = h1;
Ac = pi*((r1+r0)*sqrt(h1^2+(r1-r0)^2)+(r1+r3)*sqrt(h1^2+(r1-r3)^2)); Lc = r1-r3;
Ad = pi*(r1+r3)*(sqrt(h1^2+(r1-r3)^2)+sqrt(h2^2+(r1-r3)^2)); Ld = h2-h1;
Ae = pi*((r1+r3)*sqrt(h2^2+(r1-r3)^2)+2*r1*h2); Le = r1-r3;
Af = 2*pi*(r4+r1)*h2; Lf = 2*(r4-r1);
Ag = 2*pi*(r4+r5)*h2; Lg = 2*(r5-r4);
Ah = 2*pi*(r6^2-r5^2); Lh = h0+h2;
R = (La/Aa+Lb/Ab+Lc/Ac+Ld/Ad+Le/Ae+Lf/Af+Lh/Ah)/(mu_0*mu_ri)+(Lg/Ag)/(mu_0*mu_rf);
phi = Nc*Is/R; % flux in magnetic circuit, weber
Ba = phi/Aa; % flux density in mrf, Tesla
Bb = phi/Ab; % flux density in segment a, Tesla
Bc = phi/Ac; % flux density in segment a, Tesla
Bd = phi/Ad; % flux density in segment a, Tesla
Be = phi/Ae; % flux density in segment a, Tesla
Bf = phi/Af; % flux density in segment a, Tesla
Bg = phi/Ag; % flux density in segment a, Tesla
Bh = phi/Ah; % flux density in segment a, Tesla
B = [Ba,Bb,Bc,Bd,Be,Bf,Bg,Bh];
% damping force calculation
tauy_mrf = 1e3*(-103.4*Bg^3 + 152*Bg^2 + 8.548*Bg -0.04002); % shear yield of mrf, Pa
Fd = As*(tauy_mrf); % damping force, N, assuming a gap of >= 1.5 mm

% (LR) time constant
tau = Nc^2/(R*Rw);

% Objective function
if Fd> 80 % 120*.9 for first case
    Fd=-1000;
end

% Penalty for exceeding time constant
if tau>0.09
   penalty = 1000;
end

f = penalty + 15*M - Fd + Vs*Is + 20*max(max(B)-1.5,0); 
% note mass is multiplied with a weighting factor to bring it closer to the same order of magnitude as damping force
end
