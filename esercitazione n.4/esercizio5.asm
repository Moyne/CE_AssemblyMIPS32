	.data
tav:	.word  154, 123, 109, 86, 4, 0 , 412, -23, -231, 9, 50, 0, 123, -24, 12, 55, -45, 0, 0, 0, 0, 0, 0, 0 
	.text
	.globl main
	.ent main
main:
	la $s0,tav
	la $s1,tav
	la $s2,tav
	and $t2,$0,$0
	and $t3,$0,$0
	and $t4,$0,$0
	addi $t5,$0,5
	addi $t6,$0,3
	
	onlyx:	
			lw $t0,($s1)
			add $t2,$t2,$t0
			addi $t3,$t3,1
			addi $s1,$s1,4
			beq $t3,$t5,writex
			j onlyx
			
	writex:	
			sw $t2,($s1)
			addi $t4,$t4,1
			and $t2,$0,$0
			and $t3,$0,$0
			addi $s1,$s1,4
			bne $t4,$t6,onlyx
			
			and $t4,$0,$0
			and $t3,$0,$0
			addi $t5,$0,3
			addi $t6,$0,6
			
	onlyy:	
			lw $t0,($s2)
			add $t2,$t2,$t0
			addi $t3,$t3,1
			addi $s2,$s2,24
			beq $t3,$t5,writey
			j onlyy
			
	writey:	
			sw $t2,($s2)
			addi $t4,$t4,1
			and $t2,$0,$0
			and $t3,$0,$0
			addi $s0,$s0,4
			add $s2,$s0,$0
			bne $t4,$t6,onlyy
			
	li $v0,10
	syscall
	.end main
			
	
