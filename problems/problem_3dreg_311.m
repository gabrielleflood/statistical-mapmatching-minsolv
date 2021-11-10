function [ eqs, data0, eqs_data ] = problem_3dreg_311( data0 )

if nargin < 1 || isempty(data0)
    data0 = randi(30,3*3*(2+2),1); 
end


xx = create_vars(2);

m = 3;
n = 3;
dim = 2;
tmp = reshape(data0,3,3,(2+dim));
x = tmp(:,:,1)+xx(1)*tmp(:,:,2);
y = tmp(:,:,3)+xx(2)*tmp(:,:,4);

xd = x(:,2:3)-x(:,1)*ones(1,2);
yd = y(:,2:3)-y(:,1)*ones(1,2);
xs = [xd(:,1)'*xd(:,1); xd(:,1)'*xd(:,2);  xd(:,2)'*xd(:,2)];
ys = [yd(:,1)'*yd(:,1); yd(:,1)'*yd(:,2);  yd(:,2)'*yd(:,2)];
eqs(1) = xs(2)*ys(1)-ys(2)*xs(1);
eqs(2) = xs(3)*ys(1)-ys(3)*xs(1);
eqs(3) = xs(3)*ys(2)-ys(3)*xs(2);

if nargout == 3
    oo = create_vars(2+3*3*(2+2));
    xx = oo(1:2);
    data = oo((2+1):end);
    
    m = 3;
    n = 3;
    dim = 3;
    tmp = reshape(data,3,3,(2+2));
    x = tmp(:,:,1)+xx(1)*tmp(:,:,2);
    y = tmp(:,:,3)+xx(2)*tmp(:,:,4);

    xd = x(:,2:3)-x(:,1)*ones(1,2);
    yd = y(:,2:3)-y(:,1)*ones(1,2);
    xs = [xd(:,1)'*xd(:,1); xd(:,1)'*xd(:,2);  xd(:,2)'*xd(:,2)];
    ys = [yd(:,1)'*yd(:,1); yd(:,1)'*yd(:,2);  yd(:,2)'*yd(:,2)];
    eqs_data(1) = xs(2)*ys(1)-ys(2)*xs(1);
    eqs_data(2) = xs(3)*ys(1)-ys(3)*xs(1);
    eqs_data(3) = xs(3)*ys(2)-ys(3)*xs(2);
end
