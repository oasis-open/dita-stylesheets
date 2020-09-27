<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 17 May 2019 KJE: Initial creation                                 -->
<!--                                                                   -->
<!-- ================================================================= -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">
  
    <xsl:attribute-set name="__frontmatter">
        <xsl:attribute name="text-align">center</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__frontmatter__title" use-attribute-sets="common.title">
        <xsl:attribute name="space-before">40mm</xsl:attribute>
        <xsl:attribute name="space-before.conditionality">retain</xsl:attribute>
        <xsl:attribute name="font-size">30pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="line-height">140%</xsl:attribute>
    </xsl:attribute-set>
 
     <xsl:template match="*[contains(@class, ' topic/author ')]">
        <fo:block xsl:use-attribute-sets="author" >
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>