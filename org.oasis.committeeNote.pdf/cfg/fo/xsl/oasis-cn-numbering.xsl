<?xml version='1.0' encoding='ASCII'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 07 Sep 2015 Thomas: Created file.                                 -->
<!-- 31 Jan 2016 KJE: Replaced call to deprecated template             -->
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
  
  <!-- This stylesheet overrides the plugin:org.dita.pdf2:/xsl/fo/commons.xsl getTitle template.
       It was placed in its own file so that this override would be reusable across multiple
       customizations. Thomas, 07sep15 -->

  <!--title numbering-->
  <xsl:variable name="oa:number-levels"
    select="
      (
      true(),
      true(),
      true(),
      true(),
      true(),
      true()
      )"/>

  <!-- Oasis: Apply topic number prefixes to titles on levels 1 through n, where
    n is the size of variable oa:number-levels. -->
  <xsl:template match="*" mode="getTitle">
    <xsl:variable name="topic" select="ancestor-or-self::*[contains(@class, ' topic/topic ')][1]"/>
    <xsl:variable name="id" select="$topic/@id"/>
    <xsl:variable name="mapTopics" select="key('map-id', $id)"/>
    <!--<xsl:if test="not(..[contains(@class, ' topic/section ')])">-->
    <xsl:if test="..[contains(@class, ' topic/topic ')] and not(..[contains(@class, ' glossentry/glossentry ')])">
      <fo:inline>
        <xsl:for-each select="$mapTopics[1]">
          <xsl:variable name="depth"
            select="count(ancestor-or-self::*[contains(@class, ' map/topicref')])"/>
          <xsl:choose>
            <xsl:when test="parent::opentopic:map and contains(@class, ' bookmap/bookmap ')"/>
            <xsl:when
              test="ancestor-or-self::*[contains(@class, ' bookmap/frontmatter ') or contains(@class, ' bookmap/backmatter ')]"/>
            <xsl:when
              test="ancestor-or-self::*[contains(@class, ' bookmap/appendix ')] and $oa:number-levels[$depth]">
              <!-- Insert the "Appendix" autogen label as a prefix to the title -->
              <xsl:call-template name="getVariable">
                <xsl:with-param name="id" select="'Table of Contents Appendix'"/>
              </xsl:call-template>
              <xsl:number
                count="*[contains(@class, ' map/topicref ')][ancestor-or-self::*[contains(@class, ' bookmap/appendix ')]]"
                format="A.1.1" level="multiple"/>
            </xsl:when>
            <xsl:when test="$oa:number-levels[$depth]">
              <xsl:number
                count="*[contains(@class, ' map/topicref ')][not(ancestor-or-self::*[contains(@class, ' bookmap/frontmatter ')])]"
                format="1.1" level="multiple"/>
            </xsl:when>
          </xsl:choose>
        </xsl:for-each>
      </fo:inline>
    </xsl:if>
    <xsl:text> </xsl:text>
    <xsl:apply-templates/>
  </xsl:template>

</xsl:stylesheet>
