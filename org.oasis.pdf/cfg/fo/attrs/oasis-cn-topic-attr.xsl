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
<!-- 09 Mar 2919 KJE: Remove bold highlighting from topic titles;      -->
<!--                  add line above to topic.title and restore        -->
<!--                  padding                                          -->
<!--08 May 2919 KJE: Changed section title to bold 11.5 pt; added      -->
<!--                 attribute sets for H4-H6                          -->
<!--10 May 2019 KJE: Added attribute set for RFC-2119 term             -->
<!--15 May 2019 KJE: Removed padding from example; added attribute     -->
<!--                 set for note                                      -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" 
    xmlns:rx="http://www.renderx.com/XSL/Extensions"
    version="2.0">

    <!-- TITLES -->
    <xsl:attribute-set name="topic.title" use-attribute-sets="common.title">
        <xsl:attribute name="border-after-width">3pt</xsl:attribute>
        <xsl:attribute name="border-top-color">#000000</xsl:attribute>
        <xsl:attribute name="border-top-style">solid</xsl:attribute>
        <xsl:attribute name="border-top-width">1px</xsl:attribute>
        <xsl:attribute name="font-size">18pt</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="padding-top">16.8pt</xsl:attribute>
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

    <xsl:attribute-set name="topic.topic.topic.topic.title" use-attribute-sets="common.title">
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="space-after">2pt</xsl:attribute>
        <xsl:attribute name="space-before">10pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="topic.topic.topic.topic.topic.title" use-attribute-sets="common.title">
        <xsl:attribute name="font-size">11pt</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="space-after">2pt</xsl:attribute>
        <xsl:attribute name="space-before">10pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="topic.topic.topic.topic.topic.topic.title"
        use-attribute-sets="common.title">
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="space-after">2pt</xsl:attribute>
        <xsl:attribute name="space-before">10pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="section.title" use-attribute-sets="common.title">
        <xsl:attribute name="font-size">11.5pt</xsl:attribute>
        <!--<xsl:attribute name="font-style">italic</xsl:attribute>-->
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

    <!-- EXAMPLES -->
    <xsl:attribute-set name="example.title" use-attribute-sets="section.title"/>

    <xsl:attribute-set name="example">
        <xsl:attribute name="border-bottom-style">none</xsl:attribute>
        <xsl:attribute name="border-left-style">none</xsl:attribute>
        <xsl:attribute name="border-right-style">none</xsl:attribute>
        <xsl:attribute name="border-top-style">none</xsl:attribute>
        <xsl:attribute name="color">inherit</xsl:attribute>
        <xsl:attribute name="font-family">sans-serif</xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$default-font-size"/>
        </xsl:attribute>
        <xsl:attribute name="line-height">
            <xsl:value-of select="$default-line-height"/>
        </xsl:attribute>
        <xsl:attribute name="margin-left">0pt</xsl:attribute>
        <xsl:attribute name="margin-right">0pt</xsl:attribute>
        <xsl:attribute name="space-before">0em</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- NOTES -->   
    <xsl:attribute-set name="note__table">
        <xsl:attribute name="margin-left">20pt</xsl:attribute>
    </xsl:attribute-set>

    <!-- RFC-2119 TERM -->
    <xsl:attribute-set name="RFC-2119">
        <xsl:attribute name="font-style">normal</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>

</xsl:stylesheet>
