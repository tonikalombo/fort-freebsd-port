PORTNAME=	fort
DISTVERSIONPREFIX=	v
DISTVERSION=	1.5.1
CATEGORIES=	net

MAINTAINER=	toni@devboks.com
COMMENT=	FORT Validator is an open source RPKI validator

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

LIB_DEPENDS=	libcurl.so:ftp/curl libjansson.so:devel/jansson \
		libxml2.so:textproc/libxml2
RUN_DEPENDS=	${LOCALBASE}/bin/rsync:net/rsync

USES=		autoreconf pkgconfig ssl
USE_GCC=	yes
USE_GITHUB=	yes
USE_RC_SUBR=	fort

GH_ACCOUNT=	NICMx
GH_PROJECT=	FORT-validator

GNU_CONFIGURE=	yes

post-patch:
	@${REINPLACE_CMD} -e "s|/tmp/fort|${ETCDIR}|" \
		${WRKSRC}/examples/config.json
	@${REINPLACE_CMD} -e "s|/usr/local/ssl|/etc/ssl|" \
		${WRKSRC}/examples/config.json
	@${REINPLACE_CMD} -e "s|\"daemon\": false,|\"daemon\": true,|" \
		${WRKSRC}/examples/config.json
post-install:
	@${MKDIR} ${STAGEDIR}${ETCDIR}/repository ${STAGEDIR}${ETCDIR}/tal
	${INSTALL_DATA} ${WRKSRC}/examples/config.json \
		${STAGEDIR}${ETCDIR}/fort-config.json.sample

.include <bsd.port.mk>
