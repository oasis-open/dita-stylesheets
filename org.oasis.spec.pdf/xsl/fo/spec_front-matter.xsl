<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet exclude-result-prefixes="ditaarch opentopic spdf" version="2.0"
  xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/" xmlns:spdf="org.oasis.spec.pdf"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!--cover-->
  <xsl:param name="errata-num"/>
  <xsl:param name="stage-abbrev"/>
  <xsl:param name="revision-num"/>
  <xsl:param name="part-number"/>
  <xsl:param name="spec-release-type"/>
  
  <xsl:template name="createFrontMatter">
    <xsl:if test="$generate-front-cover">
      <fo:page-sequence master-reference="front-matter" xsl:use-attribute-sets="page-sequence.cover">
        <xsl:call-template name="insertFrontMatterStaticContents"/>
        <fo:flow flow-name="xsl-region-body">
          <fo:block-container>
            <fo:block-container xsl:use-attribute-sets="__frontmatter__align__top">
              <xsl:call-template name="createFrontCoverContentsAlignWithTop"/>
            </fo:block-container>
          </fo:block-container>
          <xsl:call-template name="insertNoticesTopics"/>
        </fo:flow>
      </fo:page-sequence>
    </xsl:if>
  </xsl:template>

  <xsl:template name="createFrontCoverContentsAlignWithTop">
    <fo:block text-align="start" border-after-style="solid" border-after-width="0.5px"
      border-after-color="black">
      <fo:external-graphic src="url('file:Customization/OpenTopic/common/artwork/oasis.tif')"
        content-height="13.3mm" content-width="60mm" scaling="uniform" text-align="left"/>
    </fo:block>
    <fo:block xsl:use-attribute-sets="__frontmatter__title">
      <xsl:choose>
        <xsl:when test="$map/*[contains(@class, ' topic/title ')][1]">
          <xsl:apply-templates select="$map/*[contains(@class, ' topic/title ')][1]"/>
        </xsl:when>
        <xsl:when test="$map//*[contains(@class, ' bookmap/mainbooktitle ')][1]">
          <xsl:apply-templates select="$map//*[contains(@class, ' bookmap/mainbooktitle ')][1]"/>
        </xsl:when>
        <xsl:when test="//*[contains(@class, ' map/map ')]/@title">
          <xsl:value-of select="//*[contains(@class, ' map/map ')]/@title"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of
            select="/descendant::*[contains(@class, ' topic/topic ')][1]/*[contains(@class, ' topic/title ')]"
          />
        </xsl:otherwise>
      </xsl:choose>
    </fo:block>
    <!-- committe draft (h2)-->
    <fo:block xsl:use-attribute-sets="oasis-head oasis-h2">
      <!--<fo:block>errata-num=<xsl:value-of select="$errata-num"/>, stage-abbrev=<xsl:value-of select="$stage-abbrev"/>,
        revision-num=<xsl:value-of select="$revision-num"/>, part-number=<xsl:value-of select="$part-number"/>, spec-release-type=<xsl:value-of select="$spec-release-type"/></fo:block>-->
      <fo:block>
        <xsl:value-of
          select="
          /*[contains(@class, ' bookmap/bookmap ')]/*
          /*[contains(@class, ' bookmap/booktitle ')]
          /*[contains(@class, ' bookmap/booktitlealt ')][@outputclass = 'specificationSubtitle1']"/>
        <xsl:choose>
          <!-- Part number less than zero means that this is the errata summary document. 11aug16 -->
          <xsl:when test="($part-number castable as xs:double) and number($part-number) &lt; 0">
            <xsl:choose>
              <!-- It's a draft -->
              <xsl:when
                test="($revision-num castable as xs:double) and number($revision-num) > 0">
                <fo:inline>
                  <xsl:value-of select="$spec-release-type"/>
                </fo:inline>
              </xsl:when>
              <!-- It's final -->
              <xsl:otherwise>
                <fo:inline>OASIS Approved Errata</fo:inline>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:when test="($errata-num castable as xs:double) and number($errata-num) > 0">
            <xsl:choose>
              <xsl:when
                test="($revision-num castable as xs:double) and number($revision-num) > 0">
                <fo:inline xsl:use-attribute-sets="revised">
                  <xsl:text>► incorporating</xsl:text>
                  <xsl:if test="$stage-abbrev = 'csprd'">
                    <xsl:text> Public Review</xsl:text>
                  </xsl:if>
                  <xsl:text> Draft&#xa0;</xsl:text>
                  <xsl:value-of select="$revision-num"/>
                  <xsl:text> of Errata&#xa0;</xsl:text>
                  <xsl:value-of select="$errata-num"/>
                  <xsl:text>◄</xsl:text>
                </fo:inline>
              </xsl:when>
              <!-- The lack of a revision number implies that this is a final. -->
              <xsl:otherwise>
                <fo:inline xsl:use-attribute-sets="revised">
                  <xsl:text> ►incorporating Approved Errata◄</xsl:text>
                </fo:inline>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
        </xsl:choose>
        <!-- If this is an errata and the revision number is non-zero ... -->
        
      </fo:block>
      <!--<xsl:if test="not(normalize-space($specSubtitle2) = '')">
        <fo:block>
          <xsl:value-of select="$specSubtitle2"/>
        </fo:block>
      </xsl:if>-->
    </fo:block>
    <!-- date (h2)-->
    <fo:block xsl:use-attribute-sets="cover_category_label oasis-head oasis-h2">
      <xsl:value-of
        select="
        /*[contains(@class, ' bookmap/bookmap ')]/*
        /*[contains(@class, ' bookmap/booktitle ')]
        /*[contains(@class, ' bookmap/booktitlealt ')][@outputclass = 'specificationApproved']"
      />
    </fo:block>
    <!--<xsl:apply-templates select="$map//*[contains(@class, ' bookmap/booktitlealt ')]"/>
    <fo:block xsl:use-attribute-sets="__frontmatter__owner">
      <xsl:apply-templates select="$map//*[contains(@class, ' bookmap/bookmeta ')]"/>
    </fo:block>-->
  </xsl:template>

  <xsl:template name="spdf:cover-image">
    <xsl:for-each
      select="($map//*[contains(@class, ' topic/data ')][@name = 'cover-image']/*[contains(@class, ' topic/image ')])[1]">
      <xsl:apply-templates mode="placeImage" select=".">
        <xsl:with-param name="imageAlign" select="@align"/>
        <xsl:with-param name="href"
          select="
            if (@scope = 'external' or opentopic-func:isAbsolute(@href)) then
              @href
            else
              concat($input.dir.url, @href)"/>
        <xsl:with-param name="height" select="@height"/>
        <xsl:with-param name="width" select="@width"/>
      </xsl:apply-templates>
    </xsl:for-each>
  </xsl:template>

  <!-- spec.pdf: Create a list of IDs for all notices topics. Delimit each ID with '~'. -->
  <xsl:variable name="noticesTopicrefs">
    <xsl:for-each
      select="
        /bookmap/opentopic:map/frontmatter/*[contains(@class, ' bookmap/notices ')] |
        /bookmap/opentopic:map/frontmatter/*[contains(@class, ' bookmap/notices ')]//topicref">
      <xsl:value-of select="concat('~', @id, '~')"/>
      <!--<xsl:message>spec_front-matter.xsl: </xsl:message>-->
    </xsl:for-each>
  </xsl:variable>

  <xsl:template name="insertNoticesTopics">
    <!-- spec.pdf: Grab all top-level topics that also have an ID associated
                 with notices. Include the '~' delimiters in the match pattern to prevent
                 substring matching.-->
    <xsl:for-each
      select="/bookmap/*[contains(@class, ' topic/topic ')][matches($noticesTopicrefs, concat('~', @id, '~'))]">
      <fo:block>
        <xsl:choose>
          <xsl:when test="@outputclass = 'cover'">
            <xsl:apply-templates mode="cover">
              <xsl:with-param name="position" select="position()" as="xs:integer"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates mode="notices">
              <xsl:with-param name="position" select="position()" as="xs:integer"/>
            </xsl:apply-templates>
          </xsl:otherwise>
        </xsl:choose>
      </fo:block>
    </xsl:for-each>
  </xsl:template>

  <!-- Tagsmiths: The next several templates with mode="cover" are responsible for outputting
    the cover topic -29oct13 -->

  <xsl:template match="*[contains(@class, ' topic/topic ') and contains(@outputclass, 'cover')]"
    mode="cover">
    <xsl:apply-templates mode="cover"/>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/author ')]" mode="cover notices">
    <!-- Suppress the cover topic's title -->
  </xsl:template>

  <xsl:template
    match="*[contains(@class, ' topic/topic ') and contains(@outputclass, 'cover')]/*[contains(@class, ' topic/title ')]"
    mode="cover">
    <fo:block xsl:use-attribute-sets="oasis-h3">
      <xsl:value-of select="."/>
    </fo:block>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/section ')]" mode="cover">
    <xsl:for-each select="*">
      <xsl:choose>
        <xsl:when test="contains(@class, ' topic/title ')">
          <fo:block
            xsl:use-attribute-sets="cover_category_label cover_category_label_spacing oasis-head"
            ><xsl:apply-templates/>:</fo:block>
        </xsl:when>
        <xsl:when test="contains(@class, ' topic/dl ')">
          <xsl:apply-templates select="." mode="cover"/>
        </xsl:when>
        <xsl:otherwise>
          <fo:block xsl:use-attribute-sets="frontmatter-indent">
            <xsl:apply-templates select="."/>
          </fo:block>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <!-- Tagsmiths: The next several templates with mode="notices" are responsible for outputting
    the notices topic -29oct13 -->
  <xsl:template match="*[contains(@class, ' topic/dl ')]" mode="cover">
    <xsl:apply-templates mode="cover"/>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/dlentry ')]" mode="cover">
    <fo:block xsl:use-attribute-sets="frontmatter-indent">
      <xsl:apply-templates mode="cover"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/dt ')]" mode="cover">
    <fo:block xsl:use-attribute-sets="dlentry.dt__content.cover">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/dd ')]" mode="cover">
    <fo:block>
      <xsl:attribute name="margin-left">.15in</xsl:attribute>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/section ')]" mode="notices">
    <xsl:for-each select="*">
      <xsl:choose>
        <xsl:when test="contains(@class, ' topic/title ')">
          <fo:block
            xsl:use-attribute-sets="cover_category_label cover_category_label_spacing oasis-head"
            ><xsl:apply-templates/>:</fo:block>
        </xsl:when>
        <xsl:otherwise>
          <fo:block>
            <xsl:apply-templates select="."/>
          </fo:block>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template
    match="*[contains(@class, ' topic/topic ') and contains(@outputclass, 'frontmatternotices')]"
    mode="notices">
    <xsl:apply-templates mode="notices"/>
  </xsl:template>

  <xsl:template
    match="*[contains(@class, ' topic/topic ') and contains(@outputclass, 'frontmatternotices')]/*[contains(@class, ' topic/title ')]"
    mode="notices">
    <fo:block xsl:use-attribute-sets="oasis-h2">
      <xsl:apply-templates/>
    </fo:block>
    <!-- Suppress the cover topic's title -->
  </xsl:template>


</xsl:stylesheet>
