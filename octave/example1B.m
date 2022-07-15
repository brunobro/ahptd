clear all;
clc;
%
% Example #1
%

%Type of conversion
type = 'C';

%Instance the AHPTD
ahptd_obj = AHPTD(type);

%Approach with PC matrix

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

%Get the PC matrix of criteria
A          = ahptd_obj.Conversion(u);
[l, u, cr] = ahptd_obj.LPV(A);

%Get the PC matrix of alternatives
A_Price   = ahptd_obj.Conversion(Price_);
A_Size    = ahptd_obj.Conversion(Size_);
A_Renewal = ahptd_obj.Conversion(Renewal_);
A_Style   = ahptd_obj.Conversion(Style_);

%Change de PC matrix A_style
%A_Style = [1 1/3 1/6; 3 1 1/2; 6 2 1];

%Get the LPV
[l_Price, v_Price, cr_Price]       = ahptd_obj.LPV(A_Price);
[l_Size, v_Size, cr_Size]          = ahptd_obj.LPV(A_Size);
[l_Renewal, v_Renewal, cr_Renewal] = ahptd_obj.LPV(A_Renewal);
[l_Style, v_Style, cr_Style]       = ahptd_obj.LPV(A_Style);

%Get the GPV
V = [v_Price; v_Size; v_Renewal; v_Style]';
x = ahptd_obj.GPV(u, V)
