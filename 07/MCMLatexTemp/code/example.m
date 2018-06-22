% Matlab example
n = 200;
Pltg = 5e-6;
Pgrw = 1e-2;
NW = [n 1:n-1];
SE = [2:n   1];
veg = zeros(n);
imh = image( cat(3,(veg==1),(veg==2),zeros(n)) );
for i=1:3000
    num =            (veg(NW,:)==1) + ...
        (veg(:,NW)==1)     +      (veg(:,SE)==1) + ...
                     (veg(SE,:)==1);

    veg = 2*( (veg==2) | (veg==0 & rand(n)<Pgrw) ) - ...
            ( (veg==2) & (num >0 | rand(n)<Pltg) );

    set(imh, 'cdata', cat(3,(veg==1),(veg==2),zeros(n)) );
    drawnow
end
