; *
; *  TOPPERS/JSP Kernel
; *      Toyohashi Open Platform for Embedded Real-Time Systems/
; *      Just Standard Profile Kernel
; * 
; *  Copyright (C) 2000-2003 by Embedded and Real-Time Systems Laboratory
; *                              Toyohashi Univ. of Technology, JAPAN
; * 
; *  �嵭����Ԥϡ��ʲ��� (1)��(4) �ξ�狼��Free Software Foundation 
; *  �ˤ�äƸ�ɽ����Ƥ��� GNU General Public License �� Version 2 �˵�
; *  �Ҥ���Ƥ���������������˸¤ꡤ�ܥ��եȥ��������ܥ��եȥ�����
; *  ����Ѥ�����Τ�ޤࡥ�ʲ�Ʊ���ˤ���ѡ�ʣ�������ѡ������ۡʰʲ���
; *  ���ѤȸƤ֡ˤ��뤳�Ȥ�̵���ǵ������롥
; *  (1) �ܥ��եȥ������򥽡��������ɤη������Ѥ�����ˤϡ��嵭������
; *      ��ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ��꤬�����Τޤޤη��ǥ���
; *      ����������˴ޤޤ�Ƥ��뤳�ȡ�
; *  (2) �ܥ��եȥ������򡤥饤�֥������ʤɡ�¾�Υ��եȥ�������ȯ�˻�
; *      �ѤǤ�����Ǻ����ۤ�����ˤϡ������ۤ�ȼ���ɥ�����ȡ�����
; *      �ԥޥ˥奢��ʤɡˤˡ��嵭�����ɽ�����������Ѿ�浪��Ӳ���
; *      ��̵�ݾڵ����Ǻܤ��뤳�ȡ�
; *  (3) �ܥ��եȥ������򡤵�����Ȥ߹���ʤɡ�¾�Υ��եȥ�������ȯ�˻�
; *      �ѤǤ��ʤ����Ǻ����ۤ�����ˤϡ����Τ����줫�ξ�����������
; *      �ȡ�
; *    (a) �����ۤ�ȼ���ɥ�����ȡ����Ѽԥޥ˥奢��ʤɡˤˡ��嵭����
; *        �ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ����Ǻܤ��뤳�ȡ�
; *    (b) �����ۤη��֤��̤�������ˡ�ˤ�äơ�TOPPERS�ץ��������Ȥ�
; *        ��𤹤뤳�ȡ�
; *  (4) �ܥ��եȥ����������Ѥˤ��ľ��Ū�ޤ��ϴ���Ū�������뤤���ʤ�»
; *      ������⡤�嵭����Ԥ����TOPPERS�ץ��������Ȥ����դ��뤳�ȡ�
; * 
; *  �ܥ��եȥ������ϡ�̵�ݾڤ��󶡤���Ƥ����ΤǤ��롥�嵭����Ԥ�
; *  ���TOPPERS�ץ��������Ȥϡ��ܥ��եȥ������˴ؤ��ơ�����Ŭ�Ѳ�ǽ����
; *  �ޤ�ơ������ʤ��ݾڤ�Ԥ�ʤ����ޤ����ܥ��եȥ����������Ѥˤ��ľ
; *  ��Ū�ޤ��ϴ���Ū�������������ʤ�»���˴ؤ��Ƥ⡤������Ǥ�����ʤ���
; * 
; *  @(#) $Id: cpu_support.S,v 1.5 2003/12/04 08:25:44 honda Exp $
; *

        .c_mode
        .align  1
        .global __kernel_dispatch
        .include  "c5402dsk.h"
        .mmregs

__kernel_dispatch:
        PSHM   AR1                       ;AR1,6,7�򥹥��å�����¸
        PSHM   AR6                       ;PC�ϸƤӽФ����˥����å�����¸�����
        PSHM   AR7                       ;¾������쥸����ARx����¸����ɬ�פϤʤ�
        LDM    SP,A
        MVDM   *(__kernel_runtsk),AR1    ;AR1 <- runtsk
        NOP
        STL    A,*AR1(TCB_sp)            ;�����������å���TCB����¸
        ST     #dispatch_r,*AR1(TCB_pc)  ;�¹ԺƳ����Ϥ�TCB����¸
        B      dispatcher_1

dispatch_r:
        POPM   AR7                       ;�쥸����������
        POPM   AR6
        POPM   AR1 
        B      __kernel_calltex          ;�������㳰�롼����θƤӽФ�

        .global __kernel_exit_and_dispatch
__kernel_exit_and_dispatch:
        SSBX   INTM                      ;�����߶ػ�
        ST     #0,*(__kernel_nest)               ;�����ͥ�ν�����������Τ���
dispatcher_1:
        LD     *(__kernel_schedtsk),A    ;schedtsk�����뤫��
        BC     dispatcher_2,AEQ          ;̵����Х�����
        MVDK   *(__kernel_schedtsk),*(__kernel_runtsk)   ;schedtsk��runtsk��
        MVDM   *(__kernel_runtsk),AR1
        NOP
        MVDK   *AR1(TCB_sp),SP           ;TCB���饹���å�������
        LD     *AR1(TCB_pc),A            ;TCB����¹ԺƳ����Ϥ�����
        BACC   A    
        
dispatcher_2:
        STM    #STACKTOP,SP
        ST     #0x01,*(__kernel_nest)
        RSBX   INTM                      ;�����ߵ���
        IDLE   1                         ;�ꥻ�åȤ��ޥ�������Ƥ��ʤ�������Ԥ�
        SSBX   INTM                      ;�����߶ػ�
        ST     #0x0,*(__kernel_nest)
        B      dispatcher_1


;
;  �������ε�ư����
;

        .global __kernel_activate_r
;         .global _activate_r
__kernel_activate_r:
;_activate_r:
        RSBX   INTM                      ;�����ߵ���
        POPM   AR2
        POPM   AR3
        LDM    AR2,B
        LDM    AR3,A
        BACC   B



        .global _interrupt
_interrupt:
        PSHM   ST0
        PSHM   AL
        PSHM   AH
        PSHM   AG
        PSHM   BL
        PSHM   BH
        PSHM   BG
        PSHM   ST1
        PSHM   AR0
        PSHM   AR2
        PSHM   AR3
        PSHM   AR4
        PSHM   AR5
        PSHM   T
        PSHM   TRN
        PSHM   BK
        PSHM   BRC
        PSHM   RSA
        PSHM   REA
        PSHM   PMST
        LD     *(__kernel_nest),A
        ADDM   #1,*(__kernel_nest)               ;�����ߤΥͥ��Ȳ���򥤥󥯥����
        BC     _interrupt_from_int,ANEQ
        LDM    SP,A                      ;�����å������ؤ���
        STM    #STACKTOP,SP              ;���Υ����å��ݥ��󥿤�
        PSHM   AL                        ;��¸��Ԥ�
        PSHM   IMR
        MVDM   *(_INT_VECNO),AR2         ;���ե��å��ͤ�AR2�˥��å�
        STM    #IMR,AR3                  ;Ʊ�������ߤ����٤⤫����ʤ��褦��
        LD     *AR2(__kernel_int_mask_table),A   ;            ��
        AND    *AR3,A                    ;            ��
        STL    A,*AR3                    ;���ߤγ����ߤ�ޥ������� 
        LD     *AR2(__kernel_int_table),A        ;�����ߥϥ�ɥ�Υ��ɥ쥹�����
        RSBX   INTM                      ;����ʹ߳����ߤ���������դ���
        CALA   A                         ;�����ߥϥ�ɥ��
        SSBX   INTM                      ;�����ߤ�ػ�
        ADDM   #-1,*(__kernel_nest)              ;�ǥ������
        POPM   IMR
        POPM   SP                        ;����褬�������ʤΤǥ����å����᤹
        LD     *(__kernel_reqflg),A
        BC     _ret_to_task_int,AEQ      ;reqflg��FALSE�ʤ饸����
        ST     #0,*(__kernel_reqflg)
        B      ret_int

_interrupt_from_int:
        LDM    SP,A
        ANDM   #0xFFFE,*(SP)
        NOP
        NOP
        PSHM   AL
        PSHM   IMR
        MVDM   *(_INT_VECNO),AR2         ;���ե��å��ͤ�AR2�˥��å�
        STM    #IMR,AR3                  ;Ʊ�������ߤ����٤⤫����ʤ��褦��
        LD     *AR2(__kernel_int_mask_table),A   ;            ��
        AND    *AR3,A                    ;            ��
        STL    A,*AR3                    ;���ߤγ����ߤ�ޥ������� 
        LD     *AR2(__kernel_int_table),A        ;�����ߥϥ�ɥ�Υ��ɥ쥹�����
        RSBX   INTM                      ;����ʹ߳����ߤ�����դ���
        CALA   A                         ;�����ߥϥ�ɥ��
        SSBX   INTM                      ;�����߶ػ�
        POPM   IMR
        POPM   SP
        ADDM   #-1,*(__kernel_nest)              ;�����ߤΥͥ��Ȳ����ǥ������
_ret_to_task_int:                        ;�쥸�����������������߸�����롣
        POPM   PMST
        POPM   REA
        POPM   RSA
        POPM   BRC
        POPM   BK
        POPM   TRN
        POPM   T
        POPM   AR5
        POPM   AR4
        POPM   AR3
        POPM   AR2
        POPM   AR0
        POPM   ST1
        POPM   BG
        POPM   BH
        POPM   BL
        POPM   AG
        POPM   AH
        POPM   AL
        POPM   ST0
        RETE
        
        .global ret_int
ret_int:
        LD     *(__kernel_enadsp),A
        BC     ret_int_1,AEQ
        MVDM    *(__kernel_runtsk),AR0
        MVDM    *(__kernel_schedtsk),AR2
        NOP
        CMPR   EQ,AR2                    ;runtsk��schedtsk����� 
        BC     ret_int_1,TC
        PSHM   AR1
        PSHM   AR6
        PSHM   AR7
        LDM    SP,A
        STL    A,*AR0(TCB_sp)
        ST     #ret_int_r,*AR0(TCB_pc)
        B      dispatcher_1
ret_int_r:
        POPM   AR7
        POPM   AR6
        POPM   AR1
ret_int_1:
        LDM    SP,A
        ANDM   #0xFFFE,*(SP)
        NOP
        NOP
        PSHM   AL
        FRAME  #-1
        LD     #__kernel_calltex,A
        CALA   A
        FRAME  #1
        POPM   SP
        NOP
        POPM   PMST
        POPM   REA
        POPM   RSA
        POPM   BRC
        POPM   BK
        POPM   TRN
        POPM   T
        POPM   AR5
        POPM   AR4
        POPM   AR3
        POPM   AR2
        POPM   AR0
        POPM   ST1
        POPM   BG
        POPM   BH
        POPM   BL
        POPM   AG
        POPM   AH
        POPM   AL
        POPM   ST0
        RETE

;
;   ���������Ԥ�
;
        .global	_sil_dly_nse
_sil_dly_nse:
        SSBX      SXM
        NOP
        LD	*(AL), A
        SUB	#SIL_DLY_TIM1, A, A
        BC	_sil_dly_nse1, AGT
        RET
_sil_dly_nse1:
        SUB	#SIL_DLY_TIM2, A, A
        BC	_sil_dly_nse1, AGT
        RET
