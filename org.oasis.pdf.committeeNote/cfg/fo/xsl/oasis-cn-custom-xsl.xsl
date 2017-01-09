<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema" 
                xmlns:fo="http://www.w3.org/1999/XSL/Format" 
                xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function" version="2.0">

  <!-- ===================== CHANGE LOG ================================ -->
  <!--                                                                   -->
  <!-- 5 Sept 2015: Eberlein, added change log. Added import statement   -->
  <!--              for layout-masters.xsl.                              -->
  <!-- 7 Sept 2015: Thomas, added import statement for oasis-cn-numbering.xsl  -->
  <!--                                                                   -->
  <!-- ================================================================= --> 
               
 <!-- IMPORT OVERRIDES TO DITA-OT XSL FILES -->
 <xsl:import href="oasis-cn-commons.xsl"/>
 <xsl:import href="oasis-cn-front-matter.xsl"/>
 <xsl:import href="oasis-cn-layout-masters.xsl"/>
 <xsl:import href="oasis-cn-static-content.xsl"/>
 <xsl:import href="oasis-cn-tables.xsl"/>
 <xsl:import href="oasis-cn-toc.xsl"/>
 
 <!-- IMPORT CUSTOM OASIS XSL FILES -->
 <xsl:import href="oasis-cn-cover-notices-xsl.xsl"/>
 <xsl:import href="oasis-cn-footers-xsl.xsl"/>
 <xsl:import href="oasis-cn-numbering.xsl"/>        
  
</xsl:stylesheet>

