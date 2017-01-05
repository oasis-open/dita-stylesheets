<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet exclude-result-prefixes="xs ditaarch opentopic spdf" version="2.0"
  xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/" xmlns:spdf="org.oasis.spec.pdf"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:attribute-set name="__frontmatter__owner">
    <xsl:attribute name="font-family">Sans</xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$default-font-size"/>
    </xsl:attribute>
    <xsl:attribute name="font-weight">normal</xsl:attribute>
    <xsl:attribute name="line-height">normal</xsl:attribute>
    <xsl:attribute name="margin-left">5mm</xsl:attribute>
    <xsl:attribute name="margin-top">8mm</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="__frontmatter__owner__container">
    <xsl:attribute name="bottom">20mm</xsl:attribute>
    <xsl:attribute name="left">30mm</xsl:attribute>
    <xsl:attribute name="position">absolute</xsl:attribute>
    <xsl:attribute name="right">15mm</xsl:attribute>
    <xsl:attribute name="top">170mm</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="__frontmatter__subtitle">
    <xsl:attribute name="font-family">Sans</xsl:attribute>
    <xsl:attribute name="font-size">14pt</xsl:attribute>
    <xsl:attribute name="font-weight">normal</xsl:attribute>
    <xsl:attribute name="margin-left">30mm</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="__frontmatter__title">
    <xsl:attribute name="margin-top">35mm</xsl:attribute>
    <xsl:attribute name="color">
      <xsl:value-of select="$cover-heading-color"/>
    </xsl:attribute>
    <xsl:attribute name="font-family">Arial</xsl:attribute>
    <xsl:attribute name="font-size">20pt</xsl:attribute>
    <xsl:attribute name="font-weight">normal</xsl:attribute>
    <xsl:attribute name="line-height">120%</xsl:attribute>
    <xsl:attribute name="margin-left">5mm</xsl:attribute>
    <xsl:attribute name="padding-bottom">0pt</xsl:attribute>
    <xsl:attribute name="padding-top">14pt</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
  </xsl:attribute-set>
</xsl:stylesheet>
