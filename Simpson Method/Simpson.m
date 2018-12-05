function [I] = Simpson(x,y)
 % This function carries out Simpson's 1/3 composite rule for integration.
 
    % Inputs
    % X - vector given by user
    % Y - vector given byuser
    
    % Outputs
    % I - Estimated Integral
    
    
   % assign variables for x and y
   a = length(x)
   b = length(y)
   
   % Check if x and y are equal
   if a ~= b
       error('Length of vectors must be the same')
   end
   
   % Check if x intervals equal
   n = diff(x)
   if min(n) ~= max(n)
       error('Intervals must have equal spacing')
   end
   
   % Even or odd number of intervals
   % If odd, tells user trap integration will be used
   
  evens= mod(a,2)
  
  if evens == 0
      disp('Trapezoid Integration will be used due to odd number of integrals')
      T = a-1
  else
      T = a
  end
  
  % Simpsons
  h = (max(x)-min(x))/T
  I = sum(y(1:2:T-2) + 4*y(2:2:T-1) + y(3:2:T))*h/3
  % Trap
  if evens == 0
      I = I + ((y(a-1) + y(a))/2)*h
  end
  
end
