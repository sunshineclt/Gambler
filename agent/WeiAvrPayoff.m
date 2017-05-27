function Q = WeiAvrPayoff(Qt_1, t, alpha, V)
Q = (1 - 1/(t^alpha))*Qt_1 + 1/(t^alpha)*V;