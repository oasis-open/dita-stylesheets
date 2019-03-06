<?xml version="1.0"?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 05 Sep 2015 KJE: Added change log.                                -->
<!-- 10 Sep 2015 KJE: Added override for @keycol                       -->
<!-- 21 Sep 2015 KJE: Added override for @keycol in header row         -->
<!-- 08 Oct 2015  BT: Added strow.stentry override                     -->
<!-- 01 Feb 2019 KJE: Changed color for table headers                  -->
<!-- 06 Mar 2019 KJE: Changed font size for simple table cells         -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:fo="http://www.w3.org/1999/XSL/Format" 
                version="2.0">
   
  <!-- VARIABLES -->
  <xsl:variable name="default-table-header-color">#edf1f8</xsl:variable>
  <xsl:variable name="default-table-font-size">9pt</xsl:variable>
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
    <xsl:attribute name="font-size">
      <xsl:value-of select="$default-table-font-size"/>
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
    <xsl:attribute name="font-size">
      <xsl:value-of select="$default-table-font-size"/>
    </xsl:attribute>
  </xsl:attribute-set>
  
</xsl:stylesheet>