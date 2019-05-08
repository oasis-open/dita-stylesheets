<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 08 May 2019 KJE: Initial creation                                 -->
<!--                                                                   -->
<!-- ================================================================= -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:opentopic="http://www.idiominc.com/opentopic"
                exclude-result-prefixes="opentopic"
                version="2.0">
  
  <xsl:template name="createFrontMatter">    
    <fo:page-sequence master-reference="front-matter" format="1"
      xsl:use-attribute-sets="__force__page__count">
      <xsl:call-template name="insertFrontMatterStaticContents"/>
      
      <!-- Render the OASIS logo -->
      <fo:flow flow-name="xsl-region-body">
        <fo:block>          
          <fo:block xsl:use-attribute-sets="oasis-cover-header">
            <fo:external-graphic content-width="5cm">
              <xsl:attribute name="src">
                <xsl:call-template name="getVariable">
                  <xsl:with-param name="id">logo Image Path</xsl:with-param>
                </xsl:call-template>
              </xsl:attribute>
            </fo:external-graphic>
          </fo:block>
          
          <!-- Render the document title-->         
          <fo:block xsl:use-attribute-sets="main-document-title">
            <xsl:value-of select="$documentTitle"/>
          </fo:block>
          
          <!-- Render the stage of the document -->          
          <fo:block xsl:use-attribute-sets="cover-stage-date">
            <fo:block>
              <xsl:value-of select="$documentStage"/>
            </fo:block>
          </fo:block>
          
          <!-- Render the stage date -->
          <fo:block xsl:use-attribute-sets="cover-stage-date">
            <xsl:value-of
              select="
              /*[contains(@class, ' bookmap/bookmap ')]/*
              /*[contains(@class, ' bookmap/booktitle ')]
              /*[contains(@class, ' bookmap/booktitlealt ')][@outputclass = 'stageDate']"
            />
          </fo:block>
          
          <!-- Process the OASIS cover-information topic -->
          <fo:block>
            <xsl:apply-templates
              select="
              /*[contains(@class, ' bookmap/bookmap ')]
              /*[contains(@class, ' topic/topic ')][@outputclass = 'cover']"
              mode="cover"/>
          </fo:block>
          
          <!-- Process the OASIS notices topic -->
          <fo:block padding-top="10pt">
            <xsl:apply-templates
              select="
              /*[contains(@class, ' bookmap/bookmap ')]
              /*[contains(@class, ' topic/topic ')][@outputclass = 'notices']"
              mode="notices"/>
          </fo:block>
        </fo:block>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>
    
</xsl:stylesheet>