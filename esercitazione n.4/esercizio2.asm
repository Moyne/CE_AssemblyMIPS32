	.data
	opa:	.word 2043
	opb:	.word 5
	res:	.word 0
	act:	.asciiz "Quale azione vuoi eseguire? (0-> somma,1-> differenza,2-> prodotto,3-> divisione)"
	.text
	.globl main
	.ent main

main:
	lw $t0,opa
	lw $t1,opb
	addi $t3,$0,1
	addi $t4,$0,2
	addi $t5,$0,3
	addi $t6,$0,-1
	li $v0,4
	la $a0,act
	syscall
	li $v0,5
	syscall
	beq $v0,$0,somma
	beq $v0,$t3,differenza
	beq $v0,$t4,prodotto
	beq $v0,$t5,divisione
	j end
	
	somma:	
			add $t6,$t0,$t1
			sw $t6,res
			j end
	
	differenza:
			sub $t6,$t0,$t1
			sw $t6,res
			j end
			
	prodotto:
			mul $t6,$t0,$t1
			sw $t6,res
			j end
			
	divisione:
			div $t6,$t0,$t1
			sw $t6,res
	
	end:	
			li $v0,1
			add $a0,$t6,$0
			syscall
			li $v0,10
			syscall
			
	.end main
	