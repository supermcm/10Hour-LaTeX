function show_plaza(plaza, t, n)
%
% show_plaza  To show the plaza matrix as a image
% 
% USAGE: h = show_plaza(plaza, h, n)
%        plaza = plaza matrix
%                1 = car, 0 = empty, -1 = forbid, -3 = empty&booth
%        h = handle of the graphics
%        n = pause time
%
% zhou lvwen: zhou.lv.wen@gmail.com
plaza = plaza';
[W, L] = size(plaza); %get its dimensions

%[L, W] = size(plaza); %get its dimensions
temp = plaza;
temp(temp==1) = 0;

PLAZA(:,:,1) = plaza;
PLAZA(:,:,2) = plaza;
PLAZA(:,:,3) = temp;

PLAZA = 1-PLAZA;
PLAZA(PLAZA>1)=PLAZA(PLAZA>1)/6;


for j = (L+1)/2
    for i = 2:W-1
        if plaza(i,j) == 1;
            PLAZA(i,j,1) =1;
            PLAZA(i,j,2) =0;
            PLAZA(i,j,3) =0;
        else
            PLAZA(i,j,1) =0;
            PLAZA(i,j,2) =1;
            PLAZA(i,j,3) =0;
        end
    end
end


x = 0.5*[-1  1 1 -1];
y = 0.5*[-1 -1 1  1];

if t==0
    figure('position',[100,100,600, 90])
    subplot('position',[0.01,0.03, 0.98, 0.94])
end

[I,J] = find(plaza~=0);
for i = 1:length(I)
    h = fill(J(i)+x,I(i)+y,PLAZA(I(i),J(i),:));
    hold on
end
h1=plot([0,L]+0.5,[[0:W]',[0:W]']+0.5, 'k');
h2=plot([[0:L]',[0:L]']+0.5,[0,W]+0.5, 'k');
hold off
axis image
axis([0.45,L+0.55, 0.45, W+0.55])
axis off
pause(n)