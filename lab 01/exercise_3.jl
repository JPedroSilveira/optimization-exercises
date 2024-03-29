using JuMP
using SCIP

MIN_ACIDITY = 0.2
MAX_ACIDITY = 0.3

MIN_SWEETNESS = 0.3
MAX_SWEETNESS = 0.4

MIN_ALCOHOL = 0.03
MAX_ALCOHOL = 0.04

NUMBER_OF_INGREDIENTS = 10

INGREDIENT_ACIDITY = [0.15 0.15 0.9 0.6 0.2 0.5 0.6 0.3 0.8 0.4]
INGREDIENT_SWEETNESS = [0.15 0.15 0.54 0.93 0.21 0.2 0.43 0.12 0.8 0.9]
INGREDIENT_ALCOHOL = [0.02 0.05 0.08 0.1 0.3 0.02 0.06 0.03 0.08 0.077]
INGREDIENT_COST = [3.5 2.5 3 2 2 2.5 3 1 1 1]

model = Model(SCIP.Optimizer)

@variable(model, INGREDIENTS_QUANTITY[1:NUMBER_OF_INGREDIENTS] >= 0)

@objective(model, Min, sum([INGREDIENTS_QUANTITY[i] * INGREDIENT_COST[i] for i in 1:NUMBER_OF_INGREDIENTS]))

@constraint(model, sum([INGREDIENTS_QUANTITY[i] for i in 1:NUMBER_OF_INGREDIENTS]) == 1)

@constraint(model, sum([INGREDIENTS_QUANTITY[i] * INGREDIENT_ACIDITY[i] for i in 1:NUMBER_OF_INGREDIENTS]) >= MIN_ACIDITY)
@constraint(model, sum([INGREDIENTS_QUANTITY[i] * INGREDIENT_ACIDITY[i] for i in 1:NUMBER_OF_INGREDIENTS]) <= MAX_ACIDITY)

@constraint(model, sum([INGREDIENTS_QUANTITY[i] * INGREDIENT_SWEETNESS[i] for i in 1:NUMBER_OF_INGREDIENTS]) >= MIN_SWEETNESS)
@constraint(model, sum([INGREDIENTS_QUANTITY[i] * INGREDIENT_SWEETNESS[i] for i in 1:NUMBER_OF_INGREDIENTS]) <= MAX_SWEETNESS)

@constraint(model, sum([INGREDIENTS_QUANTITY[i] * INGREDIENT_ALCOHOL[i] for i in 1:NUMBER_OF_INGREDIENTS]) >= MIN_ALCOHOL)
@constraint(model, sum([INGREDIENTS_QUANTITY[i] * INGREDIENT_ALCOHOL[i] for i in 1:NUMBER_OF_INGREDIENTS]) <= MAX_ALCOHOL)

# Favorite ingredients are the first 5 on the list
@constraint(model, sum([INGREDIENTS_QUANTITY[i] for i in 1:5]) >= 2 * sum([INGREDIENTS_QUANTITY[i] for i in 6:NUMBER_OF_INGREDIENTS]))

# Find solution
optimize!(model)
@show objective_value(model)
@show value.(INGREDIENT_ACIDITY) value.(INGREDIENT_SWEETNESS) value.(INGREDIENT_ALCOHOL) value.(INGREDIENT_COST) value.(INGREDIENTS_QUANTITY) 