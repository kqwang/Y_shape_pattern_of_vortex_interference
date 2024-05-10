% Off-axis interference pattern of vortex phase

% From Kaiqiang Wang, email: kqwang.optics@gmail.com

% Note: The "Order" and "Degree" are adjustable. 

close all;
clear all
clc

width = 512; % image width
height = 512; % image height
center_x = width / 2; % Center point x coordinate
center_y = height / 2; % Center point y coordinate
Order = -2;   % Angular momentum of the vortex beam 

% Create a vortex phase
vortex_phase = zeros(height, width);
for y = 1:height
    for x = 1:width
        r = sqrt((x - center_x)^2 + (y - center_y)^2); % distance from center point
        theta = atan2(y - center_y, x - center_x); % angle
        vortex_phase(y, x) = Order * theta; % get phase
    end
end

% Create a slope phase
slope_phase=meshgrid(-1:1/256:1-1/256);%Generate slope
Degree = 8*pi; % Degree of slope
slope_phase=Degree*slope_phase; %Generate slope phase 

phase_difference=vortex_phase-slope_phase; % get phase difference
I = 1+1+2*cos(phase_difference); % Get the interference fringes

% Find the location where the phase difference is an integer multiple of 2pi
TWO_PI_position = phase_difference;
TWO_PI_position(abs(rem(TWO_PI_position,2*pi))<0.4) = 1;
TWO_PI_position(TWO_PI_position~=1) = 0;

% show
figure;
imagesc(vortex_phase);
colormap('gray');
title('vortex phase');
colorbar;
figure;
imagesc(slope_phase);
colormap('gray');
title('slope phase');
colorbar;
figure;
imagesc(phase_difference);
colormap('gray');
title('phase difference');
colorbar;
figure;
imagesc(TWO_PI_position);
colormap('gray');
title('Integer multiple of TWO PI');
colorbar;
figure;
imagesc(I);
colormap('gray');
title('interference pattern');
colorbar;