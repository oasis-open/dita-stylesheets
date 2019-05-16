<?xml version="1.0"?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 05 Sep 2015 KJE: Added change log.                                -->
<!-- 10 Sep 2015 KJE: Added override for @keycol                       -->
<!-- 21 Sep 2015 KJE: Added override for @keycol in header row         -->
<!-- 08 Oct 2015  BT: Added strow.stentry override                     -->
<!-- 01 Feb 2019 KJE: Changed color for table headers                  -->
<!-- 06 Mar 2019 KJE: Changed font size for simple table cells         -->
<!-- 07 Mar 2019 KJE: Moved variables to oasis-cn-basic-settings.xsl   -->
<!-- 10 May 2019 KJE: Set margin-left for <dd> to 20pt                 -->
<!-- 15 May 2019 KJE: Added attribute sets for CALS tables             -->
<!-- 16 May 2019 KJE: Replaced definition list attribute sets with     -->
<!--                  those from old spec PDF plug-in                  -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

  <!-- DEFINITION LISTS -->

  <xsl:attribute-set name="dt__block">
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="keep-with-next">always</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="dd__block">
    <xsl:attribute name="margin-left">20pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="dl__as__list">
    <xsl:attribute name="space-after.optimum">6pt</xsl:attribute>
    <xsl:attribute name="space-before.optimum">6pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="dlentry__as__listitem">
    <xsl:attribute name="space-after.optimum">6pt</xsl:attribute>
    <xsl:attribute name="space-before.optimum">6pt</xsl:attribute>
  </xsl:attribute-set>

  <!-- CALS TABLES -->

  <xsl:attribute-set name="table.title" use-attribute-sets="base-font common.title">
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="padding-top">5pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="thead.row.entry">
    <xsl:attribute name="background-color">
      <xsl:value-of select="$default-table-header-color"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="thead.row.entry__content"
    use-attribute-sets="common.table.body.entry common.table.head.entry">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$default-table-font-size"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="tbody.row.entry__content" use-attribute-sets="common.table.body.entry">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$default-table-font-size"/>
    </xsl:attribute>
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

  <xsl:attribute-set name="sthead.stentry__keycol-content"
    use-attribute-sets="common.table.body.entry common.table.head.entry">
    <xsl:attribute name="background-color">
      <xsl:value-of select="$default-table-header-color"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="strow.stentry__keycol-content"
    use-attribute-sets="common.table.body.entry common.table.head.entry">
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
