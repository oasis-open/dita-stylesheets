<?xml version='1.0' encoding='utf-8'?>
<!-- Process every chapter/appendix topic in the map looking for
  RFC items. Write them all out to an XML file, with a link back
  to the statement. All of these statements will have an ID 
  already (depends on plugin extension that adds IDs).
  
  TODO: if a file in a subdirectory has an RFC item, AND
  that RFC item contains a local XREF, paths are not yet
  fixed so the XREF will be broken when generated. -->
<xsl:stylesheet spdf:version="2.4.1"
  exclude-result-prefixes="ditaarch opentopic spdf specrfc"
  version="2.0"
  xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
  xmlns:spdf="org.oasis.spec.pdf"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:specrfc="org.oasis.spec.pdf/rfc"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:param name="rfclist.file"/>
  
  <xsl:key name="rfc-terms" match="*[@specrfc:container]" use="true()"/>
  
  <xsl:template match="/">
    <rfclist>
      <xsl:apply-templates select="/*/*[contains(@class,' bookmap/chapter ') or contains(@class,' bookmap/appendix ')]"/>
    </rfclist>
  </xsl:template>
  
  <xsl:template match="*[contains(@class,' map/topicref ')]">
    <xsl:if test="@href and
      (not(@processing-role) or @processing-role = 'normal') and
      (not(@scope) or @scope = 'local') and
      (not(@format) or @format = 'dita') and
      not(contains(@href, '://'))">
      <xsl:variable name="topicfile"
           select="if (contains(@href, '#')) 
           then (substring-before(@href, '#'))
           else @href"/>
      <xsl:apply-templates select="document(@href)" mode="process-topic">
        <xsl:with-param name="topicfile" select="$topicfile" tunnel="yes"/>
      </xsl:apply-templates>
    </xsl:if>
    <xsl:apply-templates select="*[contains(@class,' map/topicref ')]"/>
  </xsl:template>
  
  <xsl:template match="@* | node()"/>
  
  <xsl:template match="*" mode="process-topic">
    <xsl:param name="topicfile" as="xs:string" tunnel="yes"/>
    <xsl:choose>
      <xsl:when test="(contains(@class,' topic/p ') or contains(@class,' topic/div ') or contains(@class,' topic/li ') or contains(@class,' topic/ph ')) and
        descendant::*[contains(@class, ' topic/term ')][@outputclass = 'RFC-2119']">
        <xsl:variable name="topicid" select="ancestor::*[contains(@class,' topic/topic ')][1]/@id"/>
        <rfcitem href="{$topicfile}#{$topicid}/{@id}">
          <xsl:apply-templates select="." mode="copy-normative-rule">
            <xsl:with-param name="topicfile" select="$topicfile"/>
          </xsl:apply-templates>
        </rfcitem>
      </xsl:when>
      <xsl:when test="contains(@class,' topic/draft-comment ') or contains(@class,' topic/required-cleanup ') or
        contains(@class,' topic/desc ') or contains(@class,' topic/related-links ') or
        contains(@class,' topic/prolog ')"/>
      <xsl:otherwise>
        <xsl:apply-templates select="*" mode="#current"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="@id" mode="copy-normative-rule"/>
  <xsl:template match="@href" mode="copy-normative-rule">
    <xsl:choose>
      <xsl:when test="not(contains(., '://')) and
        (not(../@scope) or ../@scope = 'local') and
        (not(../@format) or ../@format='dita')">
        <xsl:attribute name="href">
          <!-- TODO: add path from map to the topic -->
          <xsl:value-of select="."/>
        </xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:next-match/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*|@*|text()" mode="copy-normative-rule">
    <xsl:copy>
      <xsl:apply-templates select="@*|*|text()" mode="copy-normative-rule"/>
    </xsl:copy>
  </xsl:template>
  
</xsl:stylesheet>
