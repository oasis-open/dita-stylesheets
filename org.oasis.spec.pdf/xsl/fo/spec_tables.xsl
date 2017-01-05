<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet exclude-result-prefixes="opentopic-func xs dita2xslfo dita-ot ditaarch opentopic spdf" version="2.0"
  xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
  xmlns:spdf="org.oasis.spec.pdf"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <!-- XML Exchange Table Model Document Type Definition default is 1 -->
  <xsl:variable name="table.rowsep-default" select="'1'"/>
  <!-- XML Exchange Table Model Document Type Definition default is 1 -->
  <xsl:variable name="table.colsep-default" select="'1'"/>
  
  <xsl:template match="*[contains(@class, ' topic/tgroup ')]" name="tgroup">
    <xsl:if test="not(@cols)">
      <xsl:call-template name="output-message">
        <xsl:with-param name="id" select="'PDFX006E'"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:variable name="scale" as="xs:string?">
      <xsl:call-template name="getTableScale"/>
    </xsl:variable>
    
    <xsl:variable name="table" as="element()">
      <fo:table xsl:use-attribute-sets="table.tgroup">
        <xsl:call-template name="commonattributes"/>
        
        <xsl:call-template name="displayAtts">
          <xsl:with-param name="element" select=".."/>
        </xsl:call-template>
        
        <xsl:if test="(parent::*/@pgwide) = '1'">
          <xsl:attribute name="start-indent">-<xsl:value-of select="$side-col-width"/></xsl:attribute>
          <xsl:attribute name="end-indent">0</xsl:attribute>
          <xsl:attribute name="width">auto</xsl:attribute>
        </xsl:if>
        
        <xsl:apply-templates/>
      </fo:table>
    </xsl:variable>
    
    <xsl:choose>
      <xsl:when test="exists($scale)">
        <xsl:apply-templates select="$table" mode="setTableEntriesScale"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="$table"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/dl ')]">
    <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]" mode="outofline"/>
    <fo:table xsl:use-attribute-sets="dl">
      <xsl:call-template name="commonattributes"/>
      <xsl:if test="matches(@outputclass, '^ *[0-9]+.? +[0-9]+')">
        <fo:table-column column-number="1" column-width="proportional-column-width({replace(@outputclass, '^ *([0-9]+).*', '$1')})"/>
        <fo:table-column column-number="2" column-width="proportional-column-width({replace(@outputclass, '^ *[0-9]+.? +([0-9]+).*', '$1')})"/>
      </xsl:if>
      <xsl:apply-templates select="*[contains(@class, ' topic/dlhead ')]"/>
      <fo:table-body xsl:use-attribute-sets="dl__body">
        <xsl:choose>
          <xsl:when test="contains(@otherprops,'sortable')">
            <xsl:apply-templates select="*[contains(@class, ' topic/dlentry ')]">
              <xsl:sort select="opentopic-func:getSortString(normalize-space( opentopic-func:fetchValueableText(*[contains(@class, ' topic/dt ')]) ))" lang="{$locale}"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="*[contains(@class, ' topic/dlentry ')]"/>
          </xsl:otherwise>
        </xsl:choose>
      </fo:table-body>
    </fo:table>
    <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-endprop ')]" mode="outofline"/>
  </xsl:template>

</xsl:stylesheet>
