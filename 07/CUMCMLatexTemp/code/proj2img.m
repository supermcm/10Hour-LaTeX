function [xyrate, img] = proj2img(proj, phi, d, xc, yc, isplot)
% 2017 CUMCM problem A - Parameters Calibration on CT System
%
% Refernces:
% https://cn.mathworks.com/help/images/ref/iradon.html
% https://cn.mathworks.com/help/images/ref/radon.html
% https://www.clear.rice.edu/elec431/projects96/DSP/bpanalysis.html
% https://www.youtube.com/watch?v=BmkdAqd5ReY&t=607s
%
% zhou lvwen: zhou.lv.wen@gmail.com
% September 18, 2017
% 

if nargin==0
    proj = load('data/2.dat');              % phase/initial angle
    phi = 30;
    d = 0.2768;             % distance between two adjacent receivers
    xc = -33.5*d;  yc = 20*d;  % rotation center on square pallet
    isplot = 1;
end

% reconstructs the image img from projection data in the 2-D array proj.
proj = [zeros(200,180); proj; zeros(200,180)];

img0 = iradon(proj,[0:179]+phi,'Hann');

% cut out the right region: x in [xc-50, xc+50]; y in [yc-50 yc+50]
nhalf = size(img0,1)/2;
xci = ceil(-xc/d) + nhalf;  xidx = xci + [ceil(-50/d):ceil(50/d)];
yci = ceil( yc/d) + nhalf;  yidx = yci + [ceil(-50/d):ceil(50/d)];

img0 = img0(yidx,xidx);

% changle img from 362x362 to 256x256
img = imrescale(img0, [256,256]);
imgud = flipud(img);

% Compute the absorption values at 10 points (xy)
xy = load('data/4.dat');
d = 100/256;
ic = ceil(xy(:,1)/d);   % locations to index
ir = ceil(xy(:,2)/d);   
idx = sub2ind(size(imgud), ir, ic);
xyrate = [xy imgud(idx)];

%% ------------------------------------------------------------------------
if ~isplot; return; end
% show the image
imagesc([-50,50], [-50,50], imgud); colorbar
hold on; axis image
% plot the 10 points: absorption values ('x'indicates =0, '+' indicates >0)
plot(xy(imgud(idx)==0,1)-50, xy(imgud(idx)==0,2)-50, 'wx', 'linewidth', 2)
plot(xy(imgud(idx)~=0,1)-50, xy(imgud(idx)~=0,2)-50, 'r+', 'linewidth', 2)

set(gca,'ydir','normal')
xlabel('x (mm)'); ylabel('y (mm)')

% -------------------------------------------------------------------------

function new = imrescale(old, newsize)
% resize and rescale a image
scale = prod(size(old)) / prod(newsize);
new = imresize(old, newsize) * scale;
new(new<1e-1) = 0; % Less than 0.1 becomes 0 (remove negative value)
