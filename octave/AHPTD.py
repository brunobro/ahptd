
import numpy as np

class AHPTD:

    def __init__(self, data_matrix, mode='ceil'):
        
        data      = []
        data_type = []
        
        for l in range(0, len(data_matrix)):
            data.append(data_matrix[l][0])
            data_type.append(data_matrix[l][1])
        
        self.data        = np.array(data)
        self.data_type   = data_type
        (self.M, self.K) = self.data.shape

        self.__normdata() #Normalize the data table

    def __norm(self, v):
        '''
        Shortcut to normalize operation
        '''
        return v/np.linalg.norm(v, 1)
        
    def __normdata(self):
        '''
        Normalize the data
        '''
        data_norm = [] #normalized data

        for m in range(0, self.M):
            data_m = self.data[m,:] #original data
            if self.data_type[m] == 'LMP':
                data_norm.append(self.__norm(data_m))
            elif self.data_type[m] == 'SMP':
                inv_sum = 0
                for i in range(0, len(data_m)):
                    inv_sum += 1/data_m[i]
                    data_norm.append(1/(data_m * inv_sum))
        
        self.data_norm = np.array(data_norm).T #normalized data

if __name__ == '__main__':
    Price     = [20000, 30000, 45000, 40000]
    Guarantee = [5, 3, 2, 6]
    Kilometer = [1000, 500, 700, 1000]

    data_matrix = [(Price, 'SMP'), (Guarantee, 'LMP'), (Kilometer, 'LMP')]

    ahptd = AHPTD(data_matrix)
    print(ahptd.data_norm)
