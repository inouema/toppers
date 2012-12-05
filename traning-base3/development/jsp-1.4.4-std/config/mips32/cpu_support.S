/*
 *  TOPPERS/JSP Kernel
 *      Toyohashi Open Platform for Embedded Real-Time Systems/
 *      Just Standard Profile Kernel
 * 
 *  Copyright (C) 2000-2003 by Embedded and Real-Time Systems Laboratory
 *                              Toyohashi Univ. of Technology, JAPAN
 *  Copyright (C) 2000-2003 by Industrial Technology Institute,
 *                              Miyagi Prefectural Government, JAPAN
 *  Copyright (C) 2007-     by Monami Software Limited Partnership, JAPAN
 * 
 *  �嵭����Ԥϡ��ʲ��� (1)��(4) �ξ�狼��Free Software Foundation 
 *  �ˤ�äƸ�ɽ����Ƥ��� GNU General Public License �� Version 2 �˵�
 *  �Ҥ���Ƥ���������������˸¤ꡤ�ܥ��եȥ��������ܥ��եȥ�����
 *  ����Ѥ�����Τ�ޤࡥ�ʲ�Ʊ���ˤ���ѡ�ʣ�������ѡ������ۡʰʲ���
 *  ���ѤȸƤ֡ˤ��뤳�Ȥ�̵���ǵ������롥
 *  (1) �ܥ��եȥ������򥽡��������ɤη������Ѥ�����ˤϡ��嵭������
 *      ��ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ��꤬�����Τޤޤη��ǥ���
 *      ����������˴ޤޤ�Ƥ��뤳�ȡ�
 *  (2) �ܥ��եȥ������򡤥饤�֥������ʤɡ�¾�Υ��եȥ�������ȯ�˻�
 *      �ѤǤ�����Ǻ����ۤ�����ˤϡ������ۤ�ȼ���ɥ�����ȡ�����
 *      �ԥޥ˥奢��ʤɡˤˡ��嵭�����ɽ�����������Ѿ�浪��Ӳ���
 *      ��̵�ݾڵ����Ǻܤ��뤳�ȡ�
 *  (3) �ܥ��եȥ������򡤵�����Ȥ߹���ʤɡ�¾�Υ��եȥ�������ȯ�˻�
 *      �ѤǤ��ʤ����Ǻ����ۤ�����ˤϡ����Τ����줫�ξ�����������
 *      �ȡ�
 *    (a) �����ۤ�ȼ���ɥ�����ȡ����Ѽԥޥ˥奢��ʤɡˤˡ��嵭����
 *        �ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ����Ǻܤ��뤳�ȡ�
 *    (b) �����ۤη��֤��̤�������ˡ�ˤ�äơ�TOPPERS�ץ��������Ȥ�
 *        ��𤹤뤳�ȡ�
 *  (4) �ܥ��եȥ����������Ѥˤ��ľ��Ū�ޤ��ϴ���Ū�������뤤���ʤ�»
 *      ������⡤�嵭����Ԥ����TOPPERS�ץ��������Ȥ����դ��뤳�ȡ�
 * 
 *  �ܥ��եȥ������ϡ�̵�ݾڤ��󶡤���Ƥ����ΤǤ��롥�嵭����Ԥ�
 *  ���TOPPERS�ץ��������Ȥϡ��ܥ��եȥ������˴ؤ��ơ�����Ŭ�Ѳ�ǽ����
 *  �ޤ�ơ������ʤ��ݾڤ�Ԥ�ʤ����ޤ����ܥ��եȥ����������Ѥˤ��ľ
 *  ��Ū�ޤ��ϴ���Ū�������������ʤ�»���˴ؤ��Ƥ⡤������Ǥ�����ʤ���
 */

#define _MACRO_ONLY

#include "jsp_kernel.h"
#include "offset.h"

	.set at
	.set noreorder

	.section .text
	.align 2

/*
 *  �㳰/�����߽����������롼����ʰ����㳰��
 *
 *  ���͡�
 *  ��CPU�㳰�ϥ�ɥ�ϡ��󥿥�������ƥ����ȤǼ¹Ԥ��롣
 *  ��k0 �쥸�����򡢳���ߡ��㳰�ͥ��ȥ����󥿤Ȥ��ƻ��Ѥ��롣
 *  ��reqflg ������å��������˳���ߤ�ػߤ��ʤ��ȡ�reqflg ������å���˵�ư��
 *    �줿����ߥϥ�ɥ���ǥǥ����ѥå����׵ᤵ�줿���˥ǥ����ѥå�����ʤ���
 */

	.global general_exception
	.global join_interrupt_and_exception
		/* �ؿ��ƽ�(proc_interrupt_sys)����ɬ�� */

general_exception:

	.set noat

	addiu    sp, sp, -ABI_STACK(25*4)
	sw      sp,  0*4(sp)		/* EXCSTACK��¤����(cpu_experr�ؿ���) */
	sw      $at,  1*4(sp)

	.set at

	sw      v0,  2*4(sp)
	sw      v1,  3*4(sp)
	sw      a0,  4*4(sp)
	sw      a1,  5*4(sp)
	sw      a2,  6*4(sp)
	sw      a3,  7*4(sp)
	sw      t0,  8*4(sp)
	sw      t1,  9*4(sp)
	sw      t2, 10*4(sp)
	sw      t3, 11*4(sp)
	sw      t4, 12*4(sp)
	sw      t5, 13*4(sp)
	sw      t6, 14*4(sp)
	sw      t7, 15*4(sp)
	sw      t8, 16*4(sp)
	sw      t9, 17*4(sp)
	sw      gp, 18*4(sp)
	sw      fp, 19*4(sp)
	sw      ra, 20*4(sp)

	mfc0    a1, Status		/* a1 -> �㳰�����ǻȤ� */
	mfc0    t1, EPC

	sw      a1, 21*4(sp)		/* Status */
	sw      t1, 22*4(sp)		/* EPC */

	mfhi    t2			/* ������쥸���� HI ������ */
	mflo    t3			/* ������쥸���� LO ������ */

	sw      t2, 23*4(sp)		/* HI */
	sw      t3, 24*4(sp)		/* LO */

	move	a0, sp			/* �㳰�ϥ�ɥ�ΰ������� */
		/* �����ϡ��㳰ȯ�����Υǡ��������򤷤������å��ΰ�ؤΥݥ���
		   ����ߥ���ȥ�����Υǡ�����ޤ���ʣ���ˤʤ뤿�ᡢ
		   �оݤ�MIPS32�����Υ쥸������ʬ�ΤߤȤ��롣 */

#if TNUM_ICU_INTNO == 0
#else /* TNUM_ICU_INTNO != 0 */
	PUSH_ICU_IPM			/* ����ߥ���ȥ�����γ���ߥޥ�����
					   ����ޥ���(�����ƥ��¸�������) */
#endif

	bne    k0, zero, multipul_exception  /*  ���ʤ��㳰��¿���㳰��Ƚ�� */
	addiu    k0, k0, 1               /* �ͥ��ȥ����󥿤Υ��󥯥���� */

/* ���ʤ��㳰�ξ�� */
first_exception:
	la      t3, _stack_top		/* _stack_top �ϡ������ƥ��¸��
					   (��󥫥�����ץȿ侩)��� */
					/* �����å��ݥ��󥿤θ���(t3=t3-16)�ϡ�
					   _stack_top ������˹ԤäƤ���Τǡ�
					   �����Ǥ����� */
	sw      sp, (t3)		/* �����������å��ݥ��󥿤���¸ */
	move    sp, t3			/* �����å��ڤ��ؤ� */

	jal     proc_interrupt_and_exception	/* ����ߤ��㳰��Ƚ�̽����� */
	nop

	/*  ����߶ػߤ���äƤ���  */
	la      t2, reqflg
	lw      t3, (t2)		/* t3 = reqflg */
	lw      sp, (sp)		/* �����å��ڤ��ؤ� */
	beq     t3, zero, ret_to_task_int	/* �ǥ����ѥå��׵᤬�ʤ���� */
	nop

	j       ret_int			/* ����ߡ��㳰�νи������� */
	sw      zero, (t2)		/* reqflg �Υ��ꥢ */

/* ¿���㳰��¿�ų���ߡˤξ�� (�㳰�ϥ�ɥ�ΰ����ϴ��� a0 ������Ѥ�) */
multipul_exception:
	jal     proc_interrupt_and_exception	/* ����ߤ��㳰��Ƚ�̽����� */
	nop

/* �ǥ����ѥå����ƤФ���ñ��˳���߸����㳰ȯ�����ˤ������ */
ret_to_task_int:
#if TNUM_ICU_INTNO == 0
#else /* TNUM_ICU_INTNO != 0 */
	POP_ICU_IPM			/* ����ߥ���ȥ�����γ���ߥޥ�����
					   �����ޥ���(�����ƥ��¸�������) */
#endif

	lw      t0, 23*4(sp)		/* HI */
	lw      t1, 24*4(sp)		/* LO */

	mthi    t0			/* ������쥸���� HI ������ */
	mtlo    t1			/* ������쥸���� LO ������ */

	lw      t0, 21*4(sp)    	/* Status */
	lw      t1, 22*4(sp)		/* EPC */

	.set noat

	lw      $at,  1*4(sp)
	lw      v0,  2*4(sp)
	lw      v1,  3*4(sp)
	lw      a0,  4*4(sp)
	lw      a1,  5*4(sp)
	lw      a2,  6*4(sp)
	lw      a3,  7*4(sp)

	/*
	 *  ¿���㳰���ʤΤǡ������������å����ʤ����ʤΤǡ�����������ƥ�����
	 *  �γ���ߥޥ������ѹ�����Ƥ��뿴�ۤϤʤ���
	 *  �ʥ��ơ������쥸�����ϸ����ͤ򤽤Τޤ޽��᤹��
	 */
	mtc0    t0, Status
	mtc0    t1, EPC

	lw      t0,  8*4(sp)
	lw      t1,  9*4(sp)
	lw      t2, 10*4(sp)
	lw      t3, 11*4(sp)
	lw      t4, 12*4(sp)
	lw      t5, 13*4(sp)
	lw      t6, 14*4(sp)
	lw      t7, 15*4(sp)
	lw      t8, 16*4(sp)
	lw      t9, 17*4(sp)
	lw      gp, 18*4(sp)
	lw      fp, 19*4(sp)
	lw      ra, 20*4(sp)

	addiu    sp, sp, ABI_STACK(25*4)		/* ERET ̿��ϡ�ľ���̿���¹Ԥ��ʤ�
					   �Τ��ٱ䥹���åȤˤ�������ʤ���*/

	eret				/* �㳰��������� */
	nop

	.set at

/*
 *  ����ߤ��㳰��Ƚ�̽����ؿ�
 *    �ʲ��Υ쥸�������ͤ������Ѥ�
 *      a0 : �㳰�ϥ�ɥ�ΰ���, a1 : ���ơ������쥸����
 */
proc_interrupt_and_exception:
	addiu    sp, sp, -ABI_STACK(ABI_ARGUMENT+4)
	sw      ra, ABI_ARGUMENT(sp)

	mfc0    a2, Cause
	andi    t2, a2, ExcCode_mask
	beq     t2, zero, proc_interrupt        /* ����ߤ��㳰��Ƚ�� */
		/* ��������ľ��proc_interrupt_sys�����Ӥ��������Ϥ��ʤ�
		   ��ǽ��������Τǡ�����proc_interrupt�����֡� */
	nop

/* ����߰ʳ����㳰�ν��� */
	la      t4, exc_table
         	              		/* a1 = Status  */
	ori     t5, a1, SR_EXL
	xori    t5, t5, SR_EXL		/* EXL�ӥåȥ��ꥢ */
		/* ����߰ʳ����㳰��CPU���å����֤Ǥ�����դ���Τǡ�CPU���å�
		   ���֤���¸����ɬ�פ����롣���Τ���IE�ӥåȤ������ˡ����
		   ���߶ػߡ����Ĥ�EXL�ӥåȤ��Ѥ��Ƽ¸����� */
	addu     t6, t4, t2		/* �㳰�������б����ɥ쥹������ */
	lw      t7, (t6)		/* C����롼����θƽХ��ɥ쥹���� */
	jalr    t7			/* C����롼����ƤӽФ� */
	mtc0    t5, Status		/* ����ߵ��� (EXL�ӥå� = 0) */

	mfc0    t0, Status
	ori t0, t0, SR_IE
	xori t0, t0, SR_IE
	mtc0 t0, Status /* IE = 0 */

	NOP_FOR_CP0_HAZARD		/* CP0�ϥ����ɤΤ���λ��ֲԤ��ޥ���
					   (���Υޥ����ϥ����ƥ��¸�����) */

	j       join_interrupt_and_exception	/* �㳰������ߤι�ή������ */
	nop

/* ����ߤξ��ν��� */
proc_interrupt:

/*
 *  ����ߥ���ȥ������¿�������б����뤿�ᡢ�����ϥ����ƥ��¸���ǹԤ���
 *    ������ˡ�ϡ�
 *	�ޥ�����PROC_INTERRUPT_SYS�ˤޤ��ϡ��ؿ��ƽ�(proc_interrupt_sys)
 *    �Ȥ��롣
 *
 *  ���ƽл��˥��åȤ���Ƥ������
 *	a1 : ���ơ������쥸����
 *	a2 : �����쥸����
 *
 *  ���������ˤϡ�ra�쥸�������˲����ƤϤʤ�ʤ���
 *
 *  �������������Ū�ʽ�����ή�졧
 *	1. ������װ���Ƚ��
 *	2. ����ߥޥ����ʥ���������ߥ���ȥ�����ˤ�����
 *	3. ����ߵ���
 *	4. �ø���롼����θƽ�
 *	5. ����߶ػ�
 *	6. ����ߥ���ȥ�����γ�����׵�Υ��ꥢ
 *     (7. join_interrupt_and_exception����롣; �ؿ��ƽФξ��)
 */

#ifdef PROC_INTERRUPT_SYS
	PROC_INTERRUPT_SYS
#else /* PROC_INTERRUPT_SYS */
	j	proc_interrupt_sys
	nop
#endif /* PROC_INTERRUPT_SYS */

/* �㳰������߽����ι�ή���� */
join_interrupt_and_exception:
	addiu	k0, k0, -1		/* �ͥ��ȥ����� �ǥ�������� */
	lw      ra, ABI_ARGUMENT(sp)		/* ra ������ */
	jr      ra			/* proc_interrupt_and_exeption �θƽи�
					   ����� */
	addiu    sp, sp, ABI_STACK(ABI_ARGUMENT+4)

/*
 *  �����ߥϥ�ɥ�/CPU�㳰�ϥ�ɥ�и�����
 *
 *  ����褬����������ƥ����Ȥ�reqflg�����åȤ���Ƥ�����Τߡ������ˤ��롣
 *  ��k0 = 0������߶ػ߾��֡����ѥ쥸��������¸�������֤ǸƤӽФ����ȡ�
 *  ��t1��runtsk���ͤ�����Ƥ���ret_int_1�˥����פ��뤳�ȡ�
 */

ret_int:
#if TNUM_ICU_INTNO == 0
#else /* TNUM_ICU_INTNO != 0 */
	POP_ICU_IPM			/* ����ߥ���ȥ�����γ���ߥޥ�����
					   �����ޥ���(�����ƥ��¸�������) */
#endif

	lw      t1, 21*4(sp)		/* Status */
	ori t1, t1, (SR_EXL | SR_IE)
	xori t1, t1, (SR_EXL | SR_IE)
	mtc0 t1, Status /* EXL = 0, IE = 0 */

	la      t0, enadsp
	la      t3, runtsk
	lw      t2, (t0)		/* t2 = enadsp */
	lw      t1, (t3)		/* t1 = runtsk */
 	beq     t2, zero, ret_int_1	/* �ǥ����ѥå��ػߤʤ饸���� */
	nop
	la      t4, schedtsk
	lw      t5, (t4)		/* t5 = schedtsk */
	beq     t1, t5, ret_int_1	/* runtsk = schedtsk �ʤ饸���� */
	nop

/* �ǥ����ѥå�����ͳ������ν��� (t1 = runtsk ������) */

	addiu    sp, sp, -ABI_STACK(8*4)		/* ������å��쥸��������¸ */
	sw      s0, 0*4(sp)
	sw      s1, 1*4(sp)
	sw      s2, 2*4(sp)
	sw      s3, 3*4(sp)
	sw      s4, 4*4(sp)
	sw      s5, 5*4(sp)
	sw      s6, 6*4(sp)
	sw      s7, 7*4(sp)
					/* t1 = runtsk ������  */
	sw      sp, TCB_sp(t1)		/* runtsk->sp = sp
					   (�����������å��ݥ��󥿤���¸) */
	la      t2, ret_int_r

	j       dispatcher		/* �ǥ����ѥå���ƤӽФ� */
	sw      t2, TCB_pc(t1)		/* runtsk->pc = ret_int_r
					   (�¹ԺƳ����Ϥ���¸) */

/*
 * ����ߡ��㳰�νи�����
 *   ���ǥ����ѥå�������ˤ����ơ�t1 = runtsk �ȤʤäƤ��뤳�Ȥ�����
 *   �������å��ݥ��󥿤�����Ѥ�
 */
/* �ǥ����ѥå���ƤӽФ���Υ���������ƥ����Ȥ���ι�ή���� */
ret_int_r:
	lw      s0, 0*4(sp)		/* ������å��쥸���������� */
	lw      s1, 1*4(sp)
	lw      s2, 2*4(sp)
	lw      s3, 3*4(sp)
 	lw      s4, 4*4(sp)
	lw      s5, 5*4(sp)
	lw      s6, 6*4(sp)
	lw      s7, 7*4(sp)
	addiu    sp, sp, ABI_STACK(8*4)

/* �ǥ����ѥå�����ͳ���ʤ����ι�ή���� (t1 = runtsk ������) */
ret_int_1:

	/* �������㳰�����׵�Υ����å� */
	lb      t2, TCB_enatex(t1)
	andi    t4, t2, TCB_enatex_mask /* t4 = runtsk->enatex  */
	beq     t4, zero, ret_int_2     /* �������㳰�����ػߤλ��������� */
	nop

	lw      t5, TCB_texptn(t1)      /* t5 = runtsk->texptn */
	beq     t5, zero, ret_int_2	/* �������㳰�׵᤬̵������������ */
	nop

	jal     call_texrtn             /* �������㳰�����롼����(�������å���
					   ��¸�����)�θƤӽФ� */
#if ABI_ARGUMENT == 0
	nop
#else /* ABI_ARGUMENT != 0 */
	addiu sp, sp, -ABI_STACK(ABI_ARGUMENT)
	addiu sp, sp, ABI_STACK(ABI_ARGUMENT)
#endif
		/* call_texrtn()(task.c)�Ǥϡ��ºݤΥ������㳰�����롼����Ƥ�
		   �Ф�����ǡ�unlock_cpu��lock_cpu������ԤäƤ���Τǡ����֤�
		   �ݻ�����롣 */

ret_int_2:
	mfc0 t0, Status
	lw t1, 21*4(sp) /* Status */
	andi t1, t1, (SR_EXL | SR_IE)
	or t0, t0, t1
	mtc0 t0, Status /* EXL = 1 */

	/* �쥸���������� (Status�쥸�����ϡ����������Ѥ�) */
	lw      t1, 22*4(sp)		/* EPC */
	mtc0    t1, EPC

	lw      t2, 23*4(sp)		/* HI */
	lw      t3, 24*4(sp)		/* LO */

	mthi    t2			/* ������쥸���� HI ������ */
	mtlo    t3			/* ������쥸���� LO ������ */

	.set noat

	lw      $at,  1*4(sp)
	lw      v0,  2*4(sp)
	lw      v1,  3*4(sp)
	lw      a0,  4*4(sp)
	lw      a1,  5*4(sp)
	lw      a2,  6*4(sp)
	lw      a3,  7*4(sp)
	lw      t0,  8*4(sp)
	lw      t1,  9*4(sp)
	lw      t2, 10*4(sp)
	lw      t3, 11*4(sp)
	lw      t4, 12*4(sp)
	lw      t5, 13*4(sp)
	lw      t6, 14*4(sp)
	lw      t7, 15*4(sp)
	lw      t8, 16*4(sp)
	lw      t9, 17*4(sp)

	lw      gp, 18*4(sp)
	lw      fp, 19*4(sp)
	lw      ra, 20*4(sp)

	addiu    sp, sp, ABI_STACK(25*4)

	eret				/* �����/�㳰������������� */
	nop

	.set at

/*
 *  �������ǥ����ѥå���
 *  ��dispatch �ϡ�k0 = 0��CPU���å�(����߶ػ�)���֤ǸƤӽФ��ʤ���Фʤ�ʤ���
 *  ��exit_and_dispatch �ϡ�k0 = 0��CPU���å�(����߶ػ�)���֤ǸƤӽФ��Τ���§
 *    �������������ͥ뵯ư�����Τ��ᡤk0 = 1�ǸƤӽФ������ˤ��б����Ƥ��롣
 */

	.global dispatch
	.global exit_and_dispatch

/* �������ǥ����ѥå��������Ū�˸ƤӽФ��� */
dispatch:
	addiu    sp, sp, -ABI_STACK(13*4)
	sw      s0,  2*4(sp)		/* ������å��쥸���������� */
	sw      s1,  3*4(sp)
	sw      s2,  4*4(sp)
	sw      s3,  5*4(sp)
	sw      s4,  6*4(sp)
	sw      s5,  7*4(sp)
	sw      s6,  8*4(sp)
	sw      s7,  9*4(sp)
	sw      gp, 10*4(sp)
	sw      fp, 11*4(sp)
	sw      ra, 12*4(sp)

	la      t0, runtsk
	la      t2, dispatch_r
	lw      t1, (t0)		/* t1 = runtsk */
	sw      sp, TCB_sp(t1)		/* runtsk->sp = sp */
	j       dispatcher
	sw      t2, TCB_pc(t1)		/* runtsk->pc = dispatch_r */

/* ���߼¹���Υ���ƥ����Ȥ�ΤƤơ��������ǥ����ѥå����ƤӽФ��� */
exit_and_dispatch:
	move    k0, zero		/* �ͥ��ȥ����󥿤򥯥ꥢ */

dispatcher:
	/* �����ˤ� CPU���å��ʳ����߶ػߡˤ���뤳�� */
	la      t0, schedtsk
	lw      t1, (t0)		/* t1 = schedtsk */
	beq     t1, zero, dispatcher_2	/* schedtsk ��̵����г�����Ԥ��� */
	nop

dispatcher_1:
	la      t0, runtsk
	sw      t1, (t0)		/* runtsk = t1 (= schedtsk)
					   (�����������å��μ¹�) */
	lw      t2, TCB_pc(t1)		/* �¹ԺƳ����Ϥ�������롣
					   �¹ԺƳ����Ϥϰʲ���3�̤�
					     ���ǥ����ѥå���νи�  dispatch_r
					     ������ߡ��㳰�νи�    ret_int_r
					     ����������ưľ��        activate_r
					   ������ξ��� t1=runtsk �Ȥ��ƸƤ�
					   �Ф��Ƥ��뤳�Ȥ����ա� */
	jr      t2			/* �¹ԺƳ����Ϥإ����� */
	lw      sp, TCB_sp(t1)		/* �����å��ݥ��󥿤����� */

	/*
	 *  �¹Ԥ��٤��������������ޤ��ԤĽ���
	 *
	 *  �����ǥ���ƥ����Ȥ��ڤ괹����Τϡ�
	 *    ��������ȯ���������߽����ˤɤΥ����å���Ȥ����Ȥ�������β��
	 *    ������ߥϥ�ɥ���ǤΥ������ǥ����ѥå����ɻ�
	 *  �Ȥ�����Ĥΰ�̣�����롥
	 */ 
dispatcher_2:
	la	t2, runtsk
	sw	zero, (t2)		/* runtsk = NULL
					   ����ϡ�iget_id ����TSK_NONE���֤�
					   �����б����뤿�ᡣ*/

	la      sp, _stack_top		/* �����å��ڤ��ؤ� */
					/* _stack_top �ϡ������ƥ��¸��
					   (��󥫥�����ץȿ侩)��� */
	li      k0, 1			/* �ͥ��ȥ����󥿡�1 */

	/* �롼����ǻȤ�����ν��� */
	la      t2, reqflg              /* reqflg �Υ��ɥ쥹 */
	li      t4, ~SR_IE              /* Status �γ���ߵ��ĥӥå� */

dispatcher_3:
	mfc0    t1, Status
	ori     t1, t1, SR_IE		/* IE�ӥåȥ��å� */
	mtc0    t1, Status		/* ����ߵ��� : unlock_cpu ���� */
	and     t1, t1, t4		/* IE�ӥåȥꥻ�å� */
	mtc0    t1, Status		/* ����߶ػ� : lock_cpu ���� */

	NOP_FOR_CP0_HAZARD		/* CP0�ϥ����ɤΤ���λ��ֲԤ��ޥ���
					   (���Υޥ����ϥ����ƥ��¸�����) */

	lw      t5, (t2)		/* t5 = reqflg */

	beq     t5, zero, dispatcher_3	/* �ǥ����ѥå��׵᤬�ʤ���Х롼�פ�
					   ��Ƭ�� */
	nop
	sw      zero, (t2)		/* reqflg = NULL (reqflg�򥯥ꥢ) */
	j       dispatcher		/* �¹ԺƳ����Ϥμ��������إ����� */
	move    k0, zero		/* �ͥ��ȥ����󥿤򥯥ꥢ */

/*
 *  �ǥ����ѥå���и�����
 *  ���ǥ����ѥå�������ˤ����ơ�t1 = runtsk �ȤʤäƤ��뤳�Ȥ�����
 *  �������å��ݥ��󥿤�����Ѥ�
 */
dispatch_r: 
	lw      s0,  2*4(sp)		/* ������å��쥸���������� */
	lw      s1,  3*4(sp)
	lw      s2,  4*4(sp)
	lw      s3,  5*4(sp)
	lw      s4,  6*4(sp)
	lw      s5,  7*4(sp)
	lw      s6,  8*4(sp)
	lw      s7,  9*4(sp)
	lw      gp, 10*4(sp)
	lw      fp, 11*4(sp)
	lw      ra, 12*4(sp)
	addiu    sp, sp, ABI_STACK(13*4)

	/* �������㳰�����׵�Υ����å� */
	lb      t2, TCB_enatex(t1)
	andi    t4, t2, TCB_enatex_mask	/* t4 = runtsk->enatex */
	beq     t4, zero, dispatch_r_1	/* �������㳰�����ػߤλ��������� */
	nop

	lw      t5, TCB_texptn(t1)	/* t5 = runtsk->texptn */
	beq     t5, zero, dispatch_r_1	/* �������㳰�׵᤬̵������������ */
	nop

	j       call_texrtn		/* �������㳰�����롼����(�������å���
					   ��¸�����)�θƤӽФ� */
	nop
		/* call_texrtn()(task.c)�Ǥϡ��ºݤΥ������㳰�����롼����Ƥ�
		   �Ф�����ǡ�unlock_cpu��lock_cpu������ԤäƤ���Τǡ����֤�
		   �ݻ�����롣 */

dispatch_r_1:
	jr      ra			/* dispatch �ƤӽФ�������� */
	nop

/*
 *  ��������ư����
 *  ���ǥ����ѥå�������ˤ����ơ�t1 = runtsk �ȤʤäƤ��뤳�Ȥ�����
 *  �������å��ݥ��󥿤�����Ѥ�
 */

	.global activate_r

activate_r:
	/* ���������Ȥ��ϡ�CPU���å��ˤʤäƤ����IE�ӥå� = 0) */

	/* �����ߵ��Ĥν��� */
	mfc0    t0, Status
	ori t0, t0, SR_IE

	/* �������ط���������� */
					/* t1 = runtsk (�ǥ����ѥå��������) */
	lw      t2, TCB_tinib(t1)       /* t2 = runtsk->tinib */

	/* ��������ư���Ϥ����� */
	lw      t3, TINIB_task(t2)      /* t3 = runtsk->tinib->task */

	/* �������ؤΰ����ʳ�ĥ��������� */
	lw      a0, TINIB_exinf(t2)     /* a0 = runtsk->tinib->exinf */

	mtc0    t0, Status              /* unlock_cpu ���� (����ߵ���) */

	la      ra, ext_tsk             /* �����������������Ϥ����� */

	jr       t3                      /* ��������ư */
	nop

/*
 *  ���������Ԥ�
 */

	.section .text
	.align 2

	.global sil_dly_nse

sil_dly_nse:
	li v0, SIL_DLY_TIM1
	sltu v1, v0, a0
	beq v1, zero, sil_dly_nse_1 /* branch if SIL_DLY_TIM1 >= a0 */
	subu a0, a0, v0
	li v0, SIL_DLY_TIM2
sil_dly_nse_0:
	sltu v1, v0, a0
	bne v1, zero, sil_dly_nse_0 /* branch if SIL_DLY_TIM2 < a0 */
	subu a0, a0, v0
sil_dly_nse_1:
	jr ra
	nop