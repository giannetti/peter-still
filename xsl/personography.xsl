<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xhtml="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xs tei xhtml" version="2.0">

    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        
        omit-xml-declaration="yes" indent="yes" encoding="UTF-8" method="xhtml"/>
    
    <xsl:strip-space elements="*"/>
    
    <xsl:variable name="return">
        <xsl:text>
        </xsl:text>
    </xsl:variable>


        <xsl:template match="listPerson">
            <xsl:for-each select="person">
                <xsl:sort select="persName" order="ascending" data-type="text"/>
                    <h3><xsl:apply-templates select="persName" /></h3>
                    <p>
                        <xsl:if test="state">
                            <xsl:value-of select="$return"/>
                            <xsl:value-of select="concat('Relationship: ', state/desc)"/>
                            <br/>
                        </xsl:if>
                        <xsl:if test="occupation">
                            <xsl:value-of select="$return"/>
                            <xsl:value-of select="concat('Occupation: ', occupation)"/>
                            <br/>
                        </xsl:if>
                    <xsl:if test="birth">
                        <xsl:value-of select="$return"/>
                        <xsl:value-of select="concat('Born: ', birth/@when)"/>
                        <xsl:if test="birth/placeName">
                            <xsl:value-of select="concat(' in ', birth/placeName)"/>
                            
                        </xsl:if>
                        <br/>
                    </xsl:if>
                    <xsl:if test="death">
                        <xsl:value-of select="$return"/>
                        <xsl:value-of select="concat('Died: ', death/@when)"/>
                        <xsl:if test="death/placeName">
                            <xsl:value-of select="concat(' in ', death/placeName)"/>
                        </xsl:if>
                    </xsl:if>
                    </p>
                <xsl:value-of select="$return"/>
            </xsl:for-each>
        </xsl:template>

   <!--  
    <xsl:template match="listPerson">
        <xsl:for-each select="person">
            <p><xsl:value-of select="." /></p>         
        </xsl:for-each>
    </xsl:template>
    -->
    
    <!-- 
    
    <xsl:template match="/">
        <xsl:for-each select="listPerson/person">
            <xsl:apply-templates select="person"/>
            <xsl:text></xsl:text>
        </xsl:for-each>
    </xsl:template>
 
    <xsl:template match="listPerson">
        <h3><xsl:apply-templates select="person"/></h3>
    </xsl:template>
    -->
    
</xsl:stylesheet>