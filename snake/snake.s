	.file	"snake.c"
	.text
.globl addlength
	.type	addlength, @function
addlength:
.LFB2:
	pushq	%rbp
.LCFI0:
	movq	%rsp, %rbp
.LCFI1:
	subq	$32, %rsp
.LCFI2:
	movq	%rdi, -24(%rbp)
	movl	$16, %edi
	call	malloc
	movq	%rax, -8(%rbp)
	jmp	.L2
.L3:
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -24(%rbp)
.L2:
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	jne	.L3
	movq	-24(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rax, 8(%rdx)
	movq	-8(%rbp), %rax
	movq	$0, 8(%rax)
	movq	-8(%rbp), %rax
	movl	$-1, (%rax)
	movq	-8(%rbp), %rax
	movl	$-1, 4(%rax)
	leave
	ret
.LFE2:
	.size	addlength, .-addlength
.globl rmlength
	.type	rmlength, @function
rmlength:
.LFB3:
	pushq	%rbp
.LCFI3:
	movq	%rsp, %rbp
.LCFI4:
	subq	$32, %rsp
.LCFI5:
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, 8(%rax)
	movq	-8(%rbp), %rdi
	call	free
	leave
	ret
.LFE3:
	.size	rmlength, .-rmlength
.globl init_snake
	.type	init_snake, @function
init_snake:
.LFB4:
	pushq	%rbp
.LCFI6:
	movq	%rsp, %rbp
.LCFI7:
	subq	$32, %rsp
.LCFI8:
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	%edx, -28(%rbp)
	movl	$16, %edi
	call	malloc
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rdx
	movl	-20(%rbp), %eax
	movl	%eax, (%rdx)
	movq	-8(%rbp), %rdx
	movl	-24(%rbp), %eax
	movl	%eax, 4(%rdx)
	movq	-8(%rbp), %rax
	movq	$0, 8(%rax)
	movl	$1, -12(%rbp)
	jmp	.L8
.L9:
	movq	-8(%rbp), %rdi
	call	addlength
	addl	$1, -12(%rbp)
.L8:
	movl	-12(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L9
	movq	-8(%rbp), %rax
	leave
	ret
.LFE4:
	.size	init_snake, .-init_snake
.globl resetsnake
	.type	resetsnake, @function
resetsnake:
.LFB5:
	pushq	%rbp
.LCFI9:
	movq	%rsp, %rbp
.LCFI10:
	subq	$48, %rsp
.LCFI11:
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	%edx, -32(%rbp)
	movl	%ecx, -36(%rbp)
	jmp	.L12
.L13:
	movq	-24(%rbp), %rdi
	call	rmlength
.L12:
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	jne	.L13
	movq	-24(%rbp), %rdx
	movl	-28(%rbp), %eax
	movl	%eax, (%rdx)
	movq	-24(%rbp), %rdx
	movl	-32(%rbp), %eax
	movl	%eax, 4(%rdx)
	movl	$0, -4(%rbp)
	jmp	.L14
.L15:
	movq	-24(%rbp), %rdi
	call	addlength
	addl	$1, -4(%rbp)
.L14:
	movl	-4(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jl	.L15
	leave
	ret
.LFE5:
	.size	resetsnake, .-resetsnake
.globl movesnake
	.type	movesnake, @function
movesnake:
.LFB6:
	pushq	%rbp
.LCFI12:
	movq	%rsp, %rbp
.LCFI13:
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	%edx, -32(%rbp)
	movl	%ecx, -36(%rbp)
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -16(%rbp)
	movq	-24(%rbp), %rax
	movl	4(%rax), %eax
	movl	%eax, -12(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, -44(%rbp)
	cmpl	$-1, -44(%rbp)
	je	.L20
	cmpl	$-1, -44(%rbp)
	jg	.L23
	cmpl	$-2, -44(%rbp)
	je	.L19
	jmp	.L18
.L23:
	cmpl	$1, -44(%rbp)
	je	.L21
	cmpl	$2, -44(%rbp)
	je	.L22
	jmp	.L18
.L19:
	movq	-24(%rbp), %rax
	movl	4(%rax), %eax
	leal	-1(%rax), %edx
	movq	-24(%rbp), %rax
	movl	%edx, 4(%rax)
	jmp	.L18
.L21:
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movq	-24(%rbp), %rax
	movl	%edx, (%rax)
	jmp	.L18
.L22:
	movq	-24(%rbp), %rax
	movl	4(%rax), %eax
	leal	1(%rax), %edx
	movq	-24(%rbp), %rax
	movl	%edx, 4(%rax)
	jmp	.L18
.L20:
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	leal	-1(%rax), %edx
	movq	-24(%rbp), %rax
	movl	%edx, (%rax)
.L18:
	movq	-24(%rbp), %rax
	movl	4(%rax), %eax
	testl	%eax, %eax
	jg	.L24
	movl	-32(%rbp), %eax
	leal	-1(%rax), %edx
	movq	-24(%rbp), %rax
	movl	%edx, 4(%rax)
	jmp	.L25
.L24:
	movq	-24(%rbp), %rax
	movl	4(%rax), %eax
	cmpl	-32(%rbp), %eax
	jne	.L25
	movq	-24(%rbp), %rax
	movl	$1, 4(%rax)
.L25:
	movq	-24(%rbp), %rax
	movl	4(%rax), %eax
	movl	%eax, -4(%rbp)
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	jg	.L26
	movl	-36(%rbp), %eax
	leal	-1(%rax), %edx
	movq	-24(%rbp), %rax
	movl	%edx, (%rax)
	jmp	.L27
.L26:
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	cmpl	-36(%rbp), %eax
	jne	.L27
	movq	-24(%rbp), %rax
	movl	$1, (%rax)
.L27:
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -8(%rbp)
	jmp	.L28
.L31:
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movl	4(%rax), %eax
	cmpl	-4(%rbp), %eax
	jne	.L29
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	cmpl	-8(%rbp), %eax
	jne	.L29
	movl	$1, -40(%rbp)
	jmp	.L30
.L29:
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, %edx
	xorl	-16(%rbp), %edx
	movq	-24(%rbp), %rax
	movl	%edx, (%rax)
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	xorl	%eax, -16(%rbp)
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, %edx
	xorl	-16(%rbp), %edx
	movq	-24(%rbp), %rax
	movl	%edx, (%rax)
	movq	-24(%rbp), %rax
	movl	4(%rax), %eax
	movl	%eax, %edx
	xorl	-12(%rbp), %edx
	movq	-24(%rbp), %rax
	movl	%edx, 4(%rax)
	movq	-24(%rbp), %rax
	movl	4(%rax), %eax
	xorl	%eax, -12(%rbp)
	movq	-24(%rbp), %rax
	movl	4(%rax), %eax
	movl	%eax, %edx
	xorl	-12(%rbp), %edx
	movq	-24(%rbp), %rax
	movl	%edx, 4(%rax)
.L28:
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	jne	.L31
	movl	$0, -40(%rbp)
.L30:
	movl	-40(%rbp), %eax
	leave
	ret
.LFE6:
	.size	movesnake, .-movesnake
	.section	.rodata
.LC0:
	.string	"+"
	.text
.globl drawsnake
	.type	drawsnake, @function
drawsnake:
.LFB7:
	pushq	%rbp
.LCFI14:
	movq	%rsp, %rbp
.LCFI15:
	subq	$16, %rsp
.LCFI16:
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	(%rax), %esi
	movq	-8(%rbp), %rax
	movl	4(%rax), %edi
	movl	$.LC0, %edx
	movl	$0, %eax
	call	mvprintw
	jmp	.L34
.L35:
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	(%rax), %esi
	movq	-8(%rbp), %rax
	movl	4(%rax), %edi
	movl	$.LC0, %edx
	movl	$0, %eax
	call	mvprintw
.L34:
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	jne	.L35
	leave
	ret
.LFE7:
	.size	drawsnake, .-drawsnake
.globl movemunch
	.type	movemunch, @function
movemunch:
.LFB8:
	pushq	%rbp
.LCFI17:
	movq	%rsp, %rbp
.LCFI18:
	subq	$64, %rsp
.LCFI19:
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, -36(%rbp)
	movl	%ecx, -40(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
	call	rand
	movl	%eax, %edx
	movl	-40(%rbp), %eax
	subl	$2, %eax
	movl	%eax, -60(%rbp)
	movl	%edx, %eax
	sarl	$31, %edx
	idivl	-60(%rbp)
	movl	%edx, -16(%rbp)
	call	rand
	movl	%eax, %edx
	movl	-36(%rbp), %eax
	subl	$2, %eax
	movl	%eax, -60(%rbp)
	movl	%edx, %eax
	sarl	$31, %edx
	idivl	-60(%rbp)
	movl	%edx, -12(%rbp)
	jmp	.L38
.L41:
	movq	-8(%rbp), %rax
	movl	(%rax), %eax
	cmpl	-16(%rbp), %eax
	je	.L39
	movq	-8(%rbp), %rax
	movl	4(%rax), %eax
	cmpl	-16(%rbp), %eax
	jne	.L40
.L39:
	call	rand
	movl	%eax, %edx
	movl	-40(%rbp), %eax
	subl	$2, %eax
	movl	%eax, -60(%rbp)
	movl	%edx, %eax
	sarl	$31, %edx
	idivl	-60(%rbp)
	movl	%edx, -16(%rbp)
	call	rand
	movl	%eax, %edx
	movl	-36(%rbp), %eax
	subl	$2, %eax
	movl	%eax, -60(%rbp)
	movl	%edx, %eax
	sarl	$31, %edx
	idivl	-60(%rbp)
	movl	%edx, -12(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.L38
.L40:
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -8(%rbp)
.L38:
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	jne	.L41
	addl	$1, -12(%rbp)
	addl	$1, -16(%rbp)
	movq	-24(%rbp), %rdx
	movl	-16(%rbp), %eax
	movl	%eax, (%rdx)
	movq	-24(%rbp), %rdx
	movl	-12(%rbp), %eax
	movl	%eax, 4(%rdx)
	leave
	ret
.LFE8:
	.size	movemunch, .-movemunch
	.section	.rodata
.LC1:
	.string	"|"
.LC2:
	.string	"-"
	.text
.globl drawbox
	.type	drawbox, @function
drawbox:
.LFB9:
	pushq	%rbp
.LCFI20:
	movq	%rsp, %rbp
.LCFI21:
	subq	$32, %rsp
.LCFI22:
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	$1, -4(%rbp)
	jmp	.L44
.L45:
	movl	-4(%rbp), %edi
	movl	$.LC1, %edx
	movl	$0, %esi
	movl	$0, %eax
	call	mvprintw
	movl	-24(%rbp), %esi
	movl	-4(%rbp), %edi
	movl	$.LC1, %edx
	movl	$0, %eax
	call	mvprintw
	addl	$1, -4(%rbp)
.L44:
	movl	-4(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.L45
	movl	$1, -4(%rbp)
	jmp	.L46
.L47:
	movl	-4(%rbp), %esi
	movl	$.LC2, %edx
	movl	$0, %edi
	movl	$0, %eax
	call	mvprintw
	movl	-4(%rbp), %esi
	movl	-20(%rbp), %edi
	movl	$.LC2, %edx
	movl	$0, %eax
	call	mvprintw
	addl	$1, -4(%rbp)
.L46:
	movl	-4(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jl	.L47
	movl	$.LC0, %edx
	movl	$0, %esi
	movl	$0, %edi
	movl	$0, %eax
	call	mvprintw
	movl	-24(%rbp), %esi
	movl	$.LC0, %edx
	movl	$0, %edi
	movl	$0, %eax
	call	mvprintw
	movl	-20(%rbp), %edi
	movl	$.LC0, %edx
	movl	$0, %esi
	movl	$0, %eax
	call	mvprintw
	movl	-24(%rbp), %esi
	movl	-20(%rbp), %edi
	movl	$.LC0, %edx
	movl	$0, %eax
	call	mvprintw
	leave
	ret
.LFE9:
	.size	drawbox, .-drawbox
	.section	.rodata
	.align 8
.LC3:
	.string	"Difficulty specified is not a valid value."
.LC4:
	.string	"Specify either 1, 2 or 3"
.LC5:
	.string	"GAME OVER!"
.LC6:
	.string	"COLLISION!! LIVES LEFT: %d"
.LC7:
	.string	"@"
.LC8:
	.string	"LIVES %d"
	.text
.globl main
	.type	main, @function
main:
.LFB10:
	pushq	%rbp
.LCFI23:
	movq	%rsp, %rbp
.LCFI24:
	subq	$80, %rsp
.LCFI25:
	movl	%edi, -52(%rbp)
	movq	%rsi, -64(%rbp)
	movl	$1, -32(%rbp)
	movl	$0, %edi
	call	time
	movl	%eax, %edi
	call	srand
	cmpl	$1, -52(%rbp)
	jle	.L50
	movq	-64(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rdi
	call	atoi
	movl	%eax, -72(%rbp)
	cmpl	$2, -72(%rbp)
	je	.L53
	cmpl	$3, -72(%rbp)
	je	.L54
	cmpl	$1, -72(%rbp)
	jne	.L78
.L52:
	movl	$10, -48(%rbp)
	movl	$200, -44(%rbp)
	movl	$2, -40(%rbp)
	jmp	.L57
.L53:
	movl	$5, -48(%rbp)
	movl	$100, -44(%rbp)
	movl	$4, -40(%rbp)
	jmp	.L57
.L54:
	movl	$3, -48(%rbp)
	movl	$50, -44(%rbp)
	movl	$8, -40(%rbp)
	jmp	.L57
.L78:
	movl	$.LC3, %edi
	call	puts
	movl	$.LC4, %edi
	call	puts
	movl	$1, -68(%rbp)
	jmp	.L56
.L50:
	movl	$5, -48(%rbp)
	movl	$100, -44(%rbp)
	movl	$4, -40(%rbp)
.L57:
	call	initscr
	call	has_colors
	testb	%al, %al
	je	.L58
	call	start_color
	movl	$0, %edx
	movl	$1, %esi
	movl	$1, %edi
	call	init_pair
.L58:
	call	raw
	movq	stdscr(%rip), %rdi
	movl	-44(%rbp), %esi
	call	wtimeout
	call	cbreak
	movq	stdscr(%rip), %rdi
	movl	$1, %esi
	call	keypad
	call	noecho
	movl	$0, %edi
	call	curs_set
	movl	$10, %edx
	movl	$1, %esi
	movl	$1, %edi
	call	init_snake
	movq	%rax, -8(%rbp)
	movl	COLS(%rip), %eax
	subl	$1, %eax
	movl	%eax, -24(%rbp)
	movl	LINES(%rip), %eax
	subl	$2, %eax
	movl	%eax, -20(%rbp)
	movl	-24(%rbp), %eax
	leal	-1(%rax), %ecx
	movl	-20(%rbp), %eax
	leal	-1(%rax), %edx
	movq	-8(%rbp), %rsi
	movq	-16(%rbp), %rdi
	call	movemunch
	jmp	.L59
.L76:
	movq	stdscr(%rip), %rdi
	call	wclear
	movl	-24(%rbp), %esi
	movl	-20(%rbp), %edi
	call	drawbox
	movl	-28(%rbp), %eax
	movl	%eax, -76(%rbp)
	cmpl	$259, -76(%rbp)
	je	.L62
	cmpl	$259, -76(%rbp)
	jg	.L65
	cmpl	$258, -76(%rbp)
	je	.L61
	jmp	.L60
.L65:
	cmpl	$260, -76(%rbp)
	je	.L63
	cmpl	$261, -76(%rbp)
	je	.L64
	jmp	.L60
.L63:
	cmpl	$1, -32(%rbp)
	je	.L60
	movl	$-1, -32(%rbp)
	jmp	.L60
.L64:
	cmpl	$-1, -32(%rbp)
	je	.L60
	movl	$1, -32(%rbp)
	jmp	.L60
.L62:
	cmpl	$2, -32(%rbp)
	je	.L60
	movl	$-2, -32(%rbp)
	jmp	.L60
.L61:
	cmpl	$-2, -32(%rbp)
	je	.L60
	movl	$2, -32(%rbp)
.L60:
	movl	-24(%rbp), %ecx
	movl	-20(%rbp), %edx
	movl	-32(%rbp), %esi
	movq	-8(%rbp), %rdi
	call	movesnake
	testl	%eax, %eax
	je	.L69
	subl	$1, -48(%rbp)
	movq	stdscr(%rip), %rdi
	movl	$-1, %esi
	call	wtimeout
	cmpl	$0, -48(%rbp)
	jne	.L70
	movl	COLS(%rip), %edx
	movl	%edx, %eax
	shrl	$31, %eax
	addl	%edx, %eax
	sarl	%eax
	leal	-5(%rax), %esi
	movl	LINES(%rip), %edx
	movl	%edx, %eax
	shrl	$31, %eax
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, %edi
	movl	$.LC5, %edx
	movl	$0, %eax
	call	mvprintw
	movq	stdscr(%rip), %rdi
	call	wgetch
	call	endwin
	movl	$0, -68(%rbp)
	jmp	.L56
.L70:
	movl	LINES(%rip), %eax
	leal	-1(%rax), %edi
	movl	-48(%rbp), %ecx
	movl	$.LC6, %edx
	movl	$0, %esi
	movl	$0, %eax
	call	mvprintw
	movq	stdscr(%rip), %rdi
	call	wgetch
	movl	$2, -32(%rbp)
	movq	-8(%rbp), %rdi
	movl	$10, %ecx
	movl	$1, %edx
	movl	$1, %esi
	call	resetsnake
	movq	stdscr(%rip), %rdi
	movl	-44(%rbp), %esi
	call	wtimeout
.L69:
	movq	-8(%rbp), %rax
	movl	(%rax), %edx
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, %edx
	jne	.L71
	movq	-8(%rbp), %rax
	movl	4(%rax), %edx
	movq	-16(%rbp), %rax
	movl	4(%rax), %eax
	cmpl	%eax, %edx
	jne	.L71
	movl	$0, -36(%rbp)
	jmp	.L72
.L73:
	movq	-8(%rbp), %rdi
	call	addlength
	addl	$1, -36(%rbp)
.L72:
	movl	-36(%rbp), %eax
	cmpl	-40(%rbp), %eax
	jle	.L73
	movq	stdscr(%rip), %rdi
	call	wrefresh
	movl	-24(%rbp), %ecx
	movl	-20(%rbp), %edx
	movq	-8(%rbp), %rsi
	movq	-16(%rbp), %rdi
	call	movemunch
.L71:
	call	has_colors
	testb	%al, %al
	je	.L74
	movq	stdscr(%rip), %rdi
	movl	$0, %edx
	movl	$2097408, %esi
	call	wattr_on
.L74:
	movq	-16(%rbp), %rax
	movl	(%rax), %esi
	movq	-16(%rbp), %rax
	movl	4(%rax), %edi
	movl	$.LC7, %edx
	movl	$0, %eax
	call	mvprintw
	call	has_colors
	testb	%al, %al
	je	.L75
	movq	stdscr(%rip), %rdi
	movl	$0, %edx
	movl	$2097408, %esi
	call	wattr_off
.L75:
	movq	-8(%rbp), %rdi
	call	drawsnake
	movq	stdscr(%rip), %rdi
	call	wrefresh
	movl	-20(%rbp), %eax
	leal	1(%rax), %edi
	movl	-48(%rbp), %ecx
	movl	$.LC8, %edx
	movl	$0, %esi
	movl	$0, %eax
	call	mvprintw
.L59:
	movq	stdscr(%rip), %rdi
	call	wgetch
	movl	%eax, -28(%rbp)
	cmpl	$113, -28(%rbp)
	jne	.L76
	call	endwin
	movl	$0, -68(%rbp)
.L56:
	movl	-68(%rbp), %eax
	leave
	ret
.LFE10:
	.size	main, .-main
	.section	.eh_frame,"a",@progbits
.Lframe1:
	.long	.LECIE1-.LSCIE1
.LSCIE1:
	.long	0x0
	.byte	0x1
	.string	"zR"
	.uleb128 0x1
	.sleb128 -8
	.byte	0x10
	.uleb128 0x1
	.byte	0x3
	.byte	0xc
	.uleb128 0x7
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x1
	.align 8
.LECIE1:
.LSFDE1:
	.long	.LEFDE1-.LASFDE1
.LASFDE1:
	.long	.LASFDE1-.Lframe1
	.long	.LFB2
	.long	.LFE2-.LFB2
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI0-.LFB2
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI1-.LCFI0
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE1:
.LSFDE3:
	.long	.LEFDE3-.LASFDE3
.LASFDE3:
	.long	.LASFDE3-.Lframe1
	.long	.LFB3
	.long	.LFE3-.LFB3
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI3-.LFB3
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI4-.LCFI3
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE3:
.LSFDE5:
	.long	.LEFDE5-.LASFDE5
.LASFDE5:
	.long	.LASFDE5-.Lframe1
	.long	.LFB4
	.long	.LFE4-.LFB4
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI6-.LFB4
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI7-.LCFI6
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE5:
.LSFDE7:
	.long	.LEFDE7-.LASFDE7
.LASFDE7:
	.long	.LASFDE7-.Lframe1
	.long	.LFB5
	.long	.LFE5-.LFB5
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI9-.LFB5
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI10-.LCFI9
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE7:
.LSFDE9:
	.long	.LEFDE9-.LASFDE9
.LASFDE9:
	.long	.LASFDE9-.Lframe1
	.long	.LFB6
	.long	.LFE6-.LFB6
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI12-.LFB6
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI13-.LCFI12
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE9:
.LSFDE11:
	.long	.LEFDE11-.LASFDE11
.LASFDE11:
	.long	.LASFDE11-.Lframe1
	.long	.LFB7
	.long	.LFE7-.LFB7
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI14-.LFB7
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI15-.LCFI14
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE11:
.LSFDE13:
	.long	.LEFDE13-.LASFDE13
.LASFDE13:
	.long	.LASFDE13-.Lframe1
	.long	.LFB8
	.long	.LFE8-.LFB8
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI17-.LFB8
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI18-.LCFI17
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE13:
.LSFDE15:
	.long	.LEFDE15-.LASFDE15
.LASFDE15:
	.long	.LASFDE15-.Lframe1
	.long	.LFB9
	.long	.LFE9-.LFB9
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI20-.LFB9
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI21-.LCFI20
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE15:
.LSFDE17:
	.long	.LEFDE17-.LASFDE17
.LASFDE17:
	.long	.LASFDE17-.Lframe1
	.long	.LFB10
	.long	.LFE10-.LFB10
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI23-.LFB10
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI24-.LCFI23
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE17:
	.ident	"GCC: (Debian 4.3.3-3) 4.3.3"
	.section	.note.GNU-stack,"",@progbits
