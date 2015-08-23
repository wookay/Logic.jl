module Logic

export logic, identity, inverse
import Base: identity

# logic
logic{T}(::Type{T}, op::Function, i::Function) = logic(T, Val{symbol(op)}, Val{symbol(i)})
logic{T}(n::T, op::Function, i::Function) = logic(n, Val{symbol(op)}, Val{symbol(i)})

identity{T}(::Type{T}, op::Function) = logic(T, Val{symbol(op)}, Val{:identity})
identity{T}(n::T, op::Function) = logic(n, Val{symbol(op)}, Val{:identity})
inverse{T}(n::T, op::Function) = logic(n, Val{symbol(op)}, Val{:inverse})

# number identity
logic{T<:Number}(::Union{T,Type{T}}, ::Type{Val{:+}}, ::Type{Val{:identity}}) = 0
logic{T<:Number}(::Union{T,Type{T}}, ::Type{Val{:-}}, ::Type{Val{:identity}}) = 0
logic{T<:Number}(::Union{T,Type{T}}, ::Type{Val{:*}}, ::Type{Val{:identity}}) = 1
logic{T<:Number}(::Union{T,Type{T}}, ::Type{Val{:/}}, ::Type{Val{:identity}}) = 1
logic{T<:Number}(::Union{T,Type{T}}, ::Type{Val{:\}}, ::Type{Val{:identity}}) = 1

# number inverse
logic{T<:Number}(n::T, ::Type{Val{:+}}, ::Type{Val{:inverse}}) = -n
logic{T<:Number}(n::T, ::Type{Val{:-}}, ::Type{Val{:inverse}}) = +n
logic{T<:Number}(n::T, ::Type{Val{:*}}, ::Type{Val{:inverse}}) = 1/n
logic{T<:Number}(n::T, ::Type{Val{:/}}, ::Type{Val{:inverse}}) = 1\n
logic{T<:Number}(n::T, ::Type{Val{:\}}, ::Type{Val{:inverse}}) = n

# matrix
logic{T<:Matrix}(::Type{T}, ::Type{Val{:*}}, ::Type{Val{:identity}}) = eye
logic{T<:Matrix}(m::T, ::Type{Val{:*}}, ::Type{Val{:identity}}) = eye(m)
logic{T<:Matrix}(::Type{T}, ::Type{Val{:*}}, ::Type{Val{:inverse}}) = inv
logic{T<:Matrix}(m::T, ::Type{Val{:*}}, ::Type{Val{:inverse}}) = inv(m)

end # module
