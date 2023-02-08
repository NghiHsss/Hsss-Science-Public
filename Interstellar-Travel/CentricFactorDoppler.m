%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Company:  HSSS Science
% Author:   Nghi Nguyen
% Website:  https://www.hsss.science/
% Repo:     https://github.com/NghiHsss/Hsss-Science-Public
% Release:  MIT License
% Date:     7 Febuary 2023
% Version:  1.00
%
%   Program for converting Polar coordinate of celestial body into 2D Cartesian
%   FOV in radian form, and its concentric to travel vector. Calulate relativistic
%   Doppler shift from Peak Radiance Wavelength and plot relative shift by color.
%
% Program for converting Polar coordinate of celestial body into 2D Cartesian
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

s1_freq = 700;  %%%% Peak Radiance Wavelength sample 700 nm (RED COLOR)

s2_az = 60 * pi/180;
s2_al = 0 * pi/180;

s2_freq = beta*s1_freq;

% Create changes array
ds_az = linspace(s1_az, s2_az);
ds_al = linspace(s1_al, s2_al);

%%%%%%%%%%%%% Set up for coloring based on dopplar shift %%%%%%%%%%%%%%%%%
% based on the highest range of dopplar shift seen, define the
% min and max lambda shift values for defining the ends of the color scale
dw_theta = linspace(0, -2*pi);    % add rotation for 2pi rate
dw_lambda = s1_freq * cos(dw_theta)*sqrt(1-1/gamma^2);
% max and min of d_lambda for bounds of color map
d_lambda_max = max(dw_lambda);
d_lambda_min = min(dw_lambda);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create Polar array
[ds_theta,ds_rho] = cart2pol(ds_az,ds_al);

% Calculate dopplar shift
%s1_freq is labmda of reference star 1
ds_lambda = s1_freq * cos(ds_theta)*sqrt(1-1/gamma^2);
% max and min of d_lambda for bounds of color map

% Plot output for 2D FOV
figure(1)
subplot(2,2,1);
p1 = plot(ds_az, ds_al, 'k.-', 'LineWIdth', 2);

% This function only works in Matlab and not Octave
% p1.Color(4) = 0.5; % make line 50% transparent so can see markers better.

hold on
n = length(ds_az);
colors = linspace(d_lambda_min, d_lambda_max, n); % evenly space lambda for determining the colors
color = colormap(turbo(n)); % Generate vector with n elements from the turbo colormaP
% To relate colors to lambda shift, need to plot markers 1 at a time in a
% loop
for i = 1:length(ds_az)
    % compute color_value based on the lambda shift
    % find the index in colors array that's closes to the current d_lambda value
    [~, idx] = min(abs((colors-ds_lambda(i))));
    % since colors array is made to match up in length to the colormap, we
    % can use that index in the colormap
    scatter(ds_az(i), ds_al(i), 15, color(idx, :), 'filled')
end
colorbar()
hold off
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

[dw_az,dw_al] = pol2cart(dw_theta, dw_rho); % convert to Cartesian 2D

% Calculate dopplar shift
%s1_freq is labmda of reference star 1
dw_lambda = s1_freq * cos(dw_theta)*sqrt(1-1/gamma^2);

% Plot output for 2D FOV with omega rate = 2pi
subplot(2,2,2);
p1 = plot(dw_az, dw_al, 'k.-', 'LineWIdth', 2);

% This function only works in Matlab and not Octave
% p1.Color(4) = 0.5; % make line 50% transparent so can see markers better

n = length(dw_az);
colors = linspace(d_lambda_min, d_lambda_max, n); % evenly space lambda for determining the colors
color = colormap(turbo(n)); % Generate vector with n elements from the turbo colormaP
hold on
% To relate colors to lambda shift, need to plot markers 1 at a time in a
% loop
for i = 1:length(dw_az)
    % compute color_value based on the lambda shift
    % find the index in colors array that's closes to the current d_lambda value
    [~, idx] = min(abs((colors-dw_lambda(i))));
    % since colors array is made to match up in length to the colormap, we
    % can use that index in the colormap
    scatter(dw_az(i), dw_al(i), 15, color(idx, :), 'filled')
end
colorbar()
hold off
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
subplot(2,2,3);
% n = length(ds_theta);
% color = colormap(turbo(n)); % Generate vector with n elements from the turbo colormap.
polar(ds_theta,ds_rho, 'r.-');

% Another method to plot using polarscatter function, not working with colorbar
% p2.Color(4) = 0.5; % make line 50% transparent so can see markers better
% hold on;
% polarscatter(ds_theta,ds_rho, 15, color, 'filled');
% colorbar();
% hold off;

subplot(2,2,4);
polar(dw_theta,dw_rho, 'b.-');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \omega = 0, \apha = \delta x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create changes array in polar
da_theta = linspace(0, 0);  % no omega rotation
r = beta * (rho_s2-rho_s1); % distance linear by beta speed
da_rho = rho_s1 - sin(linspace(0,2*pi))*2*r; % change distance from s1 to s2 in polar form

[da_az,da_al] = pol2cart(da_theta,da_rho); % convert to Cartesian 2D


% Calculate dopplar shift
%s1_freq is labmda of reference star 1
da_lambda = s1_freq * cos(da_theta)*sqrt(1-1/gamma^2);
% max and min of d_lambda for bounds of color map


% Plot output for 2D FOV
figure(2)
subplot(2,2,1);
p1 = plot(da_az, da_al, 'k.-', 'LineWIdth', 2);

% This function only works in Matlab and not Octave
%p1.Color(4) = 0.5; % make line 50% transparent so can see markers better

n = length(da_az);
colors = linspace(d_lambda_min, d_lambda_max, n); % evenly space lambda for determining the colors
color = colormap(turbo(n)); % Generate vector with n elements from the turbo colormaP
hold on
% To relate colors to lambda shift, need to plot markers 1 at a time in a
% loop
for i = 1:length(da_az)
    % compute color_value based on the lambda shift
    % find the index in colors array that's closes to the current d_lambda value
    [~, idx] = min(abs((colors-da_lambda(i))));
    % since colors array is made to match up in length to the colormap, we
    % can use that index in the colormap
    scatter(da_az(i), da_al(i), 15, color(idx, :), 'filled')
end
colorbar()
hold off
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

% Calculate dopplar shift
%s1_freq is labmda of reference star 1
dwa_lambda = s1_freq * cos(dwa_theta)*sqrt(1-1/gamma^2);
% max and min of d_lambda for bounds of color map

dwa_lambda_max = max(dwa_lambda);
dwa_lambda_min = min(dwa_lambda);

% Plot output for 2D FOV with omega rate = 2pi
subplot(2,2,2);
p1 = plot(dwa_az, dwa_al, 'k.-', 'LineWIdth', 2);

% This function only works in Matlab and not Octave
%p1.Color(4) = 0.5; % make line 50% transparent so can see markers better

n = length(dwa_az);
colors = linspace(d_lambda_min, d_lambda_max, n); % evenly space lambda for determining the colors
color = colormap(turbo(n)); % Generate vector with n elements from the turbo colormaP
hold on
% To relate colors to lambda shift, need to plot markers 1 at a time in a
% loop
for i = 1:length(dwa_az)
    % compute color_value based on the lambda shift
    % find the index in colors array that's closes to the current d_lambda value
    [~, idx] = min(abs((colors-dw_lambda(i))));
    % since colors array is made to match up in length to the colormap, we
    % can use that index in the colormap
    scatter(dwa_az(i), dwa_al(i), 15, color(idx, :), 'filled')
end
colorbar()
hold off
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
%
% % Plot output on Polar 2D
subplot(2,2,3);
polar(da_theta,da_rho, 'r.-');
subplot(2,2,4);
polar(dwa_theta,dwa_rho, 'b.-');





