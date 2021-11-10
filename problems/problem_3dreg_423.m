function [ eqs, data0, eqs_data ] = problem_3dreg_423( data0)

if nargin < 1 || isempty(data0)
    data0 = randi(30,3*4*(2+5),1);
end


xx = create_vars(5);

m = 4;
n = 5;
dim = 3;
tmp = reshape(data0,dim,m,(2+n));

x = tmp(:,:,1)+xx(1)*tmp(:,:,2)+xx(2)*tmp(:,:,3);
y = tmp(:,:,4)+xx(3)*tmp(:,:,5)+xx(4)*tmp(:,:,6)+xx(5)*tmp(:,:,7);
xd = x(:,2:m)-x(:,1)*ones(1,m-1);
yd = y(:,2:m)-y(:,1)*ones(1,m-1);
xs = [];
ys = [];
for k1 = 1:m-1
    for k2 = k1:m-1
        xs = [xs; xd(:,k1)'*xd(:,k2)];
        ys = [ys; yd(:,k1)'*yd(:,k2)];
    end
end

k = 0;
for k1 = 1:6
    for k2 = k1+1:6
        k = k+1;
        eqs(k) = xs(k1)*ys(k2)-ys(k1)*xs(k2);
    end
end


if nargout == 3
    oo = create_vars(n+dim*m*(2+n));
    xx = oo(1:n);
    data = oo((n+1):end);
    
    m = 4;
    n = 5;
    dim = 3;
    tmp = reshape(data,dim,m,(2+n));
    
    x = tmp(:,:,1)+xx(1)*tmp(:,:,2)+xx(2)*tmp(:,:,3);
    y = tmp(:,:,4)+xx(3)*tmp(:,:,5)+xx(4)*tmp(:,:,6)+xx(5)*tmp(:,:,7);
    xd = x(:,2:m)-x(:,1)*ones(1,m-1);
    yd = y(:,2:m)-y(:,1)*ones(1,m-1);
    xs = [];
    ys = [];
    for k1 = 1:m-1
        for k2 = k1:m-1
            xs = [xs; xd(:,k1)'*xd(:,k2)];
            ys = [ys; yd(:,k1)'*yd(:,k2)];
        end
    end
    
    k = 0;
    for k1 = 1:6
        for k2 = k1+1:6
            k = k+1;
            eqs_data(k) = xs(k1)*ys(k2)-ys(k1)*xs(k2);
        end
    end
    
end
