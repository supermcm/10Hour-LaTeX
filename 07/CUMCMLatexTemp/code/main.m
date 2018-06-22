% 2017 CUMCM problem A - Parameters Calibration on CT System
%
% zhou lvwen: zhou.lv.wen@gmail.com
% September 18, 2017
% 

%% ------------------------------------------------------------------------
% problem 1

[phi, d, xc, yc] = getparm;

%% ------------------------------------------------------------------------
% problem 2
proj0 = load('data/3.dat');
figure('name', 'Problem 2-1')
[xyrate, img] = proj2img(proj0, phi, d, xc, yc, 1);

figure('name', 'Problem 2-2')
proj = img2proj(img,  phi, d, xc, yc, 1);

figure('name', 'Problem 2-3')
subplot(2,1,1); imagesc([0,179]+phi, [1,512], proj0); colorbar; 
subplot(2,1,2); imagesc([0,179]+phi, [1,512], proj);  colorbar;

%% ------------------------------------------------------------------------
%  problem 3
proj0 = load('data/5.dat');
figure('name', 'Problem 2-1')
[xyrate, img] = proj2img(proj0, phi, d, xc, yc, 1);

figure('name', 'Problem 2-2')
proj = img2proj(img,  phi, d, xc, yc, 1);

figure('name', 'Problem 2-3')
subplot(2,1,1); imagesc([0,179]+phi, [1,512], proj0); colorbar; 
subplot(2,1,2); imagesc([0,179]+phi, [1,512], proj);  colorbar;
