#	@(#)Makefile	8.2 (Berkeley) 4/4/94
# $FreeBSD$

PROG=	ftpd
MAN=	ftpd.8 ftpchroot.5
SRCS=	ftpd.c ftpcmd.y logwtmp.c popen.c

CFLAGS+=-DSETPROCTITLE -DLOGIN_CAP -DVIRTUAL_HOSTING
CFLAGS+=-DINET6
CFLAGS+=-I${.CURDIR}
YFLAGS=
WARNS?=	2
WFORMAT=0

DPADD=	${LIBUTIL} ${LIBCRYPT}
LDADD=	-lutil -lcrypt

# XXX Kluge! Conversation mechanism needs to be fixed.
DPADD+=	${LIBOPIE} ${LIBMD}
LDADD+=	-lopie -lmd

LSDIR=	../../bin/ls
.PATH:	${.CURDIR}/${LSDIR}
SRCS+=	ls.c cmp.c print.c util.c
CFLAGS+=-Dmain=ls_main -I${.CURDIR}/${LSDIR}
DPADD+=	${LIBM}
LDADD+=	-lm

.if !defined(NOPAM)
CFLAGS+=-DUSE_PAM
DPADD+= ${LIBPAM}
LDADD+= ${MINUSLPAM}
.endif

.include <bsd.prog.mk>
