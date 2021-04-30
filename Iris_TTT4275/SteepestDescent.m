% Simple optimization algorithm for nonlinear unconstrained optimization
% Finds local minimum of object function

function [x,f_opt] = SteepestDescent(f,gradf,x0,tol,N)
% f         function handle for object function
% gradf     function handle for gradient of object function

% Returns all iterates of x and value 
% of object function for final iterate

    row = size(x0, 1);
    col = size(x0, 2);

    if nargin < 5
        N = 100;
    end
    if nargin < 4
        tol = 1e-8;
    end
    
    iterate = true;
    x = NaN(row,(N+1)*col);
    x(:,1:col) = x0;
    
    xk = x0;
    i = 1;
    
    while iterate
        % Perform next iterate step
        pk = -gradf(xk);
        ak = 0.00585; %BLS(f,f(xk),xk,gradf(xk),pk);
        xk_p1 = xk + ak*pk;
        
        % Check termination criterions
        iterate = (norm(gradf(xk), inf) > tol & norm(xk_p1 - xk, inf) > tol & norm(f(xk_p1) - f(xk), inf) > tol & i < N); % Checking all termination criterias
        
        % Store and update iterate
        x(:,i*col + 1:i*col + col) = xk_p1;
        xk = xk_p1;
        i = i + 1;
    end
    
    x = x(:,1:i*col);
    f_opt = f(x(:,end-col + 1:end));
end

