<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Move generated topic numbers into the title / navigation title for
    each topic and TOC entry.
    
    Assumes that an earlier step has generated <resourceid> elements
    for the numbering.
    -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:import href="plugin:org.dita.base:xsl/common/dita-utilities.xsl"/>
    <xsl:import href="plugin:org.dita.base:xsl/common/output-message.xsl"/>
    <xsl:variable name="msgprefix" select="''"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Match <navtitle> or <linktext> inside of <topicmeta>.
        If there is a generated resourceid with a TOC number, copy that TOC number
        before the navigation title or link text. -->
    <xsl:template match="*[contains(@class, ' map/topicmeta ')]/*[contains(@class,' topic/navtitle ')] |
        *[contains(@class, ' map/topicmeta ')]/*[contains(@class,' map/navtitle ')] |
        *[contains(@class, ' map/topicmeta ')]/*[contains(@class,' topic/linktext ')] |
        *[contains(@class, ' map/topicmeta ')]/*[contains(@class,' map/linktext ')]">
        <xsl:choose>
            <xsl:when test="../resourceid[@appname='spectopicnum']">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:value-of select="concat(../resourceid[@appname='spectopicnum']/@appid, ' ')"/>
                    <xsl:apply-templates/>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:next-match/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Match a topic title; assumes root topic (does not work with <dita>).
        If there is a generated resourceid with a TOC number, copy that TOC number
        before the title text. -->
    <xsl:template match="/*[contains(@class, ' topic/topic ')]/*[contains(@class,' topic/title ')]">
        <xsl:choose>
            <xsl:when test="../*[contains(@class,' topic/prolog ')]/resourceid[@appname='spectopicnum']">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:value-of select="concat(../*[contains(@class,' topic/prolog ')]/resourceid[@appname='spectopicnum']/@appid, ' ')"/>
                    <xsl:apply-templates/>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:next-match/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Match a navigation title in a topic; assumes root topic (does not work with <dita>).
        If there is a generated resourceid with a TOC number, copy that TOC number
        before the title text. -->
    <xsl:template match="/*/*[contains(@class, ' topic/titlealts ')]/*[contains(@class,' topic/navtitle ')]">
        <xsl:choose>
            <xsl:when test="../../*[contains(@class,' topic/prolog ')]/resourceid[@appname='spectopicnum']">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:value-of select="concat(../../*[contains(@class,' topic/prolog ')]/resourceid[@appname='spectopicnum']/@appid, ' ')"/>
                    <xsl:apply-templates/>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:next-match/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Strip out the generated topic number, which is no longer needed after this step. -->
    <xsl:template match="resourceid[@appname = 'spectopicnum']"/>
    
</xsl:stylesheet>