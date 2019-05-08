<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 08 May 2019 KJE: Initial creation.                                -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:rx="http://www.renderx.com/XSL/Extensions"
                version="2.0">

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
</xsl:stylesheet>
