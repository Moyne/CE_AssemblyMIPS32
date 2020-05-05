	.data
err: .asciiz "Errore, carattere non numerico trovato"
	.text
	.globl main
	.ent main
main:
		addi $t0,$0,48
		addi $t1,$0,57
		
write: li $v0,12
		syscall
		move $t2,$v0
		beq $t2,'\n',end
		bgt $t2,$t1,error
		blt $t2,$t0,error
		j write

error: li $v0,4
		la $a0,err
		syscall
		j write
		
end:	li $v0,10
		syscall
	
	.end main