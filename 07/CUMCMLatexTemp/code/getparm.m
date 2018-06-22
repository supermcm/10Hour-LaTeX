function [phi, d, xc, yc] = getparm(isplot)
% 2017 CUMCM problem A - Parameters Calibration on CT System
%
% zhou lvwen: zhou.lv.wen@gmail.com
% September 18, 2017
% 

if nargin==0; isplot = 1; end

phantom = load('data/1.dat');
proj = load('data/2.dat');

width = sum(proj>0);  % Projection width

[wmax, imax] = max(width);
[wmin, imin] = min(width);

% phase/initial angle
phi = 180-imin;

% distance between two adjacent receivers
d = 80/sum(proj(:,imax)>0);

% rotation center on square pallet
idy = find(proj(:,imax)>0);
yc = (256-(max(idy)+min(idy))/2 )*d;

idx = find(proj(:,imin)>0);
idx = idx(idx>100);
xc = -(256-(max(idx)+min(idx))/2 )*d;


%% -----------------------------------------------------------------------
if ~isplot; return; end

figure('name', 'Problem 1-1')
hp = imagesc([0,179]+phi, [1,512], proj);
hold on
plot([90,180; 90 180], [0 0; 512 512],'w')
plot([0,179]+phi, [256.5, 256.5], 'w')
xlabel('Incident directions of X-rays (degree)');
ylabel(sprintf('512 receivers (%5.4f mm)', d));

plot( 90, (max(idy)+min(idy))/2, 'rx',  90, 256.5, 'ro');
plot(180, (max(idx)+min(idx))/2, 'rx', 180, 256.5, 'ro');

%  ellipse & circle
t = linspace(0,2*pi,90);
xi = 15*cos(t);
yi = 40*sin(t);

xi2 = 4*cos(t)+45;
yi2 = 4*sin(t);

% square pallet
xb = [-50  50 50 -50 -50]';
yb = [-50 -50 50  50 -50]';

figure('name', 'Problem 1-2')
fill(xb, yb,[0.6,0.6,0.6])
hold on
fill(xi,yi,'r', xi2, yi2,'r')
plot(xc,yc,'bx',0,0,'ok');
xlabel('x (mm)'); ylabel('y (mm)')
axis image
axis([-60 60 -60 60])
text(xc-10,yc+5,sprintf('(%6.4f,%6.4f)', xc, yc), 'color', 'blue')