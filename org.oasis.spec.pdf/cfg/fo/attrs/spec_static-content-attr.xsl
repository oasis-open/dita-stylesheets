<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

  <xsl:attribute-set name="footer__block">
    <xsl:attribute name="margin-left">
      <xsl:value-of select="$page-margins"/>
    </xsl:attribute>
    <xsl:attribute name="margin-right">
      <xsl:value-of select="$page-margins"/>
    </xsl:attribute>
    <xsl:attribute name="margin-bottom">4mm</xsl:attribute>
  </xsl:attribute-set>

  <!-- Footer table attribute sets -->
  <xsl:attribute-set name="common__footer">
    <xsl:attribute name="font-size">8pt</xsl:attribute>
    <xsl:attribute name="margin-left">
      <xsl:value-of select="concat('-', $page-margins)"/>
    </xsl:attribute>
    <xsl:attribute name="margin-right">
      <xsl:value-of select="concat('-', $page-margins)"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="inside__footer__column">
    <xsl:attribute name="column-width">proportional-column-width(3.0)</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="center__footer__column">
    <xsl:attribute name="column-width">proportional-column-width(0.7)</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="outside__footer__column">
    <xsl:attribute name="column-width">proportional-column-width(3.0)</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="footer__cell">
    <xsl:attribute name="display-align">center</xsl:attribute>
  </xsl:attribute-set>
  
  <xsl:attribute-set name="pagenum">
    <xsl:attribute name="font-style">italic</xsl:attribute>
    <xsl:attribute name="font-weight">normal</xsl:attribute>
    <xsl:attribute name="font-size">8pt</xsl:attribute>
  </xsl:attribute-set>

</xsl:stylesheet>
