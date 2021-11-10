function [ eqs, data0, eqs_data ] = problem_3dreg_303( data0 )

if nargin < 1 || isempty(data0)
    data0 = randi(30,3*3*(2+3),1);  
end


xx = create_vars(3);

m = 3;
n = 3;
dim = 3;
tmp = reshape(data0,3,3,(2+3));
x = tmp(:,:,1);
y = tmp(:,:,2)+xx(1)*tmp(:,:,3)+xx(2)*tmp(:,:,4)+xx(3)*tmp(:,:,5);
xd = x(:,2:3)-x(:,1)*ones(1,2);
yd = y(:,2:3)-y(:,1)*ones(1,2);

k = 0;
for k1 = 1:2
    for k2 = k1:2
        k = k+1;
        eqs(k,1)=xd(:,k1)'*xd(:,k2)-yd(:,k1)'*yd(:,k2);
    end
end


if nargout == 3
    oo = create_vars(3+3*3*(2+3));
    xx = oo(1:3);
    data = oo((3+1):end);
    
    
    m = 3;
    n = 3;
    dim = 3;
    tmp = reshape(data,3,3,(2+3));
    x = tmp(:,:,1);
    y = tmp(:,:,2)+xx(1)*tmp(:,:,3)+xx(2)*tmp(:,:,4)+xx(3)*tmp(:,:,5);   
    xd = x(:,2:3)-x(:,1)*ones(1,2);
    yd = y(:,2:3)-y(:,1)*ones(1,2);
    k = 0;
    clear eqs_data
    for k1 = 1:2
        for k2 = k1:2
            k = k+1;
            eqs_data(k,1)=xd(:,k1)'*xd(:,k2)-yd(:,k1)'*yd(:,k2);
        end
    end
end
