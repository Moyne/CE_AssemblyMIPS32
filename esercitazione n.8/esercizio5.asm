	.data
	str_orig: .asciiz "% nella citta' dolente, % nell'eterno dolore, % tra la perduta gente %"
	str_sost: .asciiz "per me si va"
	str_new: .space 200
	.text
	.globl main
	.ent main
main:
	la $a0, str_orig
	la $a1, str_sost
	la $a2, str_new
	addi $sp,$sp,-4
	sw $ra,($sp)
	jal sostituisci
	la $a0,str_new
	li $v0,4
	syscall
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
	.end main

sostituisci:
	addi $sp,$sp,-12
	sw $a0,8($sp)
	sw $a1,4($sp)
	sw $a2,($sp)
	loop:
		lb $t1,($a0)
		beq $t1,0,end
		beq $t1,37,sost
		sb $t1,($a2)
		addi $a2,$a2,1
		next:
			addi $a0,$a0,1
			j loop
		end:
			sb $0,($a2)
			lw $a0,8($sp)
			lw $a1,4($sp)
			lw $a2,($sp)
			addi $sp,$sp,12
			jr $ra
			
	sost:
		lb $t1,($a1)
		beq $t1,0,resetandnext
		sb $t1,($a2)
		addi $a2,$a2,1
		addi $a1,$a1,1
		j loop
		resetandnext:
		lw $a1,4($sp)
		j next
			