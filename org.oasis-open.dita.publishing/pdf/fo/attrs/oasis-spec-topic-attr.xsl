<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 08 May 2019 KJE: Initial creation.                                -->
<!-- 18 May 2019 KJE: Added fig.title attribute set                    -->
<!-- 23 Sep 2020 KJE: Added attribute sets for RFC items               -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:rx="http://www.renderx.com/XSL/Extensions"
                version="2.0">

    <!-- TITLES -->
    <xsl:attribute-set name="topic.title" use-attribute-sets="common.title">  
          <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="topic.topic.title" use-attribute-sets="common.title">
         <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="topic.topic.topic.title" use-attribute-sets="common.title">  
          <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="topic.topic.topic.topic.title" use-attribute-sets="common.title"> 
          <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="topic.topic.topic.topic.topic.title" use-attribute-sets="common.title">   
          <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="topic.topic.topic.topic.topic.topic.title" use-attribute-sets="common.title">
          <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
      
    <xsl:attribute-set name="fig.title" use-attribute-sets="base-font common.title">
        <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>  
      
    <xsl:attribute-set name="section.title" use-attribute-sets="common.title">
        <xsl:attribute name="font-size">11.5pt</xsl:attribute>
        <xsl:attribute name="font-style">normal</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
     <!-- RFC-2119 TERMS -->
    <xsl:attribute-set name="RFC-2119">
        <xsl:attribute name="font-style">normal</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="RFC-2119-statement" use-attribute-sets="common.block">
        <xsl:attribute name="border-left">2pt solid #446CAA</xsl:attribute>
        <xsl:attribute name="border-right">2pt solid #446CAA</xsl:attribute>
        <xsl:attribute name="padding-left">5pt</xsl:attribute>
        <xsl:attribute name="padding-right">5pt</xsl:attribute>
    </xsl:attribute-set>
</xsl:stylesheet>
