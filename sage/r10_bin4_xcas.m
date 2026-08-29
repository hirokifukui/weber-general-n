// r10 bin 4 cross-CAS (Magma): D_7 by (1) Gram determinant, (2) character product, (3) L(1,chi) product.
// All from KY definitions: X = 2cos(2pi/512), sigma = 3-multiplication, eps = (X+1)/(X-1).
SetDefaultRealFieldPrecision(60);
n := 7; m := 64; N := 128; M := 512;
RR := RealField(60); CC := ComplexField(60);
lam := [RR | ];
for j in [0..N-1] do
  e := Modexp(3, j, M);
  X := 2*Cos(RR!e * 2*Pi(RR)/M);
  Append(~lam, Log(Abs((X+1)/(X-1))));
end for;
ap := Max([Abs(lam[j+1]+lam[j+m+1]) : j in [0..m-1]]);
print "ANTIPERIOD max defect:", ap;
H := Matrix(RR, N, m, [lam[((i+j) mod N)+1] : i in [0..m-1], j in [0..N-1]]);
G := Transpose(H)*H;
lnD_gram := Log(Determinant(G))/2;
print "lnD7 GRAM   :", lnD_gram;
s := RR!0;
for r in [0..m-1] do
  w := Exp(2*Pi(CC)*CC.1*(2*r+1)/N);
  s +:= Log(Abs(&+[lam[j+1]*w^j : j in [0..N-1]]));
end for;
lnD_char := -(RR!m/2)*Log(RR!2) + s;
print "lnD7 CHAR   :", lnD_char;
print "gram-char   :", lnD_gram - lnD_char;
// L-values
Gq := DirichletGroup(M, CyclotomicField(2^n));
cnt := 0; sL := RR!0;
for chi in Elements(Gq) do
  if IsEven(chi) and Conductor(chi) eq M then
    L := LSeries(chi : Precision := 40);
    v := Evaluate(L, 1);
    sL +:= Log(Abs(v));
    cnt +:= 1;
  end if;
end for;
print "number of chi:", cnt;
lnD_L := (RR!m*(n+1)/2 + 1)*Log(RR!2) + sL;
print "lnD7 LROUTE :", lnD_L;
print "gram-L      :", lnD_gram - lnD_L;
L7 := Sqrt(RR!2^n)*Log(2+Sqrt(RR!5));
lnC := (RR!m/2)*Log(2/Pi(RR)) + Log(Gamma(RR!(m+2)/2 + 1)) + lnD_gram - m*Log(L7);
print "lnC7        :", lnC;
print "C7          :", Exp(lnC);
print "R10 BIN4 XCAS DONE";
