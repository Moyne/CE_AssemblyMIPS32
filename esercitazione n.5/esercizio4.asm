	.data
	DIM:	.word 3
	#	matr:	.word 3, 2, 4, 2, 2, 8, 4, 8, 0
	matr:	.word 3, 0, 0, 0, 5, 0, 0, 0, 6
	.text
	.globl main
	.ent main
main:
	lw $s0,DIM				#dimensione di un lato della matrice(radice dimensione totale)
	mul $s4,$s0,$s0			#dimensione totale della matrice
	addi $s1,$0,4
	addi $s2,$0,1
	add $s3,$s0,$s2			#s3=dimensione di un lato della matrice+1 (serve per controllare l'appartenenza o meno alla diagonale)
	la $t0,matr
	la $t1,matr
	and $t6,$0,$0			#i=0
loop:
	div $t6,$s3				#divido la i(posizione in cui mi trovo) per la dimensione di una riga+1
	mfhi $t5				#prendo il resto della divisione
	beq $t5,$0,diag			#se il resto è 0 allora si tratta di un elemento della diagonale quindi non ne devo controllare il valore e lo skippo
	lw $t3,($t1)			#se non fa' parte della diagonale ne prendo il valore
	bne $t3,$0,nextstep 	#se il valore è diverso da 0 la seguente matrice non è diagonale e devo fare il prossimo controllo sulla simmetria
diag:	
	add $t6,$t6,$s2 		#i++
	add $t1,$t1,$s1 		#adress+4
	bne $t6,$s4,loop 		#if(i!=dim)
	addi $a0,$0,2    		#è una matrice DIAGONALE voglio stamparlo
	j end
nextstep:
	and $t6,$0,$0
	and $t5,$0,$0
	mul $s5,$s0,$s1			#s5=dimriga*4, ovvero quanto devo saltare per vedere il prossimo elemento della colonna
	mul $s4,$s0,$s0
	add $t1,$0,$t0
	add $t4,$0,$t0
simm:
	lw $t2,($t0)			#elemento della riga
	lw $t3,($t1)			#elemento della colonna
	bne $t2,$t3,notsimm		#se riga!=colonna non sono simmetrici, stampo 0
	add $t6,$t6,$s2
	add $t5,$t5,$s2
	add $t0,$t0,$s1
	beq $t5,$s0,nextcol		#se il contatore ha superato la dimensione della riga, devo riaggiornare l'adress delle colonne
	add $t1,$t1,$s5			#aggiorno l'adress delle colonne nella situazione normale(non al limite)
nextSimm:	
	bne $t6,$s4,simm		#if(i!=dim)
	addi $a0,$0,1			#è una matrice simmetrica, voglio stampare 1
	j end
nextcol:	
	add $t4,$t4,$s1			#aggiorno il valore di t4(adress dell'inizio della prossima colonna)
	add $t1,$t4,$0			#t1(adress colonna)=t4(inizio colonna)
	and $t5,$0,$0			#t5(contatore riga)=0, devo ricominciare
	j nextSimm
notsimm: 
	and $a0,$0,$0			#matrice non simmetrica, voglio stampare 0
end:
	li $v0,1				#stampo
	syscall
	li $v0,10
	syscall
	.end main
	
	