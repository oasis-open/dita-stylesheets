<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
  exclude-result-prefixes="opentopic opentopic-index dita2xslfo" version="2.0">

  <!-- Suppress steps label when inside remedy.-->
  <xsl:template match="*[contains(@class, ' task/steps ')]">
    <xsl:choose>
      <xsl:when
        test="$GENERATE-TASK-LABELS = 'YES' and not(ancestor::*[contains(@class, ' troubleshooting/remedy ')])">
        <fo:block>
          <xsl:apply-templates select="." mode="dita2xslfo:task-heading">
            <xsl:with-param name="use-label">
              <xsl:apply-templates select="." mode="dita2xslfo:retrieve-task-heading">
                <xsl:with-param name="pdf2-string">Task Steps</xsl:with-param>
                <xsl:with-param name="common-string">task_procedure</xsl:with-param>
              </xsl:apply-templates>
            </xsl:with-param>
          </xsl:apply-templates>
          <fo:list-block xsl:use-attribute-sets="steps">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
          </fo:list-block>
        </fo:block>
      </xsl:when>
      <xsl:otherwise>
        <fo:list-block xsl:use-attribute-sets="steps">
          <xsl:call-template name="commonattributes"/>
          <xsl:apply-templates/>
        </fo:list-block>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Suppress steps-unordeded label when inside remedy.-->
  <xsl:template match="*[contains(@class, ' task/steps-unordered ')]">
    <xsl:choose>
      <xsl:when
        test="$GENERATE-TASK-LABELS = 'YES' and not(ancestor::*[contains(@class, ' troubleshooting/remedy ')])">
        <fo:block>
          <xsl:apply-templates select="." mode="dita2xslfo:task-heading">
            <xsl:with-param name="use-label">
              <xsl:apply-templates select="." mode="dita2xslfo:retrieve-task-heading">
                <xsl:with-param name="pdf2-string">#steps-unordered-label</xsl:with-param>
                <xsl:with-param name="common-string">task_procedure_unordered</xsl:with-param>
              </xsl:apply-templates>
            </xsl:with-param>
          </xsl:apply-templates>
          <fo:list-block xsl:use-attribute-sets="steps-unordered">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
          </fo:list-block>
        </fo:block>
      </xsl:when>
      <xsl:otherwise>
        <fo:list-block xsl:use-attribute-sets="steps-unordered">
          <xsl:call-template name="commonattributes"/>
          <xsl:apply-templates/>
        </fo:list-block>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' task/taskbody ')]/*[contains(@class, ' topic/example ')]">
    <fo:block xsl:use-attribute-sets="section">
      <xsl:call-template name="commonattributes"/>
      <xsl:choose>
        <xsl:when test="*[contains(@class, ' topic/title ')]">
          <xsl:apply-templates select="*[contains(@class, ' topic/title ')]"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="." mode="dita2xslfo:task-heading">
            <xsl:with-param name="use-label">
              <xsl:apply-templates select="." mode="dita2xslfo:retrieve-task-heading">
                <xsl:with-param name="pdf2-string">Task Example</xsl:with-param>
                <xsl:with-param name="common-string">task_example</xsl:with-param>
              </xsl:apply-templates>
            </xsl:with-param>
          </xsl:apply-templates>
        </xsl:otherwise>
      </xsl:choose>
      <fo:block xsl:use-attribute-sets="task.example__content">
        <xsl:apply-templates select="*[not(contains(@class, ' topic/title '))]|text()|processing-instruction()"/>
      </fo:block>
    </fo:block>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' task/steptroubleshooting ')]">
    <xsl:call-template name="renderAsTroubleNote"/>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' task/tasktroubleshooting ')]">
    <xsl:call-template name="renderAsTroubleNote"/>
  </xsl:template>

  <xsl:template name="renderAsTroubleNote">
    <xsl:variable name="noteImagePath">
      <xsl:call-template name="getVariable">
        <xsl:with-param name="id" select="'trouble Note Image Path'"/>
      </xsl:call-template>
    </xsl:variable>
    <fo:table xsl:use-attribute-sets="note__table">
      <fo:table-column xsl:use-attribute-sets="note__image__column"/>
      <fo:table-column xsl:use-attribute-sets="note__text__column"/>
      <fo:table-body>
        <fo:table-row>
          <fo:table-cell xsl:use-attribute-sets="note__image__entry">
            <fo:block>
              <fo:external-graphic src="url('{concat($artworkPrefix, $noteImagePath)}')"
                xsl:use-attribute-sets="note-image"/>
            </fo:block>
          </fo:table-cell>
          <fo:table-cell xsl:use-attribute-sets="note__text__entry">
            <fo:block xsl:use-attribute-sets="note__label__block">
              <fo:inline xsl:use-attribute-sets="note__label">
                <xsl:call-template name="getVariable">
                  <xsl:with-param name="id" select="'Trouble'"/>
                </xsl:call-template>
              </fo:inline>
            </fo:block>
            <xsl:apply-templates/>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
  </xsl:template>

</xsl:stylesheet>
