function [t,y] = Heun(dydt,tspan,y0,h,es,maxit)

% This function evaluates numerical functions using predictor and corrector
% equations from Heun's method
%   INPUT
%       dydt - Differential equation of interest
%       tspan - the length of the input span
%       y0 - initial condition for variable
%       h - step size
%       es - stopping criterion
%       maxit - maximum number of iterations
%   OUTPUT
%       t - t values of the function
%       y - value of the function at t

if nargin < 4 % function needs to have 4 inputs
    error('Must have 4 inputs')
end

if nargin < 5 % set default stopping criterion
    es = .001
end

if nargin < 6 % set default max iterations
    maxit = 50
end

row = ((tspan(2) - tspan(1))/h); % Calculates # of steps

if mod(row,1) > 0 || mod(row,1) < 0;
    new h = mod(row,1); % determines if smaller step size is needed
    row = row - newh
    q = zeros(1,row+2);
    w = zeros(1,row+2);
else
    q = zeros(1,row+1); % Create 0 matricies for b and c
    w = zeros(1,row+1);
    newh = 0; % If h covers all t values, then added h is 0
end

q(1) = tspan(1);
w(1) = y0 % Puts initial value for y in equation
val1 = w(1) + feval(dydt,q(1),w(1))*h; % predictor equation

for s = 1:row % runs for every step
    iter = 1; % sets iterations to 1
    q(s+1) = q(1) + s*h; % new b value
    ea = 100 % sets error back to 100
    
    while iter <= maxit && ea >= es % loop runs predictor eq until maxit is met
        valnew = w(s) + (h/2)*(feval(dydt,q(s),w(s)) + feval(dydt,q(s+1),val1));
        iter = iter +1; % counts interations
        ea = abs((valnew-val1)/valnew); % estimated error
        val1 = valnew;
    end
    
    w(s+1) = val1; %new estimate
    s = s+1
end

if newh ~= 0 % If extra step is needed
    h = newh
    iter = 1;
    ea = 100;
    q(s+1) = q(s) + h;
    while iter <= maxit && ea >= es % loop runs predictor eq until maxit is met
    valnew = w(s) + (h/2)*(feval(dydt,q(s),w(s)) + feval(dydt,q(s+1),val1));
    iter = iter +1; % counts interations
    ea = abs((valnew-val1)/valnew); % estimated error
    val1 = valnew;
    iter = iter + 1
    end
    
    w(s+1) = val1
    
end

t = q;
y = w;
plot(t,y)
xlabel('Values of t')
ylabel('Outputs of Eq')
title('Solutions of y(t)')
end
