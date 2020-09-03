<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:param name="idprefix" select="'lnk_'" as="xs:string"/>

    <xsl:import href="plugin:org.dita.base:xsl/common/dita-utilities.xsl"/>
    <xsl:import href="plugin:org.dita.base:xsl/common/output-message.xsl"/>
    <xsl:variable name="msgprefix" select="''"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*[empty(@id)]
        [contains(class,' topic/abstract ') or contains(@class,' topic/bodydiv ') or contains(@class,' topic/dd ') or
        contains(@class,' topic/dt ') or contains(@class,' topic/div ') or contains(@class,' topic/dl ') or
        contains(@class,' topic/draft-comment ') or contains(@class,' topic/example ') or contains(@class,' topic/fig ') or
        contains(@class,' topic/figgroup ') or contains(@class,' topic/image ') or contains(@class,' topic/include ') or
        contains(@class,' topic/foreign ') or contains(@class,' topic/itemgroup ') or contains(@class,' topic/li ') or
        contains(@class,' topic/lines ') or contains(@class,' topic/link ') or contains(@class,' topic/lq ') or
        contains(@class,' topic/note ') or contains(@class,' topic/object ') or contains(@class,' topic/ol ') or
        contains(@class,' topic/p ') or contains(@class,' topic/ph ') or contains(@class,' topic/pre ') or
        contains(@class,' topic/q ') or contains(@class,' topic/row ') or contains(@class,' topic/section ') or
        contains(@class,' topic/sectiondiv ') or contains(@class,' topic/simpletable ') or contains(@class,' topic/sl ') or
        contains(@class,' topic/sli ') or contains(@class,' topic/strow ') or contains(@class,' topic/table ') or
        contains(@class,' topic/title ') or contains(@class,' topic/ul ') or contains(@class,' topic/shortdesc ')]">
        
        <xsl:copy>
            <xsl:attribute name="id" select="concat($idprefix,generate-id(.))"/>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
        
    </xsl:template>
    
    
</xsl:stylesheet>