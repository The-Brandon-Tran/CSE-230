#Problem 1
#Brandon Tran (btran15@asu.edu)
main:	li $s0, 5 	# initialize a = 5
	li $s1, 2 	# initialize b = 2
	
	li $s2, 2	# puts the number 2 in to the register
	add $s1,$s1,$s2	# adds the b digit to 2
	sll $s1,$s1,2	# does the logicall left shift twice with zeros
	mul $s0, $s1	# multiplies the two numbers together
	mflo $s2	# stores the answer in the answer register
	
	li $v0, 1 	# print integer
	move $a0, $s2 	# What to print is stored at $s2
	syscall
exit:	li $v0, 10	# exit system call
	syscall
# end of Problem 1