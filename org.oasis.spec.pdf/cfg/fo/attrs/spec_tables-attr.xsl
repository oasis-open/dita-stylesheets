<?xml version='1.0' encoding='utf-8'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 02 Mar 2019 KJE: Added change log; changed color for table headers-->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/" 
                xmlns:spdf="org.oasis.spec.pdf"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" 
                xmlns:opentopic="http://www.idiominc.com/opentopic"
                xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
                xmlns:xs="http://www.w3.org/2001/XMLSchema" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                exclude-result-prefixes="xs ditaarch opentopic spdf" 
                version="2.0">

  <!-- SIMPLE TABLES -->
  <xsl:attribute-set name="simpletable">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$small-font-size"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="sthead.stentry">
    <xsl:attribute name="background-color">
      <xsl:value-of select="$tableHeaderCellHighlightBGColor"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="sthead.stentry__keycol-content">
    <xsl:attribute name="background-color">inherit</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="strow.stentry__keycol-content">
    <xsl:attribute name="background-color">white</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
  </xsl:attribute-set>
  
  
  <!-- TABLES -->
  <xsl:attribute-set name="thead.row.entry">
    <xsl:attribute name="background-color">white</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="tbody.row">
    <xsl:attribute name="keep-together.within-page">1</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="common.table.body.entry">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$small-font-size"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="thead.row.entry">
    <xsl:attribute name="background-color">
      <xsl:value-of select="$tableHeaderCellHighlightBGColor"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="table.title">
    <xsl:attribute name="font-family">Sans</xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$small-font-size"/>
    </xsl:attribute>
    <xsl:attribute name="font-style">normal</xsl:attribute>
    <xsl:attribute name="space-after.optimum">10pt</xsl:attribute>
    <xsl:attribute name="space-before.optimum">5pt</xsl:attribute>
  </xsl:attribute-set>
</xsl:stylesheet>
