using JuMP
using SCIP

# Problem Model
model = Model(SCIP.Optimizer)
@variable(model, c >= 0)
@variable(model, s >= 0)
@objective(model, Max, 0.2c + 0.5s)
@constraint(model, c + 1.5s <= 150)
@constraint(model, 50c + 50s <= 6000)
@constraint(model, c <= 80)
@constraint(model, s <= 60)
# set_upper_bound(s, 60)

# Find solution
optimize!(model)
@show objective_value(model)
@show value(c) value(s)