<?xml version="1.0" encoding="UTF-8" ?>
<!-- This file is part of the DITA Open Toolkit project hosted on 
     Sourceforge.net. See the accompanying license.txt file for 
     applicable licenses.-->
<!-- (c) Copyright IBM Corp. 2004, 2005 All Rights Reserved. -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
    xmlns:dita2html="http://dita-ot.sourceforge.net/ns/200801/dita2html"
    xmlns:ditamsg="http://dita-ot.sourceforge.net/ns/200704/ditamsg"
    xmlns:oa-cn="org.oasis.committeenote" exclude-result-prefixes="xs dita-ot dita2html ditamsg">

    <xsl:variable name="bookmap">
        <xsl:variable name="filenameonly" select="replace($ARGS.INPUT, '.*[/\\]', '')"/>
        <xsl:variable name="rawFullpathTempBookmap"
            select="concat($DITA.TEMP.DIR, '/', $filenameonly)"/>
        <xsl:variable name="fullpathTempBookmap">
            <xsl:text>file:</xsl:text>
            <xsl:choose>
                <xsl:when test="matches($rawFullpathTempBookmap, '^[a-z]:', 'i')">
                    <xsl:text>///</xsl:text>
                    <xsl:value-of select="replace($rawFullpathTempBookmap, '\\', '/')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="replace($rawFullpathTempBookmap, '\\', '/')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:copy-of select="doc($fullpathTempBookmap)"/>
    </xsl:variable>

    <xsl:template name="gen-toc">
        <div class="toc">
            <xsl:value-of select="$newline"/>
            <xsl:comment><xsl:value-of select="name($bookmap/*[1])"/></xsl:comment>
            <xsl:value-of select="$newline"/>

            <xsl:value-of select="$newline"/>
            <xsl:if test="$TRANSTYPE != 'htmlhelp'">
                <h1 class="title frontmatter-topic-title">Table of Contents</h1>
                <xsl:value-of select="$newline"/>
                <div class="toclinks">
                    <xsl:apply-templates
                        select="$bookmap/*/*[contains(@class, ' bookmap/chapter ')]" mode="toc"/>
                    <xsl:apply-templates
                        select="$bookmap/*/*[contains(@class, ' bookmap/appendix ')]" mode="toc"/>
                </div>
            </xsl:if>
            <p/>
            <xsl:value-of select="$newline"/>
        </div>
        <xsl:value-of select="$newline"/>
    </xsl:template>

    <xsl:template match="*" mode="toc">
        <!--    <xsl:param name="indent" select="'&#xa0;&#xa0;&#xa0;&#xa0;'"/>-->
        <xsl:variable name="thistitle">
            <xsl:apply-templates select="." mode="getTocTitle"/>
        </xsl:variable>
        <xsl:variable name="depth"
            select="count(ancestor-or-self::*[contains(@class, ' map/topicref ')])"/>
        <xsl:choose>
            <xsl:when test="normalize-space($thistitle) != ''">
                <xsl:variable name="topicId">
                    <xsl:apply-templates select="." mode="getId"/>
                </xsl:variable>
                <!-- Tagsmiths: The regular-expression in the following replace() function
          strips off the file extension from the filename in @href. -04oct13
        -->
                <xsl:variable name="basename" select="replace(@href, '(.*)\..*', '$1')"/>
                <p class="toc{$depth}">
                    <xsl:value-of select="' '"/>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="$basename"/>
                            <xsl:value-of select="$OUTEXT"/>
                            <xsl:text>#</xsl:text>
                            <xsl:choose>
                                <xsl:when test="contains(@href, '#')">
                                    <xsl:value-of select="substring-after(@href, '#')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$topicId"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <xsl:value-of select="$thistitle"/>
                    </a>
                </p>
                <xsl:value-of select="$newline"/>
                <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]" mode="toc">
                    <!--<xsl:with-param name="indent">
            <xsl:value-of select="$indent"/>
            <xsl:text>&#xA0;&#xA0;&#xA0;</xsl:text>
          </xsl:with-param>-->
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]" mode="toc">
                    <!--          <xsl:with-param name="indent" select="$indent"/>-->
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="text()" mode="toc"/>

    <xsl:template match="*" mode="getId">
        <xsl:value-of
            select="
                substring-after(*[contains(@class, ' map/topicmeta ')]
                /*[contains(@class, ' topic/data ')][@name = 'topicid']
                /@value, '#')"
        />
    </xsl:template>

    <xsl:template match="*" mode="getTocTitle">
        <xsl:if test="not((outputclass = 'cover') or (outputclass = 'frontmatternotices'))">
            <xsl:call-template name="getTocNumber"/>
            <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:choose>
            <xsl:when
                test="*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/navtitle ')]">
                <xsl:apply-templates
                    select="*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/navtitle ')]"
                />
            </xsl:when>
            <xsl:when test="@navtitle">
                <xsl:value-of select="@navtitle"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="getTocNumber">
        <xsl:choose>
            <xsl:when test="ancestor-or-self::*[contains(@class, ' bookmap/frontmatter ')]">
                <!-- Ignore frontmatter -->
            </xsl:when>
            <xsl:when test="ancestor-or-self::*[contains(@class, ' bookmap/chapter ')]">
                <span class="chapter-numbering">
                    <xsl:number
                        count="*[contains(@class, ' map/topicref ')][ancestor-or-self::*[contains(@class, ' bookmap/chapter ')]]"
                        format="1.1" level="multiple"/>
                </span>
            </xsl:when>
            <xsl:when test="ancestor-or-self::*[contains(@class, ' bookmap/appendix ')]">
                <span class="appendix-numbering"> Appendix <xsl:number
                        count="*[contains(@class, ' map/topicref ')][ancestor-or-self::*[contains(@class, ' bookmap/appendix ')]]"
                        format="A.1" level="multiple"/>
                </span>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/navtitle ')]">
        <xsl:apply-templates/>
    </xsl:template>

</xsl:stylesheet>
