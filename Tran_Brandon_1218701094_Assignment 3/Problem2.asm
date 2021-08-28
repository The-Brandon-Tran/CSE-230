.data 
array:	.word 0, 1, 2, 3, 7, 8, 10	# the array
size: 	.word 4	# size of "array" 

strPrompt:	.asciiz "Enter a positive number to search: \n "
strResultPositive:	.asciiz " is present in the array at loc "
strResultNegative:	.asciiz " is not present in the arrray\n"
fail:	.asciiz " failed \n"
low:	.asciiz " low \n"
high:	.asciiz " high \n"
space:	.asciiz "  "
.text 

# t8 = the location of the digit
# t0 = the digit
# t1 = low
# t2 = high
# t3 = pointer to the low position
# t4 = pointer to the high position
# t5 = mid pointer
# t6 = lower limit if the array
# t7 = higher limit of the array

# s1 = loaded digit from memory, low
# s2 = loaded digit from memory, high


main:
	# Gets the user input into the system to see if the number entered is a Palindrome
	li $v0, 4 # syscall number 4 will print string whoes address is in $a0
	la $a0, strPrompt
	syscall
	li $v0, 5      # syscall number 5 will read an int
	syscall        # actually read the int
	move $t0, $v0 # contents of string will be put into $t0
	
	
	li $t1, 0	# First position in the array, Low
	li $t2, 6	# Last position in the array, High
	li $t6, 0	# Lower Limit
	li $t7, 6	# Higher Limit
	la $t9,array 	# puts the array into the register of the system
	move $t3, $t9	
	addi $t4, $t9, 24	# places the pointer in the right places
	
	#move $t3, $t9
	#lw $t3, ($t3)
	#li $v0, 1 # syscall number 4 will print string whoes address is in 1
	#move $a0, $t3
	#syscall
	#addi $t3, $t9, 4
	#lw $t3, ($t3)
	#li $v0, 1 # syscall number 4 will print string whoes address is in 2
	#move $a0, $t3
	#syscall
	#addi $t3, $t9, 8
	#lw $t3, ($t3)
	#li $v0, 1 # syscall number 4 will print string whoes address is in 3
	#move $a0, $t3
	#syscall
	#addi $t3, $t9, 12
	#lw $t3, ($t3)
	#li $v0, 1 # syscall number 4 will print string whoes address is in 4
	#move $a0, $t3
	#syscall	
	#addi $t3, $t9, 16
	#lw $t3, ($t3)
	#li $v0, 1 # syscall number 4 will print string whoes address is in 5
	#move $a0, $t3
	#syscall
	#addi $t3, $t9, 20
	#lw $t3, ($t3)
	#li $v0, 1 # syscall number 4 will print string whoes address is in 6
	#move $a0, $t3
	#syscall	
	#addi $t3, $t9, 24
	#lw $t3, ($t3)
	#li $v0, 1 # syscall number 4 will print string whoes address is in 7
	#move $a0, $t3
	#syscall
	
	#addi $t3, $t3, 4
	
	j binarySearch
	
binarySearch:
	
	lw $s1, ($t3)	# load in the digit of the lower and hgiher bounds
	lw $s2, ($t4)
	
	beq $t0, $s1, printFound	# checks if the high is lower than the low, return the number because it isnt higher or lower, should be the same
	
	sub $t8, $t2, $t1	# computes the midpoint, add low and high
	div $t8, $t8, 2		# computes the midpoint, div total by 2
	mul $t5, $t8, 4
	add $t5, $t5, $t3	# adds the mid point distance from low
	
	lw $s3, ($t5)
	
	#li $v0, 1 # syscall number 4 will print string whoes address is in $s3
	#move $a0, $s3
	#syscall
	
	beq $t1, $t7, printNotFound	# checks if the lower pointer is at the higher limit
	beq $t2, $t6, printNotFound	# checks if the higher pointer is at the lower iimit
	bgt $t1, $t2, printNotFound	# Checks if the high is a lower than the low, prints no if it is
	bgt $t0, $s3, higher 		# compare if the number in the middle is higher than the number being looked for
	bge $s3, $t0, lower		# compare if the number in the middle is lower than the number being looked for
	
	li $v0, 4 # syscall number 4 will print string whoes address is in $a0
	la $a0, fail
	syscall
	
lower:
	beq $t8, 0, subtraction
	sub $t2, $t2, $t8
	mul $t8, $t8, 4
	sub $t4, $t4, $t8
	#li $v0, 4 # syscall number 4 will print string whoes address is in $a0
	#la $a0, low
	#syscall
	j binarySearch
higher:
	beq $t8, 0, addition
	add $t1,$t1,$t8
	mul $t8, $t8, 4
	add $t3,$t3,$t8
	#li $v0, 4 # syscall number 4 will print string whoes address is in $a0
	#la $a0, high
	#syscall
	j binarySearch
printFound:
	li $v0, 1 # prints the number in the space
	move $a0, $t0
	syscall
	li $v0, 4 # prints the phrase 
	la $a0, strResultPositive
	syscall
	addi $t1, $t1, 1
	li $v0, 1 # prints the location of the digit
	move $a0, $t1
	syscall
	j end
printNotFound: 
	li $v0, 1 # syscall number 4 will print string whoes address is in $a0
	move $a0, $t0
	syscall
	li $v0, 4 # syscall number 4 will print string whoes address is in $a0
	la $a0, strResultNegative
	syscall
	j end

addition:	# makes sure that the numbers move up one more even when its zero, no inf loop
	add $t8, $t8, 1
	j higher
subtraction:	# makes sure that the numbers move down one more even when its zero, no inf loop
	add $t8, $t8, 1
	j lower
end:
