using JuMP
using SCIP

NUMBER_OF_CYCLES = 6
CYCLE = [1:NUMBER_OF_CYCLES]
MIN_WORKERS_BY_CYCLE = [22 55 88 110 44 33]

model = Model(SCIP.Optimizer)

@variable(model, WORKERS_STARTING_BY_CYCLE[1:NUMBER_OF_CYCLES] >= 0)

@objective(model, Min, sum([WORKERS_STARTING_BY_CYCLE[t] for t in 1:NUMBER_OF_CYCLES]))

[@constraint(model, WORKERS_STARTING_BY_CYCLE[t] + (t > 1 ? WORKERS_STARTING_BY_CYCLE[t - 1] : WORKERS_STARTING_BY_CYCLE[NUMBER_OF_CYCLES])  >= MIN_WORKERS_BY_CYCLE[t]) for t in 1:NUMBER_OF_CYCLES]

optimize!(model)
@show objective_value(model)
@show value.(WORKERS_STARTING_BY_CYCLE)

