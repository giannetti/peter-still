<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml"
    version="2.0">

    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Aug 13, 2017</xd:p>
            <xd:p><xd:b>Author:</xd:b> Francesca</xd:p>
            <xd:p>This stylesheet generates a lightly edited XHTML version of TEI encoded
                correspondence belonging to the Peter Still Papers, held in Rutgers University
                Libraries Special Collections and University Archives. The output is specifically tailored for display in the item records of an Omeka installation.</xd:p>
        </xd:desc>
    </xd:doc>

    <xsl:output method="xhtml" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>

    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Create the body of the HTML doc with the WMA identifier as the title. </xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="//idno[@xml:id='WMA']"/>
                </title>
            </head>
            <body>
                <div id="primary-source-document">
                    <xsl:apply-templates select="TEI/text/body"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Create HTML divs for the TEI div elements.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="div">
        <div class="{@type}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Process the opener element.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="opener">
        <p style="text-align: right;">
            <xsl:value-of select="dateline/placeName"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="dateline/date"/>
            <br>
                <xsl:apply-templates select="lb"/>
            </br>
        </p>
        <xsl:if test="address">
            <xsl:for-each select="address/addrLine">
                <p style="text-align: right;">
                    <xsl:apply-templates />
                </p>
            </xsl:for-each>
        </xsl:if>
        <p style="text-align: left;">
            <xsl:apply-templates select="salute"/>
        </p>
    </xsl:template>

    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>When there's a choice element, take the value of the child corr element and put it
                in brackets.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="TEI//choice">
        <xsl:text>[</xsl:text>
        <xsl:value-of select="corr | expan | reg"/>
        <xsl:text>]</xsl:text>
    </xsl:template>

    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Convert the emph element to the em element.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="emph">
        <em>
            <xsl:apply-templates/>
        </em>
    </xsl:template>

    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Apply superscript to any add elements where the place is denoted as
                'above'.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="add[@place='above'] | hi[@rend='superscript']">
        <sup>
            <xsl:apply-templates/>
        </sup>
    </xsl:template>

    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Indent anything with a rendition value of #indent.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="p[@rendition='#indent']">
        <p style="text-indent:4em;">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Indent further for rendition value of #indent3.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="p[@rendition='#indent3']">
        <p style="padding-left:10em; text-indent:-2em;">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Convert rend value of 'strikethrough' to CSS line-through.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="del[@rend='strikethrough']">
        <span style="text-decoration: line-through;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Convert rendition value of #u to CSS underline.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="hi[@rendition='#u']">
        <span style="text-decoration: underline;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="ab[@rendition='#indent3']/add">
        <br>
            <span style="display:block; padding-left:10em; text-indent:-2em;" class="add"
                >⟨<xsl:apply-templates/>⟩</span>
        </br>
    </xsl:template>

    <xsl:template match="postscript"> ⟨<xsl:apply-templates/>⟩ </xsl:template>

    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Render verticle left-to-right text with CSS writing-mode.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="ab[@style='writing-mode: vertical-lr']">
        <span
            style="-ms-writing-mode: tb-lr;
            -webkit-writing-mode: vertical-lr;
            -moz-writing-mode: vertical-lr;
            -ms-writing-mode: vertical-lr;
            writing-mode: vertical-lr;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Convert lb element to br element, but only for children of the ab, opener, and closer elements (ignore
                line breaks in p element).</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="ab/lb | //opener//lb | //closer//lb">
        <br>
            <xsl:apply-templates/>
        </br>
    </xsl:template>

    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Render any unclear elements as italics followed by a question mark in
                brackets.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="unclear">
        <span style="font-style: italic;">
            <xsl:apply-templates/>
            <xsl:text>[?]</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="supplied">
        <xsl:text>[</xsl:text><xsl:apply-templates/><xsl:text>]</xsl:text>
    </xsl:template>

    <xsl:template match="pb">
        <!-- include the page number -->
        <br/>
        <p style="text-align: center;"><small>[Page: <xsl:value-of select="@n"/>]</small></p>
        <br/>
    </xsl:template>

    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Convert table to HTML table.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="table">
        <table>
            <xsl:apply-templates select="row"/>
        </table>
    </xsl:template>

    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Convert table rows to tr element.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="row">
        <tr>
            <xsl:apply-templates select="*"/>
        </tr>
    </xsl:template>

    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Convert table cells to td element.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="row/*">
        <td>
            <xsl:apply-templates select="node()"/>
        </td>
    </xsl:template>

    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Indent the closer text.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="closer">
        <p style="padding-left:10em; text-indent:-2em;">
            <xsl:apply-templates select="salute"/>
        </p>
        <p style="padding-left:13em; text-indent:-2em;">
            <xsl:apply-templates select="signed"/>
        </p>
        <xsl:if test="date | add">
            <p style="padding-left:13em; text-indent:-2em;">
                <xsl:apply-templates select="date | add"/>
            </p>
        </xsl:if>
        <xsl:if test="address">
            <xsl:for-each select="address/addrLine">
                <p style="padding-left:10em; text-indent:-2em;">
                    <xsl:apply-templates />
                </p>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
