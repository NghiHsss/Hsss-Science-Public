%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Company:  HSSS Science
% Author:   Nghi Nguyen
% Website:  https://www.hsss.science/
% Repo:     https://github.com/NghiHsss/Hsss-Science-Public
% Release:  MIT License
% Date:     31 January 2023
% Version:  1.10
%
% Original  Timofey G.
%   Program for angle of course from change of intensity
%   Initial 19/12/2022
%
% Version Control
%   1.10     Change plots to subplots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
clc;


% Inputs for Traveling Speed 1
beta = 0.1; % beta = v/c

% Inputs for Star References, in (nm)
lambda_BlueStar = 475;   % blue wavelength Star
lambda_YellowStar = 570; % yellow wavelength Star
lambda_RedStar = 650;    % red wavelength Star

% Fixed Variable
gamma = 1/sqrt(1-beta^2); % Lorentz factor

% Create changes array(delta lambda)
% delta lamda = beta * lamda
dl_BlueStar = linspace(0,lambda_BlueStar*.1);
dl_YellowStar = linspace(0,lambda_YellowStar*.1);
dl_RedStar = linspace(0,lambda_RedStar*.1);

alpha_BlueStar = acosd((dl_BlueStar/lambda_BlueStar)*(1-1/gamma^2)^(-1/2));
alpha_YellowStar = acosd((dl_YellowStar/lambda_YellowStar)*(1-1/gamma^2)^(-1/2));
alpha_RedStar = acosd((dl_RedStar/lambda_RedStar)*(1-1/gamma^2)^(-1/2));

% Plot output for Case 0.1c
figure(1)
subplot(1,2,1);
plot(alpha_BlueStar, -dl_BlueStar, alpha_RedStar, -dl_RedStar, alpha_YellowStar, -dl_YellowStar);
grid on;
xlabel('Approach Angle \theta (degree)');
ylabel('Peak Wavelength Shift (nm)');
legend('Blue = 475nm ', 'Red = 650nm', 'Yellow = 570nm ');
title('Traveling Speed at 0.1c')




% Inputs for Traveling Speed 2
beta = 0.5; % beta = v/c

% Fixed Variable
gamma = 1/sqrt(1-beta^2); % Lorentz factor

% Create changes array(delta lambda)
% delta lamda = beta * lamda
dl_BlueStar = linspace(0,lambda_BlueStar*.5);
dl_YellowStar = linspace(0,lambda_YellowStar*.5);
dl_RedStar = linspace(0,lambda_RedStar*.5);

alpha_BlueStar = acosd((dl_BlueStar/lambda_BlueStar)*(1-1/gamma^2)^(-1/2));
alpha_YellowStar = acosd((dl_YellowStar/lambda_YellowStar)*(1-1/gamma^2)^(-1/2));
alpha_RedStar = acosd((dl_RedStar/lambda_RedStar)*(1-1/gamma^2)^(-1/2));

% Plot output for Case 0.5c
subplot(1,2,2);
plot(alpha_BlueStar, -dl_BlueStar, alpha_RedStar, -dl_RedStar, alpha_YellowStar, -dl_YellowStar);
grid on;
xlabel('Approach Angle \theta (degree)');
ylabel('Peak Wavelength Shift (nm)');
legend('Blue = 475nm ', 'Red = 650nm', 'Yellow = 570nm ');
title('Traveling Speed at 0.5c')
