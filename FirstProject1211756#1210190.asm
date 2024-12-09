#Names : kareem Qutob 1211756   Ahmad Qaimari 1210190
.data
inputID:.space 8
zeroasfloat :.float 0.0
tenasfloat :.float 10.0
oneasfloat :.float 1.0
Masfloat :.float 100.0
inputTest:.space 4
combinedDate:.space 8
combinedDate1:.space 8
combinedDate2:.space 8
revYear:.space 5
revMonth:.space 3
revString:.space 20
inputString:.space 11
fractionPart:.space 7
intPart:.space 5

# the below reserved spaces are used in reading the file
char:.space 1
idString:.space 8
Tname:.space 4
date:.space 8
res1:.space 8
res2:.space 8
trash:.space 2
num:.space 12
num2:.space 12
indicies : .word 0:100
intasString:.space 12
floatString:.space 10
#---------------------------------------------------------
#node definition
.align 2 # to maintain allignmint
# we used a linked list for the implementation the node will be be divided as below
nodeSize: .word 28
idOff:.word 0
TestNameOff:.word 4
dateOff:.word 8 
res1Off:.word 16
res2Off:.word 20
pointer:.word 24
#------------------------------------------------------------
fileName: .asciiz "C:/Users/kareem/Desktop/ARC/data.txt"
open_err_msg:.asciiz "the file can't be opened\n"
invalid_tname_msg:.asciiz "the test name is invalid\n"
invalid_id_msg:.asciiz "the id intered is invalid\n"
enter_test_index:.asciiz "Enter test index or enter -1 to exit\n"
id_not_found:.asciiz "the id enterd is not found\n"
test_invalid:.asciiz "entered test value is invalid\n"
date_invalid:.asciiz "entered date is invalid\n"
enter_new_result: .asciiz "Enter the new result\n"
Month_invalid:.asciiz "Month must be between (1-12)\n"
year_invalid:.asciiz "Year must be between (2000-2024)\n"
which_result : .asciiz "Which result would you like to update (1 or 2) or enter -1 to exit\n"
welcome:.asciiz "welcome to our Medical tests database :)\n"
invalid_option:.asciiz "invalid choice !!\n\n"
chooseOp:.asciiz "chose an a option (1-7)\n"
option1:.asciiz "1)Enter a new medical test\n"
option2:.asciiz "2)Search for a test By id\n"
resultupdated:.asciiz "The new result has been saved successfully\n"
chooseRetMethod:.asciiz "\nChoose a retrtival option (1-4)\n"
method1:.asciiz"1)Retrieve all tests\n"
method2:.asciiz "2)Retrieve all up normal patient tests\n"
method3:.asciiz "3)Retrieve all patient tests in a given specific period\n"
option3:.asciiz "3)Search for unnormal tests\n"
option4:.asciiz "4)Find the average test value\n"
option5:.asciiz "5)Update an existing test result\n"
option6:.asciiz "6)Delete a test\n"
option7:.asciiz "7)Update input file and exit\n"
enterID:.asciiz "\nEnter patient ID\n"
enterIDUP:.asciiz "\nEnter patient ID or -1 to return to menu\n"
enterIDD:.asciiz "\nEnter patient ID or x to return to menu\n"
enterTname:.asciiz "\nEnter Test name\n"
enterDate:.asciiz "Enter the date of the test\n"
enterYear:.asciiz "Enter Year\n"
enterMonth:.asciiz "Enter the Month of the test\n"
enterRes1:.asciiz "Enter test result\n"
enterID6:.asciiz "\nEnter ID or -1 to exit\n"
enterRes2:.asciiz "Enter test second result\n"
recordStored:.asciiz "The record is succsesfully saved\n\n"
testdeleted:.asciiz "The test has been deleted successfully\n"
index_out_of_range:.asciiz "The entered index is out of range\n"
bracket:.asciiz ")"
newLine:.asciiz "\n"
hgbTest:.asciiz "HGB"
bgtTest:.asciiz "BGT"
ldlTest:.asciiz "LDL"
bpt:.asciiz "BPT"
zero:.asciiz "0"
bptTest:.asciiz "BPT"
returnToMenu:.asciiz "4)Return to menu\n" 
abnormal:.asciiz "ABNORMAL TEST:\n"
noabnormaltests:.asciiz "No Abnormal Tests Found\n"
notMatchedPerMsg:.asciiz "\n No tests found within given period!\n"
comma : .asciiz ","
colon : .asciiz ":"
space : .asciiz " "
hgb : .asciiz "HGB"
BGT : .asciiz "BGT"
ldl : .asciiz "LDL"
no_test_type :.asciiz "There aren't any saved tests of this type"
the_average :.asciiz "Average : "
bpt_s:.asciiz "BPT Systolic"
bpt_d:.asciiz "BPT Diastolic"
letterX:.asciiz "x\n"
HGB_min : .float 13.8
HGB_max : .float 17.2
BGT_min : .float 70.0
BGT_max : .float 99.0
LDL_max : .float 100.0 
BPTS_max : .float 120.0
BPTD_max : .float 80.0
place_holder : .space 50
date_string : .space 50
periodDate:.space 8
zeroFloat: .float 0.0 
enterRecNum:.asciiz "enter the number of record you want to delete\n"
#thhis function will convert int to areversed string
.macro write_file(%toWrite,%length) #%toWrite contains address of the string to be written
        #Write the file
        li $v0,15        # write_file syscall code = 15
        move $a0,$s0        # file descriptor
        move $a1,%toWrite        # the string that will be written
        move $a2,%length        # length of the toWrite string
        syscall
.end_macro
#Macro to write the linked list content to a file
.macro save_list_to_file
    close_file
    #Opening in write mode
    open_file(fileName,1)
    lw $t8,24($s2)
    beqz $t8,null_reached
cont_loop:
    #STructuring the test
    lw $t9,($t8)
    int2str($t9)
    la $a0,intasString
    la $a1,revString
    jal strlen
    li $a2,7
    write_file($a1,$a2)
    la $a1,colon
    li $a2,1
    write_file($a1,$a2)
    la $a1,space
    write_file($a1,$a2)
    lw $t9,4($t8)
    sw $t9,place_holder
    la $a1,place_holder
    li $a2,3
    write_file($a1,$a2)
    la $a1,comma
    li $a2,1
    write_file($a1,$a2)
    la $a1,space
    li $a2,1
    write_file($a1,$a2)
    ld $s4,8($t8)
    sd $s4,place_holder
    la $a1,place_holder
    li $a2,7
    write_file($a1,$a2)
    la $a1,comma
    li $a2,1
    write_file($a1,$a2)
    la $a1,space
    li $a2,1
    write_file($a1,$a2)
    l.s $f1,16($t8)
    la $a0,place_holder
    jal strEmpty
    la $a0,intasString
    jal strEmpty
    la $a0,revString
    jal strEmpty
    float2str ($f1 , place_holder)
    la $s7,place_holder
res1_loop :
    lb $a1,0($s7)
    sb $a1,char
    la $a3,char
    beq $a1,0,res1_written
    li $a2,1
    write_file($a3,$a2)
    addiu $s7,$s7,1
    b res1_loop
res1_written:
    lw $t9,20($t8)
    beqz $t9,finish_line
    la $a1,comma
    li $a2,1
    write_file($a1,$a2)
    la $a1,space
    li $a2,1
    write_file($a1,$a2)
    la $a0,place_holder
    jal strEmpty
    la $a0,intasString
    jal strEmpty
    la $a0,revString
    jal strEmpty
    l.s $f1,20($t8)
    float2str ($f1 , place_holder)
    la $s7,place_holder
res2_loop :
    lb $a1,0($s7)
    sb $a1,char
    la $a3,char
    beq $a1,0,finish_line
    li $a2,1
    write_file($a3,$a2)
    addiu $s7,$s7,1
    b res2_loop    
finish_line:
    lw $t8,24($t8)
    beqz $t8,null_reached
    la $a1,newLine
    li $a2,1
    write_file($a1,$a2)
    b cont_loop
	        

null_reached:
	close_file
    move $zero,$zero                
.end_macro
.macro int2str(%x)
    move $a0,%x
    li $t0,10
    la $a1,intasString ## buffer to store the number
L2:   
    div $a0,$t0 #dicide by zerp
    mflo $a0    #save q
    mfhi $t1	#save reminder
    addiu $t1,$t1,'0'  # Convert remainder to ASCII character
    sb $t1, 0($a1)
    addi $a1, $a1, 1	

    bnez $a0,L2	  # Repeat until quotient is zero
.end_macro
.macro open_file(%fileLocation, %flag)
	li $v0, 13
	la $a0,%fileLocation
	li $a1, %flag
	li $a2, 0 
	syscall
	move $s0,$v0 
	move $s1 , $s0
	bltz $v0, openError
.end_macro
#Structures the test sentence
.macro print_test
	
		print_int($t3)
		print_string(colon)
		print_string(space)
		lw $t3,4($t2)
		sw $t3,place_holder
		print_string(place_holder)
		print_string(comma)
		print_string(space)
		ld $t3,8($t2)
		sd $t3,place_holder
		print_string(place_holder)
		print_string(comma)
		print_string(space)
		l.s $f2,16($t2)
		print_float($f2)
		l.s $f2,20($t2)
		l.s $f3,zeroasfloat
		c.eq.s $f2,$f3
		bc1t one_res
		print_string(comma)
		print_string(space)
		print_float($f2)
		one_res:
			print_string(newLine)
.end_macro
.macro search_list(%head,%ID)
	move $s2,%head
	move $t1,%ID
	move $s3,$zero #Used as flag
	lw $t2,24($s2) #current = head->next
  	move $t3,$zero #current ID
  	li $s4,0
	find_node:
		lw $t3,0($t2)
		beq $t3,%ID,node_found
resume:		lw $t2,24($t2) #current = current->next
		beq $t2,$zero,null_reached
		b find_node
	node_found:
		la $t8,indicies #indicies is an array that contains pointers to the matched node,used for indexing.
		#Index is saved in $s4
		sll $t9,$s4,2 #Offset is index * 4
		add $t8,$t8,$t9 # $t8 = address of indices + offset
		sw $t2,($t8) #Load value from memory
		li $s3,1 #There is at least on node found,so change flag to 1
		#Structuring the test options
		print_int($s4)
		print_string(bracket)
		print_int($t3)
		print_string(colon)
		print_string(space)
		lw $t3,4($t2)
		sw $t3,place_holder
		print_string(place_holder)
		print_string(comma)
		print_string(space)
		ld $t3,8($t2)
		sd $t3,place_holder
		print_string(place_holder)
		print_string(comma)
		print_string(space)
		l.s $f2,16($t2)
		print_float($f2)
		l.s $f2,20($t2)
		l.s $f3,zeroasfloat
		c.eq.s $f2,$f3
		bc1t one_res
		print_string(comma)
		print_string(space)
		print_float($f2)
		print_string(newLine)
		addiu $s4 ,$s4 , 1
		b resume
	null_reached:
		bnez $s3,fi
		print_string(id_not_found)
		b fi
	one_res:
		print_string(newLine)
		addiu $s4 ,$s4 , 1
		b resume		
fi :	move $zero,$zero					
.end_macro


.macro delete_node(%head)
	la $t8,indicies
	sll $t9,$t0,2#taking entered index in $t0 and multiplying by 4
	add $t8,$t8,$t9 #Finding the offset
	lw $t2,($t8) # $t2 now contains the address of the node to be deleted
	sub $t3,$t2,4#Go to previous node in the list
	lw $t2,24($t2)
	sw $t2,($t3) #Replace where the next pointer points to
	print_string(testdeleted)
.end_macro
		
			
.macro int2float(%x)
       mtc1 %x,$f1
       cvt.s.w $f1,$f1
.end_macro
.macro float2int(%x)
 	cvt.w.s $f1, %x
         mfc1 $t0, $f1
.end_macro
#Used for the indexed menu
.macro check_index_range(%input)

	bgt %input,$s4,index_out_of_range #s4 contains counter of matched items
	blt %input,-1,index_out_of_range
	b index_in_range

index_out_of_range:
	li $v0,1		

index_in_range:
	li $v0,0

finish_check:
	move $zero,$zero		
.end_macro
#Checking the type of the test
.macro check_test_name
	la $a1 , hgbTest
	la $a0,inputTest
	jal strCMP
	beqz $v0,finish
	la $a1 , bgtTest
	la $a0,inputTest
	jal strCMP
	beqz $v0,finish
	la $a1 , ldlTest
	la $a0,inputTest
	jal strCMP
	beqz $v0,finish
	la $a1 , bptTest
	la $a0,inputTest
	jal strCMP
	beqz $v0,finish
finish : move $zero,$zero
.end_macro
.macro float2str (%x , %buffer)
	la $a0 , fractionPart
	jal strEmpty
	la $a0 , intPart
	jal strEmpty
	li $t3 , 1
	mov.s $f3 , %x
	mov.s $f4 , $f3 # move the value in other register
	float2int($f4)
	move $t9 , $t0  # this will have the integer part
	int2float($t0)
	la $a3 , %buffer
	mov.s $f5 , $f1 # reconvert to float 
	sub.s $f5 , $f3 , $f5 # to save the fraction part alone
	l.s   $f6 , Masfloat # will be needed for conversion
	mul.s $f5 , $f6 , $f5
	#print_int($t9)
	int2str($t9) # recheck this
	#print_string(intasString)
	la $a0 , intasString
	la $a1 , revString
	jal strlen     # will reverse the string after lenght
	la $a0 , revString
	la $a1 , intPart

	jal strcpy
	
	la $a0 , intasString
	jal strEmpty
	la $a0 , revString
	jal strEmpty
	int2float($a0)
	#print_float($f5)
	float2int($f5)
	
	move $t9 , $t0
	int2str($t9) # recheck this

	la $a0 , intasString
	la $a1 , revString
	jal strlen     # will reverse the string after lenght
	la $a0 , revString
	la $a1 , fractionPart
	jal strcpy
	la $a0 , intasString
	jal strEmpty
	la $a0 , revString
	jal strEmpty
	#print_string(intPart)
	#print_string(newLine)
	#print_string(fractionPart)
	la $a0 , fractionPart
	move $t1, $zero # counter
	move $t0, $a0
fractionLenghtLoop:
	lb $t2 ,0($t0)
	beqz $t2,delterzeros
	addi $t1, $t1, 1        
   	addi $t0, $t0, 1        # to the next byte
	b fractionLenghtLoop
delterzeros:
	lb $t2 ,0($t0)

	bne $t2 ,0, endDeletion
	sb $zero, 0($t0) # store null in place of the the zero
	subi $t1, $t1, 1        
	addi $t0, $t0, 1 
	beqz $t1, endDeletion
	b delterzeros
endDeletion:
	la $a1 , intPart 
	move $t2 , $a3 # the result 
	move $t0, $a0# pointer to fraction
	move $t1, $a1# pointer to INT
intPartCopy:
	lb $t3 , 0($t1)
	beqz $t3 , add.
	sb $t3, 0($t2)
	add $t1, $t1, 1  
	addi $t2, $t2, 1
	b intPartCopy
add.:
	li $t5 , 46
	sb $t5 , 0($t2)
	addi $t2, $t2, 1
fractionPartCOPY:
	lb $t3 , 0($t0)
	beqz $t3 , ENDOFCOPY	
	sb $t3, 0($t2)
	add $t0, $t0, 1  
	addi $t2, $t2, 1
	b fractionPartCOPY
ENDOFCOPY:
	sb $zero, 0($t2)


.end_macro
.macro str2float(%string)
	la $a0,%string
	li $v0,0
	li $t2,0
	li $t0,10
	l.s $f4,oneasfloat
	l.s $f6,tenasfloat
L1:	lb $t1,0($a0)
	beq $t1,'.',fp
	blt $t1, '0', done
	bgt $t1, '9', done
	addiu $t1,$t1,-48
	mul $v0,$v0,$t0
	addu $v0,$v0,$t1
	addiu $a0,$a0,1
	j L1
fp:	li $t4,0 #count of digits after period
cont:	addiu $a0,$a0,1
	addiu $t4,$t4,1
	lb $t1,0($a0)
	blt $t1, '0', done
	bgt $t1, '9', done
	addiu $t1,$t1,-48
	mul $t2,$t2,$t0
	addu $t2,$t2,$t1
	mul.s $f4,$f4,$f6
	j cont	
done: 	move $s4,$v0
	int2float($s4)
	mov.s $f2,$f1 #Part before the period
	
	int2float($t2)
	mov.s $f3,$f1 #Part after period
	div.s $f3,$f3,$f4 #divide by power of 10
	add.s $f5,$f2,$f3 #Final Result stored in $f5
.end_macro
.macro insert_node(%head,%id,%name,%date,%result1,%result2)
	move $t0,%head
	move $t2,$t0
	lw $t1,24($t0) #current = head->next
	find_null_loop:	
		beq $t1,$0,null_found
		move $t2,$t1 #Address where the current node starts
		lw $t1,24($t1)
	j find_null_loop
	null_found:
		li $v0,9
		li $a0,28
		syscall
		sw %id,0($v0)
		sw %name,4($v0)
		sd %date,8($v0)
		s.s %result1,16($v0)
		s.s %result2,20($v0)		
		sw $0,24($v0)
		sw $v0,24($t2) #previous->next = current
.end_macro
.macro create_linked_list()
	li $v0,9
	li $a0,28 #Size of Node
	syscall
	move $s2,$v0 #Head Address
.end_macro
.macro read_file
	li $v0, 14		# read_file syscall code = 14
	move $a0,$s0		# file descriptor
	la $a1,fileWords  	# The buffer that holds the string of the WHOLE file
	la $a2,1024		# hardcoded buffer length
	syscall
.end_macro
.macro print_string(%string)
    li $v0, 4           # syscall 4 - print string
    la $a0, %string    
    syscall
.end_macro

.macro close_file
	#Close the file
    	li $v0, 16         		# close_file syscall code
    	move $a0,$s1      		# file descriptor to close
    	syscall
.end_macro
.macro clear_tr
	li $v0,14 #call for read char
	move $a0, $s0      # File descriptor
	la $a1,trash  # char addres
	li $a2 , 2 # will read one char at a time 
	syscall
.end_macro 
.macro  loadchar
	li $v0,14 #call for read char
	move $a0, $s0      # File descriptor
	la $a1,char  # char addres
	li $a2 , 1 # will read one char at a time 
	syscall
.end_macro 
.macro readInt
    li $v0, 5           # System call code for read_int
    syscall             # Make the syscall to read an integer
    move $t0, $v0  
.end_macro 
.macro readChar
    li $v0, 12          # System call code for read_char
    syscall             
    move $t0, $v0 
 .end_macro 
.text
.globl main
.macro readString
    li $v0, 8                  # Syscall number for read (from stdin)
    la $a0, inputString            
    li $a1, 32                 #numbers of chars to read                
    li $a2, 0                 
    syscall    
.end_macro  
.macro print_int(%value)
    li $v0, 1           
    move $a0, %value    
    syscall             # Call the syscall to print the integer
.end_macro
.macro readFloat
	li $v0 , 6 # system call to read a float
	syscall
.end_macro 
.macro printFloat (%float)
	li $v0 , 2 # system call to print a floa
	mov.s $f12 , %float
	syscall
.end_macro 
.macro str2int(%string)
	la $s6,%string
	li $t8, 0 # Initialize: $t8 = sum = 0
	li $t9, 10 # Initialize: $t9 = 10
L1: 	lb $t7, 0($s6) # load $t7 = str[i]
	blt $t7, '0', fin # exit loop if ($t7 < '0')
	bgt $t7, '9', fin # exit loop if ($t7 > '9')
	addiu $t7, $t7, -48 # Convert character to digit
	mul $t8, $t8, $t9 # $t8 = sum * 10
	addu $t8, $t8, $t7 # $t8 = sum * 10 + digit
	addiu $s6, $s6, 1 # $s6 = address of next char
	j L1 # loop back
fin:	move $t8,$t8
.end_macro

.macro print_float(%x)
	li $v0,2
	mov.s $f12,%x
	syscall
.end_macro	



.macro search_abnormal_by_ID(%head,%ID)
	move $s2,%head
	move $t1,%ID
	move $s3,$zero #Used as flag to check if ID was found
	move $t8,$zero #Used as flag for abnormal tests
	lw $t2,24($s2) #current = head->next
	move $t3,$zero #current ID
	find_node:
		lw $t3,0($t2)
		beq $t3,%ID,node_found
resume:		lw $t2,24($t2) #current = current->next
		beq $t2,$zero,null_reached
		b find_node
	node_found:
		li $s3,1
		la $a0,4($t2) #Load Test Name
		la $a1,hgb
		jal strCMP
		beqz $v0,hgb_test
		la $a0,4($t2) #Load Test Name
		la $a1,BGT
		jal strCMP
		beqz $v0,bgt_test
		la $a0,4($t2) #Load Test Name
		la $a1,ldl
		jal strCMP
		beqz $v0,ldl_test
		la $a0,4($t2) #Load Test Name
		la $a1,bpt
		jal strCMP
		beqz $v0,bpt_test
		#Comparing Test values
		hgb_test: 
			l.s $f3,HGB_max
			l.s $f4,HGB_min
			l.s $f2,16($t2)
			c.le.s $f2,$f3
			bc1f not_normal
			c.le.s $f4,$f2
			bc1f not_normal
			bc1t normal
		bgt_test:
			l.s $f3,BGT_max
			l.s $f4,BGT_min
			l.s $f2,16($t2)
			c.le.s $f2,$f3
			bc1f not_normal
			c.le.s $f4,$f2
			bc1f not_normal
			bc1t normal
		ldl_test:
			l.s $f3,LDL_max
			l.s $f2,16($t2)
			c.le.s $f3,$f2
			bc1t not_normal
			bc1f normal
		bpt_test:
			l.s $f3,BPTS_max
			l.s $f4,BPTD_max
			l.s $f2,16($t2)
			l.s $f5,20($t2)
			c.le.s $f3,$f2
			bc1t not_normal
			c.le.s $f4,$f5
			bc1t not_normal
			bc1f normal												
	normal:	b resume		
	null_reached:
		bnez $s3,fi
		print_string(id_not_found)
		b fi
	not_normal:
		li $t8,1
		print_string(abnormal)
		print_test
		b resume
	no_abnormal_tests:
		print_string(noabnormaltests)
		b fi2						
fi :	
	beqz $t8,no_abnormal_tests #Checks the counter in $t8
fi2 :   move $zero,$zero
.end_macro

#Searches for unnomral tests of ANY type
.macro search_abnormal_tests(%head)
	la $a0,inputTest
	move $a3,$a0
	move $t8,$zero #Used as flag for abnormal tests
	lw $t2,24($s2)
resume:	
	move $a0,$a3
	beq $t2,$zero,fi
	lw $t3,0($t2)
	la $a1,4($t2)
	jal strCMP
	bnez $v0,no_match
	la $a0,4($t2) #Load Test Name
	la $a1,hgb
	jal strCMP
	beqz $v0,hgb_test
	la $a0,4($t2) #Load Test Name
	la $a1,BGT
	jal strCMP
	beqz $v0,bgt_test
	la $a0,4($t2) #Load Test Name
	la $a1,ldl
	jal strCMP
	beqz $v0,ldl_test
	la $a0,4($t2) #Load Test Name
	la $a1,bpt
	jal strCMP
	beqz $v0,bpt_test
	hgb_test:
			l.s $f3,HGB_max
			l.s $f4,HGB_min
			l.s $f2,16($t2)
			c.le.s $f2,$f3
			bc1f not_normal
			c.le.s $f4,$f2
			bc1f not_normal
			bc1t normal
	bgt_test:
			l.s $f3,BGT_max
			l.s $f4,BGT_min
			l.s $f2,16($t2)
			c.le.s $f2,$f3
			bc1f not_normal
			c.le.s $f4,$f2
			bc1f not_normal
			bc1t normal
	ldl_test:
			l.s $f3,LDL_max
			l.s $f2,16($t2)
			c.le.s $f3,$f2
			bc1t not_normal
			bc1f normal
	bpt_test:
			l.s $f3,BPTS_max
			l.s $f4,BPTD_max
			l.s $f2,16($t2)
			l.s $f5,20($t2)
			c.le.s $f3,$f2
			bc1t not_normal
			c.le.s $f4,$f5
			bc1t not_normal
			bc1f normal
	no_match:
		lw $t2,24($t2)
		b resume			
	normal:	
		lw $t2,24($t2)
		b resume		
	not_normal:
		li $t8,1
		print_string(abnormal)
		print_test
		lw $t2,24($t2)
		b resume
	no_abnormal_tests:
		print_string(noabnormaltests)
		b fi2						
fi :	
	beqz $t8,no_abnormal_tests
fi2 :   move $zero,$zero					

.end_macro

.macro find_average(%head)
	l.s $f0,zeroasfloat
	
	l.s $f1,zeroasfloat
	l.s $f2,zeroasfloat
	l.s $f3,zeroasfloat
	l.s $f4,zeroasfloat
	l.s $f5,zeroasfloat
	l.s $f6,zeroasfloat
	l.s $f7,zeroasfloat
	l.s $f8,zeroasfloat
	l.s $f9,zeroasfloat
	l.s $f10,zeroasfloat
	
	l.s $f11,oneasfloat
	
	lw $t2,24($s2)
cont:	beq $t2,$zero,null_reached
	la $a0,4($t2) #Load Test Name
	la $a1,hgb
	jal strCMP
	beqz $v0,hgb_avg
	la $a0,4($t2) #Load Test Name
	la $a1,BGT
	jal strCMP
	beqz $v0,bgt_avg
	la $a0,4($t2) #Load Test Name
	la $a1,ldl
	jal strCMP
	beqz $v0,ldl_avg
	la $a0,4($t2) #Load Test Name
	la $a1,bpt
	jal strCMP
	beqz $v0,bpt_avg
	#Computing the averages
	hgb_avg:
		add.s $f1,$f1,$f11
		l.s $f12,16($t2)
		add.s $f2,$f2,$f12
		lw $t2,24($t2)
		b cont
	bgt_avg:
		add.s $f3,$f3,$f11
		l.s $f12,16($t2)
		add.s $f4,$f4,$f12
		lw $t2,24($t2)
		b cont
	ldl_avg:
		add.s $f5,$f5,$f11
		l.s $f12,16($t2)
		add.s $f6,$f6,$f12
		lw $t2,24($t2)
		b cont
	bpt_avg:
		add.s $f7,$f7,$f11
		l.s $f12,16($t2)
		add.s $f8,$f8,$f12
		l.s $f12,20($t2)
		c.eq.s $f12,$f0
		#In case  the test only had one result
		bc1t no_res2
		add.s $f9,$f9,$f11
		add.s $f10,$f10,$f12
no_res2:	lw $t2,24($t2)
		b cont	

null_reached:
		
		print_string(newLine)
		print_string(hgb)
		print_string(space)
		print_string(the_average)
		print_string(space)
		c.eq.s $f2,$f0
		bc1t no_hgb_tests
		div.s $f2,$f2,$f1
		print_float($f2)
bgt_handle:	print_string(newLine)
		print_string(BGT)
		print_string(space)
		print_string(the_average)
		print_string(space)
		c.eq.s $f4,$f0
		bc1t no_bgt_tests
		div.s $f4,$f4,$f3		
		print_float($f4)
ldl_handle:	print_string(newLine)
		print_string(ldl)
		print_string(space)
		print_string(the_average)
		print_string(space)
		c.eq.s $f6,$f0
		bc1t no_ldl_tests
		div.s $f6,$f6,$f5		
		print_float($f6)
bpt_s_handle:	print_string(newLine)
		print_string(bpt_s)
		print_string(space)
		print_string(the_average)
		print_string(space)
		c.eq.s $f8,$f0
		bc1t no_bpt_s_tests
		div.s $f8,$f8,$f7		
		print_float($f8)
bpt_d_handle:	print_string(newLine)
		print_string(bpt_d)
		print_string(space)
		print_string(the_average)
		print_string(space)
		c.eq.s $f10,$f0
		bc1t no_bpt_d_tests
		div.s $f10,$f10,$f9		
		print_float($f10)
		print_string(newLine)
		b finish_average
#Chechking if any type of test didn't exist		
no_hgb_tests:
	print_string(no_test_type)
	b bgt_handle
no_bgt_tests:
	print_string(no_test_type)
	b ldl_handle
no_ldl_tests:
	print_string(no_test_type)
	b bpt_s_handle
no_bpt_s_tests:
	print_string(no_test_type)
	b bpt_d_handle
no_bpt_d_tests:
	print_string(no_test_type)
	print_string(newLine)				
			
finish_average : move $zero,$zero			
																												
.end_macro

.macro search_by_period(%head,%ID,%date1,%date2)
	
	move $s2,%head
	move $t1,%ID
	move $s3,$zero #Used as flag
	lw $t2,24($s2) #current = head->next
  	move $t3,$zero #current ID
  	li $t4 , 0 #flag
  	
	find_node:
		lw $t3,0($t2)
		beq $t3,%ID,node_found
resume:		
		lw $t2,24($t2) #current = current->next
		beq $t2,$zero,null_reached
		b find_node
	node_found:
		li $s3 , 1
		ld $t5 , 8($t2) # to load the date alone
		sd $t5 , periodDate

		la $a0 , periodDate # will store have the date of the current node
		move $a1 , %date1
		jal strCMP
		beq $v0 , -1 , resume
		la $a0 , periodDate # will store have the date of the current node
		move $a1 , %date2
		jal strCMP
		beq $v0 , 1 , resume
		#print_string(newLine)
		li $t4 , 1
		print_test
		
		b resume
	null_reached:
		bnez $s3,fi
		
		print_string(id_not_found)
		b fi
	one_res:
		print_string(newLine)
		b resume		
fi :	beqz $t4 , notMatchedPeriod
	b fii
notMatchedPeriod:
	print_string(notMatchedPerMsg)
fii:
	move $zero , $zero	
			

.end_macro
.macro check_test_name
	la $a1 , hgbTest
	la $a0,inputTest
	jal strCMP
	beqz $v0,finish
	la $a1 , bgtTest
	la $a0,inputTest
	jal strCMP
	beqz $v0,finish
	la $a1 , ldlTest
	la $a0,inputTest
	jal strCMP
	beqz $v0,finish
	la $a1 , bptTest
	la $a0,inputTest
	jal strCMP
	beqz $v0,finish
finish : move $zero,$zero
.end_macro
#Used for indexed menu
.macro check_index_range(%input)
	sub $s4 , $s4 , 1 
	bgt %input,$s4,index_out_of_range
	blt %input,-1,index_out_of_range
	b index_in_range

index_out_of_range:
	li $v0,1		
	b  finish_check
index_in_range:
	li $v0,0

finish_check:
	move $zero,$zero		
.end_macro
.macro update_node(%head)
	
	la $t8,indicies
	sll $t9,$t0,2 #multiplying by 4 for the offset
	add $t8,$t8,$t9 #calculating the address with offset
	lw $t2,($t8)
	la $a0,4($t2)
	la $a1,bpt
	jal strCMP
	beqz $v0,bpt_test
	print_string(enter_new_result)
	readFloat
	s.s $f0,16($t2)
	print_string(resultupdated)
	b finish_update

bpt_test:
	print_string(which_result)
	readInt
	beq $t0,1,update_res1
	beq $t0,2,update_res2
	beq $t0,-1,update_test_result
	b wrong_input

update_res1:
	readFloat
	s.s $f0,16($t2)
	print_string(resultupdated)
	b finish_update
update_res2:
	print_string(enter_new_result)
	readFloat
	s.s $f0,20($t2)
	print_string(resultupdated)
	b finish_update	

wrong_input:
	print_string(index_out_of_range)
	b bpt_test		
					
	
finish_update:
	move $zero,$zero	

.end_macro	


main:
	
	open_file (fileName, 0)
	
	create_linked_list() #Stores head of linked list in $s2
	
	
readLineByLine:

	 jal readLine
	  move $a0, $v0
	  beqz $a0,openMenu
	  j readLineByLine 
openMenu:
        print_string(welcome)
	print_string(chooseOp)
	print_string(option1)
	print_string(option2)
	print_string(option3)
	print_string(option4)
	print_string(option5)
	print_string(option6)
	print_string(option7)
	readChar
	move $a0 , $t0
	jal isValidOption
	beq $v0 , 0,invalidOptionERR
	beq $t0, '1', addMT
	beq $t0, '2', retMenu
	beq $t0, '3', abnormalTest
	beq $t0, '4', compute_average
	beq $t0, '5', update_test_result
	beq $t0, '6', DeleteTest
	beq $t0, '7', UpdateFile
#_____________________________
UpdateFile:
	save_list_to_file
	b END
#____________________________________-
update_test_result:
	print_string(enterIDD)
	readString
	la $a1 , letterX
	jal strCMP
	beq $v0,0,openMenu
	la $a0 , inputString
	jal checkID #check if id valid
	la $a1 , inputID
	jal strcpy # copy it in another string
	beq $v0,0 DeleteTest
	str2int(inputID) # convert it to int
	#beq $t0 , -1 , openMenu
	move $t0 , $t8
	search_list($s2,$t0)
	#beqz $s3,update_test_result #No tests for the entered patient ID
ask_index: 
	print_string(enter_test_index)
	readInt
	beq $t0,-1,openMenu
	check_index_range($t0)
	bnez $v0,wrong_index
	update_node($s2)
	b update_test_result
	wrong_index:
		print_string(index_out_of_range)
		b ask_index
#__________________________________
compute_average:
	find_average($s2)
	b openMenu
#__________________________________________
abnormalTest:
	la $a0 , inputString
	jal strEmpty
TestNamePart:
	print_string(enterTname) 
	readString
	la $a1, inputTest
	la $a0 , inputString
	jal strcpy
	la $a0, inputTest
	jal removeNewline
	lw $t9 , inputTest
	li $t8 ,10
	check_test_name
	bnez $v0,wrong_test_name


	search_abnormal_tests($s2)
	b openMenu
	
wrong_test_name:
		print_string(invalid_tname_msg)
		b abnormalTest
#_____________________________________

#____________________________________________________________
DeleteTest:
	print_string(enterIDD)
	readString
	la $a1 , letterX
	jal strCMP
	beq $v0,0,openMenu
	la $a0 , inputString
	jal checkID #check if id valid
	la $a1 , inputID
	jal strcpy # copy it in another string
	beq $v0,0 DeleteTest
	str2int(inputID) # convert it to int
	#beq $t0 , -1 , openMenu
	move $t6 , $t8
	search_list($s2,$t6)
#Checking the entered index for the test selection for deletion menu	
ask_index_delete: print_string(enter_test_index)
	readInt
	beq $t0,-1,openMenu
	check_index_range($t0)
	bnez $v0,wrong_index_delete
	delete_node($s2)
	b DeleteTest
	wrong_index_delete:
		print_string(index_out_of_range)
		b ask_index_delete
#__________________________________________________
retMenu:
	print_string(chooseRetMethod)
	print_string(method1)
	print_string(method2)
	print_string(method3)
	print_string(returnToMenu)
	readInt
	move $a0 , $t0
	li $a1 , 0
	li $a2 , 5
	jal inRange
	beq $v0,0 wrongOp
	beq $t0, 1, ret1
	beq $t0, 2, ret2
	beq $t0, 3, ret3
	beq $t0, 4, openMenu
wrongOp:
	print_string(invalid_option)
	b retMenu
	
#__________________________________________________
ret1:
	print_string(enterID)
	readString
	la $a0 , inputString

	jal checkID #check if id valid
	la $a1 , inputID
	jal strcpy # copy it in another string
	beq $v0,0 ret1
	str2int(inputID)
	move $s7 , $t8
	search_list($s2,$s7)
	b retMenu
#_________________________________________________
ret2:
	print_string(enterID)
	readString
	la $a0 , inputString
	jal checkID #check if id valid
	la $a1 , inputID
	jal strcpy # copy it in another string
	beq $v0,0 ret2
	str2int(inputID)
	#print_int($t8)
	move $s7 , $t8
	search_abnormal_by_ID($s2,$s7)
	b retMenu
#______________________________________________
ret3:
	print_string(enterID)
	readString
	la $a0 , inputString
	jal checkID #check if id valid
	la $a1 , inputID
	jal strcpy # copy it in another string
	beq $v0,0 ret2
	str2int(inputID)
	move $t9 , $t8
# this part to take dates
print_string(enterDate)

year1:	print_string(enterYear) # we will take year and month alone to test them
	readInt			# then after that we will comnine the,
	move $a0 , $t0
	li $a1 , 1999
	li $a2 , 2025
	jal inRange
	beq $v0,0 wrongYear1 # to print error message
	int2str($t0) # converrt to string
	
	la $a0 , intasString
	la $a1 , revString 
	jal strlen     # will reverse the string after lenght
	la $a0 , revString
	la $a1 , revYear
	jal strcpy
	la $a0 , intasString
	jal strEmpty
	la $a0 , revString
	jal strEmpty
month1:	print_string(enterMonth) # repeat the same process for month
	readInt
	move $a0 , $t0
	li $a1 , 0
	li $a2 , 13
	jal inRange
	int2str($t0)
	beq $v0,0 wrongMonth1
	la $a0 , intasString
	la $a1 , revString
	jal strlen
	la $a0 , revString	
	la $a1 , revMonth
	jal strcpy
	la $a0, revMonth
	la $a1 , revYear
	la $a2 , combinedDate1 # we combine them in yyyy-mm format
	jal combineDate
	ld $s5 , combinedDate1
	la $a0 , revMonth
	jal strEmpty
	
# the seconddate
	print_string(enterDate)

year2:	print_string(enterYear) # we will take year and month alone to test them
	readInt			# then after that we will comnine the,
	move $a0 , $t0
	li $a1 , 1999
	li $a2 , 2025
	jal inRange
	beq $v0,0 wrongYear2 # to print error message
	int2str($t0) # converrt to string
	
	la $a0 , intasString
	la $a1 , revString 
	jal strlen     # will reverse the string after lenght
	la $a0 , revString
	la $a1 , revYear
	jal strcpy
	la $a0 , intasString
	jal strEmpty
	la $a0 , revString
	jal strEmpty
month2:	print_string(enterMonth) # repeat the same process for month
	readInt
	move $a0 , $t0
	li $a1 , 0
	li $a2 , 13
	jal inRange
	int2str($t0)
	beq $v0,0 wrongMonth2
	la $a0 , intasString
	la $a1 , revString
	jal strlen
	la $a0 , revString	
	la $a1 , revMonth
	jal strcpy
	la $a0, revMonth
	la $a1 , revYear
	la $a2 , combinedDate2 # we combine them in yyyy-mm format
	jal combineDate
	la $s7 , combinedDate2
	la $s5 , combinedDate1
	print_string(newLine)
	search_by_period($s2,$t9,$s5,$s7)
	b retMenu
#__________________
wrongYear1:
	print_string(year_invalid)
	b year1
wrongYear2:
	print_string(year_invalid)
	b year2
wrongMonth1:
	print_string(Month_invalid)
	b month1
wrongMonth2:
	print_string(Month_invalid)
	b month2
#_______________________________________________
END:
	li $v0,10
	syscall	  
#----------------------------- ----------------------------------
openError:
	la $a0, open_err_msg
	li $v0, 4
	syscall
	j END
#------------------------------
isValidOption:
	li $t2,0
	li $t3,1
	blt $a0, '1', invalid
	bgt $a0, '7', invalid
	move $v0,$t3
	jr $ra 
invalid:
	move $v0,$t2
	jr $ra 
#_____________________________
#_____________________
invalidOptionERR:
	print_string(invalid_option)
	
	j openMenu
#___________________
readLine:
	li $t1,0#for null termenation
	li $t3,0 # this is used for indexing
	li $t5,0 # this is used for indexing
	li $v0,14 #call for read char
	move $a0, $s0      # File descriptor
	la $a1,idString  # char addres
	li $a2 , 7 # will read the id 
	syscall
	lb $t0,idString #In case the file is empty
	beqz $t0,finish_read
	li $t0, 0              # Load the value 0 into $t0
    	sb $t0, 8($a1) #null termenation

	str2int(idString) #ID is stored in $t8

	clear_tr # ignore symbols
	li $v0,14 #call for read char
	move $a0, $s0      # File descriptor
	la $a1,Tname  # char addres
	li $a2 , 3 # will read testname
	syscall
    	sb $t0, 4($a1) 
    	lw $s7,Tname #Stores test name in $s7

	clear_tr
	li $v0,14 #call for read char
	move $a0, $s0      # File descriptor
	la $a1,date  # char addres
	li $a2 , 7 # read date
	syscall
    	sb $t0, 8($a1)
    	ld $s5,date #Stores test date in $s5

	clear_tr
	j res1loop
res1loop:
#this loop will rad the res byte by byre
	loadchar
	beqz $v0, readEnd # in case of end of file
	lb $t1,char # load the char
	beq $t1,10,endLine# 10 is ascci code for new line 
	beq $t1,44,Preres2loop# 44 is ascci code for comma
	sb $t1,res1($t3)# the char is stored in the string###
	addi $t3, $t3, 1  # index increment 
	j res1loop 
Preres2loop:
	loadchar
	j res2loop
res2loop:
# to load second res in case was inserted
	loadchar
	beq $t6,32,res2loop# 32 is ascci code for space
	beqz $v0, readEnd # in case of end of file
	lb $t6,char # load the char
	beq $t6,10,endLine# 10 is ascci code for new line 
	sb $t6,res2($t5)# the char is stored im the string###
	addi $t5, $t5, 1  # index increment 
	j res2loop


endLine:
	sb $zero,res2($t5)#null terminator for res
	sb $zero,res1($t3)
	 #ld $t5,res1
	 str2float(res1)
	 mov.s $f7,$f5 #res1 is stored in $f7
	 #ld $t7,res2
	 str2float(res2)
	 mov.s $f8,$f5 #res1 is stored in $f8

	 ld $t3,date
	
	 lw $t6,Tname
	 insert_node($s2,$t8,$t6,$t3,$f7,$f8)
	 jr $ra # will end the function
readEnd:

	sb $zero,res2($t5)#null terminator for res
	sb $zero,res1($t3)
	 ld $t5,res1
	  str2float(res1)
	 mov.s $f7,$f5 #res1 is stored in $f7
	 ld $t7,res2
	 str2float(res2)
	 mov.s $f8,$f5 #res1 is stored in $f8
	 ld $t3,date
	
	 lw $t6,Tname
	 insert_node($s2,$t8,$t6,$t3,$f7,$f8)
	 move $v0, $zero 
finish_read:
	 jr $ra # will end the function


#_____________________________________________________________________________________
#this is a function that will convert a string to an integer
#our atoi  only handle positve numbers becauese we dont use anything else
atoi:
	li $v0, 0 # Initialize: $v0 = sum = 0
	li $t0, 10 # Initialize: $t0 = 10
L1: 	lb $t1, 0($a0) # load $t1 = str[i]
	blt $t1, '0', done # exit loop if ($t1 < '0')
	bgt $t1, '9', done # exit loop if ($t1 > '9')
	addiu $t1, $t1, -48 # Convert character to digit
	mul $v0, $v0, $t0 # $v0 = sum * 10
	addu $v0, $v0, $t1 # $v0 = sum * 10 + digit
	addiu $a0, $a0, 1 # $a0 = address of next char
	j L1 # loop back
done: jr $ra # return to caller
#__________________________________________________

#______________________________________
addMT:
	print_string(enterID)
	readString
	la $a0 , inputString
	
	jal checkID #check if id valid
	la $a1 , inputID
	jal strcpy # copy it in another string

	
	beq $v0,0 addMT
	str2int(inputID) # convert it to int

	move $s3 , $t8
	la $a0 , inputString
	
	
testName:
	jal strEmpty
	print_string(enterTname) 
	readString
	la $a1, inputTest
	la $a0 , inputString
	jal strcpy
	la $a0, inputTest
	jal removeNewline
	lw $t9 , inputTest
	la $a0,inputTest
	check_test_name
	bnez $v0,wrongTest

validTest:
	
	print_string(enterDate)

year:	print_string(enterYear) # we will take year and month alone to test them
	readInt			# then after that we will comnine the,
	move $a0 , $t0
	li $a1 , 1999
	li $a2 , 2025
	jal inRange
	beq $v0,0 wrongYear # to print error message
	int2str($t0) # converrt to string
	
	la $a0 , intasString
	la $a1 , revString 
	jal strlen     # will reverse the string after lenght
	la $a0 , revString
	la $a1 , revYear
	jal strcpy
	la $a0 , intasString
	jal strEmpty
	la $a0 , revString
	jal strEmpty
month:	print_string(enterMonth) # repeat the same process for month
	
	readInt
	move $a0 , $t0
	li $a1 , 0
	li $a2 , 13
	jal inRange
	beq $v0,0 wrongMonth
	int2str($t0)
	la $a0 , intasString
	la $a1 , revString
	jal strlen
	la $a0 , revString	
	la $a1 , revMonth
	jal strcpy
	la $a0, revMonth
	la $a1 , revYear
	la $a2 , combinedDate # we combine them in yyyy-mm format
	jal combineDate
	ld $t7 , combinedDate
	
	print_string(enterRes1)
	readFloat

	mov.s $f8 , $f0
	l.s $f9, zeroFloat
	la $a0 , inputTest
	la $a1 , bpt
	jal strCMP # we need to check if test is PBT to know if we need to tests
	beqz   $v0 , addRes2
	insert_node($s2,$s3,$t9,$t7,$f8,$f9) # insert a new node to the linked list
	la $a0 , revMonth
	jal strEmpty
recordSaved:
	print_string(recordStored)
	j openMenu
addRes2:
	print_string(enterRes2) # incase of 2 results test
	readFloat

	mov.s $f9 , $f0
	insert_node($s2,$s3,$t9,$t7,$f8,$f9)
	la $a0 , revMonth
	jal strEmpty
	b recordSaved
#_________________
wrongTest:
		print_string(invalid_tname_msg)
		b testName
#___________________________________________

#___________________________________________
wrongYear:
	print_string(year_invalid)
	b year
#_______________________________________________-
wrongMonth:
	print_string(Month_invalid)
	b month
#___________________________
checkID:
	move $t4 , $zero 
	move $a1 , $a0
count:
	lb $t1 ,  0($a1)# 
	beq $t1 , 0 , endCount
	addi $a1, $a1, 1   
	addi $t4, $t4, 1#counter for bytes
	j count
endCount:
	li $t2,8
	beq $t4 , $t2 seven # id must be 7 chars
	print_string(invalid_id_msg)
	li $v0,0
	jr $ra 
seven:
	li $v0,1
	jr $ra 
#_____________________________________________
inRange:
	slt  $t3, $a0, $a2         # Check if number is less than lower bound
    	slt $t4, $a1, $a0        # Check if number is less than upper bound
    	and $t5, $t3, $t4   
    	beq $t5 , $zero ,notInRange
    	li $v0, 1  
    	jr $ra  
notInRange:
	li $v0, 0  
	jr $ra  
#__________________ _ _ _ _ _______________________________
#$a0 will be month string and $a1 will be year string
#$2 will have the compined string
combineDate:
	move $t0 , $a0 # month 
	move $t1 , $a1 # year 
	move $t2 , $a2 
# if month is one char we  need to add char 0

	

monthCharsNum:
	lb $t3, ($t0)  # first byte 
	lb $t4, 1($t0) #second byte of char
	beq $t4, $zero,add0#if second byte is null then we need to add zero
combine:
	#move $t6 , $a0
	lw $t5 , ($t1)#loas year
	sw $t5, ($t2)#store it
	addiu $t2, $t2, 4 # increment pointer
	li $t5 ,45# add - to the string
	sb $t5 , ($t2) 
	addiu $t2, $t2, 1 # increment pointer
	# lioad month then termiate the string
	lb $t5, ($a0) 
	sb $t5 , ($t2) 
	addiu $a0, $a0, 1
	addiu $t2, $t2, 1
	lb $t5, ($a0) 
	sb $t5 , ($t2) 
	addiu $a0, $a0, 1
	addiu $t2, $t2, 1
	sb $zero, ($t2) 
	jr $ra
add0:	
	li $t5 ,48 #ascii for zero
	sb $t5 ,($t0)#dirst bit will be zer0
	addiu $t0, $t0, 1 
	sb $t3, ($t0)
	addiu $t0, $t0, 1 
	sb $zero , ($t0) # null termination
	
	j combine
	
#_________________________________________________
#a0 and a1 hold adres of strings that we want to compare 
#v0 is zero if equal -1 a0 smalleer than a1 else 1
strCMP:

    lb $t5, 0($a0)         # Load byte from str1
    lb $t6, 0($a1)         # Load byte from str2

    # Check if both strings have ended
    beqz $t5, CheckEndstring2
    beqz $t6, String2end
    
    # Compare characters
    bgt $t5, $t6, string1greater
    blt $t5, $t6, string1smaller

    # Increment counters
    addi $a0, $a0, 1       # Move to next character in str1
    addi $a1, $a1, 1       # Move to next character in str2
    j strCMP     # Repeat loop

    string1greater:
    	li $v0, 1              # Set return value to 1 (first string greater)
    	j EndCMP

    string1smaller:
    	li $v0, -1             # Set return value to -1 (first string smaller)
    	j EndCMP

    CheckEndstring2:
    	# Check if only the second string has ended
    	beqz $t6, equallStrings

    String2end:
    	# Check if both strings have ended
    	beqz $t5, equallStrings

    	li $v0, 1            
    	j EndCMP

    	equallStrings:
    	li $v0, 0              
    	j EndCMP

    	EndCMP:
    	jr $ra	
#____________________________________________________________________________________
#i
#_______________________________________________________
# afunction to reverse a string
#a0 is input string
#a1 is the output string
strlen:
	li $t0 , 0 #this is a counter
	li $t2 , 0 #for space addressing
lenLoop:
	add	$t2, $a0, $t0# curren char is $a0 + t2
	lb $t1 , 0($t2) # current char to load
	beqz  $t1, lenEND
	add	$t0, $t0, 1 #incremen number

	j lenLoop
lenEND:
	subi	$t0, $t0, 1 # in my function i need len-1
	b reverse 
reverse:
	
	li	$t5, 0			# Set t0 to zero to be sure
	li	$t3, 0			# and the same for t3
	
	reverse_loop:
		add	$t3, $a0, $t5		# $t2 is the base address for input + add loop index
		lb	$t4, 0($t3)		# load a
		beqz	$t4, reVend		# check null
		sb	$t4, revString($t0)		# Overwrite this byte address in memory	
		#sb $t4, 0($a1) 
		subi	$t0, $t0, 1		# S string--
						
		addi	$t5, $t5, 1		# (i++)
		j	reverse_loop	
reVend:
	jr $ra
#_________________________________________________________
# #a0 is the source we want to copy  a1 dest str
strcpy:
	li $t0 , 0 # for indexing
copy:
	lb $t1 , 0($a0)
	beqz $t1 , cpyEND # null mean copy ended
	sb $t1, 0($a1) # store in dest
	addi $a0, $a0, 1 
	addi $a1, $a1, 1
	b copy 
cpyEND:
	jr $ra
#_____________________________________
#address of the string is in $a0
strEmpty:
	 li $t0, 0    
	 sb $zero, 0($a0)    # Store null byte g
    	 addi $a0, $a0, 1    
    	 lb $t1, 0($a0)      # Load the byte at the current position
    	beqz $t1, emptyEnd 
        	j strEmpty
emptyEnd:
	jr $ra   
#_______________________________________________________________________________________
# this function will take an address of string in $a0 and reove the newline from it
# this is need for user input
removeNewline:
	move $t0 , $a0 
newLineloop:
	lb $t1 , ($t0) # take one char at a time
	beq $t1 , 10 remove# to check if we reached the \n
	beqz $t1 , nullfound # incase we found null
	addiu $t0 , $t0,1 # increment pointer
	j newLineloop
nullfound:
	jr $ra
remove:
	sb $zero , ($t0) # replace newline with null 
	jr $ra
#__________________________________________________________________

