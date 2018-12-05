# False Position Function

falsePosition.m will find the roots of any given function and inclue info about iterations, error, and the value of fx at the root

### INPUTS

func - the function being evaluated

x_l - the lower guess

x_u - the upper guess

es - the desired relative error (should default to 0.0001%)

maxiter - the number of iterations desired (shpuld default to 200)

### OUTPUTS

root - the estimated root location

fx - the function evaluated at the root location

ea - the approximate relative error (%)

iter - how many iterations were performed
