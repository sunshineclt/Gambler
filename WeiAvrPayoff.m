function Q = WeiAvrPayoff(t,j,alpha,V)
Q = (1 - 1/(t^alpha))*WeiAvrPayoff(t-1,j,alpha) + 1/(t^alpha)*V;