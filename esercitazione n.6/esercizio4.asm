	.data
	vetz:	.word 680, 5, 7, 9, 2, 4, 3, 0, 7, 5, 7, 250
	.text
	.globl main
	.ent main
main:
	la $a0,vetz						#carico l'indirizzo di inizio del vettore in $a0
	li $a1,12						#carico la lunghezza del vettore in $a1
	jal massimo
	add $a0,$v0,$0					#metto in $a0 il valore ritornato dalla funzione massimo($v0) per poterlo subito stampare a schermo
	li $v0,1
	syscall
	li $v0,10
	syscall
	.end main
	
massimo:							#funzione leaf che calcola il massimo di un vettore dato l'indirizzo di inizio e la sua lunghezza
	addi $sp,$sp,-8					#alloco spazio nello stack
	sw $a0,4($sp)
	sw $a1,($sp)
	and $t2,$0,$0					
	and $t3,$0,$0					#i
	max:
		lw $t4,($a0)				#carico la word vettore[i]
		bgt $t4,$t2,newMax			#se tale word è più grande del massimo vado in newMax
	next:
		addi $a0,$a0,4				#next word, indirizzo+4 byte
		addi $t3,$t3,1				#i++
		bne $t3,$a1,max				#i=lunghezza vettore($a1)? if no go to max
	lw $a0,4($sp)
	lw $a1,($sp)
	addi $sp,$sp,8					#dealloco lo stack
	add $v0,$t2,$0					#salvo in $v0 il valore del massimo come valore di ritorno
	jr $ra							#return
	newMax:
		add $t2,$t4,$0				#max=vettore[i]
		j next
		
	