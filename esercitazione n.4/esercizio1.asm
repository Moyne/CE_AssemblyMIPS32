	.data
fib:	.space 20*4
	.text
	.globl main
	.ent main
main:
	addi $t1,$0,1
	addi $t2,$0,1
	addi $t3,$0,18
	and $t4,$0,$0
	addi $t5,$0,4
	and $t6,$0,$0
	la $t0,fib
	sw $t1,($t0)
	add $t0,$t0,$t5
	sw $t1,($t0)
	add $t0,$t0,$t5


	loop:	
		add $t6,$t1,$t2
		add $t1,$0,$t2
		add $t2,$0,$t6
		sw $t6,($t0)
		addi $t4,$t4,1
		add $t0,$t0,$t5
		bne $t4,$t3,loop
		
	li $v0,10
	syscall
	
	.end main
		
