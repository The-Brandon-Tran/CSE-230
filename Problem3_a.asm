main:
# adds the numbers of the first row
li $t0, 54
sw $t0, 0x10010000 ($0)
li $t0, 16
sw $t0, 0x10010004 ($0)
li $t0, 76
sw $t0, 0x10010008 ($0)
li $t0, 14
sw $t0, 0x1001000c ($0)

# adds the numbers of the second row
li $t1, 5
sw $t1, 0x10010010 ($0)
li $t1, 20
sw $t1, 0x10010014 ($0)
li $t1, 36
sw $t1, 0x10010018 ($0)
li $t1, 8
sw $t1, 0x1001001c ($0)

# adds the numbers of the third row
li $t2, 89
sw $t2, 0x10010020 ($0)
li $t2, 10
sw $t2, 0x10010024 ($0)
li $t2, 22
sw $t2, 0x10010028 ($0)
li $t2, 12
sw $t2, 0x1001002c ($0)

# adds the numbers of the fourth row
li $t3, 46
sw $t3, 0x10010030 ($0)
li $t3, 30
sw $t3, 0x10010034 ($0)
li $t3, 6
sw $t3, 0x10010038 ($0)
li $t3, 16
sw $t3, 0x1001003c ($0)