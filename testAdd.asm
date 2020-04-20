	.data
op1: .byte 2
op2: .byte 3
res: .space 1
	.text
	.globl main
	.ent main
main:
	lb $t1,op1
	lb $t2,op2
	add $t2,$t2,$t1
	sb $t2,res
	
	li $v0,10
	syscall
	
.end main