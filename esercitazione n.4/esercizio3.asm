		.data
xvett:	.word 8, 2, 9, 3
yvett:	.word 4, 6, 2, 7
res:	.space 16*4
	
		.text
		.globl main
		.ent main
	
main:
		la $t0,xvett
		la $t1,yvett
		la $t6,res
		and $t7,$0,$0
		addi $s0,$0,4
		and $s1,$0,$0 
		lw $t3,($t0)
	
loopy:
		lw $t4,($t1)
		mul $t5,$t3,$t4
		sw	$t5,($t6)
		addi $t7,$t7,1
		add $t1,$t1,$s0
		add $t6,$t6,$s0
		bne $t7,$s0,loopy
			
		addi  $s1,$s1,1
		bne $s1,$s0,loopx
		j end

loopx:
		la $t1, yvett
		add $t0,$t0,$s0
		and $t7,$0,$0
		lw $t3,($t0)
		j loopy
		
end:	li $v0,10
		syscall
	
		.end main
