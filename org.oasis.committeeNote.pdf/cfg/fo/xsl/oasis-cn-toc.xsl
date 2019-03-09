<?xml version='1.0' encoding='ASCII'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 07 Sep 2015  BT: Iinitial draft which includes overrides to       -->
<!--                      suppress auto-generated label.               -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet exclude-result-prefixes="ditaarch opentopic oa" 
                version="2.0"
                xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
                xmlns:oa="org.oasis.specification.fo" 
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:opentopic="http://www.idiominc.com/opentopic"
                xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
                xmlns:xs="http://www.w3.org/2001/XMLSchema" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template
    match="
      *[contains(@class, ' bookmap/chapter ')] |
      *[contains(@class, ' bookmap/bookmap ')]/opentopic:map/*[contains(@class, ' map/topicref ')]"
    mode="tocPrefix" priority="-1">
  </xsl:template>

  <xsl:template match="*[contains(@class, ' bookmap/appendix ')]" mode="tocPrefix">
  </xsl:template>
  
</xsl:stylesheet>
