	.data
	writeN:	.asciiz "Write the n value: "
	writeK:	.asciiz "Write the k value:	"
	.text
	.globl main
	.ent main
main:
	li $v0,4
	la $a0,writeN
	syscall
	li $v0,5
	syscall
	add $s0,$v0,$0								#salvo il valore preso dalla funzione per non sporcarlo e metterlo in seguito in $a0
	li $v0,4
	la $a0,writeK
	syscall
	li $v0,5
	syscall
	add $a1,$v0,$0								#metto in $a1 il valore appena letto(k)
	add $a0,$s0,$0								#mi riprendo il valore che avevo salvato in $s0 e lo metto in $a0(n)
	jal combina
	add $a0,$v0,$0								#metto in $a0 il valore ritornato da combina per poterlo stampare
	li $v0,1
	syscall
	li $v0,10
	syscall
	.end main
	
combina:										#Funzione NO-LEAF che calcola la combinazione semplice passati due parametri in $a0 e $a1
	addi $sp,$sp,-12							#alloco spazio nello stack, alloco anche lo spazio per il registro $ra dato che è no leaf
	sw $ra,8($sp)								#salvo $ra, il registro contenente l'indirizzo per il salto di ritorno
	sw $a0,4($sp)								#n
	sw $a1,($sp)								#k
	sub $t5,$a0,$a1								#calcolo n-k per poterne fare il fattoriale
	jal fact									#dato che in $a0 ho ancora n faccio il fattoriale di n grazie alla funzione leaf fact
	add $t0,$v0,$0								#mi salvo il valore ritornato dalla funzione fact
	add $a0,$a1,$0								#mi preparo al calcolo del prossimo fattoriale mettendo in $a0 il valore di $a1
	jal fact									#dato che in $a0 ho $a1 ora, avrò in $a0 il valore k, faccio il fattoriale di k
	add $t1,$v0,$0								#salvo il valore ritornato dalla funzione
	add $a0,$t5,$0								#metto in $a0 il valore n-k per poterne fare il fattoriale
	jal fact									#faccio il fattoriale di n-k
	add $t2,$v0,$0								#salvo il valore del fattoriale di n-k
	mul $t1,$t1,$t2								#faccio (k fact) x (n-k fact)
	div $v0,$t0,$t1								#faccio (n fact) / ((k fact) x (n-k fact)) e lo salvo in $v0 come valore di ritorno
	lw $ra,8($sp)								#mi riprendo il valori dallo stack di $ra
	lw $a0,4($sp)
	lw $a1,($sp)
	addi $sp,$sp,12								#dealloco lo stack
	jr $ra
	
fact:											#funzione leaf per il calcolo del fattoriale di un numero passato in $a0
	addi $sp,$sp,-4								#alloco spazio nello stack
	sw $a0,($sp)
	addi $t3,$0,1								#i=1
	factL:
		beq $a0,$0,endL							#questo controllo serve per vedere se in partenza k=0, così posso subito ritornare 1
		mul $t3,$t3,$a0							#i=k x i
		addi $a0,$a0,-1							#k--
		bne $a0,$0,factL						#k=0?
	endL:
		lw $a0,($sp)							#mi riprendo il valore di $a0 dallo stack
		addi $sp,$sp,4							#dealloco lo stack
		add $v0,$t3,$0							#salvo il valore del fattoriale(i) in $v0 come valore di ritorno
		jr $ra
	
	