import numpy as np
from AHPTD import AHPTD

'''
Example #1B
'''

# Example usage of the AHPTD class
ahptd_obj = AHPTD()

# Original values
Cri1 = np.array([200, 300, 500])
Cri2 = np.array([150, 50, 100])
Cri3 = np.array([3000, 2000, 5500])
Cri4 = np.array([1, 2, 3])

# Normalize values
Price_ = ahptd_obj.SMP(Cri1)
Size_ = ahptd_obj.LMP(Cri2)
Renewal_ = ahptd_obj.SMP(Cri3)
Style_ = ahptd_obj.LMP(Cri4)

# Normalized data matrix
V = np.array([Price_, Size_, Renewal_, Style_]).T

# Criteria weight
u = ahptd_obj.CriterionWeight(V)

# Get the PC matrix of criteria
A = ahptd_obj.Conversion(u)
l, u_criteria, cr_criteria = ahptd_obj.LPV(A)

# Get the PC matrix of alternatives
A_Price = ahptd_obj.Conversion(Price_)
A_Size = ahptd_obj.Conversion(Size_)
A_Renewal = ahptd_obj.Conversion(Renewal_)
A_Style = ahptd_obj.Conversion(Style_)

# Get the local priority vectors
l_Price, v_Price, cr_Price = ahptd_obj.LPV(A_Price)
l_Size, v_Size, cr_Size = ahptd_obj.LPV(A_Size)
l_Renewal, v_Renewal, cr_Renewal = ahptd_obj.LPV(A_Renewal)
l_Style, v_Style, cr_Style = ahptd_obj.LPV(A_Style)

# Get the global priority vector
V_global = np.array([v_Price, v_Size, v_Renewal, v_Style]).T
x = ahptd_obj.GPV(u_criteria, V_global)