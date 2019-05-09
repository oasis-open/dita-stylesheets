<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 05 Sep 2015 KJE: Added change log.                                -->
<!-- 18 Sep 2015 KJE: Added styling for draft comments and             -->
<!--                  section titles                                   -->
<!-- 05 Oct 2015 KJE: Increased font size for section titles           -->
<!-- 30 Jan 2019 KJE: Changed $default-title-color as required for     -->
<!--                  OASIS rebranding                                 -->
<!-- 06 Mar 2019 KJE: Changed base-font to 10 pt                       -->
<!-- 07 Mar 2019 KJE: Changed serif to sans-serif; moved variable      -->
<!--                  to oasis-cn-basic-settings.xsl file              -->
<!-- 08 May 2019 KJE: Added template for handling monospaced elements  -->
<!--                  and attributes in titles and <dt>                -->
<!--                                                                   -->
<!-- ================================================================= -->  

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:rx="http://www.renderx.com/XSL/Extensions"
                version="2.0">

    <!-- BASIC FONT -->
    <xsl:attribute-set name="__fo__root" use-attribute-sets="base-font">
        <xsl:attribute name="font-family">sans-serif</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <xsl:attribute name="id">fo-root-do-not-change</xsl:attribute>
    </xsl:attribute-set>
   
    <!-- TITLES -->
    
    <xsl:attribute-set name="common.title">
        <xsl:attribute name="border-bottom-style">none</xsl:attribute>
        <xsl:attribute name="color">
            <xsl:value-of select="$default-title-color"/>
        </xsl:attribute>
        <xsl:attribute name="font-family">sans-serif</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- XML ELEMENTS OR ATTRIBUTES IN TITLES -->
      <xsl:attribute-set name="monospace-in-titles">
    <xsl:attribute name="font-style">normal</xsl:attribute>
    <xsl:attribute name="font-family">
      <xsl:choose>
        <xsl:when
          test="ancestor-or-self::*[contains(@class, ' topic/title ') or contains(@class, ' topic/dt ')]">sans-serif</xsl:when>
        <xsl:otherwise>monospace</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:choose>
        <xsl:when test="ancestor::*[contains(@class, ' topic/title ')]">sans-serif</xsl:when>
        <xsl:when
          test="ancestor::*[contains(@class, ' topic/table ') or contains(@class, ' topic/simpletable ')]">
          <xsl:value-of select="$small-monospace-size"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$default-monospace-size"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>
       
    <!-- REMOVE EMPTY PAGES -->  
    <xsl:attribute-set name="__force__page__count">
        <xsl:attribute name="force-page-count">
            <xsl:choose>
                <xsl:when test="/*[contains(@class, ' bookmap/bookmap ')]">
                    <xsl:value-of select="'auto'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'auto'"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:attribute-set>

    <!-- UNRESOLVED CONTENT REFERENCES -->
    <xsl:attribute-set name="__unresolved__conref">
        <xsl:attribute name="color">#CC3333</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- PAGE NUMBERS -->
    <xsl:attribute-set name="page-sequence.toc">
        <xsl:attribute name="format">1</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="page-sequence.frontmatter">
        <xsl:attribute name="format">1</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="page-sequence.lot" use-attribute-sets="page-sequence.toc">
        <xsl:attribute name="format">1</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="page-sequence.lof" use-attribute-sets="page-sequence.toc">
        <xsl:attribute name="format">1</xsl:attribute>
    </xsl:attribute-set>

</xsl:stylesheet>
