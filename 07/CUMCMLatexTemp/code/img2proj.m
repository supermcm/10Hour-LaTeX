function proj = img2proj(img, phi, d, xc, yc, isanimate)
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

if nargin==0;
    img = load('data/1.dat');
    d = 0.2768;
    xc = -33.5*d; yc = 20*d;    % rotation center on square pallet
    phi = 30;
    isanimate = 1;
end

if nargin==5; isanimate = 0; end

nhalf = 512/2;


% Cartesian coordinates of pixel on CT system
[x,y] = meshgrid([-400.5:400.5]*d, [-400.5:400.5]*d); 

imgct = zeros(size(x));

ic = ceil(401-xc/d);  jc = ceil(401+yc/d);

imgct(jc-180:jc+181, ic-180:ic+181) = imresize(img,[362,362]) * (256/362)^2;

proj = radon(imgct, [0:179]+phi);

nc = ceil(size(proj,1)/2);
proj = proj(nc-nhalf+1:nc+nhalf,:);

%% ------------------------------------------------------------------------

if ~isanimate; return; end 

imgct = rot90(imgct);

RGB0 = img2RGB(imrotate(imgct, -phi,'crop'));
hi = image([-1,1]*401*d,[-1,1]*401*d, flipud(RGB0));

hold on
% square pallet
xpo = 50 * [-1  1  1 -1 -1]';          
ypo = 50 * [-1 -1  1  1 -1]';
[xp, yp] = rotxy(xpo, ypo, xc, yc, 90-phi);

hb = plot(xp, yp,'r','linewidth',1);

% arrows
quiver(150*ones(1,10), linspace(-nhalf,nhalf,10)*d, ...
      -300*ones(1,10), zeros(1,10), 0,'b');

plot(0,0,'rx','linewidth', 2)               % rotation center
xlabel(['phi = 0^\circ'])
hp = imagesc(-150,y(abs([-400.5:400.5])<256,1),proj(:,1));
axis image; axis([-150-180,150,-100,100]);
set(gca, 'xtick', [-330:60:-150, -50, 50],'ydir','normal')
set(gca, 'xticklabel', [phi:60:180+phi, -50, 50])
hold off

theta = [0:179];
pause(1)

for i = 1:length(theta)
    ti = theta(i) + phi;
    [xp, yp] = rotxy(xpo, ypo, xc, yc, -ti+90); set(hb,'xdata',xp, 'ydata', yp);

    set(hp, 'xdata', -150-i, 'cdata', proj(:,1:i));
    xlabel(['\phi = ', num2str(ti),'^\circ'])

    RGBi = img2RGB(imrotate(imgct, -ti,'crop'));
    set(hi,'cdata', flipud(RGBi))
    drawnow
end

% -------------------------------------------------------------------------

function [x, y] = rotxy(x0, y0, xc, yc, angle)

angle = angle/180*pi;
x = (x0-xc)*cos(angle) - (y0-yc)*sin(angle); 
y = (y0-yc)*cos(angle) + (x0-xc)*sin(angle);

% -------------------------------------------------------------------------

function RGB = img2RGB(img)
R = 1 - img/max(img(:)); 
RGB = cat(3, R, R, R);
