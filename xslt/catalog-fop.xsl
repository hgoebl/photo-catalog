<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
    <xsl:output method="xml"/>

    <xsl:attribute-set name="font">
        <xsl:attribute name="font-family">'Droid Sans', Arial, Helvetica, sans-serif</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="h1" use-attribute-sets="font">
        <xsl:attribute name="font-size">16pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="keep-with-next">10</xsl:attribute>
        <xsl:attribute name="space-before">10mm</xsl:attribute>
        <xsl:attribute name="space-after">4mm</xsl:attribute>
        <xsl:attribute name="break-before">page</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="h2" use-attribute-sets="font">
        <xsl:attribute name="font-size">14pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="space-before">5mm</xsl:attribute>
        <xsl:attribute name="space-after">3mm</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="subtitle" use-attribute-sets="font">
        <xsl:attribute name="font-size">16pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="keep-with-previous">10</xsl:attribute>
        <xsl:attribute name="space-before">10mm</xsl:attribute>
        <xsl:attribute name="space-after">4mm</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="title" use-attribute-sets="subtitle">
        <xsl:attribute name="font-size">14pt</xsl:attribute>
        <xsl:attribute name="space-before">5mm</xsl:attribute>
        <xsl:attribute name="space-after">3mm</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="subtitle1" use-attribute-sets="subtitle">
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="space-before">3mm</xsl:attribute>
        <xsl:attribute name="space-after">2mm</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="subtitle2" use-attribute-sets="subtitle">
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="space-before">1mm</xsl:attribute>
        <xsl:attribute name="space-after">1mm</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="box">
        <xsl:attribute name="font-family">Arial, Helvetica, sans-serif</xsl:attribute>
        <xsl:attribute name="space-before">2mm</xsl:attribute>
        <xsl:attribute name="space-after">2mm</xsl:attribute>
        <xsl:attribute name="border-style">none</xsl:attribute>
        <xsl:attribute name="border-color">#CCCCCC</xsl:attribute>
        <xsl:attribute name="border-width">0.3mm</xsl:attribute>
        <!-- xsl:attribute name="keep-together.within-page">always</xsl:attribute -->
    </xsl:attribute-set>
    <xsl:attribute-set name="cell">
        <xsl:attribute name="padding">1.5mm</xsl:attribute>
    </xsl:attribute-set>

    <xsl:template name="row-2-cols">
        <xsl:param name="label"/>
        <xsl:param name="value"/>
        <xsl:param name="colspan" select="'1'"/>
        <fo:table-row>
            <fo:table-cell xsl:use-attribute-sets="cell">
                <fo:block font-weight="bold"><xsl:copy-of select="$label"/></fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="cell" number-columns-spanned="{$colspan}">
                <fo:block><xsl:copy-of select="$value"/></fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>

    <xsl:template name="h1">
        <xsl:param name="value"/>
        <fo:block xsl:use-attribute-sets="h1"><xsl:copy-of select="$value"/></fo:block>
    </xsl:template>

    <xsl:template name="h2">
        <xsl:param name="value"/>
        <fo:block xsl:use-attribute-sets="h2"><xsl:copy-of select="$value"/></fo:block>
    </xsl:template>

    <xsl:template match="title">
        <fo:block text-align="center" xsl:use-attribute-sets="title"><xsl:copy-of select="text()"/></fo:block>
    </xsl:template>

    <xsl:template match="subtitle1">
        <fo:block text-align="center" xsl:use-attribute-sets="subtitle1"><xsl:copy-of select="text()"/></fo:block>
    </xsl:template>

    <xsl:template match="subtitle2">
        <fo:block text-align="center" xsl:use-attribute-sets="subtitle2"><xsl:copy-of select="text()"/></fo:block>
    </xsl:template>

    <xsl:template name="single-row-table-left-right">
        <xsl:param name="left"/>
        <xsl:param name="right"/>
        <fo:table table-layout="fixed" width="100%">
            <fo:table-column column-width="proportional-column-width(1)"/>
            <fo:table-column column-width="proportional-column-width(1)"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block text-align="start"><xsl:copy-of select="$left"/></fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block text-align="end"><xsl:copy-of select="$right"/></fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>

    <xsl:template match="/photos">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master
                        master-name="Master"
                        page-height="297mm"
                        page-width="210mm"
                        margin-top="8mm"
                        margin-bottom="8mm"
                        margin-left="10mm"
                        margin-right="10mm">
                    <fo:region-body
                            margin-top="8mm"
                            margin-bottom="8mm"
                            margin-left="5mm"
                            margin-right="5mm"/>
                    <fo:region-before
                            extent="16mm"/>
                    <fo:region-after
                            extent="10mm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:declarations>
                <x:xmpmeta xmlns:x="adobe:ns:meta/">
                    <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
                        <rdf:Description rdf:about="" xmlns:dc="http://purl.org/dc/elements/1.1/">
                            <dc:title>
                                Photo-Catalog
                            </dc:title>
                            <dc:creator>
                                Heinrich Göbl
                            </dc:creator>
                        </rdf:Description>
                        <rdf:Description rdf:about="" xmlns:xmp="http://ns.adobe.com/xap/1.0/">
                            <xmp:CreatorTool>Apache FOP, IntelliJ IDEA, Linux Mint</xmp:CreatorTool>
                        </rdf:Description>
                    </rdf:RDF>
                </x:xmpmeta>
            </fo:declarations>
            <fo:page-sequence master-reference="Master">
                <fo:static-content flow-name="xsl-region-before">
                    <xsl:call-template name="single-row-table-left-right">
                        <xsl:with-param name="right">
                            <xsl:value-of select="info/header-right"/>
                        </xsl:with-param>
                        <xsl:with-param name="left">
                            <xsl:value-of select="info/header-left"/>
                        </xsl:with-param>
                    </xsl:call-template>
                </fo:static-content>
                <fo:static-content flow-name="xsl-region-after">
                    <xsl:call-template name="single-row-table-left-right">
                        <xsl:with-param name="left">
                            <xsl:value-of select="info/date"/>
                        </xsl:with-param>
                        <xsl:with-param name="right">
                            Seite
                            <xsl:text> </xsl:text>
                            <fo:page-number/>
                            <xsl:text> </xsl:text>
                            von
                            <xsl:text> </xsl:text>
                            <fo:page-number-citation-last ref-id="last-page"/>
                        </xsl:with-param>
                    </xsl:call-template>
                </fo:static-content>
                <fo:flow flow-name = "xsl-region-body">
                    <xsl:apply-templates select="photo"/>
                    <xsl:call-template name="register"/>
                    <fo:block id="last-page"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template match="src[@orientation='portrait']">
        <fo:block text-align="center">
            <fo:external-graphic src="{.}" content-height="230mm"/>
        </fo:block>
    </xsl:template>

    <xsl:template match="src"><!-- default landscape -->
        <fo:block text-align="center">
            <fo:external-graphic src="{.}" content-width="166mm"/>
        </fo:block>
    </xsl:template>

    <xsl:template match="photo">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template name="register">
        <xsl:call-template name="h1">
            <xsl:with-param name="value">Register</xsl:with-param>
        </xsl:call-template>
        <fo:table table-layout="fixed" width="100%" xsl:use-attribute-sets="box">
            <fo:table-column column-width="30mm"/>
            <fo:table-column column-width="120mm"/>
            <fo:table-column column-width="proportional-column-width(1)"/>
            <fo:table-body>
                <xsl:for-each select="photo">
                    <fo:table-row>
                        <fo:table-cell xsl:use-attribute-sets="cell">
                            <fo:block text-align="center">
                                <fo:external-graphic src="{src}" content-width="16mm"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="cell">
                            <fo:block><xsl:copy-of select="title/text()"/></fo:block>
                            <fo:block><xsl:copy-of select="subtitle1/text()"/></fo:block>
                            <fo:block><xsl:copy-of select="subtitle2/text()"/></fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="cell">
                            <fo:block text-align="right"><xsl:copy-of select="position()"/></fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:for-each>
            </fo:table-body>
        </fo:table>
    </xsl:template>

</xsl:stylesheet>
