type reg = Reg of string

type const = Const of string

type labelname = Labelname of string

type instruction = 
	| Stop
	| Add of reg * reg
	| Addc of reg * const
	| Sub of reg * reg
	| Subc of reg * const
	| Movr of reg * reg
	| Movc of reg * const
	| Jump of reg * reg * labelname
	| Compc of reg * reg * labelname
	| Getram of reg * reg * const
	| Setram of reg * reg * const
	| Label of labelname

type file = File of instruction list

