type reg = Reg of string

type const = Const of string

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

