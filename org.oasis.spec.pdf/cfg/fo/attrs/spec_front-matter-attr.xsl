<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet exclude-result-prefixes="xs ditaarch opentopic spdf" version="2.0"
  xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/" xmlns:spdf="org.oasis.spec.pdf"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:attribute-set name="__frontmatter__align__top"/>
  <xsl:attribute-set name="__frontmatter__align__bottom"/>

  <xsl:attribute-set name="__frontmatter__owner">
    <xsl:attribute name="font-family">Sans</xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$default-font-size"/>
    </xsl:attribute>
    <xsl:attribute name="font-weight">normal</xsl:attribute>
    <xsl:attribute name="margin-left">5mm</xsl:attribute>
    <xsl:attribute name="margin-top">8mm</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="__frontmatter__owner__container">
    <xsl:attribute name="bottom">20mm</xsl:attribute>
    <xsl:attribute name="left">30mm</xsl:attribute>
    <xsl:attribute name="right">15mm</xsl:attribute>
    <xsl:attribute name="top">170mm</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="__frontmatter__subtitle">
    <xsl:attribute name="font-family">Sans</xsl:attribute>
    <xsl:attribute name="font-size">14pt</xsl:attribute>
    <xsl:attribute name="font-weight">normal</xsl:attribute>
    <xsl:attribute name="margin-left">30mm</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="__frontmatter__title">
    <xsl:attribute name="margin-top">35mm</xsl:attribute>
    <xsl:attribute name="color">
      <xsl:value-of select="$cover-heading-color"/>
    </xsl:attribute>
    <xsl:attribute name="font-family">Sans</xsl:attribute>
    <xsl:attribute name="font-size">20pt</xsl:attribute>
    <xsl:attribute name="font-weight">normal</xsl:attribute>
    <xsl:attribute name="line-height">120%</xsl:attribute>
    <xsl:attribute name="margin-left">5mm</xsl:attribute>
    <xsl:attribute name="padding-bottom">0pt</xsl:attribute>
    <xsl:attribute name="padding-top">14pt</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
  </xsl:attribute-set>
  

  <!-- The following attribute sets define they presentation of content on the cover. 
    The attribute set name corresponds to the outputclass value in the oasis cover topic. 
    The OASIS cover topic is any topic referenced from the map with @otherprops="frontmatter". -->

  <xsl:attribute-set name="oasis-head">
    <xsl:attribute name="color">
      <xsl:value-of select="$cover-heading-color"/>
    </xsl:attribute>
    <xsl:attribute name="font-family">Sans</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="keep-with-next">always</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="main-document-title" use-attribute-sets="horizontal-rule">
    <xsl:attribute name="text-align">left</xsl:attribute>
    <xsl:attribute name="font-size">24pt</xsl:attribute>
    <xsl:attribute name="padding-before">4pt</xsl:attribute>
    <xsl:attribute name="margin-bottom">10pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="oasis-h2">
    <xsl:attribute name="font-size">18pt</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="color">
      <xsl:value-of select="$cover-heading-color"/>
    </xsl:attribute>
    <xsl:attribute name="margin-bottom">11pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="oasis-h3">
    <xsl:attribute name="font-size">12pt</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="color">
      <xsl:value-of select="$cover-heading-color"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="cover_category_label">
    <xsl:attribute name="text-align">left</xsl:attribute>
    <xsl:attribute name="font-size">10pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="cover_category_label_spacing">
    <xsl:attribute name="margin-top">8pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="cover_sl">
    <xsl:attribute name="provisional-distance-between-starts">0mm</xsl:attribute>
    <xsl:attribute name="provisional-label-separation">0mm</xsl:attribute>
    <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="cover_p">
    <xsl:attribute name="text-indent">0em</xsl:attribute>
    <xsl:attribute name="space-after">0.6em</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="cover_xref">
    <xsl:attribute name="color">blue</xsl:attribute>
    <xsl:attribute name="text-decoration">underline</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="frontmatter-indent">
    <xsl:attribute name="margin-left">0.5in</xsl:attribute>
  </xsl:attribute-set>

</xsl:stylesheet>
