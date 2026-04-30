clc;
clear all;

M = inf;

c = [3 -1 -1 0 0 -M -M];
A = [1 -2 1 1 0 0 0;
    -4 1 2 0 -1 1 0;
    -2 0 1 0 0 0 1];

b = [11; 3; 1];

m = size(A,1);
n = size(A,2);

X = zeros(n,1);
bv_index = n-m+1:n;

Y = [A b];

for s = 1:inf
    cb = c(bv_index);
    xb = Y(:,end);
    
    z = cb * xb;
    zj_cj = cb * Y(:,1:n) - c;
    
    if all(zj_cj >= 0)
        disp('optimal solution')
        xb
        basic_variables = bv_index
        X(basic_variables) = xb'
        fprintf('optimal objective function value = %f\n', z)
        break
    else
        [~, EV] = min(zj_cj);
        
        if all(Y(:,EV) <= 0)
            disp('unbounded solution')
            break
        else
            ratio = inf(m,1);
            for j = 1:m
                if Y(j,EV) > 0
                    ratio(j) = xb(j) / Y(j,EV);
                end
            end
            
            [~, LV] = min(ratio);
            
            bv_index(LV) = EV;
            
            pivot = Y(LV,EV);
            Y(LV,:) = Y(LV,:) / pivot;
            
            for i = 1:m
                if i ~= LV
                    Y(i,:) = Y(i,:) - Y(LV,:) * Y(i,EV);
                end
            end
        end
    end
end
