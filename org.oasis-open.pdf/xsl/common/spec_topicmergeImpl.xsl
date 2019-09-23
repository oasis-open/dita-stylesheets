<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:specrfc="org.oasis.spec.pdf/rfc"
    xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
    exclude-result-prefixes="xs dita-ot specrfc">
    
    <xsl:template match="*[contains(@class,' topic/p ') or contains(@class,' topic/div ') or contains(@class,' topic/li ') or contains(@class,' topic/ph ')]
        [descendant::*[contains(@class, ' topic/term ')][@outputclass = 'RFC-2119']]
        [ancestor::*[contains(@class,' topic/topic ')]]
        [not(ancestor::*[contains(@class,' topic/desc ') or contains(@class,' topic/related-links ')])]">
        <xsl:param name="newid"/>
        <xsl:copy>
            <xsl:apply-templates select="@*">
                <xsl:with-param name="newid"/>
            </xsl:apply-templates>
            <xsl:attribute name="specrfc:container" select="'true'"/>
            <xsl:if test="not(@id)"><xsl:attribute name="id" select="concat('rfc-genid-',generate-id(.))"/></xsl:if>
            <xsl:apply-templates select="*|text()|processing-instruction()|comment()">
                <xsl:with-param name="newid"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
