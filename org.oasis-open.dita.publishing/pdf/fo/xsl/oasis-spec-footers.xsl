<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 08 May 2019 KJE: Original creation                                -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema" 
                xmlns:fo="http://www.w3.org/1999/XSL/Format" 
                xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function" 
                version="2.0">
 
 <!-- Variable: Work product information -->  
 <xsl:variable name="ditaproduct">
  <xsl:call-template name="getVariable">
   <xsl:with-param name="id" select="'Standards track'" />
  </xsl:call-template>
 </xsl:variable>

</xsl:stylesheet>

