	.data
errnum: .asciiz "Errore, carattere non numerico trovato"
errbyte: .asciiz "Errore, numero non visibile in 4 byte"
	.text
	.globl main
	.ent main
main:
		addi $t0,$0,48
		addi $t1,$0,57
		addi $t4,$0,10
		and $t3,$0,$0
write: li $v0,12
		syscall
		move $t2,$v0
		beq $t2,'\n',end
		bgt $t2,$t1,notnum
		blt $t2,$t0,notnum
		addi $t2,$t2,-48
		mul $t3,$t3,$t4
		mfhi $t5
		bne $t5,$0,notbyte
		add $t3,$t2,$t3
		j write

notbyte: li $v0,4
		la $a0,errbyte
		syscall
		j end
notnum: li $v0,4
		la $a0,errnum
		syscall
		j write
		
end:	li $v0,1
		add $a0,$t3,$0
		syscall
		li $v0,10
		syscall
	
	.end main