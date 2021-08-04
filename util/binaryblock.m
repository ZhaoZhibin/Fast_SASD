function [ B ] = binaryblock( K1 , N0 , N1 , M )
% 

% K1 : the vertical direction
% N0 : the size of zeros
% N1 : the size of ones
% M  : the number of period
% the horizontal direction length K2 = (N0+N1) * (M-1) + N1


Tmp = [ones(K1 , N1) , zeros(K1 , N0)];

Tmp = repmat(Tmp , 1 , M-1);

B = [Tmp , ones(K1 , N1)];


end

