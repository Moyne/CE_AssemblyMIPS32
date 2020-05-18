	.data
	palin:	.asciiz "La seguente parola è palindroma !"
	notpalin: .asciiz "La seguente parola non è palindroma."
	.text
	.globl main
	.ent main
main:
	and $t1,$0,$0
read: 								#lettura di una singola lettera
	li $v0,12
	syscall
	add $t0,$v0,$0					#prendo la lettera
	beq $t0,'\n',ispal				#se la lettera è '\n' ho finito il ciclo di lettura
	addi $sp,$sp,-1					#alloco un byte(lettera) nello stack
	sb $t0,($sp)					#salvo la lettera(byte) nello stack
	addi $t1,$t1,1					#i++
	j read
	
ispal:
	and $t4,$0,$0					#i
	addi $t2,$t1,-1
	add $s0,$sp,$t2					#memorizzo due copie dello stack, $s0 che parte dalla prima parola (sp-num.lettere-1) e s1 che parte dall'ultima
	add $s1,$0,$sp					#lettera permettendomi di tenere conto dello stack di partenza per poterlo liberare correttamente
pal:
	lb $t0,($s0)					#carico le due lettere
	lb $t3,($s1)
	bne $t0,$t3,notpal				#se le lettere sono diverse la parola non è palindroma
	addi $s1,$s1,1					#aggiornamento vari puntatori
	addi $s0,$s0,-1
	addi $t4,$t4,1					#i++
	bne $t4,$t1,pal					#if(i!=num.lettere)
	li $v0,4						#la parola è palindroma
	la $a0,palin
	syscall
	j end
notpal:
	li $v0,4						#la parola non è palindroma
	la $a0,notpalin
	syscall
end:
	add $sp,$sp,$t2					#free dello stack
	li $v0,10
	syscall
	.end main