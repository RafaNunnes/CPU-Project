	.file	"stages.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.p2align 4,,15
	.globl	getBlockNumber
	.type	getBlockNumber, @function
getBlockNumber:
.LFB69:
	.cfi_startproc
	leal	-1(%rdi), %eax
	cltd
	idivl	block_size(%rip)
	ret
	.cfi_endproc
.LFE69:
	.size	getBlockNumber, .-getBlockNumber
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.p2align 4,,15
	.globl	directAccess
	.type	directAccess, @function
directAccess:
.LFB70:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	leal	-1(%rsi), %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movslq	%edi, %rbp
	movl	%r12d, %eax
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	movl	block_size(%rip), %ebx
	cltd
	movq	cache_memory(%rip), %r13
	idivl	%ebx
	movl	%ebx, %r14d
	cltd
	movl	%eax, %ecx
	movl	%eax, block_num(%rip)
	idivl	size_cache(%rip)
	movslq	%edx, %r15
	movl	%edx, address_cache(%rip)
	salq	$4, %r15
	addq	%r13, %r15
	imull	%ecx, %r14d
	cmpb	$1, (%r15)
	je	.L14
	movslq	%ebx, %rdi
	addl	$1, cacheMiss(%rip)
	movl	%ecx, 4(%r15)
	salq	$2, %rdi
	movb	$1, (%r15)
	call	malloc
	testl	%ebx, %ebx
	movq	%rax, 8(%r15)
	jle	.L11
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L15:
	movslq	address_cache(%rip), %rdi
	salq	$4, %rdi
	movq	8(%r13,%rdi), %rax
.L10:
	leal	(%rcx,%r14), %edi
	addl	$1, %ecx
	movslq	%edi, %rdi
	movl	memory_list+4(,%rdi,8), %esi
	movl	%esi, (%rax,%rdx)
	movl	block_size(%rip), %ebx
	addq	$4, %rdx
	cmpl	%ecx, %ebx
	jg	.L15
.L9:
	movslq	address_cache(%rip), %rax
	salq	$4, %rax
	movq	8(%r13,%rax), %rcx
.L5:
	movl	%r12d, %eax
	cltd
	idivl	%ebx
	movslq	%edx, %rdx
	movl	(%rcx,%rdx,4), %eax
	movl	%eax, r(,%rbp,4)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	$70, %eax
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
.L14:
	.cfi_restore_state
	cmpl	%ecx, 4(%r15)
	je	.L16
	addl	$1, cacheMiss(%rip)
	testl	%ebx, %ebx
	movl	%ecx, 4(%r15)
	jle	.L6
	xorl	%esi, %esi
	xorl	%eax, %eax
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L17:
	movl	address_cache(%rip), %edx
.L7:
	leal	(%rax,%r14), %ecx
	movslq	%edx, %rdx
	addl	$1, %eax
	salq	$4, %rdx
	movslq	%ecx, %rcx
	movq	8(%r13,%rdx), %rdx
	movl	memory_list+4(,%rcx,8), %ecx
	movl	%ecx, (%rdx,%rsi)
	movl	block_size(%rip), %ebx
	addq	$4, %rsi
	cmpl	%eax, %ebx
	jg	.L17
	jmp	.L9
.L16:
	addl	$1, cacheHit(%rip)
	movq	8(%r15), %rcx
	jmp	.L5
.L11:
	movq	%rax, %rcx
	jmp	.L5
.L6:
	movq	8(%r15), %rcx
	jmp	.L5
	.cfi_endproc
.LFE70:
	.size	directAccess, .-directAccess
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.section	.text.unlikely
.LCOLDB2:
	.text
.LHOTB2:
	.p2align 4,,15
	.globl	associativityAccess
	.type	associativityAccess, @function
associativityAccess:
.LFB71:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	leal	-1(%rsi), %eax
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movl	block_size(%rip), %r13d
	movl	size_cache(%rip), %ecx
	cltd
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movslq	%edi, %r12
	idivl	%r13d
	movl	%r13d, %ebx
	imull	%eax, %ebx
	testl	%ecx, %ecx
	movslq	%edx, %rbp
	movl	%eax, block_num(%rip)
	jle	.L19
	movq	cache_memory(%rip), %r14
	subl	$1, %ecx
	addq	$1, %rcx
	salq	$4, %rcx
	movq	%r14, %rdx
	addq	%r14, %rcx
	jmp	.L22
	.p2align 4,,10
	.p2align 3
.L20:
	addq	$16, %rdx
	cmpq	%rcx, %rdx
	je	.L44
.L22:
	cmpb	$1, (%rdx)
	jne	.L20
	cmpl	%eax, 4(%rdx)
	jne	.L20
	movq	8(%rdx), %rax
	addl	$1, cacheHit(%rip)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movl	(%rax,%rbp,4), %eax
	popq	%rbp
	.cfi_def_cfa_offset 32
	movl	%eax, r(,%r12,4)
	movl	$70, %eax
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L44:
	.cfi_restore_state
	addl	$1, cacheMiss(%rip)
	leaq	16(%r14), %rdx
	cmpb	$0, (%r14)
	jne	.L24
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L28:
	movq	%rdx, %r14
	addq	$16, %rdx
	cmpb	$0, -16(%rdx)
	je	.L33
.L24:
	cmpq	%rcx, %rdx
	jne	.L28
.L32:
	call	rand
	movl	%eax, %ecx
	movl	$2147483647, %eax
	cltd
	idivl	size_cache(%rip)
	leal	1(%rax), %esi
	movl	%ecx, %eax
	cltd
	idivl	%esi
	movl	block_num(%rip), %edx
	cltq
	salq	$4, %rax
	addq	cache_memory(%rip), %rax
	movl	%edx, 4(%rax)
	movq	8(%rax), %rsi
	movl	block_size(%rip), %eax
	testl	%eax, %eax
	jle	.L30
	movq	%rsi, %rax
	xorl	%edx, %edx
	.p2align 4,,10
	.p2align 3
.L31:
	leal	(%rdx,%rbx), %ecx
	addq	$4, %rax
	addl	$1, %edx
	movslq	%ecx, %rcx
	movl	memory_list+4(,%rcx,8), %ecx
	movl	%ecx, -4(%rax)
	cmpl	%edx, block_size(%rip)
	jg	.L31
.L30:
	movl	(%rsi,%rbp,4), %eax
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	movl	%eax, r(,%r12,4)
	movl	$70, %eax
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L33:
	.cfi_restore_state
	movslq	%r13d, %rdi
	movb	$1, (%r14)
	movl	%eax, 4(%r14)
	salq	$2, %rdi
	call	malloc
	testl	%r13d, %r13d
	movq	%rax, 8(%r14)
	jle	.L27
	leal	0(%r13,%rbx), %edi
	movl	%ebx, %edx
	movq	%rax, %rcx
	.p2align 4,,10
	.p2align 3
.L26:
	movslq	%edx, %rsi
	addl	$1, %edx
	addq	$4, %rcx
	movl	memory_list+4(,%rsi,8), %esi
	movl	%esi, -4(%rcx)
	cmpl	%edx, %edi
	jne	.L26
.L27:
	movl	(%rax,%rbp,4), %eax
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	movl	%eax, r(,%r12,4)
	movl	$70, %eax
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L19:
	.cfi_restore_state
	addl	$1, cacheMiss(%rip)
	jmp	.L32
	.cfi_endproc
.LFE71:
	.size	associativityAccess, .-associativityAccess
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.section	.text.unlikely
.LCOLDB3:
	.text
.LHOTB3:
	.p2align 4,,15
	.globl	setAssociativityAccess
	.type	setAssociativityAccess, @function
setAssociativityAccess:
.LFB72:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	leal	-1(%rsi), %eax
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movslq	%edi, %rbp
	movl	%edx, %edi
	cltd
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movl	block_size(%rip), %r15d
	idivl	%r15d
	movl	%r15d, %r12d
	movslq	%edx, %rbx
	cltd
	movl	%eax, %esi
	movl	%eax, block_num(%rip)
	idivl	size_cache(%rip)
	imull	%esi, %r12d
	testl	%edi, %edi
	movl	%edx, cacheset_address(%rip)
	jle	.L46
	movq	cacheset_memory(%rip), %r14
	movslq	%edx, %rdx
	leal	-1(%rdi), %ecx
	addq	$1, %rcx
	leaq	(%r14,%rdx,8), %r9
	salq	$4, %rcx
	movq	(%r9), %rax
	movq	%rax, %r8
	addq	%rax, %rcx
	movq	%rax, %rdx
	jmp	.L49
	.p2align 4,,10
	.p2align 3
.L47:
	addq	$16, %rdx
	cmpq	%rdx, %rcx
	je	.L73
.L49:
	cmpb	$1, (%rdx)
	jne	.L47
	cmpl	%esi, 4(%rdx)
	jne	.L47
	movq	8(%rdx), %rax
	addl	$1, cacheHit(%rip)
	movl	(%rax,%rbx,4), %eax
	movl	%eax, r(,%rbp,4)
	jmp	.L66
	.p2align 4,,10
	.p2align 3
.L73:
	addl	$1, cacheMiss(%rip)
	leaq	16(%rax), %rdx
	cmpb	$0, (%rax)
	jne	.L51
	jmp	.L74
	.p2align 4,,10
	.p2align 3
.L55:
	movq	%rdx, %r13
	movq	%rdx, %rax
	addq	$16, %rdx
	subq	%r8, %r13
	cmpb	$0, -16(%rdx)
	je	.L60
.L51:
	cmpq	%rdx, %rcx
	jne	.L55
.L59:
	movl	%edi, 8(%rsp)
	call	rand
	movl	%eax, %r8d
	movslq	cacheset_address(%rip), %rax
	movq	cacheset_memory(%rip), %r9
	movl	8(%rsp), %edi
	movq	(%r9,%rax,8), %rsi
	movl	$2147483647, %eax
	cltd
	idivl	%edi
	leal	1(%rax), %ecx
	movl	%r8d, %eax
	cltd
	idivl	%ecx
	movl	block_num(%rip), %edx
	movslq	%eax, %r8
	salq	$4, %r8
	leaq	(%rsi,%r8), %rax
	movl	%edx, 4(%rax)
	movl	block_size(%rip), %edx
	testl	%edx, %edx
	jle	.L56
	xorl	%eax, %eax
	xorl	%edx, %edx
	jmp	.L58
	.p2align 4,,10
	.p2align 3
.L75:
	movslq	cacheset_address(%rip), %rcx
	movq	(%r9,%rcx,8), %rsi
.L58:
	leal	(%rdx,%r12), %ecx
	addl	$1, %edx
	movslq	%ecx, %rcx
	movl	memory_list+4(,%rcx,8), %edi
	movq	8(%rsi,%r8), %rcx
	movl	%edi, (%rcx,%rax)
	addq	$4, %rax
	cmpl	%edx, block_size(%rip)
	jg	.L75
	movslq	cacheset_address(%rip), %rax
	addq	(%r9,%rax,8), %r8
	movq	%r8, %rax
.L56:
	movq	8(%rax), %rax
.L70:
	movl	(%rax,%rbx,4), %eax
	movl	%eax, r(,%rbp,4)
.L66:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	$70, %eax
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
.L74:
	.cfi_restore_state
	xorl	%r13d, %r13d
.L60:
	movb	$1, (%rax)
	movq	%r13, %rdx
	addq	(%r9), %rdx
	movslq	%r15d, %rdi
	salq	$2, %rdi
	movl	%esi, 4(%rdx)
	movq	%rdx, 8(%rsp)
	call	malloc
	movq	8(%rsp), %rdx
	testl	%r15d, %r15d
	movq	%rax, 8(%rdx)
	jle	.L70
	xorl	%esi, %esi
	xorl	%edx, %edx
	.p2align 4,,10
	.p2align 3
.L54:
	leal	(%rdx,%r12), %ecx
	addl	$1, %edx
	movslq	%ecx, %rcx
	movl	memory_list+4(,%rcx,8), %ecx
	movl	%ecx, (%rax,%rsi)
	movslq	cacheset_address(%rip), %rax
	addq	$4, %rsi
	cmpl	%edx, block_size(%rip)
	movq	(%r14,%rax,8), %rax
	movq	8(%rax,%r13), %rax
	jg	.L54
	jmp	.L70
.L46:
	addl	$1, cacheMiss(%rip)
	jmp	.L59
	.cfi_endproc
.LFE72:
	.size	setAssociativityAccess, .-setAssociativityAccess
	.section	.text.unlikely
.LCOLDE3:
	.text
.LHOTE3:
	.section	.text.unlikely
.LCOLDB4:
	.text
.LHOTB4:
	.p2align 4,,15
	.globl	Decod
	.type	Decod, @function
Decod:
.LFB73:
	.cfi_startproc
	movzbl	(%rdi), %eax
	subl	$65, %eax
	cmpb	$18, %al
	ja	.L77
	movzbl	%al, %eax
	jmp	*.L79(,%rax,8)
	.section	.rodata
	.align 8
	.align 4
.L79:
	.quad	.L78
	.quad	.L77
	.quad	.L80
	.quad	.L81
	.quad	.L82
	.quad	.L77
	.quad	.L83
	.quad	.L77
	.quad	.L77
	.quad	.L84
	.quad	.L77
	.quad	.L91
	.quad	.L86
	.quad	.L77
	.quad	.L77
	.quad	.L87
	.quad	.L77
	.quad	.L88
	.quad	.L89
	.text
	.p2align 4,,10
	.p2align 3
.L91:
	movl	$2, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L86:
	movzbl	1(%rdi), %eax
	cmpb	$79, %al
	je	.L92
	cmpb	$85, %al
	movl	$7, %edx
	movl	$23, %eax
	cmove	%edx, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L87:
	movl	$20, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L88:
	movl	$21, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L89:
	movzbl	1(%rdi), %edx
	movl	$3, %eax
	cmpb	$84, %dl
	je	.L85
	cmpb	$85, %dl
	movl	$23, %eax
	movl	$6, %edx
	cmove	%edx, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L78:
	movl	$5, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L80:
	movzbl	2(%rdi), %edx
	movl	$4, %eax
	cmpb	$80, %dl
	je	.L85
	cmpb	$77, %dl
	movl	$23, %eax
	movl	$9, %edx
	cmove	%edx, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L81:
	movl	$8, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L82:
	movzbl	7(%rdi), %edx
	movl	$19, %eax
	cmpb	$76, %dl
	je	.L85
	cmpb	$1, %dl
	sbbl	%eax, %eax
	addl	$23, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L83:
	movl	$18, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L84:
	movzbl	1(%rdi), %edx
	movl	$10, %eax
	cmpb	$85, %dl
	je	.L85
	cmpb	$90, %dl
	movl	$11, %eax
	je	.L85
	cmpb	$68, %dl
	movl	$17, %eax
	je	.L85
	cmpb	$69, %dl
	movl	$16, %eax
	je	.L85
	cmpb	$71, %dl
	je	.L118
	cmpb	$76, %dl
	movl	$23, %eax
	jne	.L85
	movzbl	2(%rdi), %edx
	movl	$15, %eax
	cmpb	$69, %dl
	je	.L85
	cmpb	$1, %dl
	sbbl	%eax, %eax
	andl	$-4, %eax
	addl	$18, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L92:
	movl	$1, %eax
.L85:
	rep ret
	.p2align 4,,10
	.p2align 3
.L77:
	movl	$23, %eax
	ret
.L118:
	movzbl	2(%rdi), %edx
	movl	$13, %eax
	cmpb	$69, %dl
	je	.L85
	cmpb	$1, %dl
	sbbl	%eax, %eax
	andl	$-11, %eax
	addl	$23, %eax
	ret
	.cfi_endproc
.LFE73:
	.size	Decod, .-Decod
	.section	.text.unlikely
.LCOLDE4:
	.text
.LHOTE4:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC5:
	.string	"%d"
.LC6:
	.string	"%d\n"
.LC7:
	.string	"%s"
.LC8:
	.string	"Program ended with status %d\n"
	.section	.text.unlikely
.LCOLDB9:
	.text
.LHOTB9:
	.p2align 4,,15
	.globl	Exec
	.type	Exec, @function
Exec:
.LFB74:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	cmpl	$22, %edi
	ja	.L193
	movl	%edi, %edi
	movq	%rsi, %rbx
	jmp	*.L122(,%rdi,8)
	.section	.rodata
	.align 8
	.align 4
.L122:
	.quad	.L193
	.quad	.L121
	.quad	.L123
	.quad	.L124
	.quad	.L125
	.quad	.L126
	.quad	.L127
	.quad	.L128
	.quad	.L129
	.quad	.L130
	.quad	.L190
	.quad	.L132
	.quad	.L133
	.quad	.L134
	.quad	.L135
	.quad	.L136
	.quad	.L137
	.quad	.L138
	.quad	.L139
	.quad	.L140
	.quad	.L141
	.quad	.L142
	.quad	.L143
	.text
	.p2align 4,,10
	.p2align 3
.L132:
	cmpb	$1, flag_z(%rip)
	jne	.L213
	.p2align 4,,10
	.p2align 3
.L190:
	leaq	48(%rsp), %rsi
	leaq	158(%rsp), %rdi
	movl	$10, %edx
	call	strtol
	movl	%eax, (%rbx)
	movl	$70, %eax
	.p2align 4,,10
	.p2align 3
.L120:
	movq	56(%rsp), %rbx
	xorq	%fs:40, %rbx
	jne	.L217
	addq	$72, %rsp
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
	.p2align 4,,10
	.p2align 3
.L124:
	.cfi_restore_state
	movsbl	159(%rsp), %ebx
	subl	$48, %ebx
	cmpb	$114, 188(%rsp)
	je	.L218
	leaq	48(%rsp), %rsi
	leaq	188(%rsp), %rdi
	movl	$10, %edx
	call	strtol
.L149:
	movl	associativity(%rip), %esi
	testl	%esi, %esi
	jne	.L150
	leal	-1(%rax), %r8d
	movl	block_size(%rip), %esi
	movq	cache_memory(%rip), %rdi
	movl	%r8d, %eax
	cltd
	idivl	%esi
	movslq	%edx, %r9
	cltd
	movl	%eax, %ecx
	movl	%eax, block_num(%rip)
	movl	%ecx, %r10d
	idivl	size_cache(%rip)
	movslq	%edx, %rax
	movl	%edx, address_cache(%rip)
	salq	$4, %rax
	addq	%rdi, %rax
	imull	%esi, %r10d
	testl	%esi, %esi
	movb	$1, (%rax)
	movl	%ecx, 4(%rax)
	jle	.L151
	xorl	%esi, %esi
	xorl	%eax, %eax
	jmp	.L152
	.p2align 4,,10
	.p2align 3
.L219:
	movl	address_cache(%rip), %edx
.L152:
	leal	(%r10,%rax), %ecx
	movslq	%edx, %rdx
	addl	$1, %eax
	salq	$4, %rdx
	movslq	%ecx, %rcx
	movq	8(%rdi,%rdx), %rdx
	movl	memory_list+4(,%rcx,8), %ecx
	movl	%ecx, (%rdx,%rsi)
	addq	$4, %rsi
	cmpl	%eax, block_size(%rip)
	jg	.L219
.L151:
	movslq	address_cache(%rip), %rax
	movslq	%ebx, %rbx
	movslq	%r8d, %r8
	movl	r(,%rbx,4), %edx
	salq	$4, %rax
	movq	8(%rdi,%rax), %rax
	movl	%edx, (%rax,%r9,4)
	movslq	address_cache(%rip), %rax
	salq	$4, %rax
	movq	8(%rdi,%rax), %rax
	movl	(%rax,%r9,4), %eax
	movb	$1, memory_list(,%r8,8)
	movl	%eax, memory_list+4(,%r8,8)
	movl	$70, %eax
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L123:
	movsbl	159(%rsp), %eax
	cmpb	$114, 188(%rsp)
	leal	-48(%rax), %ebx
	jne	.L144
	movsbl	189(%rsp), %eax
	subl	$48, %eax
	cltq
	movl	r(,%rax,4), %esi
.L145:
	movl	associativity(%rip), %edx
	testl	%edx, %edx
	je	.L220
	cmpl	$1, %edx
	je	.L221
	jle	.L124
	movl	%ebx, %edi
	call	setAssociativityAccess
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L121:
	movsbl	159(%rsp), %ebx
	leaq	48(%rsp), %rsi
	leaq	188(%rsp), %rdi
	movl	$10, %edx
	call	strtol
	subl	$48, %ebx
	movslq	%ebx, %rbx
	movl	%eax, r(,%rbx,4)
	movl	$70, %eax
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L143:
	movsbl	159(%rsp), %eax
	movl	$.LC5, %esi
	movl	$1, %edi
	subl	$48, %eax
	cltq
	movl	r(,%rax,4), %edx
	xorl	%eax, %eax
	call	__printf_chk
	movl	$70, %eax
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L142:
	leaq	48(%rsp), %rsi
	leaq	158(%rsp), %rdi
	movl	$10, %edx
	call	strtol
	movl	$.LC8, %esi
	movl	%eax, %edx
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
	movl	$83, %eax
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L141:
	leaq	158(%rsp), %rdx
	movl	$.LC7, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
	movl	$70, %eax
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L140:
	movsbl	159(%rsp), %eax
	movl	$.LC6, %esi
	movl	$1, %edi
	subl	$48, %eax
	cltq
	movl	r(,%rax,4), %edx
	xorl	%eax, %eax
	call	__printf_chk
	movl	$70, %eax
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L139:
	movsbl	159(%rsp), %eax
	movl	$.LC5, %edi
	subl	$48, %eax
	cltq
	leaq	r(,%rax,4), %rsi
	xorl	%eax, %eax
	call	scanf
	movl	$70, %eax
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L138:
	cmpb	$1, flag_d(%rip)
	je	.L190
	.p2align 4,,10
	.p2align 3
.L213:
	movl	$70, %eax
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L137:
	cmpb	$1, flag_e(%rip)
	jne	.L213
	jmp	.L190
	.p2align 4,,10
	.p2align 3
.L126:
	movsbl	159(%rsp), %ebx
	subl	$48, %ebx
	cmpb	$114, 188(%rsp)
	jne	.L179
	movsbl	189(%rsp), %eax
	movslq	%ebx, %rbx
	subl	$48, %eax
	cltq
	movl	r(,%rax,4), %eax
	addl	%eax, r(,%rbx,4)
	movl	$70, %eax
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L125:
	movsbl	189(%rsp), %eax
	subl	$48, %eax
	cltq
	movl	r(,%rax,4), %edx
	movsbl	159(%rsp), %eax
	subl	$48, %eax
	cltq
	movl	%edx, r(,%rax,4)
	movl	$70, %eax
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L129:
	movsbl	159(%rsp), %ebx
	subl	$48, %ebx
	cmpb	$114, 188(%rsp)
	jne	.L182
	movsbl	189(%rsp), %edx
	movslq	%ebx, %rbx
	movl	r(,%rbx,4), %eax
	subl	$48, %edx
	movslq	%edx, %rsi
	cltd
	idivl	r(,%rsi,4)
	movl	%eax, r(,%rbx,4)
	movl	$70, %eax
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L128:
	movsbl	159(%rsp), %ebx
	subl	$48, %ebx
	cmpb	$114, 188(%rsp)
	jne	.L181
	movsbl	189(%rsp), %eax
	movslq	%ebx, %rbx
	subl	$48, %eax
	cltq
	movl	r(,%rax,4), %eax
	imull	r(,%rbx,4), %eax
	movl	%eax, r(,%rbx,4)
	movl	$70, %eax
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L130:
	movsbl	159(%rsp), %eax
	movb	$0, flag_z(%rip)
	movb	$0, flag_g(%rip)
	movb	$0, flag_ge(%rip)
	movb	$0, flag_l(%rip)
	movb	$0, flag_le(%rip)
	movb	$0, flag_e(%rip)
	movb	$0, flag_d(%rip)
	subl	$48, %eax
	cmpb	$114, 188(%rsp)
	cltq
	movl	r(,%rax,4), %ebx
	jne	.L183
	movsbl	189(%rsp), %eax
	subl	$48, %eax
	cltq
	movl	r(,%rax,4), %eax
.L184:
	testl	%ebx, %ebx
	jne	.L185
	movb	$1, flag_z(%rip)
.L185:
	cmpl	%ebx, %eax
	jge	.L186
	movb	$1, flag_g(%rip)
	movb	$1, flag_ge(%rip)
.L187:
	movb	$1, flag_d(%rip)
	movl	$70, %eax
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L136:
	cmpb	$1, flag_le(%rip)
	jne	.L213
	jmp	.L190
	.p2align 4,,10
	.p2align 3
.L127:
	movsbl	159(%rsp), %ebx
	subl	$48, %ebx
	cmpb	$114, 188(%rsp)
	jne	.L180
	movsbl	189(%rsp), %eax
	movslq	%ebx, %rbx
	movl	r(,%rbx,4), %edx
	subl	$48, %eax
	cltq
	subl	r(,%rax,4), %edx
	movl	$70, %eax
	movl	%edx, r(,%rbx,4)
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L134:
	cmpb	$1, flag_ge(%rip)
	jne	.L213
	jmp	.L190
	.p2align 4,,10
	.p2align 3
.L133:
	cmpb	$1, flag_g(%rip)
	jne	.L213
	jmp	.L190
	.p2align 4,,10
	.p2align 3
.L135:
	cmpb	$1, flag_l(%rip)
	jne	.L213
	jmp	.L190
.L218:
	movsbl	189(%rsp), %eax
	subl	$48, %eax
	cltq
	movl	r(,%rax,4), %eax
	jmp	.L149
	.p2align 4,,10
	.p2align 3
.L193:
	movl	$73, %eax
	jmp	.L120
.L144:
	leaq	48(%rsp), %rsi
	leaq	188(%rsp), %rdi
	movl	$10, %edx
	call	strtol
	movl	%eax, %esi
	jmp	.L145
.L182:
	leaq	48(%rsp), %rsi
	leaq	188(%rsp), %rdi
	movl	$10, %edx
	movslq	%ebx, %rbx
	call	strtol
	movq	%rax, %rcx
	movl	r(,%rbx,4), %eax
	cltd
	idivl	%ecx
	movl	%eax, r(,%rbx,4)
	movl	$70, %eax
	jmp	.L120
.L183:
	leaq	48(%rsp), %rsi
	leaq	188(%rsp), %rdi
	movl	$10, %edx
	call	strtol
	jmp	.L184
.L180:
	leaq	48(%rsp), %rsi
	leaq	188(%rsp), %rdi
	movl	$10, %edx
	movslq	%ebx, %rbx
	call	strtol
	subl	%eax, r(,%rbx,4)
	movl	$70, %eax
	jmp	.L120
.L179:
	leaq	48(%rsp), %rsi
	leaq	188(%rsp), %rdi
	movl	$10, %edx
	movslq	%ebx, %rbx
	call	strtol
	addl	%eax, r(,%rbx,4)
	movl	$70, %eax
	jmp	.L120
.L181:
	leaq	48(%rsp), %rsi
	leaq	188(%rsp), %rdi
	movslq	%ebx, %rbx
	movl	$10, %edx
	call	strtol
	imull	r(,%rbx,4), %eax
	movl	%eax, r(,%rbx,4)
	movl	$70, %eax
	jmp	.L120
.L186:
	jle	.L222
	movb	$1, flag_l(%rip)
	movb	$1, flag_le(%rip)
	jmp	.L187
.L150:
	cmpl	$1, %esi
	je	.L223
	jle	.L213
	movl	block_size(%rip), %r13d
	subl	$1, %eax
	movq	cacheset_memory(%rip), %r14
	cltd
	movslq	%eax, %r8
	xorl	%edi, %edi
	movl	%r8d, 44(%rsp)
	movslq	%ebx, %r10
	idivl	%r13d
	movslq	%edx, %r12
	cltd
	movl	%eax, %ecx
	movl	%eax, block_num(%rip)
	leaq	0(,%r12,4), %r9
	idivl	size_cache(%rip)
	xorl	%eax, %eax
	imull	%ecx, %r13d
	movl	%edx, cacheset_address(%rip)
	xorl	%ecx, %ecx
	jmp	.L170
	.p2align 4,,10
	.p2align 3
.L168:
	addl	$1, %ecx
	addq	$16, %rax
	cmpl	%ecx, %esi
	jle	.L169
	movl	cacheset_address(%rip), %edx
.L170:
	movslq	%edx, %rdx
	movq	%rax, %r11
	addq	(%r14,%rdx,8), %r11
	cmpb	$1, (%r11)
	movq	%r11, %rdx
	jne	.L168
	movl	block_num(%rip), %r11d
	cmpl	%r11d, 4(%rdx)
	jne	.L168
	movq	8(%rdx), %rdx
	movl	r(,%r10,4), %esi
	movl	$1, %edi
	movl	%esi, (%rdx,%r9)
	movslq	cacheset_address(%rip), %rdx
	movl	associativity(%rip), %esi
	movq	(%r14,%rdx,8), %rdx
	movq	8(%rdx,%rax), %rdx
	movl	(%rdx,%r9), %edx
	movb	$1, memory_list(,%r8,8)
	movl	%edx, memory_list+4(,%r8,8)
	jmp	.L168
.L220:
	movl	%ebx, %edi
	call	directAccess
	jmp	.L120
.L169:
	testl	%edi, %edi
	je	.L171
.L174:
	call	rand
	movl	%eax, %r9d
	movslq	cacheset_address(%rip), %rax
	movq	cacheset_memory(%rip), %r8
	movq	%rax, %rcx
	movq	(%r8,%rax,8), %rsi
	movl	$2147483647, %eax
	cltd
	idivl	associativity(%rip)
	leal	1(%rax), %edi
	movl	%r9d, %eax
	cltd
	idivl	%edi
	movslq	%eax, %r9
	movl	block_num(%rip), %eax
	salq	$4, %r9
	movl	%eax, 4(%rsi,%r9)
	movl	block_size(%rip), %eax
	testl	%eax, %eax
	jle	.L172
	xorl	%ecx, %ecx
	xorl	%eax, %eax
	jmp	.L173
	.p2align 4,,10
	.p2align 3
.L209:
	movslq	cacheset_address(%rip), %rdx
	movq	(%r8,%rdx,8), %rsi
.L173:
	leal	0(%r13,%rax), %edx
	addl	$1, %eax
	movslq	%edx, %rdx
	movl	memory_list+4(,%rdx,8), %edi
	movq	8(%rsi,%r9), %rdx
	movl	%edi, (%rdx,%rcx)
	addq	$4, %rcx
	cmpl	%eax, block_size(%rip)
	jg	.L209
	movslq	cacheset_address(%rip), %rcx
.L172:
	movq	(%r8,%rcx,8), %rax
	movslq	%ebx, %rbx
	movslq	44(%rsp), %rbp
	movl	r(,%rbx,4), %edx
	movq	8(%rax,%r9), %rax
	movl	%edx, (%rax,%r12,4)
	movslq	cacheset_address(%rip), %rax
	movq	(%r8,%rax,8), %rax
	movq	8(%rax,%r9), %rax
	movl	(%rax,%r12,4), %eax
	movb	$1, memory_list(,%rbp,8)
	movl	%eax, memory_list+4(,%rbp,8)
	jmp	.L213
.L223:
	movl	block_size(%rip), %ecx
	subl	$1, %eax
	cltd
	movl	%eax, 40(%rsp)
	idivl	%ecx
	imull	%eax, %ecx
	movl	%eax, block_num(%rip)
	movslq	%edx, %r12
	movl	%ecx, %r14d
	movl	size_cache(%rip), %ecx
	testl	%ecx, %ecx
	jle	.L154
	movq	cache_memory(%rip), %r15
	leaq	0(,%r12,4), %r9
	xorl	%edx, %edx
	xorl	%esi, %esi
	movslq	%ebx, %r8
	movslq	40(%rsp), %rdi
	movq	%r15, %rax
	jmp	.L156
	.p2align 4,,10
	.p2align 3
.L155:
	movl	size_cache(%rip), %ecx
	addl	$1, %edx
	addq	$16, %rax
	cmpl	%edx, %ecx
	jle	.L224
.L156:
	cmpb	$1, (%rax)
	jne	.L155
	movl	block_num(%rip), %ecx
	cmpl	%ecx, 4(%rax)
	jne	.L155
	movq	8(%rax), %rsi
	movl	r(,%r8,4), %ecx
	movl	%ecx, (%rsi,%r9)
	movl	%ecx, memory_list+4(,%rdi,8)
	movl	$1, %esi
	movb	$1, memory_list(,%rdi,8)
	jmp	.L155
.L224:
	testl	%esi, %esi
	je	.L157
.L154:
	call	rand
	movl	%eax, %ecx
	movl	$2147483647, %eax
	cltd
	idivl	size_cache(%rip)
	leal	1(%rax), %esi
	movl	%ecx, %eax
	cltd
	idivl	%esi
	movl	block_num(%rip), %edx
	cltq
	salq	$4, %rax
	addq	cache_memory(%rip), %rax
	movl	%edx, 4(%rax)
	movl	block_size(%rip), %edx
	testl	%edx, %edx
	jle	.L225
	movq	8(%rax), %rsi
	xorl	%eax, %eax
	movq	%rsi, %rcx
	.p2align 4,,10
	.p2align 3
.L166:
	leal	(%rax,%r14), %edx
	addq	$4, %rcx
	addl	$1, %eax
	movslq	%edx, %rdx
	movl	memory_list+4(,%rdx,8), %edx
	movl	%edx, -4(%rcx)
	cmpl	%eax, block_size(%rip)
	jg	.L166
.L165:
	movslq	40(%rsp), %rbp
	movslq	%ebx, %rbx
	movl	r(,%rbx,4), %eax
	movl	%eax, (%rsi,%r12,4)
	movl	%eax, memory_list+4(,%rbp,8)
	movl	$70, %eax
	movb	$1, memory_list(,%rbp,8)
	jmp	.L120
.L171:
	testl	%esi, %esi
	jle	.L174
	leaq	0(,%r12,4), %r9
	xorl	%esi, %esi
	xorl	%edi, %edi
	movl	cacheset_address(%rip), %ecx
	movslq	%ebx, %r10
	movslq	44(%rsp), %rbp
	jmp	.L178
	.p2align 4,,10
	.p2align 3
.L175:
	leal	1(%rsi), %eax
	addq	$1, %rsi
	cmpl	associativity(%rip), %eax
	jge	.L226
.L178:
	movslq	%ecx, %rax
	movq	%rsi, %r15
	leaq	(%r14,%rax,8), %rax
	salq	$4, %r15
	movq	%r15, %rdx
	addq	(%rax), %rdx
	cmpb	$0, (%rdx)
	jne	.L175
	movb	$1, (%rdx)
	movq	%r15, %rcx
	movslq	block_size(%rip), %rdi
	addq	(%rax), %rcx
	movl	block_num(%rip), %eax
	movq	%r10, 32(%rsp)
	movq	%r9, 24(%rsp)
	movq	%rsi, 16(%rsp)
	movl	%edi, 40(%rsp)
	salq	$2, %rdi
	movl	%eax, 4(%rcx)
	movq	%rcx, 8(%rsp)
	call	malloc
	movl	40(%rsp), %edx
	movq	8(%rsp), %rcx
	movq	16(%rsp), %rsi
	movq	24(%rsp), %r9
	movq	32(%rsp), %r10
	testl	%edx, %edx
	movq	%rax, 8(%rcx)
	jle	.L176
	xorl	%edi, %edi
	xorl	%edx, %edx
	jmp	.L177
	.p2align 4,,10
	.p2align 3
.L227:
	movslq	cacheset_address(%rip), %rax
	movq	(%r14,%rax,8), %rax
	movq	8(%rax,%r15), %rax
.L177:
	leal	(%rdx,%r13), %ecx
	addl	$1, %edx
	movslq	%ecx, %rcx
	movl	memory_list+4(,%rcx,8), %ecx
	movl	%ecx, (%rax,%rdi)
	addq	$4, %rdi
	cmpl	%edx, block_size(%rip)
	jg	.L227
.L176:
	movslq	cacheset_address(%rip), %rax
	movl	r(,%r10,4), %edx
	movl	$1, %edi
	movq	(%r14,%rax,8), %rax
	movq	8(%rax,%r15), %rax
	movl	%edx, (%rax,%r9)
	movslq	cacheset_address(%rip), %rax
	movq	%rax, %rcx
	movq	(%r14,%rax,8), %rax
	movq	8(%rax,%r15), %rax
	movl	(%rax,%r9), %eax
	movb	$1, memory_list(,%rbp,8)
	movl	%eax, memory_list+4(,%rbp,8)
	jmp	.L175
.L226:
	testl	%edi, %edi
	jne	.L213
	jmp	.L174
	.p2align 4,,10
	.p2align 3
.L221:
	movl	%ebx, %edi
	call	associativityAccess
	jmp	.L120
.L157:
	testl	%ecx, %ecx
	jle	.L154
	leal	-1(%rcx), %r8d
	leaq	0(,%r12,4), %rax
	movslq	%ebx, %rbp
	movslq	40(%rsp), %r13
	addq	$1, %r8
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	salq	$4, %r8
	addq	%r15, %r8
	jmp	.L164
	.p2align 4,,10
	.p2align 3
.L160:
	addq	$16, %r15
	cmpq	%r8, %r15
	je	.L228
.L164:
	cmpb	$0, (%r15)
	jne	.L160
	movb	$1, (%r15)
	movl	block_num(%rip), %eax
	movq	%r8, 16(%rsp)
	movl	%eax, 4(%r15)
	movslq	block_size(%rip), %rdi
	movl	%edi, 8(%rsp)
	salq	$2, %rdi
	call	malloc
	movl	8(%rsp), %esi
	movq	%rax, 8(%r15)
	movq	16(%rsp), %r8
	testl	%esi, %esi
	jle	.L163
	leal	(%rsi,%r14), %edi
	movl	%r14d, %edx
	movq	%rax, %rcx
	.p2align 4,,10
	.p2align 3
.L162:
	movslq	%edx, %rsi
	addl	$1, %edx
	addq	$4, %rcx
	movl	memory_list+4(,%rsi,8), %esi
	movl	%esi, -4(%rcx)
	cmpl	%edi, %edx
	jne	.L162
.L163:
	movl	r(,%rbp,4), %edx
	movq	24(%rsp), %rsi
	movb	$1, memory_list(,%r13,8)
	movl	%edx, (%rax,%rsi)
	movl	%edx, memory_list+4(,%r13,8)
	movl	$1, %eax
	jmp	.L160
.L228:
	testl	%eax, %eax
	jne	.L213
	jmp	.L154
.L217:
	call	__stack_chk_fail
.L225:
	movq	8(%rax), %rsi
	jmp	.L165
.L222:
	movb	$1, flag_ge(%rip)
	movb	$1, flag_le(%rip)
	jne	.L187
	movb	$1, flag_e(%rip)
	movl	$70, %eax
	jmp	.L120
	.cfi_endproc
.LFE74:
	.size	Exec, .-Exec
	.section	.text.unlikely
.LCOLDE9:
	.text
.LHOTE9:
	.local	flag_d
	.comm	flag_d,1,1
	.local	flag_e
	.comm	flag_e,1,1
	.local	flag_le
	.comm	flag_le,1,1
	.local	flag_ge
	.comm	flag_ge,1,1
	.local	flag_l
	.comm	flag_l,1,1
	.local	flag_g
	.comm	flag_g,1,1
	.local	flag_z
	.comm	flag_z,1,1
	.comm	block_num,4,4
	.comm	cacheset_address,4,4
	.comm	address_cache,4,4
	.globl	total_blocks
	.section	.rodata
	.align 4
	.type	total_blocks, @object
	.size	total_blocks, 4
total_blocks:
	.long	200000
	.local	r
	.comm	r,40,32
	.comm	block_size,4,4
	.comm	associativity,4,4
	.comm	size_cache,4,4
	.comm	cacheset_memory,8,8
	.comm	cache_memory,8,8
	.comm	memory_list,8000000,32
	.comm	instruction_list,9000,32
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.5) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
