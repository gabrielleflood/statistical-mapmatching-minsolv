function sols = solver_3dreg_302_2(data)
[C0,C1] = setup_elimination_template(data);
C1 = C0 \ C1;
RR = [-C1(end-1:end,:);eye(4)];
AM_ind = [5,1,6,2];
AM = RR(AM_ind,:);
[V,D] = eig(AM);
V = V ./ (ones(size(V,1),1)*V(1,:));
sols(1,:) = V(2,:);
sols(2,:) = diag(D).';

% Action =  y
% Quotient ring basis (V) = 1,x,y,y^2,
% Available monomials (RR*V) = x*y,y^3,1,x,y,y^2,
function [coeffs] = compute_coeffs(data)
tmp = reshape(data,3,3,(2+2));
xd_1 = tmp(:,2:3,1)-repmat(tmp(:,1,1),1,2);

yd_1 = tmp(:,2:3,2)-repmat(tmp(:,1,2),1,2);
yd_x = tmp(:,2:3,3)-repmat(tmp(:,1,3),1,2);
yd_y = tmp(:,2:3,4)-repmat(tmp(:,1,4),1,2);

xs1_1 = xd_1'*xd_1; xs1_1 = xs1_1([1 2 4]);
xsc = xs1_1;

ys1_1 = yd_1'*yd_1; ys1_1 = ys1_1([1 2 4]);
ys1_y = 2*yd_1'*yd_y; ys1_y = ys1_y(:)'*[1 0 0 0;0 1/2 1/2 0;0 0 0 1]';
ysy_y = yd_y'*yd_y; ysy_y = ysy_y([1 2 4]);
ys1_x = 2*yd_1'*yd_x; ys1_x = ys1_x(:)'*[1 0 0 0;0 1/2 1/2 0;0 0 0 1]';
ysx_y = 2*yd_x'*yd_y; ysx_y = ysx_y(:)'*[1 0 0 0;0 1/2 1/2 0;0 0 0 1]';
ysx_x = yd_x'*yd_x; ysx_x = ysx_x([1 2 4]);

ysc = [ys1_1;ys1_y;ysy_y;ys1_x;ysx_y;ysx_x];

e1c = xsc(:,2)*ysc(:,1)' - xsc(:,1)*ysc(:,2)';
e2c = xsc(:,3)*ysc(:,1)' - xsc(:,1)*ysc(:,3)';
e3c = xsc(:,3)*ysc(:,2)' - xsc(:,2)*ysc(:,3)';
ec = [e1c e2c e3c];
ii= [4 16 2 14 5 17 10 8 11 1 13 6 18 3 15 7 12 9];
coeffs = ec(ii)';

function [C0,C1] = setup_elimination_template(data)
[coeffs] = compute_coeffs(data);
coeffs0_ind = [12,17,5,12,17,9,14,5,9,18,1,17,12,7,3,1,7,9,5,8,14,18];
coeffs1_ind = [16,10,10,7,1,16,10,16,8,3,3,8,18,14];
C0_ind = [1,6,7,8,9,12,13,14,15,18,19,22,23,24,25,26,27,28,29,30,32,33];
C1_ind = [4,5,7,10,11,12,14,15,16,17,20,21,22,23];
C0 = zeros(6,6);
C1 = zeros(6,4);
C0(C0_ind) = coeffs(coeffs0_ind);
C1(C1_ind) = coeffs(coeffs1_ind);

