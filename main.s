.syntax unified

.word 0x20000100
.word _start

.global _start
.type _start, %function
_start:
	mov r0, sp
	mov r1, #3
	mov r2, #2
	mov r3, #1
	
	push {r1,r2,r3}
	pop {r1,r2,r3}
	
	push {r3}
	push {r1}
	push {r2}
	pop {r3}
	pop {r1}
	pop {r2}

