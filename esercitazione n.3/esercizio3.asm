.data
giorni: .byte 2
ore: 	.byte 4
minuti: .byte 10
ow: .asciiz "Errore overflow"
res: .word 0
.text
	.globl main
	.ent main
main:
	lb $t0,giorni
	lb $t1,ore
	lb $t2,minuti
	addi $t3,$0,24
	addi $t4,$0,60
	
	mul $t5,$t0,$t3
	mfhi $t6
	bne $t6,$0,owerr
	add $t1,$t1,$t5
	mul $t1,$t1,$t4
	mfhi $t6
	bne $t6,$0,owerr
	add $t2,$t2,$t1
	li $v0,1
	add $a0,$0,$t2
	syscall
	sw $t2,res
	j end
	
owerr: li $v0,4
		la $a0,ow
		syscall
		
end: li $v0,10
	syscall
	.end main