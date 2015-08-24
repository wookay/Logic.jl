push!(LOAD_PATH, "../src")
push!(LOAD_PATH, "src")

using Logic
using Base.Test

# number
@test zero == identity(Number, +)
@test zero == identity(Number, -)
@test one == identity(Number, *)
@test one == identity(Number, /)
@test one == identity(Number, \)

@test (-) == inverse(Number, +)
@test (+) == inverse(Number, -)
@test :(1/n) == inverse(Number, *)
@test :(1\n) == inverse(Number, /)
@test :(n/1) == inverse(Number, \)

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
@test zero == logic(Number, +, identity)
@test one == logic(Number, *, identity)
@test (-) == logic(Number, +, inverse)
@test :(1/n) == logic(Number, *, inverse)
@test eye == logic(Matrix, *, identity)
@test inv == logic(Matrix, *, inverse)
@test 0 == logic(5, +, identity)
@test 1 == logic(5, *, identity)
@test 0 == 5 + logic(5, +, inverse)
@test 1 == 5 * logic(5, *, inverse)
@test [1 0;0 1] == logic([4 7;2 6], *, identity)
@test_approx_eq [0.6 -0.7;-0.2 0.4] logic([4 7;2 6], *, inverse)
