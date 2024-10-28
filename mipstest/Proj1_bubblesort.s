#Bubblesort Test

.data
arr:
        .word   5  
        .word   4 
        .word   3 
        .word   2 
        .word	1 
.text
main:

  li $sp, 0x10011000 	#Int stack pointer
  sub	$sp, $sp, 32 	#make space on stack 
  addi	$a0, $sp, 8 	#a0 is the array stack
  addi	$a1, $zero, 20  #array size in bytes

#Store each element in Array
  sw	$a1, 4($sp) 	#stores array
  addi	$t1, $zero, 5	#t1 loads 5
  sw	$t1, 0($a0)	#a0(0) stores 5
  addi	$t1, $zero, 4 	
  sw	$t1, 4($a0)	#a0(1) stores 4
  addi	$t1, $zero, 3	
  sw	$t1, 8($a0)	#a0(2) stores 3	
  addi	$t1, $zero, 2
  sw	$t1, 12($a0)	#a0(3) stores 2
  addi	$t1, $zero, 1
  sw	$t1, 16($a0)	#a0(4) stores 1
  addi	$t1, $zero, 0
bubble:
  addi  $t8, $sp, 8     #t8 is the start pointer
  addi  $t7, $zero, 0   #t7 swapped
  addi  $t6, $zero, 4   #t6 the index counter

whileloop:
  slt   $t9, $t6, $a1	     #checks t6 less than array size
  bne   $t9, 1, swapped	     #if flase than jump
  lw	$t0, 0($t8)          #t0 loads a(i)
  lw	$t1, 4($t8)          #t1 loads a(i+1)
  slt	$t2, $t1, $t0        #checks a(i+1) less than a(i)
  bne	$t2, 1, loop         #loop if not
  sw	$t1, 0($t8)          #swap a(i) and a(i+1)
  sw	$t0, 4($t8)          #swap a(i+1) and a(i)
  addi	$t7, $zero, 1        #set swapped to 1
  j	loop                 #go to loop

loop:
  addi    $t6, $t6, 4           # increments i
  addi    $t8, $t8, 4           # increments array
  j       whileloop             #back to loop
swapped:
  beq	$t7, 1, bubble		#swap repeat bubble sort

whiledone:
#Load all elements
  lw	$t0, 0($a0) 		#load a(0)
  lw	$t1, 4($a0)		#load a(1)
  lw	$t2, 8($a0)		#load a(2)
  lw	$t3, 12($a0)		#load a(3)
  lw	$t4, 16($a0)		#load a(4)
  
