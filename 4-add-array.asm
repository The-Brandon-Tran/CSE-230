# compute the sum of elements in an array

.data
array: .word   0 : 5        # "array" of 5 words
size: .word  16             # size of "array" 
      .text 

# initialize array with values 
la $s1, array
li $t0, 1
sw $t0, 0($s1)

li $t0, 2
sw $t0, 4($s1)

li $t0, 4
sw $t0, 8($s1)

li $t0, 3
sw $t0, 12($s1)

li $t0, 5
sw $t0, 16($s1)

## loop to add the array elements
addi $s2, $s1, 20
add $t3, $0, $0
move $t0, $s1

Loop: 
beq $t0, $s2 endLoop
 lw $t1, 0($t0)
 add $t3, $t3, $t1
 addi $t0, $t0, 4
 j Loop
 
endLoop:
move $a0, $t3
li $v0, 1         # syscall number 1 -- print int
syscall           # actually print the int

li $v0, 10  # Syscall number 10 is to terminate the program
syscall     # exit now
