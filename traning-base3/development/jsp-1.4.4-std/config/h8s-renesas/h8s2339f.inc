;
;  TOPPERS/JSP Kernel
;      Toyohashi Open Platform for Embedded Real-Time Systems/
;      Just Standard Profile Kernel
;
;  Copyright (C) 2000-2004 by Embedded and Real-Time Systems Laboratory
;                              Toyohashi Univ. of Technology, JAPAN
;  Copyright (C) 2001-2004 by Dep. of Computer Science and Engineering
;                   Tomakomai National College of Technology, JAPAN
;  Copyright (C) 2001-2007 by Industrial Technology Institute,
;                              Miyagi Prefectural Government, JAPAN
;
;  �嵭����Ԥϡ��ʲ��� (1)��(4) �ξ�狼��Free Software Foundation
;  �ˤ�äƸ�ɽ����Ƥ��� GNU General Public License �� Version 2 �˵�
;  �Ҥ���Ƥ���������������˸¤ꡤ�ܥ��եȥ��������ܥ��եȥ�����
;  ����Ѥ�����Τ�ޤࡥ�ʲ�Ʊ���ˤ���ѡ�ʣ�������ѡ������ۡʰʲ���
;  ���ѤȸƤ֡ˤ��뤳�Ȥ�̵���ǵ������롥
;  (1) �ܥ��եȥ������򥽡��������ɤη������Ѥ�����ˤϡ��嵭������
;      ��ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ��꤬�����Τޤޤη��ǥ���
;      ����������˴ޤޤ�Ƥ��뤳�ȡ�
;  (2) �ܥ��եȥ������򡤥饤�֥������ʤɡ�¾�Υ��եȥ�������ȯ�˻�
;      �ѤǤ�����Ǻ����ۤ�����ˤϡ������ۤ�ȼ���ɥ�����ȡ�����
;      �ԥޥ˥奢��ʤɡˤˡ��嵭�����ɽ�����������Ѿ�浪��Ӳ���
;      ��̵�ݾڵ����Ǻܤ��뤳�ȡ�
;  (3) �ܥ��եȥ������򡤵�����Ȥ߹���ʤɡ�¾�Υ��եȥ�������ȯ�˻�
;      �ѤǤ��ʤ����Ǻ����ۤ�����ˤϡ����Τ����줫�ξ�����������
;      �ȡ�
;    (a) �����ۤ�ȼ���ɥ�����ȡ����Ѽԥޥ˥奢��ʤɡˤˡ��嵭����
;        �ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ����Ǻܤ��뤳�ȡ�
;    (b) �����ۤη��֤��̤�������ˡ�ˤ�äơ�TOPPERS�ץ��������Ȥ�
;        ��𤹤뤳�ȡ�
;  (4) �ܥ��եȥ����������Ѥˤ��ľ��Ū�ޤ��ϴ���Ū�������뤤���ʤ�»
;      ������⡤�嵭����Ԥ����TOPPERS�ץ��������Ȥ����դ��뤳�ȡ�
;
;  �ܥ��եȥ������ϡ�̵�ݾڤ��󶡤���Ƥ����ΤǤ��롥�嵭����Ԥ�
;  ���TOPPERS�ץ��������Ȥϡ��ܥ��եȥ������˴ؤ��ơ�����Ŭ�Ѳ�ǽ����
;  �ޤ�ơ������ʤ��ݾڤ�Ԥ�ʤ����ޤ����ܥ��եȥ����������Ѥˤ��ľ
;  ��Ū�ޤ��ϴ���Ū�������������ʤ�»���˴ؤ��Ƥ⡤������Ǥ�����ʤ���
;
;  @(#) $Id: h8s2339f.inc,v 1.2 2007/03/23 07:59:26 honda Exp $
;

;  H8S/2339F������ʥ�����֥��ѡ�

 .AIFDEF _H8S2339F_INC_
 .AELSE

_H8S2339F_INC_: .DEFINE ""

        .INCLUDE "util.inc"

;
;  �����쥸����������ʲ���16�ӥåȤΤߡ�
;

;    �Х�����ȥ�����
ABWCR:                   .DEFINE         "H'fed0"
ASTCR:                   .DEFINE         "H'fed1"
WCRH:                    .DEFINE         "H'fed2"
WCRL:                    .DEFINE         "H'fed3"
BCRH:                    .DEFINE         "H'fed4"
BCRL:                    .DEFINE         "H'fed5"

PFCR1:                   .DEFINE         "H'ff45"
PFCR2:                   .DEFINE         "H'ffac"


;    I/O�ݡ���
P1DR:                    .DEFINE         "H'ff60"
P2DR:                    .DEFINE         "H'ff61"
P3DR:                    .DEFINE         "H'ff62"
P4DR:                    .DEFINE         "H'ff63"
P5DR:                    .DEFINE         "H'ff64"
P6DR:                    .DEFINE         "H'ff65"
P7DR:                    .DEFINE         "H'ff66"
P8DR:                    .DEFINE         "H'ff67"
P9DR:                    .DEFINE         "H'ff68"
PADR:                    .DEFINE         "H'ff69"
PBDR:                    .DEFINE         "H'ff6a"
PCDR:                    .DEFINE         "H'ff6b"
PDDR:                    .DEFINE         "H'ff6c"
PEDR:                    .DEFINE         "H'ff6d"
PFDR:                    .DEFINE         "H'ff6e"
PGDR:                    .DEFINE         "H'ff6f"

P1DDR:                   .DEFINE         "H'feb0"
P2DDR:                   .DEFINE         "H'feb1"
P3DDR:                   .DEFINE         "H'feb2"
P4DDR:                   .DEFINE         "H'feb3"
P5DDR:                   .DEFINE         "H'feb4"
P6DDR:                   .DEFINE         "H'feb5"
P7DDR:                   .DEFINE         "H'feb6"
P8DDR:                   .DEFINE         "H'feb7"
P9DDR:                   .DEFINE         "H'feb8"
PADDR:                   .DEFINE         "H'feb9"
PBDDR:                   .DEFINE         "H'feba"
PCDDR:                   .DEFINE         "H'febb"
PDDDR:                   .DEFINE         "H'febc"
PEDDR:                   .DEFINE         "H'febd"
PFDDR:                   .DEFINE         "H'febe"
PGDDR:                   .DEFINE         "H'febf"

 .AENDI ; _H8S2339F_INC_
