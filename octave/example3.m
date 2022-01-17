%
% Example #3
% Reference: Alelaiwi, A. (2019). Evaluating distributed IoT databases for edge/cloud platforms using the analytic hierarchy process. Journal of Parallel and Distributed Computing, 124, 41-46. https://doi.org/10.1016/j.jpdc.2018.10.008
% With conversion function

%Type of conversion
type = 'C';

%Instance the AHPTD
ahptd_obj = AHPTD(type);

%Original values for Alternatives DaDaBIK, DataFlex, Oracle application express and FileMaker
Usability      = [0.059 0.020 0.15 0.165];
Portability    = [0.0053 0.0427 0.0061 0.0455];
Supportability = [0.0255 0.0255 0.19 0.268];

%Normalize values
Usability_      = ahptd_obj.LMP(Usability);
Portability_    = ahptd_obj.LMP(Portability);
Supportability_ = ahptd_obj.LMP(Supportability);

%Get the PC matrices
A_Usability      = ahptd_obj.Conversion(Usability_);
A_Portability    = ahptd_obj.Conversion(Portability_);
A_Supportability = ahptd_obj.Conversion(Supportability_);

%Get the LPV
[l_Usability, v_Usability, cr_Usability]                = ahptd_obj.LPV(A_Usability);
[l_Portability, v_Portability, cr_Portability]          = ahptd_obj.LPV(A_Portability);
[l_Supportability, v_Supportability, cr_Supportability] = ahptd_obj.LPV(A_Supportability);

%With conversion function
%Normalized data matrix
V = [v_Usability; v_Portability; v_Supportability]';

%Criterion weight
u = ahptd_obj.CriterionWeight(V);

%GPV
x = ahptd_obj.GPV(u, V)