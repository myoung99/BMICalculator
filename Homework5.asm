#Homework 5- BMI Calculator - Melecia Young

		.data
#need a height and weight
height:		.double
weight:		.double
weightx:	.double	703.0
#need to store the bmi after its calculated
bmi:		.double

#conditions
underweight:	.double	18.5
normalwt:	.double	25.0
overwt:		.double	30.0

#need to store a string with user name
name:		.space	16

#need prompts for user
nameQ:		.asciiz	"What is your name?"
heightQ:	.asciiz	"Please enter your height in inches."
weightQ:	.asciiz	"Pease enter your weight in pounds (round to the nearest whole number)."	

#message for the end
msg:		.asciiz	" your bmi is "
period:		.asciiz	"."
under:		.asciiz	" This is considered underweight. "
normal:		.asciiz	" This is considered normal weight."
over:		.asciiz	" This is considered overweight. "
obese:		.asciiz	" This is considered obese. "
	.text
main:

	l.d	$f2, height
	l.d	$f4, weight
	l.d	$f6, weightx
	l.d	$f12, bmi
################################## PPROMPTS ####################################
	#prompt the user for data
	li	$v0, 4
	la	$a0, nameQ	#ask for name
	syscall
	
	
	li	$v0, 8
	la	$a0, name	#get name
	li	$a1, 16
	syscall
	
	li	$v0, 4
	la	$a0, heightQ	#ask for height
	syscall

	li	$v0, 7		#get height
	syscall
	
	mov.d	$f2, $f0	#store inputed height in $f2
	
	
	li	$v0, 4		#ask for weight
	la	$a0, weightQ
	syscall
	
	li	$v0, 7		#get weight
	syscall
	
	mov.d	$f4, $f0	#store inputed weight in $f4
		
	
 ############################## CALCULTIONS ################################### 
	
	#weight *= 703
	mul.d	$f4, $f4, $f6	#weight = 155*703 = 108965
	
	#height *= height (height squared)
	mul.d	$f2, $f2, $f2	#height = 66^2 = 4356
	
	#bmi = wight/height
	div.d	$f12, $f4, $f2	#bmi = 25.015

################################## OUTPUT ####################################	
	li	$v0, 4
	la	$a0, name	#print their name
	syscall
	
	li	$v0, 4
	la	$a0, msg	# " your bmi is "
	syscall

	#print out bmi 
	li	$v0, 3		#use 2 to print out a float and 3 to print a double 
	syscall
	
	li	$v0, 4
	la	$a0, period	#add a period to end sentence. 
	syscall
	
############################### IF ELSE ##################################### 
	#if bmi < 18.5 --> "this is considered underweight"
	#else if bmi < 25 --> "this is considered normal weight"
	#else if bmi < 30 --> "this is considered overweight"
	#else --> "this is considered obese"
	
	#going to store the conditions in registers so we can compare
	l.d	$f2, underweight
	l.d	$f4, normalwt
	l.d	$f6, overwt

##############################	comparisons	
	c.lt.d	$f12, $f2 	#if bmi is less than 18.5
	bc1t	UnderWeight	#if its true branch to underweight
	bc1f	NormalCheck	#if its false check to see if its normal weight
	
NormalCheck:
	c.lt.d	$f12, $f4	# if it gets here you know its over 18.5 
	bc1t	NormalWeight	# but if its less than 25 it is normal weight
	bc1f	OverCheck	# and if its false check to see if its over weight

OverCheck:
	c.lt.d	$f12, $f6	#if its here you know its over 25
	bc1t	OverWeight	#if its under 30 it is just over weight
	bc1f	Obese		#but if its over 30 it is obese


########################## PRINT RESULTS #################################
UnderWeight:
	li	$v0, 4
	la	$a0, under
	syscall	
	j	exit
NormalWeight:
	li	$v0, 4
	la	$a0, normal
	syscall
	j	exit
OverWeight:
	li	$v0, 4
	la	$a0, over
	syscall
	j	exit
Obese:
	li	$v0, 4
	la	$a0, obese
	syscall
	j	exit

####	EXIT	####
exit:
	li	$v0, 10 
	syscall
