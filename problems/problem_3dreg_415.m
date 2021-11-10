function [eqs, data0, eqs_data] = problem_3dreg_415( data0)

if nargin < 1 || isempty(data0)
    data0 = randi(30,3*4*(2+6),1);
end

xx = create_vars(6);

m = 4;
n = 6; 
dim = 3; 
tmp = reshape(data0,dim,m,(2+n)); 
x = tmp(:,:,1)+xx(1)*tmp(:,:,2);
y = tmp(:,:,3)+xx(2)*tmp(:,:,4)+xx(3)*tmp(:,:,5)+xx(4)*tmp(:,:,6)+xx(5)*tmp(:,:,7)+xx(6)*tmp(:,:,8);

xd = x(:,2:m)-x(:,1)*ones(1,m-1);
yd = y(:,2:m)-y(:,1)*ones(1,m-1);

k = 0; 
for k1 = 1:m-1
    for k2 = k1:m-1
        k = k+1;
        eqs(k,1) = xd(:,k1)'*xd(:,k2)-yd(:,k1)'*yd(:,k2);
    end
end

if nargout == 3
    oo = create_vars(n+dim*m*(2+n));
    xx = oo(1:n);
    data = oo((n+1):end);
    
    m = 4; 
    n = 6; 
    dim = 3;
    tmp = reshape(data,dim,m,(2+n));
    x = tmp(:,:,1)+xx(1)*tmp(:,:,2);
    y = tmp(:,:,3)+xx(2)*tmp(:,:,4)+xx(3)*tmp(:,:,5)+xx(4)*tmp(:,:,6)+xx(5)*tmp(:,:,7)+xx(6)*tmp(:,:,8);
    xd = x(:,2:m)-x(:,1)*ones(1,m-1);
    yd = y(:,2:m)-y(:,1)*ones(1,m-1);
    k = 0;
    for k1 = 1:m-1
        for k2 = k1:m-1
            k = k+1;
            eqs_data(k,1) = xd(:,k1)'*xd(:,k2)-yd(:,k1)'*yd(:,k2);
        end
    end
end
