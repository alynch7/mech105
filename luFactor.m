function [L,U,P,invA] = luFactor(A)
% the function luFactor performs LU decomposition on a system of equations
% and produces a lower trianglular matrix, an upper triangular matrix, and a pivot matrix
% **** CALL FUNCTION USING FORMAT [L,U,P] = luFactor(A) ****

% If you would like to know the inverse of A as well, call using [L,U,P,invA] = luFactor(A)
%   INPUTS
%       A - Coefficient matrix
%   OUTPUTS
%       L - Lower trianglular matrix
%       U - Upper triangular matrix
%       P - Pivot matrix

[r,c] = size(A); % size of matrix
if r~=c % Error if not same number of equations as variables
    error('input matrix must be square')
end

if nargin > 1 % Error if too many inputs
    error('Too many inputs')
end

L = eye(r); % identity matricies
P = eye(r);
U = A;

for i = 1: c-1
    Pivot = max(abs(U(i:c,i))); % pivoting
    for j = i:c
        if (abs(U(j,i)) == Pivot)
            var = j;
        end
    end
    U([i,var],i:c) = U([var,i],i:c); % Upper Row Change
    L([i,var],1:i-1) = L([var,i],1:i-1); % Lower Row Change
    P([i,var],:) = P([var,i],:); % Row Pivot
    for j = i+1:c
        L(j,i) = U(j,i)/U(i,i); % Lower Triangle
        U(j,i:c) = U(j,i:c) - L(j,i)*U(i,i:c); % Upper Triangle
    end
end

L_multiplied_by_U = L*U % Show L*U = A

% Finding invA
for q=[1:c];
    N=r;
    vec = zeros(N,1);
    positions=[q];
    vec(positions)=1;
    mat(:,q) = vec; % Create vectors that help to find d
end
for u = [1:c];
    d = L\(mat(:,u)); % Find inv rows using calculated values
    x = U\d;
    invA(:,u) = x; % Create inv matrix
end


end
            








