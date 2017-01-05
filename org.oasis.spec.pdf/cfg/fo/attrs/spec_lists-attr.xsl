<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet exclude-result-prefixes="xs ditaarch opentopic spdf" version="2.0"
  xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/" xmlns:spdf="org.oasis.spec.pdf"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!--Unordered list-->
  <xsl:attribute-set name="ul" use-attribute-sets="common.block">
    <xsl:attribute name="provisional-distance-between-starts">3mm</xsl:attribute>
    <xsl:attribute name="provisional-label-separation">1mm</xsl:attribute>
    <xsl:attribute name="space-after.optimum">6pt</xsl:attribute>
    <xsl:attribute name="space-before.optimum">6pt</xsl:attribute>
    <xsl:attribute name="keep-with-previous.within-column">always</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="ul.li">
    <xsl:attribute name="space-after.optimum">6pt</xsl:attribute>
    <xsl:attribute name="space-before.optimum">6pt</xsl:attribute>
  </xsl:attribute-set>

  <!--Ordered list-->
  <xsl:attribute-set name="ol" use-attribute-sets="common.block">
    <xsl:attribute name="provisional-distance-between-starts">7mm</xsl:attribute>
    <xsl:attribute name="provisional-label-separation">2mm</xsl:attribute>
    <xsl:attribute name="space-after.optimum">6pt</xsl:attribute>
    <xsl:attribute name="space-before.optimum">6pt</xsl:attribute>
    <xsl:attribute name="keep-with-previous.within-column">always</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="ol.li">
    <xsl:attribute name="space-after.optimum">6pt</xsl:attribute>
    <xsl:attribute name="space-before.optimum">6pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="ol.li__label__content">
    <xsl:attribute name="text-align">right</xsl:attribute>
    <xsl:attribute name="font-weight">normal</xsl:attribute>
  </xsl:attribute-set>

</xsl:stylesheet>
