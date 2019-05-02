<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 05 Sep 2015 KJE: Added change log.                                -->
<!-- 03 Mar 2015 ARH: Modifications to accommodate OASIS rebranding:   -->
<!--                  Changes to footer margins; default header        -->
<!-- 09 Mar 2019 KJE: Removed unused attribute sets                    -->
<!-- 14 Mar 2019 KJE: Commented out contents of "default_header"       -->
<!-- 02 May 2019 KJE: Changed footer font size to 8 pt                 -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="2.0">
  
  <!-- FOOTER -->
  <!-- Footer appears on every page, including cover -->
  
  <xsl:attribute-set name="default_footer">
    <xsl:attribute name="font-size">8pt</xsl:attribute>
    <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
    <xsl:attribute name="margin-left">-1.5in</xsl:attribute>
    <xsl:attribute name="margin-right">-1.5in</xsl:attribute>
    <xsl:attribute name="padding-top">0pt</xsl:attribute>
  </xsl:attribute-set>
  
  <!-- HEADER -->  
  <!-- Header rule appears on every page except cover -->

  <xsl:attribute-set name="default_header">   
    <!--<xsl:attribute name="border-top-color">#000000</xsl:attribute>
    <xsl:attribute name="border-top-style">solid</xsl:attribute>
    <xsl:attribute name="border-top-width">1px</xsl:attribute>
    <xsl:attribute name="font-size">9pt</xsl:attribute>   
    <xsl:attribute name="margin-left">1in</xsl:attribute>
    <xsl:attribute name="margin-right">1in</xsl:attribute>
    <xsl:attribute name="margin-top">1in</xsl:attribute>
    <xsl:attribute name="text-align">center</xsl:attribute>-->
  </xsl:attribute-set>

</xsl:stylesheet>