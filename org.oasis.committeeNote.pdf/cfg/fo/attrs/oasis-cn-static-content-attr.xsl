<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 05 Sep 2015 KJE: Added change log.                                -->
<!-- 03 Mar 2015 ARH: Modifications to accommodate OASIS rebranding:   -->
<!--                  Changes to footer margins; default header        -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="2.0">
  
  <!-- MISCELLANEOUS -->
  <xsl:attribute-set name="pagenum">
    <xsl:attribute name="font-weight">bold</xsl:attribute>
  </xsl:attribute-set>
  
  <!-- FOOTERS -->
  
  <xsl:attribute-set name="default_footer">
    <xsl:attribute name="font-size">9pt</xsl:attribute>
    <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
    <xsl:attribute name="margin-left">-1.5in</xsl:attribute>
    <xsl:attribute name="margin-right">-1.5in</xsl:attribute>
    <xsl:attribute name="padding-top">0pt</xsl:attribute>
  </xsl:attribute-set>
  
  <xsl:attribute-set name="odd__footer">
    <xsl:attribute name="text-align">end</xsl:attribute>
    <xsl:attribute name="end-indent">10pt</xsl:attribute>
    <xsl:attribute name="space-after">10pt</xsl:attribute>
    <xsl:attribute name="space-after.conditionality">retain</xsl:attribute>
  </xsl:attribute-set>
  
  <xsl:attribute-set name="even__footer">
    <xsl:attribute name="start-indent">10pt</xsl:attribute>
    <xsl:attribute name="space-after">10pt</xsl:attribute>
    <xsl:attribute name="space-after.conditionality">retain</xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Footers: Body -->
  <xsl:attribute-set name="__body__odd__footer" use-attribute-sets="odd__footer">
  </xsl:attribute-set>
  
  <xsl:attribute-set name="__body__odd__footer__heading">
  </xsl:attribute-set>
  
  <xsl:attribute-set name="__body__odd__footer__pagenum" use-attribute-sets="pagenum">
  </xsl:attribute-set>
  
  <xsl:attribute-set name="__body__even__footer" use-attribute-sets="even__footer">
  </xsl:attribute-set>
  
  <xsl:attribute-set name="__body__even__footer__heading">
  </xsl:attribute-set>
  
  <xsl:attribute-set name="__body__even__footer__pagenum" use-attribute-sets="pagenum">
  </xsl:attribute-set>
  
  <!-- Footers: Body first -->
  <xsl:attribute-set name="__body__first__footer" use-attribute-sets="odd__footer">
  </xsl:attribute-set>
  
  <xsl:attribute-set name="__body__first__footer__heading">
  </xsl:attribute-set>
  
  <xsl:attribute-set name="__body__first__footer__pagenum" use-attribute-sets="pagenum">
  </xsl:attribute-set>
  
  <!-- Footers: Body last -->
  <xsl:attribute-set name="__body__last__footer">
  </xsl:attribute-set>
  
  <!-- Footers: TOC -->
  <xsl:attribute-set name="__toc__odd__footer" use-attribute-sets="odd__footer">
  </xsl:attribute-set>
  
  <xsl:attribute-set name="__toc__odd__footer__pagenum" use-attribute-sets="pagenum">
  </xsl:attribute-set>
  
  <xsl:attribute-set name="__toc__even__footer" use-attribute-sets="even__footer">
  </xsl:attribute-set>
  
  <xsl:attribute-set name="__toc__even__footer__pagenum" use-attribute-sets="pagenum">
  </xsl:attribute-set>
  
  <!-- Footers: Index -->
  <xsl:attribute-set name="__index__odd__footer" use-attribute-sets="odd__footer">
  </xsl:attribute-set>
  
  <xsl:attribute-set name="__index__odd__footer__pagenum" use-attribute-sets="pagenum">
  </xsl:attribute-set>
  
  <xsl:attribute-set name="__index__even__footer" use-attribute-sets="even__footer">
  </xsl:attribute-set>
  
  <xsl:attribute-set name="__index__even__footer__pagenum" use-attribute-sets="pagenum">
  </xsl:attribute-set>
  
  <!-- Footers: Glossary -->
  <xsl:attribute-set name="__glossary__odd__footer" use-attribute-sets="odd__footer">
  </xsl:attribute-set>
  
  <xsl:attribute-set name="__glossary__odd__footer__pagenum" use-attribute-sets="pagenum">
  </xsl:attribute-set>
  
  <xsl:attribute-set name="__glossary__even__footer" use-attribute-sets="even__footer">
  </xsl:attribute-set>
  
  <xsl:attribute-set name="__glossary__even__footer__pagenum" use-attribute-sets="pagenum">
  </xsl:attribute-set>
  
  <!-- HEADERS -->
  
  <!-- Header rule appears on every page except cover -->

  <xsl:attribute-set name="default_header">
    <xsl:attribute name="font-size">9pt</xsl:attribute>
    <!--<xsl:attribute name="margin-top">30pt</xsl:attribute>-->
    <xsl:attribute name="margin-top">1in</xsl:attribute>
    <xsl:attribute name="text-align">center</xsl:attribute>
    <xsl:attribute name="border-top-color">#000000</xsl:attribute>
    <xsl:attribute name="border-top-style">solid</xsl:attribute>
    <xsl:attribute name="border-top-width">1px</xsl:attribute>
    <xsl:attribute name="margin-left">1in</xsl:attribute>
    <xsl:attribute name="margin-right">1in</xsl:attribute>
  </xsl:attribute-set>

</xsl:stylesheet>