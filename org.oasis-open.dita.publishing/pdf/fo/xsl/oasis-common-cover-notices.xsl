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
<!-- 09 May 2019 KJE: Added template to render list items with 0 pt    -->
<!--                  margin-left; reworked templates                  -->
<!-- 10 May 2019 KJE: Added template for xrefs in "Status" section     -->
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


  <!-- RENDERS AND STYLES SECTION TITLES -->
  <!-- ================================= -->
  
    <xsl:template 
        match="*[contains(@class,' topic/section ')]/*[contains(@class,' topic/title ')]"
        mode="cover">
        <fo:block xsl:use-attribute-sets="cover-section-title">
            <xsl:apply-templates/>
            <xsl:text>:</xsl:text>
        </fo:block>
    </xsl:template>
   
  <!-- RENDERS AND STYLES SIMPLE LIST -->
  <!-- Renders list items flush left  -->
  <!-- ============================== -->
  
    <xsl:template 
      match="*[contains(@class, ' topic/sl ')]
              [ancestor::*[@outputclass = 'cover']]"
      mode="cover">
        <fo:list-block xsl:use-attribute-sets="cover-sl">
          <xsl:call-template name="commonattributes"/>
          <xsl:apply-templates/>
        </fo:list-block>
  </xsl:template>
  
    
  <!-- FORMAT CROSS REFERENCES                   -->
  <!-- ==========================================-->
  
  <!-- Styles cross references WITH underlining  --> 
  <!-- Cross references in <sli>                 -->
  <xsl:template match="*[@outputclass = 'cover']//*[contains(@class, ' topic/sli ')]/*[contains(@class, ' topic/xref ')]">
    <fo:basic-link xsl:use-attribute-sets="cover-xref">
      <xsl:call-template name="buildBasicLinkDestination">
        <xsl:with-param name="scope" select="@scope"/>
        <xsl:with-param name="format" select="@format"/>
        <xsl:with-param name="href" select="@href"/>
      </xsl:call-template>
      <xsl:apply-templates/>
    </fo:basic-link>
  </xsl:template>
  
  <!-- Styles cross references WITH underlining  --> 
  <!-- Cross references in <li>                 -->  
    <xsl:template match="*[@outputclass = 'cover']//*[contains(@class, ' topic/li ')]/*[contains(@class, ' topic/xref ')]">
    <fo:basic-link xsl:use-attribute-sets="cover-xref">
      <xsl:call-template name="buildBasicLinkDestination">
        <xsl:with-param name="scope" select="@scope"/>
        <xsl:with-param name="format" select="@format"/>
        <xsl:with-param name="href" select="@href"/>
      </xsl:call-template>
      <xsl:apply-templates/>
    </fo:basic-link>
  </xsl:template>
  
    <!-- Styles cross references WITHOUT underlining  --> 
    <!-- Cross references in <p>                      -->
    <xsl:template 
      match="*[contains(@class, ' topic/p ')]/*[contains(@class, ' topic/xref ')]"
      mode="cover">
    <fo:basic-link xsl:use-attribute-sets="status-section-xref">
      <xsl:call-template name="buildBasicLinkDestination">
        <xsl:with-param name="scope" select="@scope"/>
        <xsl:with-param name="format" select="@format"/>
        <xsl:with-param name="href" select="@href"/>
      </xsl:call-template>
      <xsl:apply-templates/>
    </fo:basic-link>
  </xsl:template>

  
  <!-- FORMAT FIRST PARAGRAPH OF SECTIONS                 -->
  <!-- Apply special formatting to <p> immediately after  -->
  <!-- section titles on cover page.                      -->
  <!-- ================================================   -->
  
  <xsl:template 
    match="*[contains(@class, ' topic/p ')]
            [ancestor::*[contains(@class, ' topic/topic ')][@outputclass = 'cover']]
            [preceding-sibling::*[contains(@class, ' topic/title ')]]"
    mode="cover">
        <fo:block xsl:use-attribute-sets="cover-p">
          <xsl:call-template name="commonattributes"/>
          <xsl:apply-templates/>
        </fo:block>
  </xsl:template>
  

  <!-- FORMAT DEFINITION LIST used in "Citation format" -->
  <!-- Renders entries flush left                       -->
  <!-- ================================================ -->
  
  <!-- Fires templates for <dlentry> elements -->
  <xsl:template 
    match="*[contains(@class, ' topic/dlentry ')]" 
    mode="cover">
    <xsl:apply-templates mode="cover"/>
  </xsl:template>

  <!-- Apply bold formatting to <dt> element -->
  <xsl:template 
    match="*[contains(@class, ' topic/dt ')]" 
    mode="cover">
    <fo:block>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!--  Format <dd>: make flush left with margin and add some padding -->
  <xsl:template 
    match="*[contains(@class, ' topic/dd ')]" 
    mode="cover">
    <fo:block>
      <xsl:attribute name="margin-left">0in</xsl:attribute>      
      <xsl:attribute name="padding-top">5pt</xsl:attribute>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  
  
  <!-- FORMAT UNORDERED LIST used in "Additional artifacts" -->
  <!-- and "Related work"                                   -->
  <!-- Renders list items flush left                        -->
  <!-- ==================================================== -->
  
    <!-- Fires templates for <ul> elements -->
    <xsl:template 
      match="*[contains(@class, ' topic/ul ')]"
      mode="cover">
        <fo:list-block xsl:use-attribute-sets="ul">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates mode="cover"/>         
        </fo:list-block>
    </xsl:template>
  
  <!-- Applies cover-li attribute set to list item -->
  <xsl:template 
    match="*[contains(@class, ' topic/ul ')]/*[contains(@class, ' topic/li ')]"
    mode="cover">
        <xsl:variable name="depth" select="count(ancestor::*[contains(@class, ' topic/ul ')])"/>
        <fo:list-item xsl:use-attribute-sets="cover-li">
            <xsl:call-template name="commonattributes"/>
            <fo:list-item-label xsl:use-attribute-sets="ul.li__label">
                <fo:block xsl:use-attribute-sets="ul.li__label__content">
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="concat('Unordered List bullet ', (($depth - 1) mod 4) + 1)"/>
                    </xsl:call-template>
                </fo:block>
            </fo:list-item-label>
            <fo:list-item-body xsl:use-attribute-sets="ul.li__body">
                <fo:block xsl:use-attribute-sets="ul.li__content">
                    <xsl:apply-templates/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>


  <!-- RENDER NOTICES TOPIC -->
  <!-- ==================== -->

  <!-- Templates with mode="notices" are fired from oasis-cn-front-matter.xsl. -->
 
  <xsl:template 
    match="*[contains(@class, ' topic/topic ')][contains(@outputclass, 'notices')]"
    mode="notices">
    <xsl:apply-templates mode="notices"/>
  </xsl:template>
  
  <!-- Format title of "Notices" and make it start on a new page -->
  <xsl:template
    match="*[contains(@class, ' topic/topic ')][contains(@outputclass, 'notices')]
           /*[contains(@class, ' topic/title ')]"
    mode="notices">
    <fo:block page-break-before="always" xsl:use-attribute-sets="cover-stage-date">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  
  <!-- Trigger default templates for chilren of <section> -->
  <xsl:template match="*[contains(@class, ' topic/section ')]" mode="notices">
    <xsl:apply-templates select="."/>
  </xsl:template>
  
</xsl:stylesheet>

