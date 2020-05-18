	.data
	val:	.word 3141592653
	.text
	.globl main
	.ent main
main:
	lw $t0,val
	and $t3,$0,$0						#i
	addi $t1,$0,10						#t1=10
resto:
	divu $t0,$t0,$t1					#t0=t0/10
	mfhi $t2							#t2=t0%10 resto
	addi $t3,$t3,1						#i++
	addi $sp,$sp,-4						#allocazione dello stack
	sw $t2,($sp)						#salvo il resto nello stack
	bne $t0,$0,resto					#se il quoziente è 0 ho finito di leggere la parola
	
	
stampa:	
	lw $t0,($sp)						#lettura dallo stack
	addi $sp,$sp,4						#deallocazione dello stack
	li $v0,1
	add $a0,$t0,$0
	syscall
	addi $t3,$t3,-1						#i--
	bne $t3,$0,stampa					#se non ho ancora finito le cifre stampo ancora if(i!=0)
	
	li $v0,10
	syscall
	.end main