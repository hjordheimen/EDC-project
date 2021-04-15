function class = classifier(x, W_tilde)
%Returns class of Fisher vector x based on the linear discriminant
%classifier defined by the weight matrix W_tilde on homogenous form

    x_tilde = [x' 1]';    % Homogenous form
    g = W_tilde*x_tilde;
    
    [~, class] = max(g);
end

