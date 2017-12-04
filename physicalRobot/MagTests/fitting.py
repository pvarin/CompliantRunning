import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import Rbf

import torch
from torch.autograd import Variable
from torch import nn

X = np.loadtxt('magsensordata_csv.csv',delimiter=',',skiprows=1)
Y = X[:,0]
X = X[:,1:]

from scipy.optimize import curve_fit
def gaussian(x,*p):
    A, mu, var, offset = p
    return A*np.exp(-(x-mu)**2/(2*var))+offset

coeff = [None]*4
coeff[0], _ = curve_fit(gaussian, Y, X[:,0], (-.09,4,.5,.72))
coeff[1], _ = curve_fit(gaussian, Y, X[:,1], (-.09,3,.5,.72))
coeff[2], _ = curve_fit(gaussian, Y, X[:,2], (-.09,2,.5,.72))
coeff[3], _ = curve_fit(gaussian, Y, X[:,3], (-.09,1,.5,.72))

print (coeff)

for i,c in enumerate(coeff):
    print("A: {}, mu: {}, var: {}, b: {}".format(*c))
    plt.plot(Y,X[:,i],'.')
    y = np.linspace(0,5)
    plt.plot(y,gaussian(y,*c))

plt.show()