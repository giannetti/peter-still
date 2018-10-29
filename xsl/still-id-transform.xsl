<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    >
    
    <!-- identity transform: -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- fix persName values that aren't formated as lastname, firstname -->
    <xsl:template match="persName[ contains( ., ',' ) ]">
        <xsl:copy-of select=" . "/>
    </xsl:template>
    <xsl:template match="persName[ not( contains( ., ',' ) ) ]">
        <xsl:variable name="names" select="tokenize( .,' ')"/>
        <xsl:copy>
        <xsl:value-of select="$names[position() eq last()]"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="$names[position() lt last()]"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>