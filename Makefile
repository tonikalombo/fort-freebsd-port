PORTNAME= fort
DISTVERSION= 1.5.1
CATEGORIES=	net
MASTER_SITES= https://github.com/NICMx/FORT-validator/releases/download/v1.5.1/fort-1.5.1.tar.gz
LICENSE_FILE=	${WRKSRC}/LICENSE
MAINTAINER=	toni@devboks.com
COMMENT= This is the FreeBSD Port for the FORT Validator, an open source RPKI validator. 
NO_BUILD=	no
USE_RC_SUBR=	fort
FETCH_DEPENDS= curl:${PORTSDIR}/ftp/curl
USES=	autoconf:${PORTSDIR}/devel/autoconf \
				automake:${PORTSDIR}/devel/automake \
				gcc:${PORTSDIR}/lang/gcc \
				jansson:${PORTSDIR}/devel/jansson \
				pkgconf:${PORTSDIR}/devel/pkgconf \
				rsync:${PORTSDIR}/net/rsync \
				libxml2:${PORTSDIR}/textproc/libxml2
pre-install:
	@ln -s /usr/local/include/jansson.h /usr/include/jansson.h
	@ln -s /usr/local/include/jansson_config.h /usr/include/jansson_config.h
	@ln -s /usr/local/include/curl /usr/include/curl

do-install:
	@cd ${WRKSRC}/ && ${COPYTREE_SHARE} . ${STAGEDIR}/	

post-install:
	${STRIP_CMD} ${STAGEDIR}${PREFIX}/bin/fort
	@${MKDIR} ${STAGEDIR}/${PREFIX}/etc/fort
	@${MKDIR} ${STAGEDIR}/${PREFIX}/etc/fort/tal
	@${MKDIR} ${STAGEDIR}/${PREFIX}/etc/fort/repository
	${INSTALL_DATA} ${PORTSDIR}/net/fort/files/fort-config.json.example \
		${STAGEDIR}${PREFIX}/etc/fort/fort-config.json.example
	@fort --init-tals --tal ${STAGEDIR}/${PREFIX}/etc/fort/tal


.include <bsd.port.mk>