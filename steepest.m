clc;
clear all;

f = @(x1,x2) (x1)^2 + 2*(x2)^2;
grad_f = @(x1,x2) [2*x1, 4*x2];

X = [3, 3];
alpha = 0.1;
tol = 1e-6;

fprintf('Initial point (%.2f, %.2f)\n', X(1), X(2));

for iter = 1:100
    gradient = grad_f(X(1), X(2));
    
    if norm(gradient) < tol
        fprintf('Converged after %d iterations\n', iter-1);
        break;
    end
    
    X = X - alpha * gradient;
    
    fprintf('Iteration %d: X = (%.4f, %.4f), f(x) = %.6f\n', ...
        iter, X(1), X(2), f(X(1), X(2)));
end
