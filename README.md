# Logic

Linux, OSX: [![Build Status](https://api.travis-ci.org/wookay/Logic.jl.svg?branch=master)](https://travis-ci.org/wookay/Logic.jl)
Windows: [![Build status](https://ci.appveyor.com/api/projects/status/kbx8cnnyaws4uuf5?svg=true)](https://ci.appveyor.com/project/wookay/Logic.jl)
[![Coverage Status](https://coveralls.io/repos/wookay/Logic.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/wookay/Logic.jl?branch=master)


# install

```shell
λ ~$ julia
               _
   _       _ _(_)_     |  A fresh approach to technical computing
  (_)     | (_) (_)    |  Documentation: http://docs.julialang.org
   _ _   _| |_  __ _   |  Type "?help" for help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 0.4.0-dev+7032 (2015-08-27 04:01 UTC)
 _/ |\__'_|_|_|\__'_|  |  Commit 5d3ccd6 (0 days old master)
|__/                   |  x86_64-apple-darwin14.5.0

julia> Pkg.clone("git@github.com:wookay/Logic.jl.git")
INFO: Cloning Logic from git@github.com:wookay/Logic.jl.git
INFO: Computing changes...

julia> using Logic
```


# examples
```shell
julia> using Logic

julia> identity(Number, +)
zero (generic function with 13 methods)

julia> a = 5
5

julia> identity(a, +) + a == a
true

julia> inverse(Number, +)
- (generic function with 182 methods)

julia> inverse(a, +) + a == 0
true

julia> A = [4 7; 2 6]
2x2 Array{Int64,2}:
 4  7
 2  6

julia> identity(Matrix, *)
eye (generic function with 7 methods)

julia> identity(A, *) * A == A
true

julia> inverse(Matrix, *)
inv (generic function with 28 methods)

julia> A * inverse(A, *)
2x2 Array{Float64,2}:
 1.0  0.0
 0.0  1.0
```
