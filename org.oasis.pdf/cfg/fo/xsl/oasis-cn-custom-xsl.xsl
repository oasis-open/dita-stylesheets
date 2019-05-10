<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 05 Sep 2015 KJE: Added change log. Added import statement for     -->
<!--                  layout-masters.xsl.                              -->
<!-- 07 Sep 2015  BT: Added import statement for                       -->
<!--                  oasis-cn-numbering.xsl                           -->
<!--  15 Aug 2015 KJE: Commented out import statements, which were     -->
<!--                   moved to style sheet shell.                     -->
<!--  10 May 2019 KJE: Added template for RFC-2119 term                -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema" 
                xmlns:fo="http://www.w3.org/1999/XSL/Format" 
                xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function" 
                version="2.0">
               
    <xsl:template match="*[contains(@class,' topic/term ')][@outputclass = 'RFC-2119']">
       <fo:inline xsl:use-attribute-sets="RFC-2119">
        <xsl:call-template name="commonattributes"/>
        <xsl:apply-templates/>
       </fo:inline>
    </xsl:template>    
  
</xsl:stylesheet>

