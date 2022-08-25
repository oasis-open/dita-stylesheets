<?xml version="1.0" encoding="UTF-8" ?>
<!--
    Create next/previous linking that goes through
    the map from start to finish, regardless of 
    parent/child sequencing.
-->

<xsl:stylesheet version="2.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
                exclude-result-prefixes="xs dita-ot">
  
  <!-- Check if "oasislinks" is a link type; if so, apply our custom next/previous -->
  <xsl:template match="*[contains(@class, ' map/topicref ')]" mode="link-from">
    <xsl:choose>
      <xsl:when test="$include.roles = 'oasislinks'">
        <xsl:if test="$include.roles = 'parent'">
          <xsl:apply-templates select="." mode="link-to-parent"/>
        </xsl:if>
        <xsl:apply-templates select="." mode="link-to-oasis-next-prev"/>
        <xsl:if test="$include.roles = 'child'">
          <xsl:apply-templates select="." mode="link-to-children"/>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:next-match/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="*" mode="link-to-oasis-next-prev"/>
  <xsl:template match="*[contains(@class,' map/topicref ')]
    [ancestor-or-self::*[contains(@class,' bookmap/chapter ') or contains(@class,' bookmap/appendix ')]]"
    mode="link-to-oasis-next-prev">
    
    <!-- Previous: if there is a preceding sibling, go there and dig for children,
      find the last actual topicref before this one. 
      Otherwise, previous is the parent. -->
    <xsl:choose>
      <xsl:when test="preceding-sibling::*[contains(@class,' map/topicref ')][@href]">
        <xsl:apply-templates select="preceding-sibling::*[contains(@class,' map/topicref ')][@href][1]" mode="find-previous-oasis-link"/>
      </xsl:when>
      <xsl:when test="contains(@class,' bookmap/chapter ') or contains(@class,' bookmap/appendix ')">
        <!-- Should only fire with first chapter, which does not have preceding siblings;
          do not go up to map and then back down -->
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="parent::*" mode="link">
          <xsl:with-param name="role">previous</xsl:with-param>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
    
    <!-- If there is a child, the first child is the next topic.
      Otherwise, go back up and look for next topic after parent (or grandparent, or ...) -->
    <xsl:choose>
      <xsl:when test="*[contains(@class,' map/topicref ')][@href]">
        <xsl:apply-templates select="*[contains(@class,' map/topicref ')][@href][1]" mode="link">
          <xsl:with-param name="role">next</xsl:with-param>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="." mode="find-next-oasis-link"/>
      </xsl:otherwise>
    </xsl:choose>
      
  </xsl:template>
  
  <!-- Go to previous, look at last child, keep going down, to find the true "last" -->
  <xsl:template match="*" mode="find-previous-oasis-link">
    <xsl:choose>
      <xsl:when test="*[contains(@class,' map/topicref ')][@href]">
        <xsl:apply-templates select="*[contains(@class,' map/topicref ')][@href][last()]" mode="find-previous-oasis-link"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="." mode="link">
          <xsl:with-param name="role">previous</xsl:with-param>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Go to next, or go back up a level (or more) and then go to next. -->
  <xsl:template match="*" mode="find-next-oasis-link">
    <xsl:choose>
      <xsl:when test="following-sibling::*[contains(@class,' map/topicref ')][@href]">
        <xsl:apply-templates select="following-sibling::*[contains(@class,' map/topicref ')][@href][1]" mode="link">
          <xsl:with-param name="role">next</xsl:with-param>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="parent::*" mode="find-next-oasis-link"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
