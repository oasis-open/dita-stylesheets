<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:oa="http://www.oasis-open.org"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs oa"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <!-- Intentionally matching <keyword> but not specializations; we want
    quotes around <keyword> itself when used in spec -->
  <xsl:template match="keyword
    [not(ancestor-or-self::*[contains(@class,' topic/topic ')][@outputclass='cover'])]
    [not(ancestor-or-self::*[contains(@class,' topic/dt ')])]">
    <span>
      <xsl:text>"</xsl:text>
      <xsl:next-match/>
      <xsl:text>"</xsl:text>
    </span>
  </xsl:template>

</xsl:stylesheet>
