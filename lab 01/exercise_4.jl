using JuMP
using SCIP

DURATION = [0 2 1 3 2.5 1.5 2 4 3 0]
PRE_REQUISITE = [
    [],
    [1],
    [2],
    [2],
    [4],
    [4],
    [3 5],
    [6 7],
    [3 5],
    [8 9]
]

model = Model(SCIP.Optimizer)

@variable(model, INIT[1:10] >= 0)

@objective(model, Min, INIT[10])

[[@constraint(model, INIT[i] >= INIT[p] + DURATION[p]) for p in PRE_REQUISITE[i]] for i in 1:10]

optimize!(model)
@show objective_value(model)
@show value.(INIT)