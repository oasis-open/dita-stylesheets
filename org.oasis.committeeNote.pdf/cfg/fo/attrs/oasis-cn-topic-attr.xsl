<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 15 Aug 2015 KJE: Initial creation. Moved content from override    -->
<!--                  of commons-attr.xsl.                             -->
<!-- 03 Mar 2019 ARH: Changes to accommodate OASIS rebranding: Removal -->
<!--                  of horizontal-rule attribute set; correction to  -->
<!--                  padding                                          -->
<!-- 09 Mar 2919 KJE: Update font size for topic.topic.topic.title     -->
<!--                  to match OASIS 2019 rebranding                   -->
<!-- 09 Mar 2919 KJE: Remove bold highlighting from topic titles       -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:rx="http://www.renderx.com/XSL/Extensions"
                version="2.0">

    <!-- Set font, spacing for topic titles -->
    <!-- Set padding to zero so titles start at true top-of-page -->

    <xsl:attribute-set name="topic.title" use-attribute-sets="common.title">
        <xsl:attribute name="border-after-width">3pt</xsl:attribute>
        <xsl:attribute name="font-size">18pt</xsl:attribute>     
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="padding-top">0</xsl:attribute>
        <xsl:attribute name="space-after">14pt</xsl:attribute>
        <xsl:attribute name="space-before">0pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="topic.topic.title" use-attribute-sets="common.title">
        <xsl:attribute name="font-size">14pt</xsl:attribute>      
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="padding-top">0</xsl:attribute>        
        <xsl:attribute name="space-before">12pt</xsl:attribute>
        <xsl:attribute name="space-after">2pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="topic.topic.topic.title" use-attribute-sets="common.title">       
        <xsl:attribute name="font-size">13pt</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="space-after">2pt</xsl:attribute>
        <xsl:attribute name="space-before">10pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="section.title" use-attribute-sets="common.title">
        <xsl:attribute name="font-size">13pt</xsl:attribute>
        <xsl:attribute name="font-style">italic</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="space-before">15pt</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- DRAFT COMMENTS -->
    <xsl:attribute-set name="draft-comment" use-attribute-sets="common.border">
        <xsl:attribute name="background-color">#E6E6F6</xsl:attribute>
        <xsl:attribute name="color">black</xsl:attribute>
        <xsl:attribute name="padding">5pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="draft-comment__label">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>

</xsl:stylesheet>
