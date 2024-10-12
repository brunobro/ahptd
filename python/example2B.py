import numpy as np
from AHPTD import AHPTD

'''
Example #2B
'''

# Example usage of the AHPTD class
ahptd_obj = AHPTD()

# Original values
C1 = [4000, 9330, 10660]
C2 = [11, 26, 30]
C3 = [30, 25, 35]
C4 = [25, 25, 120]
C5 = [1, 2, 2]
C6 = [0 + 0.1, 1 + 0.1, 1 + 0.1] # + 0.1: Can be considered tau > 0
C7 = [290000000, 310000000, 310000000]
C8 = [592000000, 633000000, 633000000]
C9 = [6, 8, 8]

# Normalize values
C1_ = ahptd_obj.LMP(C1)
C2_ = ahptd_obj.LMP(C2)
C3_ = ahptd_obj.LMP(C3)
C4_ = ahptd_obj.LMP(C4)
C5_ = ahptd_obj.LMP(C5)
C6_ = ahptd_obj.LMP(C6)
C7_ = ahptd_obj.SMP(C7)
C8_ = ahptd_obj.SMP(C8)
C9_ = ahptd_obj.SMP(C9)

# Normalized data matrix
G = np.array([C1_, C2_, C3_, C4_, C5_, C6_, C7_, C8_, C9_]).T

# Criteria weight
u = ahptd_obj.CriterionWeight(G)

# Criterion weight (semi-automated approach)
A               = ahptd_obj.Conversion(u)
[l_A, u_, cr_A] = ahptd_obj.LPV(A)

# Get the PC matrix
A_C1 = ahptd_obj.Conversion(C1_)
A_C2 = ahptd_obj.Conversion(C2_)
A_C3 = ahptd_obj.Conversion(C3_)
A_C4 = ahptd_obj.Conversion(C4_)
A_C5 = ahptd_obj.Conversion(C5_)
A_C6 = ahptd_obj.Conversion(C6_)
A_C7 = ahptd_obj.Conversion(C7_)
A_C8 = ahptd_obj.Conversion(C8_)
A_C9 = ahptd_obj.Conversion(C9_)

# Get the LPV
[l_C1, v_C1, cr_C1] = ahptd_obj.LPV(A_C1)
[l_C2, v_C2, cr_C2] = ahptd_obj.LPV(A_C2)
[l_C3, v_C3, cr_C3] = ahptd_obj.LPV(A_C3)
[l_C4, v_C4, cr_C4] = ahptd_obj.LPV(A_C4)
[l_C5, v_C5, cr_C5] = ahptd_obj.LPV(A_C5)
[l_C6, v_C6, cr_C6] = ahptd_obj.LPV(A_C6)
[l_C7, v_C7, cr_C7] = ahptd_obj.LPV(A_C7)
[l_C8, v_C8, cr_C8] = ahptd_obj.LPV(A_C8)
[l_C9, v_C9, cr_C9] = ahptd_obj.LPV(A_C9)

# Global priority vector (GPV)
V = np.array([v_C1, v_C2, v_C3, v_C4, v_C5, v_C6, v_C7, v_C8, v_C9]).T

x = ahptd_obj.GPV(u_, V)