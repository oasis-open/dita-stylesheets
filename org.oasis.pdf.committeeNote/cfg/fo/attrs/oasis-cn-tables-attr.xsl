<?xml version="1.0"?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">
  
  <!-- ===================== CHANGE LOG ================================ -->
  <!--                                                                   -->
  <!-- 5 Sept 2015: Eberlein, added change log.                          -->
  <!-- 10 Sept 2015: Eberlein, added override for @keycol                -->
  <!-- 21 Sept 2015: Eberlein, added override for @keycol in header row  -->
  <!-- 8 Oct 2015: Thomas, added strow.stentry override                  -->
  <!--                                                                   -->
  <!-- ================================================================= --> 
  
  <!-- VARIABLES -->
  <xsl:variable name="default-table-header-color">#f5f4ee</xsl:variable>
  
  <!-- DEFINITION LISTS -->
  <xsl:attribute-set name="dl"/>
  
  <xsl:attribute-set name="dlentry.dt__content">
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="keep-with-next">always</xsl:attribute>
  </xsl:attribute-set>
  
  <xsl:attribute-set name="dlentry.dd__content">
    <xsl:attribute name="start-indent">from-parent(start-indent) + 5mm</xsl:attribute>
  </xsl:attribute-set>
  
  <!-- SIMPLE TABLES -->

  <xsl:attribute-set name="sthead.stentry">
    <xsl:attribute name="background-color">
      <xsl:value-of select="$default-table-header-color"/>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <xsl:attribute-set name="sthead.stentry__keycol-content" use-attribute-sets="common.table.body.entry common.table.head.entry">
    <xsl:attribute name="background-color">
      <xsl:value-of select="$default-table-header-color"/>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <xsl:attribute-set name="strow.stentry__keycol-content" use-attribute-sets="common.table.body.entry common.table.head.entry">
    <xsl:attribute name="background-color">white</xsl:attribute>
  </xsl:attribute-set>
  
  <!-- This override ensures that a top-border is output whenever a page break occurs
       within a strow element. -->
  <xsl:attribute-set name="strow.stentry">
    <xsl:attribute name="border-before-color">black</xsl:attribute>
    <xsl:attribute name="border-before-style">solid</xsl:attribute>
    <xsl:attribute name="border-before-width">1pt</xsl:attribute>
    <xsl:attribute name="border-before-width.conditionality">retain</xsl:attribute>
  </xsl:attribute-set>
  
</xsl:stylesheet>