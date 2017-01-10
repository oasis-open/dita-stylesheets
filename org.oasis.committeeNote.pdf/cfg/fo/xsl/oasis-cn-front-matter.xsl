<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    exclude-result-prefixes="opentopic"
    version="2.0">

  <!-- ===================== CHANGE LOG ================================ -->
  <!--                                                                   -->
  <!-- 5 Sept 2015: Kimber, modified to generate sidebar on cover.       -->
  <!-- 5 Sept 2015: Eberlein, reworked code to generate OASIS styling.   -->
  <!--              Moved formatting to attribute sets. Moved text to    -->
  <!--              en.xml file.                                         -->
  <!-- 31 Jan 2016 KJE: Replaced call to deprecated template             -->
  <!--                                                                   -->
  <!-- ================================================================= -->
  
  <xsl:template name="createFrontMatter">    
    <fo:page-sequence master-reference="front-matter" format="1"
      xsl:use-attribute-sets="__force__page__count">
      <xsl:call-template name="insertFrontMatterStaticContents"/>
      <xsl:comment>====== Cover ======</xsl:comment> 
      <xsl:comment>====== Left flow ======</xsl:comment>
      <fo:static-content flow-name="xsl-region-start">     
        <fo:block-container xsl:use-attribute-sets="cover-sidebar">
          <fo:block xsl:use-attribute-sets="cover-sidebar-text">
            <fo:inline>
              <xsl:call-template name="getVariable">
                <xsl:with-param name="id" select="'Statement 1'" />
              </xsl:call-template>
            </fo:inline>
            <xsl:text> </xsl:text>
            <fo:inline>
              <xsl:call-template name="getVariable">
                <xsl:with-param name="id" select="'Statement 2'" />
              </xsl:call-template>
            </fo:inline>
          </fo:block>
        </fo:block-container>
      </fo:static-content>
      <xsl:comment>====== Right flow ======</xsl:comment>
      <fo:flow flow-name="xsl-region-body">
        <fo:block>          
          <fo:block>
            <fo:external-graphic content-width="5cm">
              <xsl:attribute name="src">
                <xsl:call-template name="getVariable">
                  <xsl:with-param name="id">logo Image Path</xsl:with-param>
                </xsl:call-template>
              </xsl:attribute>
            </fo:external-graphic>
          </fo:block>
          
          <!-- Document title-->
          
          <fo:block xsl:use-attribute-sets="main-document-title">
            <xsl:value-of select="$hwDocumentTitle"/>
          </fo:block>
          
          <!-- Status -->
          
          <fo:block xsl:use-attribute-sets="oasis-h2">
            <fo:block>
              <xsl:value-of select="$specSubtitle1"/>
            </fo:block>
            <xsl:if test="not(normalize-space($specSubtitle2) = '')">
              <fo:block>
                <xsl:value-of select="$specSubtitle2"/>
              </fo:block>
            </xsl:if>
          </fo:block>
          
          <!-- Approval date -->
          <fo:block xsl:use-attribute-sets="oasis-h2">
            <xsl:value-of
              select="
              /*[contains(@class, ' bookmap/bookmap ')]/*
              /*[contains(@class, ' bookmap/booktitle ')]
              /*[contains(@class, ' bookmap/booktitlealt ')][@outputclass = 'specificationApproved']"
            />
          </fo:block>
          
          <!-- Process the cover topic. -->
          <fo:block>
            <xsl:apply-templates
              select="/*[contains(@class, ' bookmap/bookmap ')]/*[contains(@class, ' topic/topic ')][@outputclass = 'cover']"
              mode="cover"/>
          </fo:block>
          <!-- Process the notices topic. -->
          <fo:block padding-top="10pt">
            <xsl:apply-templates
              select="/*[contains(@class, ' bookmap/bookmap ')]/*[contains(@class, ' topic/topic ')][@outputclass = 'frontmatternotices']"
              mode="notices"/>
          </fo:block>
        </fo:block>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>
  
  <xsl:template name="insertChapterFirstpageStaticContent">
    <!-- Avoid the default large "Chapter [newline] #" style heading at the
         top of chapters and appendices. Only save the portion that creates
         anchors for link targets. -->
    <xsl:param name="type"/>
    <fo:block>
      <xsl:attribute name="id">
        <xsl:value-of select="concat('_OPENTOPIC_TOC_PROCESSING_', generate-id())"/>
      </xsl:attribute>
    </fo:block>
  </xsl:template>
    
</xsl:stylesheet>