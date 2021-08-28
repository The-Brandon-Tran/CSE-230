.data 
array:	.word 54, 16, 76, 14	# first row
	.word 5, 20, 36, 8	# second row
	.word 89, 10, 22, 12	# third row
	.word 46, 30, 6, 16	# fourth row

size: 	.word 4	# size of "array" 
	.text 
	
main:	li $s0,0	# true x and y value ( the number x4 )
	li $s1,0
	li $s2,0	# array x and y value eg: (1,0)
	li $s3,0
	li $s5,0	# distance away from the original address of the array
	li $s6,0	# second digit's address
	
	li $s7,0	# switching temporary number holder, and the register for intermediate calculations
	li $t8,0	# holds the number temp for the number in the array
	
	la $t1,array	# loads the address of the array in to the register

loop:		# main loop of incrementing the loction of the array counters
	add $s1,$s1,4
	add $s3,$s3,1
	
	add $s5,$s0,$s1	# Calculates $s5 and $s6 to check for true distance
	sll $s6,$s3,4	
	sll $s7,$s2,2
	add $s6,$s6,$s7
	
	bge $s2,$s3,loop
	bge $s5,64,exit		
	bgt $s1,12,loopReset	# checks that its still in the array
	
	bgt $s3,$s2,switch	# is not any of the other conditions so start to switch the numbers

loopReset:	# checks if the location is in the top right of the array
	add $s0,$s0,$s1
	li $s1,-4
	add $s2,$s2,1
	li $s3,-1
	j loop
	
switch:	
	add $s5,$t1,$s5	# adds the orignial address onto the distance away
	add $s6,$t1,$s6	# adds the orignial address onto the distance away of the flipped address

	lw $s7,0($s5)
	lw $t8,0($s6)
	sw $t8,0($s5)
	sw $s7,0($s6)
	j loop

exit:	# checks for the end of the array
