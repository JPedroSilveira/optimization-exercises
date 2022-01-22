using JuMP
using SCIP
using Random

C = 50
n = 10
c = rand(1:20, 10)
w = rand(1:10, 10)

model = Model(SCIP.Optimizer)

@variable(model, x[1:n] >= 0)

@objective(model, Max, sum([c[i] * x[i] for i in 1:n]))

@constraint(model, sum([w[i] * x[i] for i in 1:n]) <= C)

optimize!(model)

@show objective_value(model)
@show value.(x)