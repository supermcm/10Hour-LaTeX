from pylab import *
import scipy.signal as signal
#A function to plot frequency and phase response
def mfreqz(b,a=1):
    w,h = signal.freqz(b,a)
    h = abs(h)
    return(w/max(w), h)
