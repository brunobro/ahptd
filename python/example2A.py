import numpy as np
from AHPTD import AHPTD

'''
Example #2A
'''

# Example usage of the AHPTD class
ahptd_obj = AHPTD()

# Original values
C1 = [4000, 9330, 10660]
C2 = [11, 26, 30]
C3 = [30, 25, 35]
C4 = [25, 25, 120]
C5 = [1, 2, 2]
C6 = [0, 1, 1]
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

x = ahptd_obj.GPV(u, G)