module Logic

export logic, identity, inverse
import Base: identity

# logic
logic{T}(::Type{T}, op::Function, i::Function) = logic(T, Val{symbol(op)}, Val{symbol(i)})
logic{T}(n::T, op::Function, i::Function) = logic(n, Val{symbol(op)}, Val{symbol(i)})
identity{T}(::Type{T}, op::Function) = logic(T, Val{symbol(op)}, Val{:identity})
identity{T}(n::T, op::Function) = logic(n, Val{symbol(op)}, Val{:identity})
inverse{T}(::Type{T}, op::Function) = logic(T, Val{symbol(op)}, Val{:inverse})
inverse{T}(n::T, op::Function) = logic(n, Val{symbol(op)}, Val{:inverse})

# number identity
logic{T<:Number}(::Type{T}, ::Type{Val{:+}}, ::Type{Val{:identity}}) = zero
logic{T<:Number}(::Type{T}, ::Type{Val{:-}}, ::Type{Val{:identity}}) = zero
logic{T<:Number}(::Type{T}, ::Type{Val{:*}}, ::Type{Val{:identity}}) = one
logic{T<:Number}(::Type{T}, ::Type{Val{:/}}, ::Type{Val{:identity}}) = one
logic{T<:Number}(::Type{T}, ::Type{Val{:\}}, ::Type{Val{:identity}}) = one

# number inverse
logic{T<:Number}(::Type{T}, ::Type{Val{:+}}, ::Type{Val{:inverse}}) = -
logic{T<:Number}(::Type{T}, ::Type{Val{:-}}, ::Type{Val{:inverse}}) = +
logic{T<:Number}(::Type{T}, ::Type{Val{:*}}, ::Type{Val{:inverse}}) = :( /(1,n) )
logic{T<:Number}(::Type{T}, ::Type{Val{:/}}, ::Type{Val{:inverse}}) = :( \(1,n) )
logic{T<:Number}(::Type{T}, ::Type{Val{:\}}, ::Type{Val{:inverse}}) = :( /(n,1) )

# matrix
logic{T<:Matrix}(::Type{T}, ::Type{Val{:*}}, ::Type{Val{:identity}}) = eye
logic{T<:Matrix}(::Type{T}, ::Type{Val{:*}}, ::Type{Val{:inverse}}) = inv


for (T,op,i) in [
    (Number,+,identity),
    (Number,-,identity),
    (Number,*,identity),
    (Number,/,identity),
    (Number,\,identity),
    (Number,+,inverse),
    (Number,-,inverse),
    (Matrix,*,identity),
    (Matrix,*,inverse),
  ]
  @eval begin
    logic{T<:$T}(n::T, ::Type{Val{symbol($op)}}, ::Type{Val{symbol($i)}}) =
      logic(T, Val{symbol($op)}, Val{symbol($i)})(n)
  end
end

for (T,op,i) in [
    (Number,*,inverse),
    (Number,/,inverse),
    (Number,\,inverse),
  ]
  @eval begin
    @generated logic{T<:$T}(n::T, ::Type{Val{symbol($op)}}, ::Type{Val{symbol($i)}}) =
      logic(T, Val{symbol($op)}, Val{symbol($i)})
  end
end

# logic{T<:Number}(n::T, ::Type{Val{:+}}, ::Type{Val{:identity}}) = zero(n)
# logic{T<:Number}(n::T, ::Type{Val{:-}}, ::Type{Val{:identity}}) = zero(n)
# logic{T<:Number}(n::T, ::Type{Val{:*}}, ::Type{Val{:identity}}) = one(n)
# logic{T<:Number}(n::T, ::Type{Val{:/}}, ::Type{Val{:identity}}) = one(n)
# logic{T<:Number}(n::T, ::Type{Val{:\}}, ::Type{Val{:identity}}) = one(n)
# logic{T<:Number}(n::T, ::Type{Val{:+}}, ::Type{Val{:inverse}}) = -(n)
# logic{T<:Number}(n::T, ::Type{Val{:-}}, ::Type{Val{:inverse}}) = +(n)
# logic{T<:Number}(n::T, ::Type{Val{:*}}, ::Type{Val{:inverse}}) = /(1,n)
# logic{T<:Number}(n::T, ::Type{Val{:/}}, ::Type{Val{:inverse}}) = \(1,n)
# logic{T<:Number}(n::T, ::Type{Val{:\}}, ::Type{Val{:inverse}}) = /(n,1)
# logic{T<:Matrix}(m::T, ::Type{Val{:*}}, ::Type{Val{:identity}}) = eye(m)
# logic{T<:Matrix}(m::T, ::Type{Val{:*}}, ::Type{Val{:inverse}}) = inv(m)

end # module
