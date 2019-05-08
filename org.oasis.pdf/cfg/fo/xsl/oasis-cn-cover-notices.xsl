<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 05 Sep 2015 KJE: Added change log                                 -->
<!-- 31 Jan 2016 KJE: Replaced call to deprecated template             -->
<!-- 12 Jul 2016  BT: Changed xref from fo:inline to fo:basic-link     -->
<!-- 14 Mar 2019 KJE: Restored code for suppressing map author on cover -->
<!-- 30 Apr 2019 KJE: Commented out template for "Specification URIs"  -->
<!-- 01 May 2019 KJE: Modified template for <sl> to remove need to use -->
<!--                  outputclass in the DITA source                   -->
<!-- 02 May 2019 KJE: Added page break before "Notices", reworked      -->
<!--                  template for xref to remove need for outputclass -->
<!--                  attributes, removed unused templates, added      -->
<!--                  comments, and rearranged order                   -->
<!-- 05 May 2019 KJE: Renamed attribute sets to be more intuitive      -->
<!-- 06 May 2019 KJE: Changed @outputclass values to be more intuitive -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" 
                xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
                version="2.0">
  
  
  <!-- SUPPRESSES CONTENT THAT WE DO NOT WANT RENDERED -->
  <!-- =============================================== -->
  
  <!-- Suppresses rendering title of cover-information topic -->  
   <xsl:template
    match="*[contains(@class, ' topic/topic ')]/*[contains(@class, ' topic/title ')]"
    mode="cover">
  </xsl:template>

  <!-- Suppresses rendering the map author on the cover page   --> 
  <!-- or notices. This behaviour comes from the PDF2 plug-in. -->
  <xsl:template 
    match="*[contains(@class, ' topic/author ')]" 
    mode="cover notices">
  </xsl:template>


  <!-- TRIGGERS TEMPLATES FOR ELEMENTS THAT ARE DIRECT CHILDREN OF SECTION -->
  <!-- Applies to <title>, <dl>, <p>, <sl>, and <ul>                       -->
  <!-- Also applies special formatting to the section titles               -->
  <!-- =================================================================== -->
  
  <xsl:template match="*[contains(@class, ' topic/section ')]" mode="cover">
    <xsl:for-each select="*">
      <xsl:choose>
        <!-- For section titles, applies cover_category_label attribute set and adds a colon after the title-->
        <xsl:when test="contains(@class, ' topic/title ')">
          <fo:block xsl:use-attribute-sets="cover-section-title">
            <xsl:apply-templates/>:
          </fo:block>
        </xsl:when>
        <!-- For definition lists, fires templates with mode="cover"-->
        <xsl:when test="contains(@class, ' topic/dl ')">
          <xsl:apply-templates select="." mode="cover"/>
        </xsl:when>
        <xsl:otherwise>
          <!-- Fire templates and apply fallthrough styles -->
          <!-- Applies to <p>, <sl>, and <ul> -->
          <xsl:apply-templates select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  
    <!-- KJE: Override simple list on cover -->
    <!--      Could this be built into above template -->
    <xsl:template match="*[contains(@class, ' topic/sl ')]">
    <xsl:choose>
      <xsl:when test="ancestor::*[@outputclass = 'cover']">
        <fo:list-block xsl:use-attribute-sets="cover-sl">
          <xsl:call-template name="commonattributes"/>
          <xsl:apply-templates/>
        </fo:list-block>
      </xsl:when>
      <xsl:otherwise>
        <fo:list-block xsl:use-attribute-sets="sl">
          <xsl:call-template name="commonattributes"/>
          <xsl:apply-templates/>
        </fo:list-block>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Apply special formatting to <p> immediately after section titles -->
  <!-- on cover page. Standard formatting for other paragraphs.         -->
  <xsl:template match="*[contains(@class, ' topic/p ')]">
    <xsl:choose>
      <xsl:when
        test="
          ancestor::*[contains(@class, ' topic/topic ')][@outputclass = 'cover'] and
          preceding-sibling::*[contains(@class, ' topic/title ')]">
        <fo:block xsl:use-attribute-sets="cover-p">
          <xsl:call-template name="commonattributes"/>
          <xsl:apply-templates/>
        </fo:block>
      </xsl:when>
      <xsl:otherwise>
        <fo:block xsl:use-attribute-sets="p">
          <xsl:call-template name="commonattributes"/>
          <xsl:apply-templates/>
        </fo:block>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- FORMAT DEFINITION LIST used in "Citation format" -->
  <!-- ================================================ -->
  
  <!-- Fires templates for <dlentry> elements -->
  <xsl:template match="*[contains(@class, ' topic/dlentry ')]" mode="cover">
    <xsl:apply-templates mode="cover"/>
  </xsl:template>

  <!-- Apply bold formatting to <dt> element -->
  <xsl:template match="*[contains(@class, ' topic/dt ')]" mode="cover">
    <fo:block>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!--  Format <dd>: make flush left with margin and add some padding -->
  <xsl:template match="*[contains(@class, ' topic/dd ')]" mode="cover">
    <fo:block>
      <xsl:attribute name="margin-left">0in</xsl:attribute>      
      <xsl:attribute name="padding-top">5pt</xsl:attribute>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  
  
  <!-- FORMAT CROSS REFERENCES ON THE COVER PAGE        -->
  <!-- Style cross references on cover with underlining --> 
  <!-- ================================================ -->
  
  <xsl:template match="*[@outputclass = 'cover']//*[contains(@class, ' topic/xref ')]">
    <fo:basic-link xsl:use-attribute-sets="cover-xref">
      <xsl:call-template name="buildBasicLinkDestination">
        <xsl:with-param name="scope" select="@scope"/>
        <xsl:with-param name="format" select="@format"/>
        <xsl:with-param name="href" select="@href"/>
      </xsl:call-template>
      <xsl:apply-templates/>
    </fo:basic-link>
  </xsl:template>


  <!-- RENDER NOTICES TOPIC -->
  <!-- ==================== -->

  <!-- Templates with mode="notices" are fired from oasis-cn-front-matter.xsl. -->
  
  <xsl:template 
    match="*[contains(@class, ' topic/topic ') and contains(@outputclass, 'notices')]"
    mode="notices">
    <xsl:apply-templates mode="notices"/>
  </xsl:template>
  
  <!-- Format title of "Notices" and make it start on a new page -->
  <xsl:template
    match="*[contains(@class, ' topic/topic ') and contains(@outputclass, 'notices')]/*[contains(@class, ' topic/title ')]"
    mode="notices">
    <fo:block page-break-before="always" xsl:use-attribute-sets="cover-stage-date">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  
    <!-- Trigger templates for chilren of <section> -->
  <xsl:template match="*[contains(@class, ' topic/section ')]" mode="notices">
    <xsl:apply-templates select="."/>
  </xsl:template>
  
</xsl:stylesheet>

