# tscan64.jl - ALL 64 class-1 components, full b-scan each (r9 hw 102, corrected:
# components are NOT Galois-equivalent for l = 1 mod 128). Reports per-component
# min and the binding max-min. Sequential over components, threaded over b.
using Base.Threads
function scan_component(l::UInt64, aj::UInt64, M::Matrix{Float64})
    A = zeros(UInt64, 64); A[1] = UInt64(1) % l
    for k in 2:64; A[k] = UInt64((UInt128(A[k-1]) * aj) % l); end
    half = l/2.0; inv2 = 2.0/l
    nt = Threads.maxthreadid() + 2
    gmin = fill(1e300, nt); garg = zeros(UInt64, nt); c4 = zeros(Int64, nt)
    @threads :static for b in UInt64(1):(l-UInt64(1))
        t = threadid()
        c = Vector{Float64}(undef, 64)
        @inbounds for k in 1:64
            r = UInt64((UInt128(b) * A[k]) % l)
            c[k] = r > half ? Float64(r) - Float64(l) : Float64(r)
        end
        T = 0.0
        @inbounds for j in 1:128
            s = 0.0
            @simd for k in 1:64; s += M[j,k]*c[k]; end
            T += exp(inv2 * s)
        end
        if T < gmin[t]; gmin[t] = T; garg[t] = b; end
        if T < 4224.0; c4[t] += 1; end
    end
    i = argmin(gmin)
    return gmin[i], garg[i], sum(c4)
end
function main()
    l = parse(UInt64, ARGS[1]); a = parse(UInt64, ARGS[2])
    lam = [parse(Float64, x) for x in readlines(ARGS[3])]
    M = [lam[((k-1)+(j-1)) % 128 + 1] for j in 1:128, k in 1:64]
    worst = -1.0; worstj = -1
    for j in 0:63
        e = 2*j + 1
        aj = UInt64(powermod(BigInt(a), e, BigInt(l)))
        m, arg, c4 = scan_component(l, aj, M)
        println("component j=$j (a^$e = $aj): min T = $m at b = $arg ; #T<4224 = $c4")
        flush(stdout)
        if m > worst; worst = m; worstj = j; end
    end
    println("BINDING max-min over 64 components: $worst at component $worstj")
    println(worst < 4224.0 ? "ALL COMPONENTS CLEAR THE 4224 BAR" : "AT LEAST ONE COMPONENT FAILS THE BAR")
    println("R9 TSCAN64 DONE")
end
main()
