.data
DIM: .asciiz "Quanti valori vuoi leggere? "
media: .asciiz "La media e': "
.text
.globl main
.ent main
main:
	li $v0,4
	la $a0,DIM
	syscall
	li $v0,5
	syscall
	move $t0,$v0	
	and $t1,$0,$0		
	and $t2,$0,$0 		
loop: li $v0,5
		syscall
		move $t3,$v0
		add $t2,$t2,$t3
		addi $t1,$t1,1
		blt $t1,$t0,loop
		
	li $v0,4
	la $a0,media
	syscall
	div $t2,$t2,$t0
	li $v0,1
	add $a0,$t2,$0
	syscall
	
	li $v0,10
	syscall
	.end main
