import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import Rbf

import torch
from torch.autograd import Variable
from torch import nn

X = np.loadtxt('magData2.csv',delimiter=',',skiprows=0)
Y = X[:,0]
X = X[:,1:]

from scipy.optimize import curve_fit
def gaussian(x,*p):
    mu, var, A, offset = p
    return A*np.exp(-(x-mu)**2/(2*var))+offset

coeff = [None]*4
coeff[0], _ = curve_fit(gaussian, Y, X[:,0], (4,.5,-.09,.72))
coeff[1], _ = curve_fit(gaussian, Y, X[:,1], (3,.5,-.09,.72))
coeff[2], _ = curve_fit(gaussian, Y, X[:,2], (2,.5,-.09,.72))
coeff[3], _ = curve_fit(gaussian, Y, X[:,3], (1,.5,-.09,.72))

print (coeff)

for i,c in enumerate(coeff):
    print("{},{},{},{}".format(*c))
    # print("A: {}, mu: {}, var: {}, b: {}".format(*c))
    plt.plot(Y,X[:,i],'.')
    y = np.linspace(0,5)
    plt.plot(y,gaussian(y,*c))

plt.show()