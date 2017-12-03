import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import Rbf

import torch
from torch.autograd import Variable
from torch import nn

X = np.loadtxt('magsensordata_csv.csv',delimiter=',',skiprows=1)
Y = X[:,0]
X = X[:,1:]
idx = np.random.binomial(1,.9,len(Y)).astype(bool)
X_test = X[np.logical_not(idx),:]
Y_test = Y[np.logical_not(idx)]
X_train = X[idx,:]
Y_train = Y[idx]

# from scipy.interpolate import Rbf
# rbfi = Rbf(X_train[:,0], X_train[:,1], X_train[:,2], X_train[:,3], Y_train)
# y_pred = rbfi(X_test[:,0],X_test[:,1],X_test[:,2],X_test[:,3])

# from sklearn.gaussian_process import GaussianProcessRegressor
# gp = GaussianProcessRegressor()
# gp.fit(X_train,Y_train)
# y_pred = gp.predict(X_test)

# print(gp.get_params(deep=True))

from scipy.optimize import curve_fit
def gaussian(x,*p):
    A, mu, sigma, offset = p
    return A*np.exp(-(x-mu)**2/(2*sigma**2))+offset

coeff = [None]*4
coeff[0], _ = curve_fit(gaussian, Y, X[:,0], (-.09,4,.7,.72))
coeff[1], _ = curve_fit(gaussian, Y, X[:,1], (-.09,3,.7,.72))
coeff[2], _ = curve_fit(gaussian, Y, X[:,2], (-.09,2,.7,.72))
coeff[3], _ = curve_fit(gaussian, Y, X[:,3], (-.09,1,.7,.72))

for i,c in enumerate(coeff):
    plt.plot(Y,X[:,i],'.')
    y = np.linspace(0,5)
    plt.plot(y,gaussian(y,*c))
# plt.plot(Y,gaussian(Y,*[-.09,4,.7,.72]))


# position = np.argmin(X,axis=1)
# plt.plot(Y,X,'.')
# plt.figure()
# plt.plot(Y_test,y_pred,'.')
# plt.figure()
# plt.plot(Y,position,'.')
plt.show()