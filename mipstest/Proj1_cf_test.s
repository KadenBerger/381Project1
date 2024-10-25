#cfTest

.data

.text
main:
	li $sp, 0x10011000 	 #Int stack pointer 
	addi	$a0, $zero, 0x0  #a0 = 0
	addi	$a1, $zero, 0x1	 #a1 = 1
	addi	$a2, $zero, 0x2  #a2 = 2
	jal	stackframetest	 #call stack
	addi	$s0, $v0, 0	 #store result in s0
	j	finish		 #done

stackframetest:
	addi	$sp, $sp, -16    #allocate 16 bytes
	slti	$t4, $a2, 0xF00	 #check if a2 less than imm
	beq	$t4, 0, testdone #not than skip testdone
	sw	$ra, 0($sp)	 #save ra
	sw	$a0, 4($sp)	 #save a0
	sw	$a1, 8($sp)	 #save a1
	sw	$a2, 12($sp)	 #save a2
	addi	$v0, $v0, 1	 #increment v0 by 1
	j	stacklooptest	 #jump to loop
	
stacklooptest:
	lw	$t0, 4($sp)	#t0 loads a0
	lw	$t1, 8($sp)	#t1 loads a1
	lw	$t2, 12($sp)	#t2 loads a2
	add	$t1, $t1, $t0	#t2 = t1+t0
	add	$t2, $t2, $t1	#t2 = t2 +t1
	addi	$t0, $t0, 1	#increment t0 by 1
	addi	$a2, $t2, 0	#update a2
	addi	$a1, $t1, 0	#update a1
	addi	$a0, $t0, 0	#update a0
	j	stackframetest	#jump to start
testdone:
	addi	$sp, $sp, 16	 #deallocate 16 bytes
	lw	$t0, 4($sp)	 #t0 loads a0
	lw	$t1, 8($sp)	 #t1 loads a1
	lw	$t2, 12($sp)	 #t2 loads a2
	add	$t1, $t1, $t0	 #t1 = t1+t0
	add	$t2, $t2, $t1	 #t2 = t2+t1
	add	$v1, $v1, $t2	 #v1 = v1+t2
	bne	$t0, 1, testdone #loop to testdone if t0!=1
	lw	$ra, 0($sp)	 #restore ra
	jr	$ra		 #return to caller
	
finish:
	