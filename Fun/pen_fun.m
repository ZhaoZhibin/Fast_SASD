function [phi , wfun] = pen_fun(a , pen)
% Construct the penlty function
% Input:
%          a    : the input signal
%          pen  : the penalty function
% Output:
%          phi  : penlty funtion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    switch pen
        case 'abs'
            phi = @(x) abs(x);
            wfun = @(x) abs(x);
            a = 0;
        case 'l0'
            phi = @(x) abs(x).^0.000001;
            wfun = @(x) abs(x).^0.000001;
        case 'rat'
            phi = @(x) abs(x)./(1+a*abs(x)/2);
            wfun = @(x) abs(x) .* (1 + a*abs(x)/2).^2;
        case 'log'
            phi = @(x) 1/a * log(1 + a*abs(x));
            wfun = @(x) abs(x) .* (1 + a*abs(x));
        case 'atan'
            phi = @(x) 2/(a*sqrt(3)) *  (atan((1+2*a*abs(x))/sqrt(3)) - pi/6);
            wfun = @(x) abs(x) .* (1 + a*abs(x) + a^2.*abs(x).^2);
        case 'mcp'        
            phi = @(t) (abs(t) - a/2 * t.^2).*(abs(t) <= 1/a) + 1/(2*a)*(abs(t) > 1/a);
            wfun = @(x) abs(x) ./ max(1 - a*abs(x), 0); 
            % Note: divide by zero OK -> divide by inf -> multiply by zero
        otherwise
            error('penalty must be ''abs'', ''log'', ''atan'', ''rat'', ''mcp''')
    end
end

