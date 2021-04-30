% Backtracking line search algorithm for finding optimal step length in 
% gradient descent optimization algorithms.
% Uses the Armijo rule for sufficient decrease
function alpha = BLS(f, f_val, df_val, x_k, p_k)
    % 0 < c < rho < 1
    alpha = 1;
    c = 1e-4;
    rho = 0.9;
  
    while f(x_k + alpha*p_k) > f_val + c*alpha*(df_val')*p_k

        if alpha < 1e-8
            error('Alpha too small -- something wrong');
        end

        alpha = rho*alpha;
    end
end