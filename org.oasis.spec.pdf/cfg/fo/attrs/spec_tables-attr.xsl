<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet exclude-result-prefixes="xs ditaarch opentopic spdf" version="2.0"
  xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/" xmlns:spdf="org.oasis.spec.pdf"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">



  <xsl:attribute-set name="thead.row.entry">
    <xsl:attribute name="background-color">white</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="sthead.stentry__keycol-content">
    <xsl:attribute name="background-color">white</xsl:attribute>
    <xsl:attribute name="end-indent">3pt</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="space-after">3pt</xsl:attribute>
    <xsl:attribute name="space-after.conditionality">retain</xsl:attribute>
    <xsl:attribute name="space-before">3pt</xsl:attribute>
    <xsl:attribute name="space-before.conditionality">retain</xsl:attribute>
    <xsl:attribute name="start-indent">3pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="strow.stentry__keycol-content">
    <xsl:attribute name="background-color">white</xsl:attribute>
    <xsl:attribute name="end-indent">3pt</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="space-after">3pt</xsl:attribute>
    <xsl:attribute name="space-after.conditionality">retain</xsl:attribute>
    <xsl:attribute name="space-before">3pt</xsl:attribute>
    <xsl:attribute name="space-before.conditionality">retain</xsl:attribute>
    <xsl:attribute name="start-indent">3pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="property.entry__keycol-content">
    <xsl:attribute name="margin">3pt 3pt 3pt 3pt</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="background-color">white</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="strow.stentry"> </xsl:attribute-set>

</xsl:stylesheet>
