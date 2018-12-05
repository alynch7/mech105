function [root,fx,ea,iter] = falsePosition(func,x_l,x_u,es,maxiter,varargin)
% falsePosition.m will find the roots of any given function and inclue info
% about iterations, error, and the value of fx at the root
%   INPUTS
%       func - the function being evaluated
%       x_l - the lower guess
%       x_u - the upper guess
%       es - the desired relative error (should default to 0.0001%)
%       maxiter - the number of iterations desired (shpuld default to 200)
%   OUTPUTS
%       root - the estimated root location
%       fx - the function evaluated at the root location
%       ea - the approximate relative error (%)
%       iter - how many iterations were performed


test = func(x_l,varargin{:})*func(x_u,varargin{:});
if test>0
    error('error, no sign change') % The if statement is used to find the interval 
                                   % of where the root can be
end

if nargin<4 || isempty(es)  % If statement sets parameters for error 
                            % based on the values the user inputs
    es = 0.0001;
end

if nargin<5 || isempty(maxiter) % If statement sets parameters for  iterations 
                                % based on the values the user inputs
    maxiter = 200;
end

iter = 0;
xr = x_l;
ea = 100;

while (1)
    xrold = xr;
    num = double(func(x_u))*(x_l-x_u);  % False position function numerator
    den = double(func(x_l))-double(func(x_u)); % False position function denominator
    xr = x_u-((num)/(den));
    iter = iter+1;   % Tells matlab to increase the value of iter by one for each run
    
    if xr ~= 00
        ea = abs((xrold-xr)/xr)*100;    % This is the calculated error
    end
    
    test = func(x_l,varargin{:})*func(xr,varargin{:}); % Plugs new root back in to see what the sign is
    
    if test<0
        x_u = xr;
    elseif text>0
        x_l = xr;
    end
    
    if ea<=es || iter>=maxiter
        break
    end
end
    root = xr;                       % Outputs
    fx = func(xr,varargin{:}); 
    

end
