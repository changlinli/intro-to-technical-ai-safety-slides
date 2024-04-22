# QKV-Composition

When we consider how two attention heads in two different layers of a
transformer can compose, there are three main ways they can interact with each
other.

## V-Composition

V-composition ends up 

We can talk about


y_i, y_j





$OV_0(a_{0, 0, 0} x_0 + a_{0, 0, 1} x_1)$
OV_0(a_{0, 1, 0} x_0 + a_{0, 1, 1} x_1)

OV_1(a_{1, 0, 0} OV_0(a_{0, 0, 0} x_0 + a_{0, 0, 1} x_1) + a_{1, 0, 1} OV_0(a_{0, 1, 0} x_0 + a_{0, 1, 1} x_1))
OV_1(a_{1, 1, 0} OV_0(a_{0, 0, 0} x_0 + a_{0, 0, 1} x_1) + a_{1, 1, 1} OV_0(a_{0, 1, 0} x_0 + a_{0, 1, 1} x_1))

a_{1, 0, 0} a_{0, 0, 0} OV_1(OV_0(x_0)) + a_{1, 0, 0} a_{0, 0, 1} OV_1(OV_0(x_1)) + a_{1, 1, 1} a_{0, 1, 0} OV_1(OV_0(x_0)) + a_{1, 1, 1} a_{0, 1, 1} OV_1(OV_0(x_1))

(a_{1, 0, 0} a_{0, 0, 0} + a_{1, 1, 1} a_{0, 1, 0}) OV_1(OV_0(x_0)) + (a_{1, 0, 0} a_{0, 0, 1} + a_{1, 1, 1} a_{0, 1, 1}) OV_1(OV_0(x_1))


