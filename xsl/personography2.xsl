<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Jan 29, 2025</xd:p>
            <xd:p><xd:b>Author:</xd:b> Francesca</xd:p>
            <xd:p>This stylesheet takes the personography.xml file and generates an HTML document of the people mentioned in the letters.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:output method="xhtml" encoding="utf-8" omit-xml-declaration="yes"/>
    
    <xd:doc>
        <xd:desc>Create HTML document</xd:desc>
    </xd:doc>
    <xsl:template match="/">
        <html>
            <head>Still Papers: People</head>
            <body>
                <div style="text-align: center;">
                    <h2>
                        <xsl:value-of select="/TEI/text/front/docTitle/titlePart"/>
                    </h2>
                    <xsl:apply-templates select="//body" />
                </div>
                <hr/>
            </body>
        </html>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>Sort <gi>person</gi> in alphabetical order by @xml:id values. Included birth/death dates. Still have to add notes on relation to Peter, occupation, events, place(s) of residence.</xd:desc>
    </xd:doc>
    <xsl:template match="listPerson">
        <xsl:for-each select="person">
        <xsl:sort select="@xml:id" />
            <div style="text-align: left;">
            <xsl:text>&#xd;</xsl:text> <!-- carriage return -->
            <xsl:value-of select="persName/reg"/>
            <xsl:text> (b. </xsl:text>
            <xsl:choose>
                <xsl:when test="birth/@when">
                    <xsl:value-of select="format-date(birth/@when, '[D] [MNn] [Y]')"/>
                    <xsl:if test="birth/placeName">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="birth/placeName"/>
                    </xsl:if>
                </xsl:when>
                <xsl:when test="birth/@notAfter | birth/@notBefore">
                    <xsl:value-of select="birth/@notBefore"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="birth/@notAfter"/>
                    <xsl:if test="birth/placeName">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="birth/placeName"/>
                    </xsl:if>
                </xsl:when>
                <xsl:when test="birth/@when-iso">
                    <xsl:value-of select="birth/@when-iso"/>
                    <xsl:if test="birth/placeName">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="birth/placeName"/>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="birth"/>
                    <xsl:if test="birth/placeName">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="birth/placeName"/>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>&#x2013;d. </xsl:text>
            <xsl:choose>
                <xsl:when test="death/@when">
                    <xsl:value-of select="format-date(death/@when, '[D] [MNn] [Y]')"/>
                    <xsl:if test="death/placeName">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="death/placeName"/>
                    </xsl:if>
                </xsl:when>
                <xsl:when test="death/@notAfter | death/@notBefore">
                    <xsl:value-of select="death/@notBefore"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="death/@notAfter"/>
                    <xsl:if test="death/placeName">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="death/placeName"/>
                    </xsl:if>
                </xsl:when>
                <xsl:when test="death/@when-iso">
                    <xsl:value-of select="death/@when-iso"/>
                    <xsl:if test="death/placeName">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="death/placeName"/>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="death"/>
                    <xsl:if test="death/placeName">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="death/placeName"/>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>)</xsl:text>
            </div>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>