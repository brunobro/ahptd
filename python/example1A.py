import numpy as np
from AHPTD import AHPTD

'''
Example #1A
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

x = ahptd_obj.GPV(u, V)