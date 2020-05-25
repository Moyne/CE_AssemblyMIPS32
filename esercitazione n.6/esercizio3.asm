	.data
	parola: .asciiz "minuscolo"
	.text
	.globl main
	.ent main
main:
	la $s0,parola
	and $s1,$0,$0					#i=0
	readLetter:
		add $a0,$s0,$s1				#carico in $a0 l'indirizzo del byte da leggere e convertire ($a0=$a0+i)
		jal convert
		beq $v0,$0,end				#se il valore letto era la fine della parola vado alla label end
		sb $v0,($a0)				#altrimenti salvo il byte in memoria sostituendolo a quello vecchio
		addi $s1,$s1,1				#i++
		j readLetter
end:
	li $v0,4						#stampo la nuova parola convertita
	la $a0,parola
	syscall
	li $v0,10
	syscall
	.end main
	
convert:							#funzione leaf che converte una lettera(byte) da minuscolo a maiuscolo, come parametro($a0) ho l'indirizzo del byte
	addi $sp,$sp,-4					#alloco spazio nello stack per non sporcare l'indirizzo
	sw $a0,($sp)
	add $t0,$a0,$0
	lb $t1,($t0)					#carico il byte
	beq $t1,$0,zero					#se il byte valeva 0 è finita la lettura e vado a zero che termina il processo ritornando 0
	addi $v0,$t1,-32				#conversione da minuscolo a maiuscolo, sottraendo 32
	lw $a0,($sp)					#mi riprendo $a0 dallo stack
	addi $sp,$sp,					#dealloco lo stack
	jr $ra							#return
	zero:
		and $v0,$0,$0				#metto in $v0 0 come valore di ritorno
		lw $a0,($sp)				#mi riprendo $a0 dallo stack
		addi $sp,$sp,4				#dealloco lo stack
		jr $ra						#return