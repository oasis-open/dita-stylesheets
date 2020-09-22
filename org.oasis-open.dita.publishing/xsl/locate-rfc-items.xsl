<?xml version="1.0" encoding="UTF-8"?>
<!-- Locate the RFC items and add a unique ID to help with later linking. -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:param name="FILENAME"/>
    <xsl:param name="FILEDIR"/>
    <xsl:param name="store.dita.rfc.filename" select="''"/>
    
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@* | node()" mode="ignore-rfc-in-rfc">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" mode="ignore-rfc-in-rfc"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*[(contains(@class,' topic/p ') or contains(@class,' topic/div ') or contains(@class,' topic/li ') or contains(@class,' topic/ph '))]
        [descendant::*[contains(@class, ' topic/term ')][@outputclass = 'RFC-2119']]">
        <xsl:copy>
            <xsl:attribute name="rfclink" select="generate-id(.)"/>
            <xsl:apply-templates select="@* | node()" mode="ignore-rfc-in-rfc"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*[contains(@class,' topic/data ')][@name='rfc-list']">
        <xsl:variable name="rfctopic">
            <xsl:if test="$FILEDIR != '' and $FILEDIR != '.'">
                <xsl:value-of select="concat($FILEDIR, '/')"/>
            </xsl:if>
            <xsl:value-of select="concat($FILENAME, '#', ancestor::*[contains(@class,' topic/topic ')][1]/@id)"/>
        </xsl:variable>
        <xsl:result-document href="{$store.dita.rfc.filename}" method="text">
            <xsl:value-of select="$rfctopic"/>
        </xsl:result-document>
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>