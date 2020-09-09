<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:import href="plugin:org.dita.base:xsl/common/dita-utilities.xsl"/>
    <xsl:import href="plugin:org.dita.base:xsl/common/output-message.xsl"/>
    <xsl:variable name="msgprefix" select="''"/>
    
    <xsl:variable name="fulltoc" as="element()">
        <xsl:for-each select="/*">
            <xsl:copy>
                <xsl:copy-of select="@*"/>
                <xsl:apply-templates select="/*/*[contains(@class,' map/topicref ')]" mode="buildtoc"/>
            </xsl:copy>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:template match="*" mode="buildtoc">
        <xsl:choose>
            <xsl:when test="@href">
                <xsl:copy>
                    <xsl:copy-of select="@*"/>
                    <xsl:attribute name="genid" select="generate-id(.)"/>
                    <xsl:apply-templates select="*[contains(@class,' map/topicref ')]" mode="buildtoc"/>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="*[contains(@class,' map/topicref ')]" mode="buildtoc"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="@* | node()">
        <xsl:param name="spectopicnum"/>
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*[contains(@class,' map/topicref ')]
        [@href]
        [ancestor-or-self::*[contains(@class,' bookmap/chapter ') or contains(@class,' bookmap/appendix ')]]">
        <xsl:variable name="id-in-gentoc" select="generate-id(.)"/>
        <xsl:variable name="tocnum">
            <xsl:apply-templates select="$fulltoc//*[@genid = $id-in-gentoc]" mode="find-position-in-toc"/>
        </xsl:variable>
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="spectopicnum" select="$tocnum"/>
            <xsl:if test="empty(*[contains(@class,' map/topicmeta ')])">
                <topicmeta class="- map/topicmeta " xtrf="{@xtrf}" xtrc="{@xtrc}">
                    <resourceid class="- topic/resourceid " appname="spectopicnum" appid="{$tocnum}" xtrf="{@xtrf}" xtrc="{@xtrc}"/>
                </topicmeta>
            </xsl:if>
            <xsl:apply-templates select="node()">
                <xsl:with-param name="spectopicnum" select="$tocnum"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*[contains(@class,' map/topicmeta ')]">
        <xsl:param name="spectopicnum" as="xs:string?"/>
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
            <xsl:if test="string-length($spectopicnum) > 0">
                <resourceid class="- topic/resourceid " appname="spectopicnum" appid="{$spectopicnum}" xtrf="{@xtrf}" xtrc="{@xtrc}"/>
            </xsl:if>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*" mode="find-position-in-toc">
      <xsl:choose>
        <xsl:when test="contains(@class,' bookmap/appendix ')">
            <xsl:number format="A" count="*[contains(@class, ' bookmap/appendix ')]" level="any"/>
        </xsl:when>
        <xsl:when test="contains(@class,' bookmap/chapter ')">
            <xsl:number format="1" count="*[contains(@class, ' bookmap/chapter ')]" level="any"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:apply-templates select="parent::*" mode="find-position-in-toc"/>
            <xsl:text>.</xsl:text>
            <xsl:number format="1" count="*[contains(@class, ' map/topicref ')]"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:template>
    
    <xsl:template match="*" mode="count-submap-topics">
        <xsl:choose>
            <xsl:when test="self::submap">
                <xsl:apply-templates select="*[contains(@class,' map/topicref ')]" mode="count-submap-topics"/>
            </xsl:when>
            <xsl:when test="@href">
                <xsl:copy-of select="."/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="*[contains(@class,' map/topicref ')]" mode="count-submap-topics"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>