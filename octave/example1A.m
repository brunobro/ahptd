clear all;
clc;
%
% Example #1
%

%Instance the AHPTD
ahptd_obj = AHPTD();

%Approach without PC matrix

%Original values
Price   = [200 300 500];
Size    = [150 50 100];
Renewal = [3000 2000 5500];
Style   = [1 2 3];

%Normalize values
Price_   = ahptd_obj.SMP(Price);
Size_    = ahptd_obj.LMP(Size);
Renewal_ = ahptd_obj.SMP(Renewal);
Style_   = ahptd_obj.LMP(Style);

%Normalized data matrix
V = [Price_; Size_ ; Renewal_; Style_]';

%Criterion weight
u = ahptd_obj.CriterionWeight(V);

%Global priority vector (GPV)
x = ahptd_obj.GPV(u, V)