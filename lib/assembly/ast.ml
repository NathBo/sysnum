type reg = Reg of int list

type const = Const of int list

type instruction = 
	| Stop
	| Add of reg * reg
	| Sub of reg * reg
	| Movr of reg * reg
	| Movc of reg * const
	| Jump of reg * reg * const
	| Getram of reg * reg * const
	| Setram of reg * reg * const
	| Rom of reg * reg * const

type file = File of instruction list
