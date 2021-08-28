#Problem 1
#Brandon Tran (btran15@asu.edu)
main:	li $s0,40	# loads in the number one to the $s0 register
	sub $s0,$s0,1	# subtracts the number by 1 to get the odd integer to add onto the resultant register
	

loop:	add $s2,$s2,$s0	# adds the odd number to the resultant
	sub $s0,$s0,2	# subtracts the counter by 2	
	bgtz $s0, loop	# checks if the is greater than zero, goes back to begin of loop if it is greater
	
	li $v0, 1 	# print integer
	move $a0, $s2 	# What to print is stored at $s2
	syscall
	
exit:	li $v0, 10	# exit system call
	syscall
# end of Problem 2