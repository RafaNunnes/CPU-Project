	.file	"main.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.p2align 4,,15
	.globl	freeMemory
	.type	freeMemory, @function
freeMemory:
.LFB69:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$80, %rsp
	.cfi_def_cfa_offset 112
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	leaq	112(%rsp), %rax
	testl	%edi, %edi
	movq	%rsi, 40(%rsp)
	movq	%rdx, 48(%rsp)
	movq	%rcx, 56(%rsp)
	movq	%rax, 8(%rsp)
	leaq	32(%rsp), %rax
	movq	%r8, 64(%rsp)
	movq	%r9, 72(%rsp)
	movl	$8, (%rsp)
	movq	%rax, 16(%rsp)
	jle	.L1
	movl	%edi, %ebp
	xorl	%ebx, %ebx
	jmp	.L11
	.p2align 4,,10
	.p2align 3
.L16:
	movl	%eax, %edx
	addq	16(%rsp), %rdx
	addl	$8, %eax
	movl	%eax, (%rsp)
.L4:
	movq	(%rdx), %r12
	movq	(%r12), %rdi
	testq	%rdi, %rdi
	je	.L5
	call	free
	movq	$0, (%r12)
.L5:
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	je	.L1
.L11:
	movl	(%rsp), %eax
	cmpl	$47, %eax
	jbe	.L16
	movq	8(%rsp), %rdx
	leaq	8(%rdx), %rax
	movq	%rax, 8(%rsp)
	jmp	.L4
	.p2align 4,,10
	.p2align 3
.L1:
	movq	24(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L17
	addq	$80, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L17:
	.cfi_restore_state
	call	__stack_chk_fail
	.cfi_endproc
.LFE69:
	.size	freeMemory, .-freeMemory
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"Tamanho da cache: "
.LC2:
	.string	"%d"
.LC3:
	.string	"N\303\255vel de Associatividade: "
.LC4:
	.string	"r"
.LC5:
	.string	"memory/matriz.txt"
.LC6:
	.string	"memory.txt"
.LC7:
	.string	" "
.LC8:
	.string	"w"
.LC9:
	.string	"%d\n"
.LC10:
	.string	"\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC11:
	.string	"\nCacheHit = %d\tCacheMiss = %d\n"
	.section	.text.unlikely
.LCOLDB12:
	.section	.text.startup,"ax",@progbits
.LHOTB12:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB70:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movl	$.LC1, %esi
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movl	$1, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$184, %rsp
	.cfi_def_cfa_offset 240
	movq	%fs:40, %rax
	movq	%rax, 168(%rsp)
	xorl	%eax, %eax
	movq	$0, 16(%rsp)
	movq	$0, 24(%rsp)
	movq	$0, 32(%rsp)
	movq	$0, 40(%rsp)
	movl	$1, 12(%rsp)
	call	__printf_chk
	movl	$size_cache, %esi
	movl	$.LC2, %edi
	xorl	%eax, %eax
	call	scanf
	movslq	size_cache(%rip), %rdi
	salq	$4, %rdi
	call	malloc
	movq	%rax, cache_memory(%rip)
	movl	$1000000, %eax
	movl	$.LC3, %esi
	cltd
	movl	$1, %edi
	idivl	total_blocks(%rip)
	movl	%eax, block_size(%rip)
	xorl	%eax, %eax
	call	__printf_chk
	xorl	%eax, %eax
	movl	$associativity, %esi
	movl	$.LC2, %edi
	call	scanf
	movl	associativity(%rip), %r12d
	cmpl	$1, %r12d
	jle	.L22
	movslq	size_cache(%rip), %rdi
	movq	%rdi, %rbx
	salq	$3, %rdi
	call	malloc
	testl	%ebx, %ebx
	movq	%rax, cacheset_memory(%rip)
	jle	.L22
	leal	-1(%rbx), %eax
	movslq	%r12d, %r13
	xorl	%ebx, %ebx
	salq	$4, %r13
	leaq	8(,%rax,8), %r15
	.p2align 4,,10
	.p2align 3
.L23:
	movq	%rbx, %rbp
	addq	cacheset_memory(%rip), %rbp
	movq	%r13, %rdi
	addq	$8, %rbx
	call	malloc
	cmpq	%r15, %rbx
	movq	%rax, 0(%rbp)
	jne	.L23
	movq	cacheset_memory(%rip), %rcx
	leal	-1(%r12), %esi
	addq	$1, %rsi
	addq	%rcx, %rbx
	salq	$4, %rsi
	.p2align 4,,10
	.p2align 3
.L25:
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L24:
	movq	(%rcx), %rdx
	movb	$0, (%rdx,%rax)
	addq	$16, %rax
	cmpq	%rax, %rsi
	jne	.L24
	addq	$8, %rcx
	cmpq	%rbx, %rcx
	jne	.L25
.L22:
	movl	$.LC4, %esi
	movl	$.LC5, %edi
	call	fopen
	movl	$.LC4, %esi
	movq	%rax, %r13
	movl	$.LC6, %edi
	call	fopen
	testq	%r13, %r13
	movq	%rax, %rbp
	je	.L20
	testq	%rax, %rax
	je	.L20
	movl	$instruction_list, %ebx
	xorl	%r12d, %r12d
	.p2align 4,,10
	.p2align 3
.L21:
	leaq	32(%rsp), %rsi
	leaq	16(%rsp), %rdi
	movq	%r13, %rcx
	movl	$10, %edx
	call	__getdelim
	cmpq	$-1, %rax
	je	.L62
	movq	16(%rsp), %rdi
	movl	$.LC7, %esi
	movq	%rbx, %r15
	call	strtok
	testq	%rax, %rax
	movq	%rax, 48(%rsp)
	je	.L27
	.p2align 4,,10
	.p2align 3
.L51:
	movq	%r15, %rdi
	movq	%rax, %rsi
	addq	$30, %r15
	call	strcpy
	xorl	%edi, %edi
	movl	$.LC7, %esi
	call	strtok
	testq	%rax, %rax
	movq	%rax, 48(%rsp)
	jne	.L51
.L27:
	addl	$1, %r12d
	addq	$90, %rbx
	jmp	.L21
.L62:
	movl	$memory_list, %ebx
	movq	%rbx, %r15
	jmp	.L29
	.p2align 4,,10
	.p2align 3
.L64:
	movb	$0, (%r15)
.L31:
	addq	$8, %r15
.L29:
	leaq	40(%rsp), %rsi
	leaq	24(%rsp), %rdi
	movq	%rbp, %rcx
	movl	$10, %edx
	call	__getdelim
	cmpq	$-1, %rax
	je	.L63
	movq	24(%rsp), %rdi
	movl	$.LC7, %esi
	call	strtok
	cmpb	$10, (%rax)
	je	.L64
	leaq	56(%rsp), %rsi
	movl	$10, %edx
	movq	%rax, %rdi
	call	strtol
	movb	$1, (%r15)
	movl	%eax, 4(%r15)
	jmp	.L31
.L63:
	movl	$70, %eax
.L45:
	subl	$68, %eax
	movzbl	%al, %edx
.L57:
	cmpb	$15, %al
	ja	.L57
	jmp	*.L35(,%rdx,8)
	.section	.rodata
	.align 8
	.align 4
.L35:
	.quad	.L34
	.quad	.L36
	.quad	.L37
	.quad	.L57
	.quad	.L57
	.quad	.L38
	.quad	.L57
	.quad	.L57
	.quad	.L57
	.quad	.L57
	.quad	.L57
	.quad	.L57
	.quad	.L57
	.quad	.L57
	.quad	.L57
	.quad	.L39
	.section	.text.startup
.L39:
	movl	$.LC8, %esi
	movl	$.LC6, %edi
	call	fopen
	testq	%rax, %rax
	movq	%rax, %rbp
	jne	.L44
	jmp	.L20
	.p2align 4,,10
	.p2align 3
.L65:
	movl	4(%rbx), %ecx
	xorl	%eax, %eax
	movl	$.LC9, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	addq	$8, %rbx
	call	__fprintf_chk
	cmpq	$memory_list+800, %rbx
	je	.L40
.L44:
	cmpb	$0, (%rbx)
	jne	.L65
	xorl	%eax, %eax
	movl	$.LC10, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	addq	$8, %rbx
	call	__fprintf_chk
	cmpq	$memory_list+800, %rbx
	jne	.L44
.L40:
	movl	cacheMiss(%rip), %ecx
	movl	cacheHit(%rip), %edx
	movl	$.LC11, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
	movq	%r13, %rdi
	call	fclose
	movq	%rbp, %rdi
	call	fclose
	leaq	48(%rsp), %r8
	leaq	24(%rsp), %rdx
	leaq	16(%rsp), %rsi
	movl	$5, %edi
	movl	$cache_memory, %r9d
	movl	$cacheset_memory, %ecx
	xorl	%eax, %eax
	call	freeMemory
	xorl	%edi, %edi
	call	exit
.L38:
	movq	168(%rsp), %rcx
	xorq	%fs:40, %rcx
	movl	$-1, %eax
	jne	.L66
	addq	$184, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L37:
	.cfi_restore_state
	movl	12(%rsp), %eax
	cmpl	%eax, %r12d
	jl	.L40
	leal	-1(%rax), %esi
	addl	$1, %eax
	leaq	64(%rsp), %rdi
	movl	$90, %ecx
	movl	%eax, 12(%rsp)
	movl	$68, %eax
	movslq	%esi, %rsi
	imulq	$90, %rsi, %rsi
	addq	$instruction_list, %rsi
	rep movsb
	jmp	.L45
.L36:
	subq	$96, %rsp
	.cfi_def_cfa_offset 336
	movsbl	%r14b, %edi
	movq	160(%rsp), %rax
	leaq	108(%rsp), %rsi
	movq	%rax, (%rsp)
	movq	168(%rsp), %rax
	movq	%rax, 8(%rsp)
	movq	176(%rsp), %rax
	movq	%rax, 16(%rsp)
	movq	184(%rsp), %rax
	movq	%rax, 24(%rsp)
	movq	192(%rsp), %rax
	movq	%rax, 32(%rsp)
	movq	200(%rsp), %rax
	movq	%rax, 40(%rsp)
	movq	208(%rsp), %rax
	movq	%rax, 48(%rsp)
	movq	216(%rsp), %rax
	movq	%rax, 56(%rsp)
	movq	224(%rsp), %rax
	movq	%rax, 64(%rsp)
	movq	232(%rsp), %rax
	movq	%rax, 72(%rsp)
	movq	240(%rsp), %rax
	movq	%rax, 80(%rsp)
	movzwl	248(%rsp), %eax
	movw	%ax, 88(%rsp)
	call	Exec
	addq	$96, %rsp
	.cfi_def_cfa_offset 240
	jmp	.L45
.L34:
	leaq	64(%rsp), %rdi
	call	Decod
	cmpb	$23, %al
	movl	%eax, %r14d
	sete	%al
	addl	$69, %eax
	jmp	.L45
.L66:
	call	__stack_chk_fail
.L20:
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE70:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE12:
	.section	.text.startup
.LHOTE12:
	.globl	cacheMiss
	.bss
	.align 4
	.type	cacheMiss, @object
	.size	cacheMiss, 4
cacheMiss:
	.zero	4
	.globl	cacheHit
	.align 4
	.type	cacheHit, @object
	.size	cacheHit, 4
cacheHit:
	.zero	4
	.comm	block_size,4,4
	.comm	associativity,4,4
	.comm	size_cache,4,4
	.comm	cacheset_memory,8,8
	.comm	cache_memory,8,8
	.comm	memory_list,8000000,32
	.comm	instruction_list,9000,32
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.5) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
