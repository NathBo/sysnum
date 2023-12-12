def full_adder(a, b, c):
    tmp = a ^ b
    return (tmp ^ c, (tmp & c) | (a & b))


def n_adder(a, b):
    assert(a.bus_size == 16 and b.bus_size == 16)
    c = Constant("0")
    (s, c) = full_adder(a[0], b[0], c) 
    for i in range(1, 16):
        (s_i, c) = full_adder(a[i], b[i], c)
        s = s + s_i
    return (s, c)


def n_not(a):
    rep = Not(a[0]) 
    for i in range(1,16):
        rep_i = Not(a[i])
        rep = rep + rep_i
    return rep

def mux16(a,b,c):
    assert(a.bus_size == 16 and b.bus_size == 16)
    rep = Mux(a[0],b[0],c) 
    for i in range(16):
        rep_i = Mux(a[i],b[i],c)
        rep = rep + rep_i



def alu(a,b,sub):
    bnot = n_not(b)
    moins_b = n_adder(bnot,Constant("0000000000000001"))       #y a 15 0 en tout
    bon_b = mux16(b,moins_b,sub)
    (s,c) = n_adder(a,bon_b)
    return (s,c)


def main():
    a = Input(16)
    b = Input(16)
    sub = Input(1)
    (s,c) = alu(a,b,sub)
    s.set_as_output("sum")
    c.set_as_output("overflow")