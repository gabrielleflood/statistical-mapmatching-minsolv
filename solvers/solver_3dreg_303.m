function sols = solver_3dreg_303_2(data)
[C0,C1] = setup_elimination_template(data);
C1 = C0 \ C1;
RR = [-C1(end-2:end,:);eye(8)];
AM_ind = [9,6,1,8,2,10,11,3];
AM = RR(AM_ind,:);
[V,D] = eig(AM);
V = V ./ (ones(size(V,1),1)*V(1,:));
sols(1,:) = V(2,:);
sols(2,:) = V(4,:);
sols(3,:) = diag(D).';

% Action =  z
% Quotient ring basis (V) = 1,x,x*z,y,y*z,z,z^2,z^3,
% Available monomials (RR*V) = x*z^2,y*z^2,z^4,1,x,x*z,y,y*z,z,z^2,z^3,
function [coeffs] = compute_coeffs(data)
tmp = reshape(data,3,3,(2+3));
xd_1 = tmp(:,2:3,1)-repmat(tmp(:,1,1),1,2);
yd_1 = tmp(:,2:3,2)-repmat(tmp(:,1,2),1,2);
yd_x = tmp(:,2:3,3)-repmat(tmp(:,1,3),1,2);
yd_y = tmp(:,2:3,4)-repmat(tmp(:,1,4),1,2);
yd_z = tmp(:,2:3,5)-repmat(tmp(:,1,5),1,2);

xs1_1 = xd_1'*xd_1; xs1_1 = xs1_1([1 2 4]);
xsc = xs1_1;

ys1_1 = yd_1'*yd_1; ys1_1 = ys1_1([1 2 4]);
ys1_z = 2*yd_1'*yd_z; ys1_z = ys1_z([1 2 3 4]); ys1_z = ys1_z*[1 0 0 0;0 1/2 1/2 0;0 0 0 1]';
ysz_z = yd_z'*yd_z; ysz_z = ysz_z([1 2 4]);
ys1_y = 2*yd_1'*yd_y; ys1_y = ys1_y([1 2 3 4]); ys1_y = ys1_y*[1 0 0 0;0 1/2 1/2 0;0 0 0 1]';
ysz_y = 2*yd_z'*yd_y; ysz_y = ysz_y([1 2 3 4]); ysz_y = ysz_y*[1 0 0 0;0 1/2 1/2 0;0 0 0 1]';
ysy_y = yd_y'*yd_y; ysy_y = ysy_y([1 2 4]);
ys1_x = 2*yd_1'*yd_x; ys1_x = ys1_x([1 2 3 4]); ys1_x = ys1_x*[1 0 0 0;0 1/2 1/2 0;0 0 0 1]';
ysz_x = 2*yd_z'*yd_x; ysz_x = ysz_x([1 2 3 4]); ysz_x = ysz_x*[1 0 0 0;0 1/2 1/2 0;0 0 0 1]';
ysy_x = 2*yd_y'*yd_x; ysy_x = ysy_x([1 2 3 4]); ysy_x = ysy_x*[1 0 0 0;0 1/2 1/2 0;0 0 0 1]';
ysx_x = yd_x'*yd_x; ysx_x = ysx_x([1 2 4]); 

ysc = [ys1_1; ys1_z; ysz_z; ys1_y; ysz_y; ysy_y; ys1_x; ysz_x; ysy_x; ysx_x];

xsc_exp = [xsc; zeros(9,3)];
ysc_exp = ysc;

e1c = xsc_exp(:,1)-ysc_exp(:,1);
e2c = xsc_exp(:,2)-ysc_exp(:,2);
e3c = xsc_exp(:,3)-ysc_exp(:,3);

ec = [e1c;e2c;e3c];
ii = [11 17 14 12 19 18 15 1 21 7 27 4 24 2 22 20 9 29 8 28 16 5 25 13 ...
        10 30 6 26 3 23];
coeffs = ec(ii)';

function [C0,C1] = setup_elimination_template(data)
[coeffs] = compute_coeffs(data);
coeffs0_ind = [25,16,17,25,16,5,26,27,17,5,21,18,27,21,28,25,16,26,19,6,17,25,16,5,26,18,22,19,6,7,27,17,5,21,18,20,28,22,7,27,21,28,23,19,6,16,25,26,20,29,...
24,22,19,6,7,5,17,18,20,23,29,24,22,7,21,27,28,23,30,29,24,6,19,20,30,29,24,7,22,23,30,25,16,26,10,2,17,5,25,26,16,18,12,10,2,3,11,27,21,17,...
18,5,28,12,3,13,27,28,21,10,2,19,6,26,16,25,20,11,14,4,12,10,2,3,11,22,7,19,20,18,5,17,6,23,13,14,4,12,3,13,15,22,23,28,21,27,7,10,2,26,...
16,25,11,8,1,12,3,10,11,18,5,17,2,13,8,1,9,12,13,28,21,27,3,14,4,2,10,11,29,24,20,6,19,30,15,14,4,3,12,13,15,29,30,23,7,22,24,24,29,30];
coeffs1_ind = [9,1,8,8,1,11,2,10,9,8,1,14,4,11,2,10,20,6,19,15,9,8,9,13,3,12,1,8,1,9,14,15,13,3,12,23,7,22,4,9,1,8,15,4,14,1,8,9,15,4,...
14,30,24,29,4,14,15,30,24,29];
C0_ind = [1,4,27,28,29,30,39,53,54,55,56,65,80,81,91,109,112,130,131,134,135,136,137,138,142,156,157,158,159,160,161,162,163,164,168,169,182,184,185,188,189,194,195,213,216,217,218,219,234,235,...
238,239,240,241,242,243,244,245,246,260,262,263,266,267,269,270,271,272,273,291,294,295,296,297,312,318,319,321,322,323,324,352,353,363,365,368,378,379,380,381,388,389,391,392,393,394,403,404,405,406,...
407,414,415,418,419,429,432,433,440,447,450,456,457,460,461,462,467,468,469,472,473,474,475,476,480,482,483,484,485,486,487,488,492,493,494,496,497,500,501,506,507,510,511,512,513,514,518,534,535,541,...
542,543,545,547,550,560,561,562,563,567,568,569,570,571,574,575,585,588,589,593,594,595,596,603,606,607,608,609,612,613,616,617,618,623,624,630,631,633,634,635,636,640,641,642,643,644,648,659,660,661];
C1_ind = [21,22,23,40,41,47,48,49,51,57,60,66,67,70,71,72,73,74,75,77,78,94,95,99,100,101,102,110,111,116,120,121,122,123,124,125,126,127,128,148,149,150,151,152,153,165,166,167,174,175,...
176,177,178,179,191,192,193,200,201,202];
C0 = zeros(26,26);
C1 = zeros(26,8);
C0(C0_ind) = coeffs(coeffs0_ind);
C1(C1_ind) = coeffs(coeffs1_ind);
