<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 06 Sep 2021 KJE: Initial creation                                 -->
<!--                                                                   -->
<!-- ================================================================= -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">
  
    <xsl:attribute-set name="choicetable" use-attribute-sets="base-font">
        <!--It is a table container -->
        <xsl:attribute name="width">100%</xsl:attribute>
        <xsl:attribute name="space-after">10pt</xsl:attribute>
        <xsl:attribute name="space-before">10pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="chhead.choptionhd__content" use-attribute-sets="common.table.body.entry common.table.head.entry">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$default-table-font-size"/>
    </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="chhead.chdeschd__content" use-attribute-sets="common.table.body.entry common.table.head.entry">
     <xsl:attribute name="font-size">
      <xsl:value-of select="$default-table-font-size"/>
    </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="chrow.choption__keycol-content" use-attribute-sets="common.table.body.entry common.table.head.entry">
     <xsl:attribute name="font-size">
      <xsl:value-of select="$default-table-font-size"/>
    </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="chrow.choption__content" use-attribute-sets="common.table.body.entry">
     <xsl:attribute name="font-size">
      <xsl:value-of select="$default-table-font-size"/>
    </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="chrow.chdesc__keycol-content" use-attribute-sets="common.table.body.entry common.table.head.entry">
     <xsl:attribute name="font-size">
      <xsl:value-of select="$default-table-font-size"/>
    </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="chrow.chdesc__content" use-attribute-sets="common.table.body.entry">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$default-table-font-size"/>
    </xsl:attribute>
    </xsl:attribute-set>

</xsl:stylesheet>