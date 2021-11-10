function sols = solver_3dreg_311_2(data)
C = setup_elimination_template(data);
C0 = C(:,1:9);
C1 = C(:,10:end);
C1 = C0 \ C1;
RR = [-C1(end-2:end,:);eye(4)];
AM_ind = [5,1,2,3];
AM = RR(AM_ind,:);
[V,D] = eig(AM);
V = V ./ (ones(size(V,1),1)*V(1,:));
sols(1,:) = diag(D).';
sols(2,:) = V(3,:);

% Action =  x
% Quotient ring basis (V) = 1,x,y,y^2,
% Available monomials (RR*V) = x^2,x*y,x*y^2,1,x,y,y^2,
function [coeffs,coeffs_ind] = compute_coeffs(data)
tmp = reshape(data,3,3,(2+2));
xd_1 = tmp(:,2:3,1)-repmat(tmp(:,1,1),1,2);
xd_x = tmp(:,2:3,2)-repmat(tmp(:,1,2),1,2);
yd_1 = tmp(:,2:3,3)-repmat(tmp(:,1,3),1,2);
yd_y = tmp(:,2:3,4)-repmat(tmp(:,1,4),1,2);
xs1_1 = xd_1'*xd_1; xs1_1 = xs1_1([1 2 4]);
xs1_x = 2*xd_1'*xd_x; xs1_x = xs1_x([1 2 3 4]); xs1_x = xs1_x*[1 0 0 0;0 1/2 1/2 0;0 0 0 1]';
xs1_x2 = xd_x'*xd_x; xs1_x2 = xs1_x2([1 2 4]);
xsc = [xs1_1;xs1_x;xs1_x2];
ys1_1 = yd_1'*yd_1; ys1_1 = ys1_1([1 2 4]);
ys1_x = 2*yd_1'*yd_y; ys1_x = ys1_x([1 2 3 4]); ys1_x = ys1_x*[1 0 0 0;0 1/2 1/2 0;0 0 0 1]';
ys1_x2 = yd_y'*yd_y; ys1_x2 = ys1_x2([1 2 4]);
ysc = [ys1_1;ys1_x;ys1_x2];
e1c = xsc(:,2)*ysc(:,1)' - xsc(:,1)*ysc(:,2)';
e2c = xsc(:,3)*ysc(:,1)' - xsc(:,1)*ysc(:,3)';
e3c = xsc(:,3)*ysc(:,2)' - xsc(:,2)*ysc(:,3)';
e1c = e1c(:);
e2c = e2c(:);
e3c = e3c(:);
ec = [e1c;e2c;e3c];
ii= [5 , 23 , 14 , 4 , 22 , 2 , 20 , 8 , 26 , 6 , 24 , 13 , 11 , 17 , 15 , 1 , 19 , 7 , 25 , 3 , 21 , 9 , 27 , 10 , 16 , 12 , 18 ];
coeffs = ec(ii)';
coeffs_ind = [22,27,23,22,27,23,10,15,11,8,10,14,27,15,22,11,23,9,8,14,9,1,20,3,15,26,10,21,11,2,6,13,26,20,21,7,4,6,12,3,13,1,7,2,5,18,1,25,14,3,...
    8,2,9,19,24,16,17,16,24,13,6,7,17,16,12,24,4,17,5,4,25,12,18,5,19];
function C = setup_elimination_template(data)
[coeffs,coeffs_ind] = compute_coeffs(data);
C_ind = [1,3,9,11,14,16,19,21,27,28,29,30,31,32,33,34,35,36,38,41,43,46,47,48,49,50,51,52,53,54,55,57,58,60,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,...
78,79,80,81,85,87,89,91,93,94,96,98,99,101,103,104,105,106,107,110,112,113,114,115,116];
C = zeros(9,13);
C(C_ind) = coeffs(coeffs_ind);

