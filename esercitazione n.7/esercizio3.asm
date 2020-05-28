	.data
	value:	.asciiz "What is the value: "
	.text
	.globl main
	.ent main
main:
	#lettura del valore da tastiera
	li $v0,4
	la $a0,value
	syscall
	li $v0,5
	syscall
	add $a0,$v0,$0
	#allocazione dello stack
	addi $sp,$sp,-4
	#salvataggio nello stack di $ra
	sw $ra,($sp)
	jal sequenzaDiCollatz
	#lettura risultato
	add $a0,$v0,$0				#preparo già il valore in $a0 così è subito pronto per la stampa
	#lettura dallo stack di $ra
	lw $ra,($sp)
	#deallocazione dello stack
	addi $sp,$sp,4
	#stampa
	li $v0,1
	syscall
	jr $ra
	.end main
	
sequenzaDiCollatz:	#funzione non leaf che chiama calcolaSuccessivo fino a quando non ottiene 1
	#alloco lo stack frame
	addi $sp,$sp,-12
	sw $a0,8($sp)			#parametro
	sw $ra,4($sp)			#è una funzione non-leaf mi serve
	sw $s0,($sp)			#è un registro callee-save
	addi $s0,$0,1			#contatore i
	ciclo:
		jal calcolaSuccessivo
		addi $s0,$s0,1		#i++
		beq $v0,1,end		#se la calcolaSuccessivo ritorna 1 vado su end
		add $a0,$v0,$0		#mi preparo per il prossimo calcolaSuccessivo avendo il prossimo $a0
		j ciclo				#ritorno al ciclo
	end:
		add $v0,$s0,$0		#metto in $v0 il conteggio
		#mi riprendo dallo stack i valori che ci avevo messo dentro
		lw $a0,8($sp)
		lw $ra,4($sp)
		lw $s0,($sp)
		#allocazione dello stack
		addi $sp,$sp,12
		jr $ra
	
calcolaSuccessivo:	#funzione leaf che calcola il successivo della sequenzaDiCollatz
	#allocazione dello stack e salvataggio del parametro
	addi $sp,$sp,-4
	sw $a0,($sp)
	#per vedere se una parola è pari o dispari la confronto con un and(per MASCHERARE i bit) con 1
	#se rimane 1 significa che è dispari (0001 dispari 10101 dispari 10010 pari ecc.)
	andi $t2,$a0,1				#and con 1 per MASCHERARE tutti i bit tranne l'ultimo
	beq $t2,1,dispari			#se la parola rimane 1 vado a dispari
	pari:
		div $v0,$a0,2			#val/2
		lw $a0,($sp)			#ripresa dallo stack del valore
		addi $sp,$sp,4			#deallocazione stack
		jr $ra
	dispari:
		mul $a0,$a0,3			#val*3+1
		addi $v0,$a0,1
		lw $a0,($sp)			#ripresa dallo stack del valore
		addi $sp,$sp,4			#deallocazione dello stack
		jr $ra