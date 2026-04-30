clc;
clear all;

demand = [5 8 7 14];
supply = [12 13 5];

cost = [23 27 16 18;
        12 17 20 51;
        22 28 12 32];

[m,n] = size(cost);

if sum(supply) == sum(demand)
    disp('Balanced problem');
elseif sum(supply) < sum(demand)
    cost(end+1,:) = zeros(1,n);
    supply(end+1) = sum(demand) - sum(supply);
else
    cost(:,end+1) = zeros(m,1);
    demand(end+1) = sum(supply) - sum(demand);
end

balanced = [cost supply'; demand sum(demand)];

[m,n] = size(cost);
X = zeros(m,n);
I_cost = cost;

while any(supply ~= 0) || any(demand ~= 0)
    min_cost = min(cost(:));
    [r,c] = find(cost == min_cost);
    
    y = min(supply(r), demand(c));
    [alloc,index] = max(y);
    
    rr = r(index);
    cc = c(index);
    
    X(rr,cc) = alloc;
    
    supply(rr) = supply(rr) - alloc;
    demand(cc) = demand(cc) - alloc;
    
    if supply(rr) == 0
        cost(rr,:) = inf;
    end
    
    if demand(cc) == 0
        cost(:,cc) = inf;
    end
end

if nnz(X) == m + n - 1
    disp('Non-degenerate')
else
    disp('Degenerate')
end

Matrix = I_cost .* X;
Final_cost = sum(Matrix(:))
