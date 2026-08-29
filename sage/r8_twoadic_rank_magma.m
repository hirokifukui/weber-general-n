// r8_twoadic_rank_magma.m - homework 27: independent Magma reproduction
// of the three F_2 ranks (fam1/fam2/fam3) in Z[z]/(z^256+1, 16).
// Independent code path: Magma quotient rings, no shared code with Sage.
N := 256;
R16 := Integers(16);
P<x> := PolynomialRing(R16);
Q<z> := quo< P | x^256 + 1 >;
den := z^2 - z + 1;
// invert den by Newton from the mod-2 inverse
P2<y> := PolynomialRing(GF(2));
g, s, t := XGCD(y^2 + y + 1, y^256 + 1);
assert g eq 1;
inv := Q ! P ! [ R16 ! (Integers() ! c) : c in Coefficients(s) ];
for step in [1..3] do
    inv := inv * (2 - den*inv);
end for;
assert den*inv eq Q!1;
print "MAGMA HW27: denominator inverse verified";
eps := (z^2 + z + 1) * inv;
// closed-form crosscheck
assert eps - 1 eq 2*z*inv;
print "MAGMA HW27: closed form (eps-1) = 2 z inv PASS";
// conjugates sigma^i : z -> z^(3^i mod 512), with z^256 = -1 handled by quotient
conj := [ Q | ];
for i in [0..63] do
    e := Modexp(3, i, 512);
    // build z^e in Q: e < 512; z^256 = -1 automatic in quotient
    zi := (Q!x)^e;
    // substitute: map coefficients of eps through z -> z^e
    co := Coefficients(P ! eps);
    im := Q ! 0;
    for k in [1..#co] do
        if co[k] ne 0 then
            im := im + co[k] * zi^(k-1);
        end if;
    end for;
    Append(~conj, im);
end for;
// three families over GF(2)
function ToBits(elt, k)
    co := Coefficients(P ! elt);
    v := [ GF(2) | ];
    for j in [1..N] do
        c := j le #co select Integers() ! co[j] else 0;
        assert c mod 2^k eq 0;
        Append(~v, GF(2) ! ((c div 2^k) mod 2));
    end for;
    return v;
end function;
M1 := Matrix(GF(2), 64, N, [ ToBits(conj[i] - 1, 1) : i in [1..64] ]);
M2 := Matrix(GF(2), 64, N, [ ToBits(conj[i]^2 - 1, 2) : i in [1..64] ]);
M3 := Matrix(GF(2), 64, N, [ ToBits(conj[i]^4 - 1, 3) : i in [1..64] ]);
print "MAGMA RANKS:", Rank(M1), Rank(M2), Rank(M3);
assert Rank(M1) eq 64 and Rank(M2) eq 64 and Rank(M3) eq 64;
print "R8 MAGMA TWOADIC RANK DONE";
