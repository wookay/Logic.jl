push!(LOAD_PATH, "../src")
push!(LOAD_PATH, "src")

using Logic
using Base.Test

# number
@test 0 == identity(Number, +)
@test 0 == identity(Number, -)
@test 1 == identity(Number, *)
@test 1 == identity(Number, /)
@test 1 == identity(Number, \)

a = Number(5)
@test a == a + identity(a, +)
@test a == a - identity(a, -)
@test a == a * identity(a, *)
@test a == a / identity(a, /)
@test a == identity(a, \) \ a

@test 0 == a + inverse(a, +)
@test 0 == a - inverse(a, -)
@test 1 == a * inverse(a, *)
@test 1 == a / inverse(a, /)
@test 1 == inverse(a, \) \ a


# matrix
@test eye == identity(Matrix, *)
@test inv == inverse(Matrix, *)

@test [1 0;0 1] == identity([4 7;2 6], *)
@test_approx_eq [0.6 -0.7;-0.2 0.4] inverse([4 7;2 6], *)


# logic
@test 0 == logic(Number, +, identity)
@test 0 == 5 + logic(5, +, inverse)
@test eye == logic(Matrix, *, identity)
@test inv == logic(Matrix, *, inverse)
