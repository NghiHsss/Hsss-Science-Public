%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Company:  HSSS Science
% Author:   Nghi Nguyen
% Website:  https://www.hsss.science/
% Repo:     https://github.com/NghiHsss/Hsss-Science-Public
% Release:  MIT License
% Date:     22 January 2023
% Version:  1.00
%
%   Program for converting Polar coordinate of celestial body into 2D Cartesian
%   FOV in radian form, and its concentric to travel vector
%
%   Cartesian (x,y) = to Polar 2D
%   https://www.mathworks.com/help/matlab/ref/cart2pol.html
%     [theta,rho] = cart2pol(x,y)
%     transforms corresponding elements of the two-dimensional Cartesian
%     coordinate arrays x and y into polar coordinates theta and rho.
%     theta = atan2(y,x)  angle between X to vector
%     rho   = sqrt(x.^2 + y.^2) distance vector 2D
%
%   Polar to Cartesian 2D
%   https://www.mathworks.com/help/matlab/ref/pol2cart.html
%     [x,y] = pol2cart(theta,rho)
%     transforms corresponding elements of the polar coordinate arrays
%     theta and rho to two-dimensional Cartesian, or xy, coordinates.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
clc;

% Inputs for Traveling Speed 0.5C
beta = 0.5; % beta = v/c
gamma = 1/sqrt(1-beta^2); % Lorentz factor

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \omega = 0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Inputs for Star References, in 2D Cartesian(azimuth, altitude)
s1_az = 45 * pi/180;  % deg to radian
s1_al = 0 * pi/180;

s1_freq = 700;  %%%% 700 nm (RED COLOR)

s2_az = 60 * pi/180;
s2_al = 0 * pi/180;

s2_freq = beta*s1_freq; %%% NOT SURE IF THIS CORRECT


% Create changes array
ds_az = linspace(s1_az, s2_az);
ds_al = linspace(s1_al, s2_al);

% Create Polar array
[ds_theta,ds_rho] = cart2pol(ds_az,ds_al);

% Plot output for 2D FOV
figure(1)
subplot(2,2,1); plot(ds_az, ds_al, 'r.-', 'LineWIdth', 2, 'MarkerSize', 10);
axis([-pi/2 pi/2 -pi/2 pi/2]);
set(gca, 'XAxisLocation', 'origin');
set(gca, 'YAxisLocation', 'origin');

xticks([-pi/2 -pi/4 0 pi/4 pi/2]);
xticklabels({'-\pi/2','-\pi/4','0','\pi/4','\pi/2'});
yticks([-pi/2 -pi/4 0 pi/4 pi/2]);
yticklabels({'-\pi/2','-\pi/4','0','\pi/4','\pi/2'});

grid on;
xlabel('Azimuth (radian)');
ylabel('Altitude (radian)');
title('\omega = 0');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \omega = 2*pi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[theta_s1,rho_s1] = cart2pol(s1_az,s1_al); % convert to Polar form
[theta_s2,rho_s2] = cart2pol(s2_az,s2_al);

% Create changes array in polar
dw_theta = linspace(0, -2*pi);    % add rotation for 2pi rate
dw_rho = linspace(rho_s1,rho_s2); % change distance from s1 to s2 in polar form

[dw_az,dw_al] = pol2cart(dw_theta,dw_rho); % convert to Cartesian 2D

% Plot output for 2D FOV with omega rate = 2pi
subplot(2,2,2); plot(dw_az, dw_al, 'b.-', 'LineWIdth', 2, 'MarkerSize', 10);
axis([-pi/2 pi/2 -pi/2 pi/2]);
set(gca, 'XAxisLocation', 'origin');
set(gca, 'YAxisLocation', 'origin');

xticks([-pi/2 -pi/4 0 pi/4 pi/2]);
xticklabels({'-\pi/2','-\pi/4','0','\pi/4','\pi/2'});
yticks([-pi/2 -pi/4 0 pi/4 pi/2]);
yticklabels({'-\pi/2','-\pi/4','0','\pi/4','\pi/2'});

grid on;
xlabel('Azimuth (radian)');
ylabel('Altitude (radian)');
title('\omega = 2\pi');

%% Plot Polar
subplot(2,2,3); polar(ds_theta,ds_rho, 'r.-');
subplot(2,2,4); polar(dw_theta,dw_rho, 'b.-');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \omega = 0, \apha = \delta x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create changes array in polar
da_theta = linspace(0, 0);  % no omega rotation
r = beta * (rho_s2-rho_s1); % distance linear by beta speed
da_rho = rho_s1 - sin(linspace(0,2*pi))*2*r; % change distance from s1 to s2 in polar form

[da_az,da_al] = pol2cart(da_theta,da_rho); % convert to Cartesian 2D

% Plot output for 2D FOV
figure(2)
subplot(2,2,1); plot(da_az, da_al, 'r.-', 'LineWIdth', 2, 'MarkerSize', 10);
axis([-pi/2 pi/2 -pi/2 pi/2]);
set(gca, 'XAxisLocation', 'origin');
set(gca, 'YAxisLocation', 'origin');

xticks([-pi/2 -pi/4 0 pi/4 pi/2]);
xticklabels({'-\pi/2','-\pi/4','0','\pi/4','\pi/2'});
yticks([-pi/2 -pi/4 0 pi/4 pi/2]);
yticklabels({'-\pi/2','-\pi/4','0','\pi/4','\pi/2'});

grid on;
xlabel('Azimuth (radian)');
ylabel('Altitude (radian)');
title('\omega = 0, \alpha = \Delta x');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \omega = 2*pi, \alpha = \delta x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[theta_s1,rho_s1] = cart2pol(s1_az,s1_al); % convert to Polar form
[theta_s2,rho_s2] = cart2pol(s2_az,s2_al);

% Create changes array in polar
dwa_theta = linspace(0, -2*pi);    % add rotation for 2pi rate
dwa_rho = da_rho + linspace(0,rho_s2-rho_s1);

[dwa_az,dwa_al] = pol2cart(dwa_theta,dwa_rho); % convert to Cartesian 2D

% Plot output for 2D FOV with omega rate = 2pi
subplot(2,2,2); plot(dwa_az, dwa_al, 'b.-', 'LineWIdth', 2, 'MarkerSize', 10);
axis([-pi/2 pi/2 -pi/2 pi/2]);
set(gca, 'XAxisLocation', 'origin');
set(gca, 'YAxisLocation', 'origin');

xticks([-pi/2 -pi/4 0 pi/4 pi/2]);
xticklabels({'-\pi/2','-\pi/4','0','\pi/4','\pi/2'});
yticks([-pi/2 -pi/4 0 pi/4 pi/2]);
yticklabels({'-\pi/2','-\pi/4','0','\pi/4','\pi/2'});

grid on;
xlabel('Azimuth (radian)');
ylabel('Altitude (radian)');
title('\omega = 2\pi, \alpha = \Delta x');

% Plot output on Polar 2D
subplot(2,2,3); polar(da_theta,da_rho, 'r.-');
subplot(2,2,4); polar(dwa_theta,dwa_rho, 'b.-');



