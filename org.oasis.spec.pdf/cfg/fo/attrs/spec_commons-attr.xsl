<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet exclude-result-prefixes="xs ditaarch opentopic spdf" version="2.0"
  xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/" xmlns:spdf="org.oasis.spec.pdf"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:attribute-set name="__fo__root" use-attribute-sets="base-font">
    <xsl:attribute name="font-family">Sans</xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$default-font-size"/>
    </xsl:attribute>
    <xsl:attribute name="line-height">
      <xsl:value-of select="$default-line-height"/>
    </xsl:attribute>
    <xsl:attribute name="id">fo-root-do-not-change</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="__force__page__count">
    <xsl:attribute name="force-page-count">auto</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="horizontal-rule">
    <xsl:attribute name="border-top-color">#888888</xsl:attribute>
    <xsl:attribute name="border-top-style">solid</xsl:attribute>
    <xsl:attribute name="border-top-width">1px</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="__inline__monospace">
    <xsl:attribute name="font-style">normal</xsl:attribute>
    <xsl:attribute name="font-family">
      <xsl:choose>
        <xsl:when
          test="ancestor-or-self::*[contains(@class, ' topic/title ') or contains(@class, ' topic/dt ')]"
          >inherit</xsl:when>
        <xsl:otherwise>monospace</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:choose>
        <xsl:when test="ancestor::*[contains(@class, ' topic/title ')]">inherit</xsl:when>
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

  <xsl:attribute-set name="desc">
    <xsl:attribute name="font-size">8pt</xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
    <xsl:attribute name="line-height">0.8</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="draft-comment" use-attribute-sets="common.border">
    <xsl:attribute name="background-color">#BDFCC9</xsl:attribute>
    <xsl:attribute name="color">#000000</xsl:attribute>
    <xsl:attribute name="padding-before">5pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="example">
    <xsl:attribute name="border-bottom-style">none</xsl:attribute>
    <xsl:attribute name="border-left-style">none</xsl:attribute>
    <xsl:attribute name="border-right-style">none</xsl:attribute>
    <xsl:attribute name="border-top-style">none</xsl:attribute>
    <xsl:attribute name="color">inherit</xsl:attribute>
    <xsl:attribute name="font-family">Sans</xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$default-font-size"/>
    </xsl:attribute>
    <xsl:attribute name="line-height">12pt</xsl:attribute>
    <xsl:attribute name="margin-left">0pt</xsl:attribute>
    <xsl:attribute name="margin-right">0pt</xsl:attribute>
    <xsl:attribute name="padding">5pt</xsl:attribute>
    <xsl:attribute name="space-before">0.6em</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="example.title" use-attribute-sets="section.title"/>

  <xsl:attribute-set name="fig.title">
    <xsl:attribute name="font-family">Sans</xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$small-font-size"/>
    </xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
    <xsl:attribute name="space-after.optimum">10pt</xsl:attribute>
    <xsl:attribute name="space-before.optimum">5pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="p">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$default-font-size"/>
    </xsl:attribute>
    <xsl:attribute name="space-after">0.6em</xsl:attribute>
    <xsl:attribute name="space-after.optimum">3pt</xsl:attribute>
    <xsl:attribute name="space-before">0.6em</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="note" use-attribute-sets="common.block">
    <xsl:attribute name="margin-left">
      <xsl:call-template name="getNoteMargin"/>
    </xsl:attribute>
    <xsl:attribute name="margin-right">
      <xsl:call-template name="getNoteMargin"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:template name="getNoteMargin">
    <xsl:choose>
      <xsl:when
        test="ancestor::*[contains(@class, ' topic/table ') or contains(@class, ' topic/simpletable ')]"
        >4pt</xsl:when>
      <xsl:otherwise>8pt</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:attribute-set name="pre" use-attribute-sets="base-font common.block">
    <xsl:attribute name="background-color">#f0f0f0</xsl:attribute>
    <xsl:attribute name="font-family">
      <xsl:choose>
        <xsl:when
          test="ancestor-or-self::*[contains(@class, ' topic/title ') or contains(@class, ' topic/dt ')]"
          >inherit</xsl:when>
        <xsl:otherwise>monospace</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:choose>
        <xsl:when
          test="ancestor-or-self::*[contains(@class, ' topic/title ') or contains(@class, ' topic/dt ')]"
          >inherit</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$default-font-size"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <xsl:attribute-set name="topic__shortdesc" use-attribute-sets="body">
    <xsl:attribute name="border-left">none</xsl:attribute>
    <xsl:attribute name="font-family">Sans</xsl:attribute>
    <xsl:attribute name="font-style">normal</xsl:attribute>
    <xsl:attribute name="padding-left">0pt</xsl:attribute>
    <xsl:attribute name="padding-right">0pt</xsl:attribute>
    <xsl:attribute name="space-after">0em</xsl:attribute>
    <xsl:attribute name="space-before">0em</xsl:attribute>
  </xsl:attribute-set>
  
  <xsl:attribute-set name="dlentry.dt__content.cover">
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="keep-with-next">always</xsl:attribute>
    <xsl:attribute name="margin-left">0in</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="dt__block">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$small-font-size"/>
    </xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="keep-with-next">always</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="dd__block">
    <xsl:attribute name="margin-left">0.3in</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="common.title">
    <xsl:attribute name="font-family">Sans</xsl:attribute>
    <xsl:attribute name="font-style">normal</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="color">
      <xsl:choose>
        <!-- Use red the ancestor topic is flagged as revised. -->
        <xsl:when
          test="ancestor::*[contains(@class, ' topic/topic ')][1][child::ditaval-startprop[count(preceding-sibling::*) = 0]]">
          <xsl:text>red</xsl:text>
        </xsl:when>
        <!-- Otherwise, use OASIS purple -->
        <xsl:otherwise>
          <xsl:text>#66116D</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:attribute name="padding-top">0pt</xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="title.color"> </xsl:attribute-set>

  <xsl:attribute-set name="section.title" use-attribute-sets="common.title">
    <xsl:attribute name="font-size">11.5pt</xsl:attribute>
    <xsl:attribute name="margin-top">10pt</xsl:attribute>
    <xsl:attribute name="space-before.optimum">18pt</xsl:attribute>
  </xsl:attribute-set>

  <!-- h1 -->
  <xsl:attribute-set name="topic.title" use-attribute-sets="common.title horizontal-rule">
    <xsl:attribute name="border-after-style">none</xsl:attribute>
    <xsl:attribute name="font-size">18pt</xsl:attribute>
    <xsl:attribute name="border-bottom">none</xsl:attribute>
    <xsl:attribute name="margin-bottom">4pt</xsl:attribute>
    <xsl:attribute name="margin-top">0pt</xsl:attribute>
    <xsl:attribute name="padding-top">7pt</xsl:attribute>

  </xsl:attribute-set>

  <!-- h2 -->
  <xsl:attribute-set name="topic.topic.title" use-attribute-sets="common.title">
    <xsl:attribute name="border-bottom-style">none</xsl:attribute>
    <xsl:attribute name="font-size">14pt</xsl:attribute>
    <xsl:attribute name="margin-bottom">4pt</xsl:attribute>
    <xsl:attribute name="margin-top">8pt</xsl:attribute>
    <xsl:attribute name="space-before.optimum">15pt</xsl:attribute>
    <xsl:attribute name="space-before.conditionality">discard</xsl:attribute>
  </xsl:attribute-set>

  <!-- h3 -->
  <xsl:attribute-set name="topic.topic.topic.title" use-attribute-sets="common.title">
    <xsl:attribute name="font-size">13pt</xsl:attribute>
    <xsl:attribute name="margin-bottom">2pt</xsl:attribute>
    <xsl:attribute name="margin-top">6pt</xsl:attribute>
    <xsl:attribute name="space-before.conditionality">discard</xsl:attribute>
  </xsl:attribute-set>

  <!-- h4 -->
  <xsl:attribute-set name="topic.topic.topic.topic.title" use-attribute-sets="common.title">
    <xsl:attribute name="font-size">12pt</xsl:attribute>
    <xsl:attribute name="margin-bottom">2pt</xsl:attribute>
    <xsl:attribute name="margin-left">0pt</xsl:attribute>
    <xsl:attribute name="margin-top">6pt</xsl:attribute>
    <xsl:attribute name="space-before.conditionality">discard</xsl:attribute>
  </xsl:attribute-set>

  <!-- h5 -->
  <xsl:attribute-set name="topic.topic.topic.topic.topic.title" use-attribute-sets="common.title">
    <xsl:attribute name="font-size">12pt</xsl:attribute>
    <xsl:attribute name="margin-bottom">2pt</xsl:attribute>
    <xsl:attribute name="margin-left">0pt</xsl:attribute>
    <xsl:attribute name="margin-top">6pt</xsl:attribute>
  </xsl:attribute-set>

  <!-- h6 -->
  <xsl:attribute-set name="topic.topic.topic.topic.topic.topic.title"
    use-attribute-sets="common.title">
    <xsl:attribute name="font-size">11pt</xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
    <xsl:attribute name="margin-bottom">2pt</xsl:attribute>
    <xsl:attribute name="margin-left">0pt</xsl:attribute>
    <xsl:attribute name="margin-top">6pt</xsl:attribute>
  </xsl:attribute-set>

  <!-- h7 -->
  <xsl:attribute-set name="topic.topic.topic.topic.topic.topic.topic.title"
    use-attribute-sets="common.title">
    <xsl:attribute name="font-size">11pt</xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
    <xsl:attribute name="margin-bottom">2pt</xsl:attribute>
    <xsl:attribute name="margin-left">0pt</xsl:attribute>
    <xsl:attribute name="margin-top">6pt</xsl:attribute>
  </xsl:attribute-set>

  <!-- h8 -->
  <xsl:attribute-set name="topic.topic.topic.topic.topic.topic.topic.topic.title"
    use-attribute-sets="common.title">
    <xsl:attribute name="font-size">11pt</xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
    <xsl:attribute name="margin-bottom">2pt</xsl:attribute>
    <xsl:attribute name="margin-left">0pt</xsl:attribute>
    <xsl:attribute name="margin-top">6pt</xsl:attribute>
  </xsl:attribute-set>

  <!-- h9 -->
  <xsl:attribute-set name="topic.topic.topic.topic.topic.topic.topic.topic.topic.title"
    use-attribute-sets="common.title">
    <xsl:attribute name="font-size">11pt</xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
    <xsl:attribute name="margin-bottom">2pt</xsl:attribute>
    <xsl:attribute name="margin-left">0pt</xsl:attribute>
    <xsl:attribute name="margin-top">6pt</xsl:attribute>
  </xsl:attribute-set>
  
  <xsl:attribute-set name="page-sequence.frontmatter">
    <xsl:attribute name="format">1</xsl:attribute>
  </xsl:attribute-set>


  <xsl:attribute-set name="revised">
    <xsl:attribute name="color">red</xsl:attribute>
  </xsl:attribute-set>
  

</xsl:stylesheet>
