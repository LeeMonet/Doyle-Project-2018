function [A,B_2]= discretizeMatrices(A_c, B2_c, t)
%discretize discretize matrices
%   project support of A_c onto expm(A)

[sz , ~]= size(A_c);
A_e = expm(A_c*t);
A_sup = double((double(A_c ~= 0) + eye(sz)) ~=0);
A = A_sup .* A_e;

fun = @(x) A_sup .* expm(A_c*x) * B2_c;    
B_2 = integral(fun, 0, t, "ArrayValued", true);

end

