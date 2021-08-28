.data
strPrompt:	.asciiz "Enter a String: "
strYes:		.asciiz "Yes"
strNo:		.asciiz "No"
strCR:		.asciiz "\n"
strInput: 	.space 1024 # Reserve space for the String
.text
.globl main

main:

	# Gets the user input into the system to see if the number entered is a Palindrome
	li $v0, 4 # syscall number 4 will print string whoes address is in $a0
	la $a0, strPrompt
	syscall
	li $v0, 8      # syscall number 8 will read an string
	la $a0, strInput # load space into address
	li $a1, 1024
	move $t0, $a0 # contents of string will be put into $t0
	syscall        # actually read the string

	li $t4, 0
	move $t1, $t0
	
findLen:			# finds the length of the palindrome
	lb $s1, ($t1)
	beq $s1, $0, exitLen	#
	addi $t4, $t4, 1
	addi $t1,$t1, 1
	j findLen

exitLen:
	addi $t4, $t4, -1
	
	li $t2, 0
	beq $t4, $t2, printN
	li $t2, 1
	beq $t4, $t2, printY
	
	div $s2, $t4, 2
	move $s1, $t0
	subi $t1, $t1, 2
	
PalindromeLoop:
	beqz $s2, printY
	lb $t2, ($s1)
	lb $t3, ($t1)
	bne $t3, $t2, printN
	
	addi $s1, $s1, 1
	addi $t1, $t1, -1
	addi $s2, $s2, -1
	
	j PalindromeLoop	# repeats the loop untill printing yes or no
	
printY:
	li $v0, 4	# syscall number 4 wil print string whose address is in $a0
	la $a0, strYes	# "load address" of the Yes string
	syscall
	li $v0, 10	# syscall 10 exits the program
	syscall

printN:
	li $v0, 4	# syscall number 4 wil print string whose address is in $a0
	la $a0, strNo	# "load address" of the No string
	syscall
	
	
