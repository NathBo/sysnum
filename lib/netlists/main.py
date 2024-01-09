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
    return Mux(addr[2],Concat(wmux4(addr),Constant("0000")),Concat(Constant("0000"),wmux4(addr)))

def wmux16(addr):
    return Mux(addr[3],Concat(wmux8(addr),Constant("00000000")),Concat(Constant("00000000"),wmux8(addr)))


def mulreg(we,waddr,wdata,raddr1,raddr2):
    a = wmux16(waddr)
    b = Mux(we,Constant("0000000000000000"),a)
    regarray = [reg_16bit(b[i],wdata) for i in range(16)]
    return (mux16(raddr1,regarray),mux16(raddr2,regarray))

def is0(a):
    rep = Constant("0")
    for i in range(a.bus_size):
        rep = Or(rep,a[i])
    return Not(rep)


def execute(r1,r2,sub,c,use2reg,do_operation,ram,we):
    #use2reg = 1 si on utilise r1 et r2, = 0 si on utilise r1 et c
    #do_operation = 1 si on fait un add/sub, = 0 si on fait un mov

    #add r1 r2 -> sub = 0, use2reg = 1, do_operation = 1, ram = 0, we = 1
    #sub r1 r2 -> sub = 1, use2reg = 1, do_operation = 1, ram = 0, we = 1
    #movr r1 r2 -> sub = any, use2reg = 1, do_operation = 0, ram = 0, we = 1
    #movc r1 c -> sub = any, use2reg = 0, do_operation = 0, ram = 0, we = 1
    #getram r1 r2 c -> sub = 0, use2reg = 1, do_operation = 1, ram = 1, we = 1
    #setram r1 r2 c -> sub = 0, use2reg = 1, do_operation = 1, ram = 1, we = 0
    #rom r1 r2 c -> sub = 0, use2reg = 1, do_operation = 1, ram = 1, we = 1, isjump = 0
    #jumpe r1 r2 c -> sub = 1, use2reg = 1, do_operation = 1, ram = 0, we = 0, isjump = 1
    #jumpg r1 r2 c -> sub = 0

    #faciles à faire mais pas dans le tableau de base
    #r1 <- r1 + c -> sub = 0, use2reg = 0, do_operation = 1, ram = 0, we = 1
    #r1 <- r1 - c -> sub = 1, use2reg = 0, do_operation = 1, ram = 0, we = 1
    val1,val2 = mulreg(we,r1,Defer(16, lambda : result),r1,r2)
    bon_val2 = Mux(use2reg,c,val2)
    bon_val1 = Mux(ram,val1,c)
    pre_result,_ = alu(sub,bon_val1,bon_val2)
    pre_result_regop = Mux(do_operation,bon_val2,pre_result)
    pre_result_ram = RAM(16,16,pre_result,Not(we),bon_val2,val1)
    result = Mux(ram,pre_result_regop,pre_result_ram)
    return result,is0(result)

def loop():
    ligne = reg_16bit(Constant("1"),Defer(16, lambda : nouvligne))
    instruction = ROM(16,32,ligne)
    isjump = Select(5,instruction)
    ligneplusun,_ = n_adder(ligne,Constant("1000000000000000"))
    c = Slice(16,32,instruction)
    res,a = execute(Slice(8,12,instruction),Slice(12,16,instruction),Select(0,instruction),c,Select(1,instruction),Select(2,instruction),Select(3,instruction),Select(4,instruction))
    eventuelligne = Mux(isjump,ligneplusun,c)
    nouvligne = Mux(a,ligneplusun,eventuelligne)
    return res,ligne,instruction,Slice(8,12,instruction)



def main():
    re,l,i,s = loop()
    re.set_as_output("re")
    l.set_as_output("l")
    i.set_as_output("i")
    s.set_as_output("sa")