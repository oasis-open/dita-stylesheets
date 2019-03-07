<?xml version="1.0" encoding="UTF-8"?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 29 Oct 2016 KJE: Initial creation.                                -->
<!-- 07 Mar 2019 KJE: Changed font-size to a variable                  -->
<!--                                                                   -->
<!-- ================================================================= -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="2.0">
  
  <xsl:attribute-set name="xmlelement">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$default-monospace-font"/>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <xsl:attribute-set name="xmlatt">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$default-monospace-font"/>
    </xsl:attribute>
  </xsl:attribute-set>
    
</xsl:stylesheet>
