type reg = Reg of string

type const = Const of string

type instruction = 
	| Stop
	| Add of reg * reg
	| Addc of reg * const
	| Sub of reg * reg
	| Subc of reg * const
	| Movr of reg * reg
	| Movc of reg * const
	| Jump of reg * reg * const
	| Getram of reg * reg * const
	| Setram of reg * reg * const
	| Rom of reg * reg * const

type file = File of instruction list

