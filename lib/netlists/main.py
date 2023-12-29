from lib_carotte import *


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



def alu(sub,a,b):
    bnot = n_not(b)
    moins_b,_ = n_adder(bnot,Constant("1000000000000000"))       #y a 15 0 en tout
    bon_b = Mux(sub,b,moins_b)
    (s,c) = n_adder(a,bon_b)
    non_c = Not(c)
    bon_c = Mux(sub,c,non_c)
    return (s,bon_c)

def reg_1bit(we,wdata):
    rdata = Reg(Defer(1, lambda : new_rdata))
    new_rdata = Mux(we,rdata,wdata)
    return rdata


def reg_16bit(we,wdata):
    assert(wdata.bus_size == 16)
    rep = reg_1bit(we,wdata[0])
    for i in range(1,16):
        rep_i = reg_1bit(we,wdata[i])
        rep = rep + rep_i
    return rep


def mux4(addr,regarray):
    rep_0 = Mux(addr[0],regarray[0],regarray[1])
    rep_1 = Mux(addr[0],regarray[2],regarray[3])
    rep = Mux(addr[1],rep_0,rep_1)
    return  rep

def mux8(addr,regarray):
    rep_0 = mux4(addr,regarray[:4])
    rep_1 = mux4(addr,regarray[4:])
    rep = Mux(addr[2],rep_0,rep_1)
    return rep

def mux16(addr,regarray):
    rep_0 = mux8(addr,regarray[:8])
    rep_1 = mux8(addr,regarray[8:])
    rep = Mux(addr[3],rep_0,rep_1)
    return rep


def wmux2(addr):
    return Mux(addr[0],Constant("10"),Constant("01"))

def wmux4(addr):
    return Mux(addr[1],Concat(wmux2(addr),Constant("00")),Concat(Constant("00"),wmux2(addr)))

def wmux8(addr):
    return Mux(addr[1],Concat(wmux4(addr),Constant("0000")),Concat(Constant("0000"),wmux4(addr)))

def wmux16(addr):
    return Mux(addr[1],Concat(wmux8(addr),Constant("00000000")),Concat(Constant("00000000"),wmux8(addr)))


def mulreg(we,waddr,wdata,raddr1,raddr2):
    a = wmux16(waddr)
    b = Mux(we,Constant("0000000000000000"),a)
    regarray = [reg_16bit(b[i],wdata) for i in range(16)]
    return (mux16(raddr1,regarray),mux16(raddr2,regarray))


def add_reg(r1,r2,sub,c,usereg):
    val1,val2 = mulreg(Constant("1"),r1,Defer(16, lambda : result),r1,r2)
    bon_val2 = Mux(usereg,c,val2)
    result,_ = alu(sub,val1,bon_val2)
    return result



def main():
    r1 = Input(4)
    r2 = Input(4)
    sub = Input(1)
    c = Input(16)
    usereg = Input(1)
    re = add_reg(r1,r2,sub,c,usereg)
    re.set_as_output("re")