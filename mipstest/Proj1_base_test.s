#basic test instructions
.data

.text
main:
	li $sp, 0x10011000		#Int stack pointer
	addi	$t0, $zero, 0x5		#load 0x5 into t0
	addi	$t1, $zero, 0x10	#load 0x15 into t1
	add	$t0, $t0, $t1		#sum expected 0x15
	addiu	$t0, $t0, 0x10		#sum expected 0x25
	addu	$t1, $t0, 0x100000	#load t1 and t0 and add 0x100000
	and	$t2, $t0, 0x20		#expected 0x20
	andi	$t2, $t2, 0x0		#expected 0x0
	lui	$t3, 0x1001		#load t3 with imm
	sw	$t3, 0($sp)		#store t3 value at stack pointer
	lw	$t4, 0($sp)		#loads value from the stack pointer and t4 expected 0x10010000
	nor	$t5, $t4, $t4		#t5 expected 0x11111111
	xor	$t5, $t5, $t4		#t4 expected 0x11111111
	xori	$t5, $t5, 0x10010000	#t5 expected 0x01101111
	or	$t6, $t5, 0		#t6 expected 0x01101111
	ori	$t6, $t6, 0x10010000	#t6 expected 0x11111111
	slt	$t7, $t5, $t6		#t7 expected 1 since t5 less than t6
	slti	$t7, $t0, 0x10		#t7 expected 0 since t0 greater than or equal to t6
	addi	$t7, $zero, 0x1		#loads 0x1 into t7
	sll	$t8, $t7, 0x4		#t8 expected 0x10
	addi	$t7, $zero, 0xFFFF1234	#loads imm into t7
	srl	$t8, $t7, 0x2		#t8 expected 0x3FFFC48D
	sra	$t9, $t7, 0x2		#t9 expected 0xFFFFC48D
	addi	$t0, $zero, 0x20	#t0 loads 0x20
	addi	$t1, $zero, 0x40	#t1 loads 0x40
	sub	$t2, $t1, $t0		#t2 expected 0x20
	subu	$t2, $t2, $t0		#t2 expected 0x0
	addi	$t0, $zero, 0x20	#t0 loads 0x20
	addi	$t1, $zero, 0x19	#t1 loads 0x19
	addi	$t9, $t9, 0xFFFFFFFF	#Decrement t9 by 1 
	slt	$t2, $t0, $t1		#t2 expected 0
	beq	$t2, $zero, btest	#t2 = 0 for branch
	
btest:
	addi	$t7, $zero, 0x4		#t7 loads 0x4
	addi	$t8, $t7, 0x10		#t8 expected 0x14
	jal	jltest			# jump and link to jltest
	slt	$t0, $t6, $t9		#t0 expected 0
	bne	$t0, 1, afterbranch	#branch if t0 !=1
	beq	$t0, 1, afterbranch	#branch if t0 ==1
	
jltest:
	add	$t9, $t7, $t8		#t9 expected 0x18
	add	$t6, $t7, $t8		#t6 expected 0x18
	jr	$ra			#return to branch
	
afterbranch:
	addi	$t9, $zero, 1 		#t9 loads 0x1
	
	
