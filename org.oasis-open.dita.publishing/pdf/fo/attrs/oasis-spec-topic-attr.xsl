<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 08 May 2019 KJE: Initial creation.                                -->
<!-- 18 May 2019 KJE: Added fig.title attribute set                    -->
<!-- 23 Sep 2020 KJE: Added attribute sets for RFC items               -->
<!-- 03 Sep 2021 KJE: Remove attribute sets for titles; now part of    -->
<!--                  common-topic-attr.xsl (OASIS tweak)              -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:rx="http://www.renderx.com/XSL/Extensions"
                version="2.0">
    
    <!-- RFC-2119 TERMS -->
    <xsl:attribute-set name="RFC-2119">
        <xsl:attribute name="font-style">normal</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="RFC-2119-statement" use-attribute-sets="common.block">
        <xsl:attribute name="border-left">2pt solid #446CAA</xsl:attribute>
        <xsl:attribute name="border-right">2pt solid #446CAA</xsl:attribute>
        <xsl:attribute name="padding-left">5pt</xsl:attribute>
        <xsl:attribute name="padding-right">5pt</xsl:attribute>
    </xsl:attribute-set>
  
</xsl:stylesheet>
