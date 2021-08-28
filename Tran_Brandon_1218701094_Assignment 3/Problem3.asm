.data 
array:	.word 0, 1, 2, 3, 7, 8, 10	# the array
strPrompt:	.asciiz "Enter a positive integer: \n "
invalidOutput:	.asciiz " invalid entry\n"
one:	.asciiz " One"
two:	.asciiz " Two"
three:	.asciiz " Three"
four:	.asciiz " Four"
five:	.asciiz " Five"
six:	.asciiz " Six"
seven:	.asciiz " Seven"
eight:	.asciiz " Eight"
nine:	.asciiz " Nine"
zero:	.asciiz " Zero"
nextline:	.asciiz "\n"
.text 

# t0 = number
# t1 = 10
# t2 = answer
# t3 = remainder
# t4 = 0

main: 
	# Gets the user input into the system to see if the number entered is a Palindrome
	li $v0, 4 	# syscall number 4 will print string whoes address is in $a0
	la $a0, strPrompt
	syscall
	li $v0, 5      	# syscall number 5 will read an int
	syscall        	# actually read the int
	move $t0, $v0	# contents of string will be put into $t0
	
	li $t3, 0	# number 0
	li $t4, 1	# number 1
	
	addiu $sp, $sp, -8	# allocates memory space
	sw $t3, ($sp)		# stores the value
	sw $t3, 4($sp)		# stores end condition into pointer
	
	blt $t0, 0, invalid	# checks if there is negative
	j divide
	
divide:
	# prints the number in $t0
	#li $v0, 1     	# syscall number 5 will read an int
	#move $a0, $t0	# contents of string will be put into $t0
	#syscall        	# actually read the int
	#li $v0, 4 	# next line
	#la $a0, nextline
	#syscall
	
	# calculated the division
	li $t1, 10	# loads 10 into the register
	divu $t0, $t1	# divides the number by 10
	mflo $t0	# stores the result in t0
	mfhi $t3	#stores the mod into t3
	
# prints the quotient
	#li $v0, 1     	# syscall number 5 will readan int
	#move $a0, $t2	# contents of string will be put into $t0
	#syscall        	# actually read the int
	#li $v0, 4 	# syscall number 4 will print string whoes address is in $a0
	#la $a0, nextline
	#syscall
	
# prints the remainer
	#li $v0, 1     	# syscall number 5 will read an int
	#move $a0, $t3	# contents of string will be put into $t0
	#syscall        	# actually read the int
	#li $v0, 4 	# syscall number 4 will print string whoes address is in $a0
	#la $a0, nextline
	#syscall
	
	beq $t0, 0, print	# checks end condition, if there there is no more numbers
	j store			# jumps to store otherwise
	
store:
	addiu $sp, $sp, -8	# allocates memory space
	sw $t3, 0($sp)		# stores the value
	sw $t4, 4($sp)		# stores the number 1 into the stack pointer to end the loop
	j divide		# goes back find the next digit
print:
	beq $t3, 1, pone	# jumps to the print function of every number 
	beq $t3, 2, ptwo
	beq $t3, 3, pthree
	beq $t3, 4, pfour
	beq $t3, 5, pfive
	beq $t3, 6, psix
	beq $t3, 7, pseven
	beq $t3, 8, peight
	beq $t3, 9, pnine
	beq $t3, 0, pzero

decrese:
	lw $t3, 0($sp)		# gets the number from the stack pointer
	lw $t4, 4($sp)		# the counter for the stack pointer, if 1, there is another number, if 0 then no more numbers to print
	addiu $sp, $sp, 8	# moves the stack pointer to the next loction, frees up the allocated memory
	beq $t4, 1, print	# checks if there was another digit to print, if 1 there is, if 0 then no
	j end			# ends the program if there isn't another number

invalid:
	li $v0, 4 	# syscall number 4 will print string whoes address is in $a0
	la $a0, invalidOutput	
	syscall
	j end		# ends the program

# all the number prints
pone:
	li $v0, 4 	# syscall number 4 will print string whoes address is in $a0
	la $a0, one	# changes the string
	syscall
	j decrese
ptwo:
	li $v0, 4 	# syscall number 4 will print string whoes address is in $a0
	la $a0, two	# changes the string
	syscall
	j decrese
pthree:
	li $v0, 4 	# syscall number 4 will print string whoes address is in $a0
	la $a0, three	# changes the string
	syscall
	j decrese
pfour:
	li $v0, 4 	# syscall number 4 will print string whoes address is in $a0
	la $a0, four	# changes the string
	syscall
	j decrese
pfive:
	li $v0, 4 	# syscall number 4 will print string whoes address is in $a0
	la $a0, five	# changes the string
	syscall
	j decrese
psix:
	li $v0, 4 	# syscall number 4 will print string whoes address is in $a0
	la $a0, six	# changes the string
	syscall
	j decrese
pseven:
	li $v0, 4 	# syscall number 4 will print string whoes address is in $a0
	la $a0, seven	# changes the string
	syscall
	j decrese
peight:
	li $v0, 4 	# syscall number 4 will print string whoes address is in $a0
	la $a0, eight	# changes the string
	syscall
	j decrese
pnine:
	li $v0, 4 	# syscall number 4 will print string whoes address is in $a0
	la $a0, nine	# changes the string
	syscall
	j decrese
pzero:
	li $v0, 4 	# syscall number 4 will print string whoes address is in $a0
	la $a0, zero	# changes the string
	syscall
	j decrese
	
end:
