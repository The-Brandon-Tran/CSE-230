main:
	# $s0 = M
	# $s1 = N
	# $s2 is the legnth in A
	# $s3 = Number at t3
	# $s4 = Number at t4
	# $s5 = intermediate calculation
	# $s6 = intermediate number before putting it into array
	
	# $t0 = A og address
	# $t1 = X og address
	# $t2 = B
	# $t3 = pointer to A
	# $t4 = pointer to X
	# t8 is the counter of number of rows that have been run
	# t9 is the counter of number of column that have been run

	lw $s0,0x10010000
	lw $s1,0x10010004
	
	mult $s1,$s0
	mflo $s2
	li $s3,4
	mult $s2,$s3
	mflo $s2		# $s2 is the legnth in A
				
	li $t0,0x10010008	# $t0 = A og address
	
	add $t1,$t0,$s2		# $t1 = X og address
	
	li $s3,4		# $t2 = B
	mult $s1,$s3
	mflo $t2
	add $t2,$t1,$t2
	
	# $t3 = pointer to x
	move $t3,$t0
	move $t4,$t1
	li $s6,0
	li $t9,0
	
	jal calc
		
calc:	
	lw $s3,0($t3)
	lw $s4,0($t4)
	mult $s3,$s4		# multiples the numbers together
	mflo $s5
	add $s6,$s6,$s5		# adds them together with pervious numbers
	
	addi $t9,$t9,1		#  increments counter to see what column we are on
	addi $t3,$t3,4
	addi $t4,$t4,4
	blt $t9,$s1,calc 	# compares to see if we are at the last column
	
	sw $s6,0($t2)		# saves the number in
	li $s6,0		# resets the save variable
	li $t9,0		# resets the column counter
	
	li $s5, 4
	add $t2,$t2,$s5		# increases the B pointer addess by 4, s5 is temp set as 4
	
	addi $t8,$t8,1
	move $t4,$t1		# resets the number for the X array
	blt $t8,$s0,calc 	# runs the program again for each row
	j end
end:	