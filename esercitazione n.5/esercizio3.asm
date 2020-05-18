	.data
	reada:	.asciiz "Si introduca il coefficiente A dell'equazione: "
	readb:	.asciiz "Si introduca il coefficiente B dell'equazione: "
	readc:	.asciiz "Si introduca il coefficiente C dell'equazione: "
	yes:	.asciiz "L'equazione introdotta ha soluzioni reali! :)"
	no:		.asciiz "L'equazione introdotta non ha soluzioni reali! :("
	.text
	.globl main
	.ent main
main:
		#reading the Avalue 
	li $v0,4 
	la $a0,reada
	syscall
	li $v0,5
	syscall
	add $t0,$0,$v0
		#reading the Bvalue
	li $v0,4
	la $a0,readb
	syscall
	li $v0,5
	syscall
	add $t1,$0,$v0
		#reading the Cvalue
	li $v0,4
	la $a0,readc
	syscall
	li $v0,5
	syscall
	add $t2,$0,$v0
		#controlling the radixValue
	mul $t1,$t1,$t1						#b*b
	mul $t0,$t0,$t2						#a*c
	sll $t0,$t0,2						#4*a*c
	sub $t1,$t1,$t0						#(b^2)-4*(a*c)  value of the radix
	slt $t3,$t1,$0						#if 0 is bigger than t1(value of the radix) t3 will be 1,else it will be 0
	addi $t4,$0,1
	beq $t3,$t4,notreal					#t3( value of radix < 0 ?) == 1? if true jump to notreal
	li $v0,4							#soluzioni reali
	la $a0,yes							#stampa
	syscall
	j end
	
notreal:
	li $v0,4							#soluzioni non reali
	la $a0,no
	syscall
	
end:
	li $v0,10
	syscall
	
.end main