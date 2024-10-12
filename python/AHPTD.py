'''
ANALYTIC HIERARCHY PROCESS FOR TABULAR DATA (AHPTD)
Author: Bruno Rodrigues de Oliveira <bruno@editorapantanal.com.br>
ORCID: https://orcid.org/0000-0002-1037-6541
Version: 1

Reference Paper: Automatic and Semi-automatic Analytic Hierarchy Process (AHP)
DOI: https://doi.org/10.46420/TAES.e240009
Available: https://editorapantanal.com.br/journal/index.php/taes/article/view/17
'''

import numpy as np

class AHPTD:
    def __init__(self, type_conversion='C'):
        self.type_conversion = type_conversion

    # Amplitude transformation
    def Tamp(self, x, tau=0.01):
        x = np.array(x)
        return x + abs(np.min(x)) + tau

    # Normalization function
    def LMP(self, x):
        x = np.array(x)
        return x / np.sum(np.abs(x))

    # Normalization function
    def SMP(self, x):
        x = np.array(x)
        return 1.0 / (x * np.sum(1.0 / np.abs(x)))

    # Gets the weight of the criteria
    def CriterionWeight(self, V):
        avgV = np.mean(V, axis=0)
        N = V.shape[0]
        u = []
        for m in range(V.shape[1]):
            u.append((1 / N) * np.sum(np.abs(V[:, m] - avgV[m])))
        u = np.array(u) / np.sum(u)
        return u

    # Conversion function
    def Conversion(self, V):
        N = len(V)
        C = np.eye(N)

        for i in range(N - 1):
            for j in range(i + 1, N):
                r = V[i] / V[j]
                s = r ** self.f(r)

                if self.type_conversion == 'C':
                    s = np.ceil(s)
                elif self.type_conversion == 'F':
                    s = np.floor(s)
                elif self.type_conversion == 'I':
                    s = round(s)

                l = max(1, min(s, 9))

                C[i, j] = l ** self.f(r)
                C[j, i] = 1 / (l ** self.f(r))

        return C

    # Local priority vector
    def LPV(self, A):
        # Principal eigenvalue and eigenvector
        l, w = np.linalg.eig(A)
        l = np.real(l)
        idx = np.argmax(l)
        l = l[idx]
        w = np.real(w[:, idx])
        w = w / np.sum(w)

        # Consistency ratio
        n = A.shape[0]
        ri = [0.1e-10, 0.1e-10, 0.58, 0.90, 1.12, 1.24, 1.32, 1.41, 1.45, 1.49, 
              1.51, 1.48, 1.56, 1.57, 1.59, 1.605, 1.61, 1.615, 1.62, 1.625]

        if n > len(ri):
            cr = np.nan
        else:
            ci = (l - n) / (n - 1)
            cr = ci / ri[n - 1]

        return l, w, cr

    # Global priority vector
    def GPV(self, u, V):
        return np.dot(u, V.T)

    # Conversion helper function
    def f(self, r):
        return 1 if r > 1 else -1