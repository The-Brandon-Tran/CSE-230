# Create some null terminated strings to use
.data
strPromptFirst:	 .asciiz "Enter an integer value n:"
strPromptSecond: .asciiz "Enter an second integer value n:"
strResult:	 .asciiz "GCD is: "
strCR:		 .asciiz "\n"
.text
.globl main
main:
		# STEP 1 -- get the first operand
		# Print a prompt asking user for input
		li $v0, 4   # syscall number 4 will print string whose address is in $a0       
		la $a0, strPromptFirst     # "load address" of the string
		syscall     # actually print the string  
		# Now read in the first operand 
		li $v0, 5      # syscall number 5 will read an int
		syscall        # actually read the int
		move $s0, $v0  # save result in $s0 for later
		
		# STEP 2 -- get the first operand
		# Print a prompt asking user for input
		li $v0, 4   # syscall number 4 will print string whose address is in $a0       
		la $a0, strPromptSecond    # "load address" of the string
		syscall     # actually print the string  
		# Now read in the first operand 
		li $v0, 5      # syscall number 5 will read an int
		syscall        # actually read the int
		move $s1, $v0  # save result in $s1 for later

		# STEP 2 Call the function to calculate the sum 
		move $a0, $s0  # move the input integer n to register $a0 
		jal GCD        # jump to the function sum to calculate the sum 	
		move $s1, $v0  # move the final sum value to register $s1

		# STEP 3 -- print the sum
                # First print the string prelude  
		li $v0, 4      # syscall number 4 -- print string
	        la $a0, strResult   
	        syscall        # actually print the string   
	        # Then print the actual sum
	        li $v0, 1         # syscall number 1 -- print int
	        move $a0, $s1     # put the result in $a0 for print
	        syscall           # actually print the int

		# STEP 4 --
		# Finally print a carriage return
		li $v0, 4      # syscall for print string
	        la $a0, strCR  # address of string with a carriage return
	        syscall        # actually print the string

		# STEP 5 -- exit
		li $v0, 10  # Syscall number 10 is to terminate the program
		syscall     # exit now
GCD:
		beqz $s0,zero
		beqz $s1,zero
		beq $s0,$s1,equal
		bgt $s0,$s1,else
		sub $s1,$s1,$s0
		j GCD	
zero:
		li $v0,0
		jr $ra
equal:		
		move $v0,$s0
		jr $ra
else:		
		sub $s0,$s0,$s1
		j GCD	
		
