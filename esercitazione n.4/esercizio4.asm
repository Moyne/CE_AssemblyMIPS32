	.data
	tav:	.space 400
	.text
	.globl main
	.ent main
main:
	la $t0,tav
	and $t1,$0,$0
	and $t2,$0,$0
	addi $t3,$0,10
	loopy:	mul $t5,$t1,$t2
			sw $t5,($t0)
			addi $t2,$t2,1
			addi $t0,$t0,4
			bne $t2,$t3,loopy
			
	addi $t1,$t1,1
	bne $t1,$t3,loopx
	j end
	
	loopx:	addi $t1,$t1,4
			and $t2,$0,$0
			loopx
			
	end:	li $v0,10
			syscall
			.end main