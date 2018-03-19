<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:spec="http://docs.oasis-open.org/dita"
  exclude-result-prefixes="xs spec" version="2.0">

  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="wp-abbrev">
    <xsl:value-of
      select="normalize-space(/bookmap/frontmatter/topichead/keydef[@keys = 'wp-abbrev'])"/>
  </xsl:variable>
  <xsl:variable name="version-id">
    <xsl:value-of
      select="normalize-space(/bookmap/frontmatter/topichead/keydef[@keys = 'version-id'])"/>
  </xsl:variable>
  <xsl:variable name="errata-num">
    <xsl:value-of
      select="normalize-space(/bookmap/frontmatter/topichead/keydef[@keys = 'errata-num'])"/>
  </xsl:variable>
  <xsl:variable name="stage-abbrev">
    <xsl:value-of
      select="normalize-space(/bookmap/frontmatter/topichead/keydef[@keys = 'stage-abbrev'])"/>
  </xsl:variable>
  <xsl:variable name="prev-stage-abbrev">
    <xsl:value-of
      select="normalize-space(/bookmap/frontmatter/topichead/keydef[@keys = 'prev-stage-abbrev'])"/>
  </xsl:variable>
  <xsl:variable name="revision-num">
    <xsl:value-of
      select="normalize-space(/bookmap/frontmatter/topichead/keydef[@keys = 'revision-num'])"/>
  </xsl:variable>
  <xsl:variable name="prev-revision-num">
    <xsl:value-of
      select="normalize-space(/bookmap/frontmatter/topichead/keydef[@keys = 'prev-revision-num'])"/>
  </xsl:variable>
  <xsl:variable name="part-number">
    <xsl:value-of
      select="normalize-space(/bookmap/frontmatter/topichead/keydef[@keys = 'part-number'])"/>
  </xsl:variable>
  <xsl:variable name="abbrev-part-name">
    <xsl:value-of
      select="normalize-space(/bookmap/frontmatter/topichead/keydef[@keys = 'abbrev-part-name'])"/>
  </xsl:variable>
  <xsl:variable name="errata-artifact-type">
    <!-- Notice that this select attribute uses a general //keydef XPath selector instead
         of the /bookmap/frontmatter/topichead/keydef selector. This was done so that you
         can override this key in the errata summary bookmap by defining it directly in the
         bookmap before the part-specify key definition ditamap gets read.
    -->
    <xsl:value-of select="normalize-space((//keydef[@keys = 'errata-artifact-type'])[1])"/>
  </xsl:variable>
  <!-- This is needed for the errata summary document cover. Specifically, it's here to
       to trigger the correct file name construction for parts 0 - 3 in the Additional
       artifacts section.-->
  <xsl:variable name="part-errata-artifact-type">
    <xsl:choose>
      <xsl:when test="xs:integer($part-number) &lt; 0">
        <xsl:text>complete</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$errata-artifact-type"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="oasis-dita-uri-base">
    <xsl:value-of
      select="normalize-space(/bookmap/frontmatter/topichead/keydef[@keys = 'oasis-dita-uri-base'])"
    />
  </xsl:variable>
  <xsl:variable name="outputbasefilename">
    <xsl:value-of
      select="spec:getBaseFilename($errata-num, $errata-artifact-type, $stage-abbrev, $revision-num, $part-number, $abbrev-part-name)"
    />
  </xsl:variable>
  <xsl:variable name="grammarfilename">
    <xsl:value-of select="replace($outputbasefilename, '-complete', '-complete-grammars.zip')"/>
  </xsl:variable>
  <xsl:variable name="sourcefilename">
    <xsl:value-of select="concat($outputbasefilename, '-dita.zip')"/>
  </xsl:variable>
  <xsl:variable name="approval-date">
    <xsl:value-of
      select="normalize-space(/bookmap/frontmatter/topichead/keydef[@keys = 'approval-date'])"/>
  </xsl:variable>
  <xsl:variable name="spec-release-type">
    <xsl:choose>
      <xsl:when test="$stage-abbrev = 'csd'">
        <xsl:text>Committee Specification Draft </xsl:text>
        <xsl:value-of select="$revision-num"/>
      </xsl:when>
      <xsl:when test="$stage-abbrev = 'csprd'">
        <xsl:text>Committee Specification Draft </xsl:text>
        <xsl:value-of select="$revision-num"/>
        <xsl:text> / Public Review Draft </xsl:text>
        <xsl:value-of select="$revision-num"/>
      </xsl:when>
      <xsl:when test="$stage-abbrev = 'os'">OASIS Standard</xsl:when>
    </xsl:choose>
  </xsl:variable>

  <xsl:template match="/">
    <args>
      <oasis>
        <bookmeta>
          <wp-abbrev>
            <xsl:value-of select="$wp-abbrev"/>
          </wp-abbrev>
          <version-id>
            <xsl:value-of select="$version-id"/>
          </version-id>
          <errata-num>
            <xsl:value-of select="$errata-num"/>
          </errata-num>
          <stage-abbrev>
            <xsl:value-of select="$stage-abbrev"/>
          </stage-abbrev>
          <revision-num>
            <xsl:value-of select="$revision-num"/>
          </revision-num>
          <part-number>
            <xsl:value-of select="$part-number"/>
          </part-number>
          <abbrev-part-name>
            <xsl:value-of select="$abbrev-part-name"/>
          </abbrev-part-name>
          <errata-artifact-type>
            <xsl:value-of select="$errata-artifact-type"/>
          </errata-artifact-type>
          <outputfilebasename>
            <xsl:value-of select="$outputbasefilename"/>
          </outputfilebasename>
          <filename-prefix>
            <xsl:value-of select="$wp-abbrev"/>
            <xsl:text>-v</xsl:text>
            <xsl:value-of select="$version-id"/>
            <xsl:text>-errata</xsl:text>
            <xsl:number value="number($errata-num)" format="01"/>
            <xsl:text>-</xsl:text>
            <xsl:value-of select="$stage-abbrev"/>
            <xsl:if test="($revision-num castable as xs:double) and number($revision-num) > 0">
              <xsl:number value="number($revision-num)" format="01"/>
            </xsl:if>
          </filename-prefix>
          <sourcefilename>
            <xsl:value-of select="$sourcefilename"/>
          </sourcefilename>
          <approval-date>
            <xsl:value-of select="$approval-date"/>
          </approval-date>
          <spec-release-type>
            <xsl:value-of select="$spec-release-type"/>
          </spec-release-type>
          <citation-release-type>
            <xsl:if test="not($stage-abbrev = 'os')">
              <xsl:text>OASIS </xsl:text>
            </xsl:if>
            <xsl:value-of select="$spec-release-type"/>
          </citation-release-type>

        </bookmeta>
      </oasis>
    </args>
  </xsl:template>
  
  

  <xsl:function name="spec:getUriStub">
    <xsl:param name="local-errata-num"/>
    <xsl:param name="local-errata-artifact-type"/>
    <xsl:param name="local-stage-abbrev"/>
    <xsl:param name="local-revision-num"/>
    <!-- Tagsmiths: Magic number alert for local-part-number:
            -1 means that there is no part associated with the publication (e.g. errata summary).
         03nov16 -->
    <xsl:param name="local-part-number"/>
    <xsl:param name="local-abbrev-part-name"/>
    <xsl:value-of select="$oasis-dita-uri-base"/>
    <xsl:value-of select="$wp-abbrev"/>
    <xsl:text>/v</xsl:text>
    <xsl:value-of select="$version-id"/>
    <xsl:if test="($local-errata-num castable as xs:double) and number($local-errata-num) > 0">
      <xsl:text>/</xsl:text>
      <xsl:text>errata</xsl:text>
      <xsl:number value="number($local-errata-num)" format="01"/>
    </xsl:if>
    <xsl:if test="$local-stage-abbrev != ''">
      <xsl:text>/</xsl:text>
      <xsl:value-of select="$local-stage-abbrev"/>
      <xsl:if test="($local-revision-num castable as xs:double) and number($local-revision-num) > 0">
        <xsl:number value="number($local-revision-num)" format="01"/>
      </xsl:if>
    </xsl:if>
    <xsl:if test="$local-errata-artifact-type != ''">
      <xsl:text>/</xsl:text>
      <xsl:value-of select="$local-errata-artifact-type"/>
    </xsl:if>
    <xsl:if test="xs:integer($local-part-number) >= 0">
      <xsl:text>/part</xsl:text>
      <xsl:value-of select="$local-part-number"/>
      <xsl:text>-</xsl:text>
      <xsl:value-of select="$local-abbrev-part-name"/>
    </xsl:if>
    <xsl:text>/</xsl:text>
  </xsl:function>

  <xsl:function name="spec:getUriStubLatest">
    <xsl:value-of select="spec:getUriStub($errata-num, '', '', '', -1, '')"/>
  </xsl:function>

  <xsl:function name="spec:getBaseFilename">
    <xsl:param name="local-errata-num"/>
    <xsl:param name="local-errata-artifact-type"/>
    <xsl:param name="local-stage-abbrev"/>
    <xsl:param name="local-revision-num"/>
    <!-- Tagsmiths: Magic number alert for local-part-number:
            -1 means that there is no part associated with the publication (e.g. errata summary)
            -2 means to return the symlink version of the filename (e.g. symlink for errata summary).
         03nov16 -->
    <xsl:param name="local-part-number"/>
    <xsl:param name="local-abbrev-part-name"/>
    <!-- Sample base filename: dita-v1.3-errata01-csd01-part1-base-complete -->
    <xsl:value-of select="$wp-abbrev"/>
    <xsl:text>-v</xsl:text>
    <xsl:value-of select="$version-id"/>
    <xsl:if test="($local-errata-num castable as xs:double) and number($local-errata-num) > 0">
      <xsl:text>-errata</xsl:text>
      <xsl:number value="number($local-errata-num)" format="01"/>
    </xsl:if>
    <xsl:if test="$local-stage-abbrev != '' and $local-part-number > -1">
      <xsl:text>-</xsl:text>
      <xsl:value-of select="$local-stage-abbrev"/>
      <xsl:if test="($local-revision-num castable as xs:double) and number($local-revision-num) > 0">
        <xsl:number value="number($local-revision-num)" format="01"/>
      </xsl:if>
    </xsl:if>
    <xsl:if test="xs:integer($local-part-number) >= 0">
      <xsl:text>-part</xsl:text>
      <xsl:value-of select="$local-part-number"/>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="$local-part-number = -2"><!--Latest version symlink for errata filename. Output nothing.--></xsl:when>
      <xsl:when test="$local-abbrev-part-name = ''">
        <xsl:text>-</xsl:text>
        <xsl:value-of select="concat($local-stage-abbrev, $local-revision-num)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>-</xsl:text>
        <xsl:value-of select="$local-abbrev-part-name"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="$local-errata-artifact-type != ''">
      <xsl:text>-</xsl:text>
      <xsl:value-of select="$local-errata-artifact-type"/>
    </xsl:if>
  </xsl:function>

</xsl:stylesheet>
